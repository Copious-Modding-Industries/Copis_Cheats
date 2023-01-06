dofile_once("mods/Copis_Cheats/gui_fns/teleport_list.lua")
function Gui_fn(gui, id_fn)
    GuiIdPushString(gui, "CheatsTeleporter")
    GuiConfigForNextWidget(gui, { 6 }, nil, 5)
    GuiBeginScrollContainer(gui, 2, Bar.x, Bar.y + 25, 100, 100, false, 0, 0)

    do
        GuiColorSetForNextWidget(gui, 1.0, 1.0, 1.0, 0.5)
        GuiText(gui, 0, 0, "X:")
        local query = tostring(ModSettingGetNextValue("Copis_Cheats.tele_x") or "")
        local query_new = GuiTextInput(gui, 3, 10, 0, query, 88, 200, "-1234567890 ")
        if query ~= query_new then
            ModSettingSetNextValue("Copis_Cheats.tele_x", query_new, false)
        end
    end

    do
        GuiColorSetForNextWidget(gui, 1.0, 1.0, 1.0, 0.5)
        GuiText(gui, 0, 12, "Y:")
        local query = tostring(ModSettingGetNextValue("Copis_Cheats.tele_y") or "")
        local query_new = GuiTextInput(gui, 4, 10, 12, query, 88, 200, "-1234567890 ")
        if query ~= query_new then
            ModSettingSetNextValue("Copis_Cheats.tele_y", query_new, false)
        end
    end

    do
        local lmb = GuiImageButton(gui, 5, 6, 24, "", "mods/Copis_Cheats/ui_gfx/save.png")
        if lmb then
            local x, y = EntityGetTransform(GetUpdatedEntityID())
            ModSettingSetNextValue("Copis_Cheats.tele_x", x, false)
            ModSettingSetNextValue("Copis_Cheats.tele_y", y, false)
        end
        GuiTooltip(gui, "Get Position", "Save your current location to the inputs")
    end

    do
        local lmb = GuiImageButton(gui, 6, 6, 34, "", "mods/Copis_Cheats/ui_gfx/load.png")
        if lmb then
            local x, y = EntityGetTransform(GetUpdatedEntityID())
            local new_x = ModSettingGetNextValue("Copis_Cheats.tele_x") or x
            local new_y = ModSettingGetNextValue("Copis_Cheats.tele_y") or y
            EntitySetTransform(GetUpdatedEntityID(), new_x, new_y)
        end
        GuiTooltip(gui, "Teleport", "Teleport to the location in the inputs")
    end

    local map_w, map_h
    do
        local path = MagicNumbersGetValue("BIOME_MAP")
        map_w, map_h = GuiGetImageDimensions(gui, path)
        GuiImage(gui, id_fn(), 14, 24, path, 1, 1, 1)
        local mw, mh = BiomeMapGetSize()
        local x, y = EntityGetTransform(GetUpdatedEntityID())
        x = (x % mw) / 512
        y = (y % mh) / 512
        GuiImage(gui, id_fn(), 14 + x, 24 + y, "mods/Copis_Cheats/dot.png", 1, 1, 1)
    end

    -- Teleports

    local count = 0
    local x, y = 0, 0
    for index, teleport in ipairs(teleport_presets) do

        x = math.floor(count % 6)
        y = math.floor(count / 6)

        GuiConfigForNextWidget(gui, {6}, nil, 4.9)
        local lmb, rmb = GuiImageButton(gui, id_fn(), x * 16 + 3, y * 16 + 36 + map_h, "", teleport.icon)
        local description = ""
        if (type(teleport.tooltip) == "function") then
            description = teleport.tooltip()
        else
            description = teleport.tooltip
        end
        GuiTooltip(gui, teleport.name, description)
        if (teleport.lmb_fn ~= nil) and lmb then
            teleport.lmb_fn()
        end
        if (teleport.rmb_fn ~= nil) and rmb then
            teleport.rmb_fn()
        end
        count = count + 1
    end

    GuiEndScrollContainer(gui)
    GuiIdPop(gui)
end

return Gui_fn
