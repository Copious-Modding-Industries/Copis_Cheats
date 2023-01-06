local columns = 5
local padding = 20
-- Spell Borders
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
function Gui_fn(gui, id_fn)
    GuiIdPushString(gui, "CheatsSpellSpawner")
    GuiConfigForNextWidget(gui, { 6 }, nil, 5)
    GuiBeginScrollContainer(gui, 1, Bar.x, Bar.y + 25, 100, 100, false, 0, 0)
    -- Display Spells
    dofile_once( "data/scripts/gun/gun.lua" );

    local query = tostring(ModSettingGetNextValue("Copis_Cheats.spellquery") or "")
    local query_new = GuiTextInput(gui, 2, 0, 0, query, 99, 200, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 ")
    if query ~= query_new then
        ModSettingSetNextValue("Copis_Cheats.spellquery", query_new, false)
    end

    local count = 0
    local x, y = 0, 0
    for index, action in ipairs(actions) do
        local localized = ModSettingGet("Copis_Cheats.localized_search")
        local searched = (localized and GameTextGetTranslatedOrNot(action.name) or action.id):upper():match((ModSettingGetNextValue("Copis_Cheats.spellquery") or ""):upper())
        if searched then

            -- Calculate Next Spell
            x = math.floor(count % columns)
            y = math.floor(count / columns)

            -- Slot Background
            GuiConfigForNextWidget(gui, {6}, nil, 4.9)
            GuiImage(gui, id_fn(), x * padding, (y * padding) + 12, "data/ui_gfx/inventory/full_inventory_box.png", 1, 1, 1)

            -- Spell Border
            GuiConfigForNextWidget(gui, {6}, nil, 4.8)
            GuiImage(gui, id_fn(), x * padding, (y * padding) + 12, border_by_type[action.type + 1], 1, 1, 1)

            -- Spell Sprite/Button
            GuiConfigForNextWidget(gui, {6, 22}, nil, 4.7)
            local lmb, rmb = GuiImageButton(gui, id_fn(), x * padding + 2, (y * padding) + 14, "", action.sprite)
            GuiTooltip(gui, action.name, action.description)

            -- Spawn In-world
            if lmb then
                GamePlaySound("data/audio/Desktop/ui.bank", "ui/button_click", GameGetCameraPos())
                local ex, ey = EntityGetTransform(GetUpdatedEntityID())
                CreateItemActionEntity(action.id, ex, ey)
            end

            -- Give To Player Functionality
            if rmb then
                GamePlaySound("data/audio/Desktop/ui.bank", "ui/button_click", GameGetCameraPos())
                local player = GetUpdatedEntityID()
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
    GuiEndScrollContainer(gui)
    GuiIdPop(gui)
end

return Gui_fn