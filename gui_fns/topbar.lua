local player = GetUpdatedEntityID()
local controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")
local bar = { x = 20, y = 50, w = 108, h = 20}
local mouse = { x = 0, y = 0 }
local dragger = { x = 0, y = 0 }
local drag_offset = { x = 0, y = 0 }
local dragging = false
function Gui_fn(gui, id_fn)
    GuiIdPushString(gui, "CheatsTopBar")
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), bar.x + 1, bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/spells.png")
        GuiTooltip(gui, "Spell Spawner", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to give to player.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), bar.x + 10, bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/perks.png")
        GuiTooltip(gui, "Perk Spawner", "[LMB] perk icons to spawn in-world,\n[RMB] perk icons to give to player.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), bar.x + 19, bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/items.png")
        GuiTooltip(gui, "Item Spawner", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), bar.x + 28, bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/money.png")
        GuiTooltip(gui, "Wallet Editor", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), bar.x + 37, bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/health.png")
        GuiTooltip(gui, "Health Editor", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), bar.x + 46, bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/hacks.png")
        GuiTooltip(gui, "Quick Cheats", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), bar.x + 55, bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/teleports.png")
        GuiTooltip(gui, "Teleport Menu", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), bar.x + 64, bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/secrets.png")
        GuiTooltip(gui, "Progress Manager", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), bar.x + 73, bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/stats.png")
        GuiTooltip(gui, "Wand Editor", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), bar.x + 82, bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/none.png")
        GuiTooltip(gui, "Collapse cheat menu", "[LMB] other icons to open their tabs")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    if controls ~= nil then

        -- top bar
        GuiConfigForNextWidget(gui, { 6 }, nil, 5)
        GuiOptionsAddForNextWidget(gui, 6)
        GuiImageNinePiece(gui, id_fn(), bar.x, bar.y, bar.w, bar.h)
        local hovered; _, _, hovered = GuiGetPreviousWidgetInfo(gui)

        if hovered then
            -- Dragger element
            GuiConfigForNextWidget(gui, { 51, 21, 4, 47, 6 }, nil, 4.9)
            GuiImageButton(gui, id_fn(), bar.x, bar.y, "", "mods/Copis_Cheats/files/ui_gfx/bar_blank.png")
            _, _, _, _, _, _, _, dragger.x, dragger.y = GuiGetPreviousWidgetInfo(gui)

            -- handle mouse pos
            local swidth, sheight = GuiGetScreenDimensions(gui)
            local mraw_x, mraw_y = ComponentGetValue2(controls, "mMousePositionRaw")
            mouse.x, mouse.y = mraw_x * swidth / 1280, mraw_y * sheight / 720

            -- handle dragging
            local pos_changed = (dragger.x ~= bar.x) or (dragger.y ~= bar.y)
            local not_reset = dragger.x ~= 0 and dragger.y ~= 0
            if pos_changed and not_reset then
                if not dragging then
                    dragging = true
                    drag_offset.x, drag_offset.y = mouse.x - bar.x, mouse.y - bar.y
                end
                bar.x, bar.y = dragger.x - drag_offset.x, dragger.y - drag_offset.y
                GlobalsSetValue("Copis_Cheats_win_x", tostring(bar.x))
                GlobalsSetValue("Copis_Cheats_win_y", tostring(bar.y + 25))
            else
                dragging = false
            end
        end
    end
    GuiIdPop(gui)
end
return Gui_fn