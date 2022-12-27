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
    local win_x, win_y = tonumber(GlobalsGetValue("Copis_Cheats_win_x")) or 20, tonumber(GlobalsGetValue("Copis_Cheats_win_y")) or 75
    GuiConfigForNextWidget(gui, { 6 }, nil, 5)
    GuiBeginScrollContainer(gui, 1, win_x, win_y, padding * columns, 100, false, 0, 0)
    -- Display Spells
    dofile_once( "data/scripts/gun/gun.lua" );
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
            GuiImage(gui, id_fn(), x * padding, y * padding, "data/ui_gfx/inventory/full_inventory_box.png", 1, 1, 1)

            -- Spell Border
            GuiConfigForNextWidget(gui, {6}, nil, 4.8)
            GuiImage(gui, id_fn(), x * padding, y * padding, border_by_type[action.type + 1], 1, 1, 1)

            -- Spell Sprite/Button
            GuiConfigForNextWidget(gui, {6, 22}, nil, 4.7)
            local lmb, rmb = GuiImageButton(gui, id_fn(), x * padding + 2, y * padding + 2, "", action.sprite)
            GuiTooltip(gui, action.name, action.description)

            count = count + 1
        end
    end
    GuiEndScrollContainer(gui)
    GuiIdPop(gui)
end

return Gui_fn