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
                id = "installcheats",
                ui_name = "",
                ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                    if not in_main_menu then
                        local cheats_enabled = ModSettingGetNextValue("Copis_Cheats.cheats_enabled")
                        local lmb, rmb = GuiButton(gui, im_id, mod_setting_group_x_offset, 0, "[manage cheats]")
                        GuiTooltip(gui, "Press this button to manage the in-game cheat menu.", "[LMB]: Enable Cheat Menu\n[RMB]: Disable Cheat Menu")
                        if lmb then
                            local player = EntityGetWithTag("player_unit")[1]
                            EntityAddComponent2(player, "LuaComponent", {
                                script_source_file = "mods/Copis_Cheats/cheats.lua",
                                execute_on_added = false,
                                execute_on_removed = false,
                                execute_every_n_frame = 1,
                                execute_times = 0,  -- infinite
                                remove_after_executed = false,
                                enable_coroutines = false,
                            })
                        end
                        if rmb then
                            GamePlaySound("data/audio/Desktop/ui.bank", "ui/button_click", GameGetCameraPos())
                            local player = EntityGetWithTag("player_unit")[1]
                            local cheatcomp = EntityGetFirstComponentIncludingDisabled(player, "LuaComponent", "Copis_Cheats")
                            if cheatcomp ~= nil then
                                EntityRemoveComponent(player, cheatcomp)
                            end
                        end
                    end
                end
            },
            {
                id = "indicator",
                ui_name = "",
                ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                    if not in_main_menu then
                        GuiLayoutBeginHorizontal(gui, 0, 0, false, 2, 0)
                        local player = EntityGetWithTag("player_unit")[1]
                        local has_cheats = false
                        if EntityGetFirstComponentIncludingDisabled(player, "LuaComponent", "Copis_Cheats") ~= nil then
                            has_cheats = true
                        end
                        GuiImage(gui, im_id, mod_setting_group_x_offset, 0, ("mods/Copis_Cheats/%s.png"):format(has_cheats and "bool_t" or "bool_f"))
                        GuiColorSetForNextWidget(gui, has_cheats and 0.4 or 0.9, has_cheats and 0.9 or 0.4, 0.4, 0.8)
                        GuiText(gui, mod_setting_group_x_offset, 0, ("cheats are %s"):format( has_cheats and "enabled" or "disabled"))
                        GuiLayoutEnd(gui)
                    end
                end
            },
        }
    end
end

function ModSettingsUpdate( init_scope )
    local old_version = mod_settings_get_version( mod_id ) -- This can be used to migrate some settings between mod versions.
    mod_settings_update( mod_id, mod_settings, init_scope )
end