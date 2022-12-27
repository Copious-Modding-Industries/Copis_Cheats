dofile_once("mods/Copis_Cheats/teleport_list.lua")
function Gui_fn(gui, id_fn)
    GuiIdPushString(gui, "CheatsTeleporter")
    GuiConfigForNextWidget(gui, { 6 }, nil, 5)
    GuiBeginScrollContainer(gui, 1, Bar.x, Bar.y + 25, 100, 100, false, 0, 0)
    -- Teleports

    local count = 0
    local x, y = 0, 0
    for index, teleport in ipairs(teleport_presets) do

        x = math.floor(count % 5)
        y = math.floor(count / 5)

        GuiConfigForNextWidget(gui, {6}, nil, 4.9)
        local lmb, rmb = GuiImageButton(gui, id_fn(), x * 16, y * 16, "", teleport.icon)
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
