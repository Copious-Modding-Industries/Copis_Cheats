local player = GetUpdatedEntityID()
local controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")

local dragger = { x = 0, y = 0 }
local drag_offset = { x = 0, y = 0 }
local dragging = false
function Gui_fn(gui, id_fn)
    GuiIdPushString(gui, "CheatsTopBar")
    if controls ~= nil then

        dofile_once("mods/Copis_Cheats/gui_fns/tabs.lua")(Gui, id_fn)

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

            -- handle dragging
            local pos_changed = (dragger.x ~= Bar.x) and (dragger.y ~= Bar.y)
            local not_reset = (dragger.x ~= 0) and (dragger.y ~= 0)
            if (pos_changed and not_reset) then
                -- start drag
                if not dragging then
                    dragging = true
                    drag_offset.x, drag_offset.y = dragger.x - Bar.x, dragger.y - Bar.y
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