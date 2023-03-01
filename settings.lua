dofile("data/scripts/lib/mod_settings.lua") -- see this file for documentation on some of the features.
dofile("data/scripts/lib/utilities.lua")
local mod_id = "Copis_Cheats"
local in_game = false
mod_settings_version = 1
mod_settings = {
    {
        id = "warning",
        ui_name = "",
        ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
            if in_main_menu then
                GuiLayoutBeginHorizontal(gui, 0, 0, false, 5, 5)
                GuiImage(gui, im_id, 0, 0, "data/ui_gfx/inventory/icon_warning.png", 1, 1, 1)
                GuiColorSetForNextWidget(gui, 0.9, 0.4, 0.4, 0.9)
                GuiText(gui, 0, 2, "Cheats are only useable in-game!")
                GuiLayoutEnd(gui)
            end
        end
    },
}

function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end

-- This function is called to display the settings UI for this mod. Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsGui(gui, in_main_menu)
    screen_width, screen_height = GuiGetScreenDimensions(gui)
    mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
    if not in_main_menu and not in_game then
        in_game = true
        mod_settings = {
            {
                id = "progress",
                ui_name = "",
                ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                    GuiColorSetForNextWidget(gui, 0.9, 0.4, 0.4, 0.8)
                    local lmb = GuiButton(gui, im_id, mod_setting_group_x_offset, 0, "[Haxx]")
                    if lmb then
                        dofile_once("data/scripts/gun/gun.lua");
                        for _, action in ipairs(actions) do
                            AddFlagPersistent(table.concat { "action_", action.id:lower() })
                        end
                    end
                end
            },
            {
                id = "installcheats",
                ui_name = "",
                ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                    if not in_main_menu then
                        local player = EntityGetWithTag("player_unit")[1]
                        local cheatcomp = EntityGetFirstComponentIncludingDisabled(player, "LuaComponent", "Copis_Cheats")
                        if cheatcomp ~= nil then
                            GuiColorSetForNextWidget(gui, 0.4, 0.9, 0.4, 0.8)
                            local lmb = GuiButton(gui, im_id, mod_setting_group_x_offset, 0, "[Disable Cheats]")
                            if lmb then
                                GamePlaySound("data/audio/Desktop/ui.bank", "ui/button_click", GameGetCameraPos())
                                EntityRemoveComponent(player, cheatcomp)
                            end
                        else
                            GuiColorSetForNextWidget(gui, 0.9, 0.4, 0.4, 0.8)
                            local lmb = GuiButton(gui, im_id, mod_setting_group_x_offset, 0, "[Enable Cheats]")
                            if lmb then
                                local cheatcomp_new = EntityAddComponent2(player, "LuaComponent", {
                                    script_source_file = "mods/Copis_Cheats/cheats.lua",
                                    execute_on_added = false,
                                    execute_on_removed = false,
                                    execute_every_n_frame = 1,
                                    execute_times = 0, -- infinite
                                    remove_after_executed = false,
                                    enable_coroutines = false,
                                })
                                ComponentAddTag(cheatcomp_new, "Copis_Cheats")
                            end
                        end
                        GuiTooltip(gui, "Press this button to manage the in-game cheat menu.",
                            cheatcomp and "Cheats are currently enabled" or "Cheats are currently disabled")
                    end
                end
            },
            {
                category_id = "spawn_perks",
                ui_name = "Perk Spawner",
                ui_description = "Search and spawn perks",
                foldable = true,
                _folded = true,
                settings =
                {
                    {
                        id = "perksearch",
                        ui_name = "",
                        ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                            if not in_main_menu then
                                GuiLayoutBeginHorizontal(gui, mod_setting_group_x_offset, 0, false, 0, 6)
                                GuiColorSetForNextWidget(gui, 1.0, 1.0, 1.0, 0.5)
                                GuiText(gui, 0, 0, "Search: ")
                                local query = tostring(ModSettingGetNextValue("Copis_Cheats.perkquery") or "")
                                local query_new = GuiTextInput(gui, im_id, 0, 0, query, 200, 100,
                                    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 ")
                                if query ~= query_new then
                                    ModSettingSetNextValue("Copis_Cheats.perkquery", query_new, false)
                                end
                                GuiLayoutEnd(gui)
                            end
                        end
                    },
                    {
                        id = "perksmenu",
                        ui_name = "",
                        ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                            if not in_main_menu then
                                dofile_once("data/scripts/perks/perk.lua")
                                GuiLayoutBeginHorizontal(gui, 0, 0, false, 6, 6)
                                local count = 0
                                for _, perk in ipairs(perk_list) do
                                    if GameTextGetTranslatedOrNot(perk.ui_name):upper():match((ModSettingGetNextValue("Copis_Cheats.perkquery") or ""):upper()) then
                                        if count % 14 == 0 then
                                            GuiLayoutEnd(gui)
                                            GuiLayoutBeginHorizontal(gui, 0, 0, false, 6, 6)
                                        end
                                        GuiOptionsAddForNextWidget(gui, 28)
                                        GuiOptionsAddForNextWidget(gui, 6)
                                        local lmb, rmb = GuiImageButton(gui, im_id + #perk_list + count, 0, 0, "",
                                            perk.perk_icon)
                                        GuiTooltip(gui, perk.ui_name, perk.ui_description)
                                        if lmb then
                                            local player = EntityGetWithTag("player_unit")[1]
                                            local ex, ey = EntityGetTransform(player)
                                            perk_spawn(ex, ey, perk.id, true)
                                        end
                                        if rmb then
                                            local player = EntityGetWithTag("player_unit")[1]
                                            local ex, ey = EntityGetTransform(player)
                                            perk_spawn(ex, ey, perk.id, true)
                                            perk_pickup(perk, player, EntityGetName(perk), false, false)
                                        end
                                        count = count + 1
                                    end
                                end
                                GuiLayoutEnd(gui)
                            else
                                GuiLayoutBeginHorizontal(gui, 0, 0, false, 5, 5)
                                GuiImage(gui, im_id, 0, 0, "data/ui_gfx/inventory/icon_warning.png", 1, 1, 1)
                                GuiColorSetForNextWidget(gui, 0.9, 0.4, 0.4, 0.9)
                                GuiText(gui, 0, 2, "Please open this menu in-game to spawn perks!")
                                GuiLayoutEnd(gui)
                            end
                            mod_setting_tooltip(mod_id, gui, in_main_menu, setting)
                        end
                    },
                },
            },
            {
                category_id = "runscripts",
                ui_name = "Run Scripts",
                ui_description = "Run customs scripts in-game!",
                foldable = true,
                _folded = true,
                settings =
                {
                    {
                        id = "warning",
                        ui_name = "",
                        ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                            GuiLayoutBeginHorizontal(gui, 0, 0, false, 5, 5)
                            GuiImage(gui, im_id, 0, 0, "data/ui_gfx/inventory/icon_info.png", 1, 1, 1)
                            GuiColorSetForNextWidget(gui, 0.4, 0.4, 0.4, 0.8)
                            GuiText(gui, 0, 2, "For usage instructions, see the tutorial map!")
                            GuiLayoutEnd(gui)
                        end
                    },
                    {
                        id = "scriptname",
                        ui_name = "",
                        ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                            if not in_main_menu then
                                local query = tostring(ModSettingGetNextValue("Copis_Cheats.scriptname") or "")
                                local query_new = GuiTextInput(gui, 2,
                                    0, 0,
                                    query,
                                    99, 200,
                                    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
                                )
                                if query ~= query_new then
                                    ModSettingSetNextValue("Copis_Cheats.scriptname", query_new, false)
                                end
                            end
                        end
                    },
                    {
                        id = "runscript",
                        ui_name = "",
                        ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                            GuiColorSetForNextWidget(gui, 0.4, 0.4, 0.9, 0.8)
                            local lmb = GuiButton(gui, im_id, mod_setting_group_x_offset, 0, "[Run script]")
                            if lmb then
                                dofile(table.concat{"data/scripts/", ModSettingGetNextValue("Copis_Cheats.scriptname"), ".lua"})
                            end
                        end
                    },
                }
            }
        }
    end
end

function ModSettingsUpdate(init_scope)
    local old_version = mod_settings_get_version(mod_id) -- This can be used to migrate some settings between mod versions.
    mod_settings_update(mod_id, mod_settings, init_scope)
end
