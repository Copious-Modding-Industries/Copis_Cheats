local player = GetUpdatedEntityID()
local controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")

local mouse = { x = 0, y = 0 }
local dragger = { x = 0, y = 0 }
local drag_offset = { x = 0, y = 0 }
local dragging = false
function Gui_fn(gui, id_fn)
    GuiIdPushString(gui, "CheatsTopBar")
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 1, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/spells.png")
        GuiTooltip(gui, "Spell Spawner", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to give to player.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 10, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/perks.png")
        GuiTooltip(gui, "Perk Spawner", "[LMB] perk icons to spawn in-world,\n[RMB] perk icons to give to player.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 19, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/items.png")
        GuiTooltip(gui, "Item Spawner", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 28, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/money.png")
        GuiTooltip(gui, "Wallet Editor", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Money")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 37, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/health.png")
        GuiTooltip(gui, "Health Editor", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 46, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/hacks.png")
        GuiTooltip(gui, "Quick Cheats", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 55, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/teleports.png")
        GuiTooltip(gui, "Teleport Menu", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Teleport")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 64, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/secrets.png")
        GuiTooltip(gui, "Progress Manager", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 73, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/stats.png")
        GuiTooltip(gui, "Wand Editor", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 82, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/materials.png")
        GuiTooltip(gui, "Collapse cheat menu", "[LMB] other icons to open their tabs")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "None")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 91, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/fungal.png")
        GuiTooltip(gui, "Collapse cheat menu", "[LMB] other icons to open their tabs")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "None")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 100, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/none.png")
        GuiTooltip(gui, "Collapse cheat menu", "[LMB] other icons to open their tabs")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "None")
        end
    end
    if controls ~= nil then

        -- top Bar
        GuiConfigForNextWidget(gui, { 6 }, nil, 5)
        GuiOptionsAddForNextWidget(gui, 6)
        GuiImageNinePiece(gui, id_fn(), Bar.x, Bar.y, Bar.w, Bar.h)
        local hovered; _, _, hovered = GuiGetPreviousWidgetInfo(gui)

        if hovered or dragging then
            -- Dragger element
            GuiConfigForNextWidget(gui, { 51, 21, 4, 47, 6 }, nil, 4.9)
            GuiImageButton(gui, id_fn(), Bar.x, Bar.y, "", "mods/Copis_Cheats/files/ui_gfx/Bar_blank.png")
            _, _, _, _, _, _, _, dragger.x, dragger.y = GuiGetPreviousWidgetInfo(gui)

            -- handle mouse pos
            local mraw_x, mraw_y = ComponentGetValue2(controls, "mMousePositionRaw")
            mouse.x, mouse.y = mraw_x * ScreenX / 1280, mraw_y * ScreenY / 720

            -- handle dragging
            local pos_changed = (dragger.x ~= Bar.x) or (dragger.y ~= Bar.y)
            local not_reset = dragger.x ~= 0 and dragger.y ~= 0
            if (pos_changed and not_reset) then
                -- start drag
                if not dragging then
                    dragging = true
                    drag_offset.x, drag_offset.y = mouse.x - Bar.x, mouse.y - Bar.y
                end
                -- drag
                Bar.x = dragger.x - drag_offset.x
                Bar.y = dragger.y - drag_offset.y
            else
                -- end drag
                if dragging then
                    dragging = false
                    ModSettingSet("Copis_Cheats.Bar_x", dragger.x - drag_offset.x)
                    ModSettingSet("Copis_Cheats.Bar_y", dragger.y - drag_offset.y)
                end
            end
        end
    end
    GuiIdPop(gui)
end
return Gui_fn