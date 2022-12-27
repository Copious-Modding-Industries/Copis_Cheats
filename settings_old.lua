dofile("data/scripts/lib/mod_settings.lua") -- see this file for documentation on some of the features.
dofile("data/scripts/lib/utilities.lua")
local mod_id = "Copis_Cheats"
mod_settings_version = 1
print("HEY!!! HELLO!!")
mod_settings =
{
    {
        category_id = "spawn_spells",
        ui_name = "Spell Spawner",
        ui_description = "Search and spawn spells",
        foldable = true,
        _folded = true,
        settings =
        {
            {
                id = "spellsearch",
                ui_name = "",
                ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                    GuiLayoutBeginHorizontal(gui, mod_setting_group_x_offset, 0, false, 0, 6)
                        GuiColorSetForNextWidget(gui, 1.0, 1.0, 1.0, 0.5)
                        GuiText(gui, 0, 0, "Search: ")
                        local query = tostring(ModSettingGetNextValue("Copis_Cheats.spellquery") or "")
                        local query_new = GuiTextInput(gui, im_id, 0, 0, query, 200, 100, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 ")
                        if query ~= query_new then
                            ModSettingSetNextValue("Copis_Cheats.spellquery", query_new, false)
                        end
                    GuiLayoutEnd(gui)
                end
            },
            {
                id = "spellsmenu",
                ui_name = "",
                ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                    if not in_main_menu then
                        dofile_once( "data/scripts/gun/gun.lua" );
                        GuiLayoutBeginHorizontal(gui, 0, 0, false, 4, 3)
                            local count = 0
                            for _, action in ipairs(actions) do
                                local progress = HasFlagPersistent("action_" .. (action.id):lower())
                                local searched = GameTextGetTranslatedOrNot(action.name):upper():match((ModSettingGetNextValue("Copis_Cheats.spellquery") or ""):upper())
                                if searched and progress then
                                    if count % 14 == 0 then
                                        GuiLayoutEnd(gui)
                                        GuiLayoutBeginHorizontal(gui, 0, 0, false, 4, 3)
                                    end
                                    local border_by_type = {
                                        "data/ui_gfx/inventory/item_bg_projectile.png",
                                        "data/ui_gfx/inventory/item_bg_static_projectile.png",
                                        "data/ui_gfx/inventory/item_bg_modifier.png",
                                        "data/ui_gfx/inventory/item_bg_draw_many.png",
                                        "data/ui_gfx/inventory/item_bg_material.png",
                                        "data/ui_gfx/inventory/item_bg_other.png",
                                        "data/ui_gfx/inventory/item_bg_utility.png",
                                        "data/ui_gfx/inventory/item_bg_passive.png",
                                    }
                                    GuiZSetForNextWidget(gui, 5)
                                    GuiOptionsAddForNextWidget(gui, 28)
                                    GuiOptionsAddForNextWidget(gui, 6)
                                    GuiImage(gui, im_id + count, 0, 0, border_by_type[action.type + 1], 1, 1, 1)
                                    GuiOptionsAddForNextWidget(gui, 28)
                                    GuiOptionsAddForNextWidget(gui, 6)
                                    GuiOptionsAddForNextWidget(gui, 22)
                                    GuiOptionsAddForNextWidget(gui, 22)
                                    local lmb, rmb = GuiImageButton(gui, im_id + #actions + count, -22, 2, "", action.sprite)
                                    GuiTooltip(gui, action.name, action.description)
                                    if lmb then
                                        local player = EntityGetWithTag("player_unit")[1]
                                        local ex, ey = EntityGetTransform(player)
                                        CreateItemActionEntity( action.id, ex, ey)
                                    end
                                    if rmb then
                                        GamePlaySound("data/audio/Desktop/ui.bank", "ui/button_click", GameGetCameraPos())
                                        local player = EntityGetWithTag("player_unit")[1]
                                        local ex, ey = EntityGetTransform(player)
                                        local full_inventory = nil;
                                        local player_child_entities = EntityGetAllChildren( player );
                                        if player_child_entities ~= nil then
                                            for i,child_entity in ipairs( player_child_entities ) do
                                                if EntityGetName( child_entity ) == "inventory_full" then
                                                    full_inventory = child_entity;
                                                    break;
                                                end
                                            end
                                        end

                                        -- set inventory contents
                                        if full_inventory ~= nil then
                                            if #(EntityGetAllChildren(full_inventory) or {}) < 16 then
                                                local action_card = CreateItemActionEntity(action.id, ex, ey)
                                                GamePickUpInventoryItem(player, action_card)
                                                GamePrint( GameTextGetTranslatedOrNot(action.name) .. " added to your inventory" );
                                            else
                                                GamePrint("Not enough inventory space to spawn " .. GameTextGetTranslatedOrNot(action.name))
                                            end
                                        end
                                    end
                                    count = count + 1
                                end
                            end
                        GuiLayoutEnd(gui)
                    else
                        GuiLayoutBeginHorizontal(gui, 0, 0, false, 5, 5)
                            GuiImage(gui, im_id, 0, 0, "data/ui_gfx/inventory/icon_warning.png", 1, 1, 1)
                            GuiColorSetForNextWidget(gui, 0.9, 0.4, 0.4, 0.9)
                            GuiText(gui, 0, 2, "Please open this menu in-game to spawn spells!")
                        GuiLayoutEnd(gui)
                    end
                    mod_setting_tooltip(mod_id, gui, in_main_menu, setting)
                end
            },
        },
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
                            local query_new = GuiTextInput(gui, im_id, 0, 0, query, 200, 100, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 ")
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
                                    local lmb, rmb = GuiImageButton(gui, im_id + #perk_list + count, 0, 0, "", perk.perk_icon)
                                    GuiTooltip(gui, perk.ui_name, perk.ui_description)
                                    if lmb then
                                        local player = EntityGetWithTag("player_unit")[1]
                                        local ex, ey = EntityGetTransform(player)
                                        perk_spawn( ex, ey, perk.id, true)
                                    end
                                    if rmb then
                                        local player = EntityGetWithTag("player_unit")[1]
                                        local ex, ey = EntityGetTransform(player)
                                        perk_spawn( ex, ey, perk.id, true)
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
        category_id = "progress",
        ui_name = "Progress",
        ui_description = "Complete/Clear progress entries",
        foldable = true,
        _folded = true,
        settings =
        {
            {
                id = "spell_progress",
                ui_name = "",
                ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                    if not in_main_menu then
                        GuiLayoutBeginHorizontal(gui, 0, 0, false, 0, 0)
                            local lmb, rmb = GuiButton(gui, im_id, mod_setting_group_x_offset, 0, "[Spell Progress]")
                            if lmb then
                                dofile_once( "data/scripts/gun/gun.lua" );
                                for _, action in ipairs(actions) do
                                    AddFlagPersistent("action_" .. (action.id):lower())
                                end
                            elseif rmb then
                                dofile_once( "data/scripts/gun/gun.lua" );
                                for _, action in ipairs(actions) do
                                    RemoveFlagPersistent("action_" .. (action.id):lower())
                                    GamePlaySound("data/audio/Desktop/ui.bank", "ui/button_click", GameGetCameraPos())
                                end
                            end
                            GuiTooltip(gui, "[LMB] to complete spell progress", "[RMB] to reset spell progress")
                        GuiLayoutEnd(gui)
                        mod_setting_tooltip(mod_id, gui, in_main_menu, setting)
                    else
                        GuiLayoutBeginHorizontal(gui, 0, 0, false, 5, 5)
                            GuiImage(gui, im_id, 0, 0, "data/ui_gfx/inventory/icon_warning.png", 1, 1, 1)
                            GuiColorSetForNextWidget(gui, 0.9, 0.4, 0.4, 0.9)
                            GuiText(gui, 0, 2, "Please open this menu in-game to edit progress!")
                        GuiLayoutEnd(gui)
                    end
                end,
            },
            {
                id = "perk_progress",
                ui_name = "",
                ui_fn = function(mod_id, gui, in_main_menu, im_id, setting)
                    if not in_main_menu then
                        GuiLayoutBeginHorizontal(gui, 0, 0, false, 0, 0)
                            GuiOptionsAddForNextWidget(gui, 6)
                            local lmb, rmb = GuiButton(gui, im_id, mod_setting_group_x_offset, 0, "[Perk Progress]")
                            if lmb then
                                dofile_once("data/scripts/perks/perk_list.lua")
                                for _, perk in ipairs(perk_list) do
                                    AddFlagPersistent("perk_picked_" .. (perk.id):lower())
                                end
                            elseif rmb then
                                dofile_once("data/scripts/perks/perk_list.lua")
                                for _, perk in ipairs(perk_list) do
                                    RemoveFlagPersistent("perk_picked_" .. (perk.id):lower())
                                    GamePlaySound("data/audio/Desktop/ui.bank", "ui/button_click", GameGetCameraPos())
                                end
                            end
                            GuiTooltip(gui, "[LMB] to complete perk progress", "[RMB] to reset perk progress")
                        GuiLayoutEnd(gui)
                        mod_setting_tooltip(mod_id, gui, in_main_menu, setting)
                    end
                end,
            },
        },
    },
}
function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end

-- This function is called to display the settings UI for this mod. Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsGui(gui, in_main_menu)
    screen_width, screen_height = GuiGetScreenDimensions(gui)
    mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end