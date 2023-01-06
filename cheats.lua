Gui_fns = Gui_fns or dofile_once("mods/Copis_Cheats/gui_list.lua")
dofile_once("mods/Copis_Cheats/gui_lib.lua")
Tab = ModSettingGet("Copis_Cheats.Tab") or "Spells"
local id = 69
function NewID()
    id = id + 1
    return id
end

Bar = Bar or { x = (ModSettingGet("Copis_Cheats.Bar_x") or 20), y = (ModSettingGet("Copis_Cheats.Bar_y") or 50), w = 108, h = 20}

Gui = Gui or GuiCreate()
GuiStartFrame(Gui)
ScreenX, ScreenY = GuiGetScreenDimensions(Gui)
Bar.x = math.min(math.max(Bar.x, 0), ScreenX - Bar.w)
Bar.y = math.min(math.max(Bar.y, 0), ScreenY - Bar.h)
GuiIdPushString(Gui, "Copis_Cheats")

-- Show tab
Gui_fns[Tab](Gui, NewID)

-- Top bar
Gui_fns["TopBar"](Gui, NewID)

GuiIdPop(Gui)