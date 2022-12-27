Gui_fns = Gui_fns or dofile_once("mods/Copis_Cheats/gui_list.lua")
dofile_once("mods/Copis_Cheats/gui_lib.lua")
Tab = ModSettingGet("Copis_Cheats.Tab") or "Spells"
local id = 1
function NewID()
    id = id + 1
    return id
end

Gui = Gui or GuiCreate()
GuiStartFrame(Gui)
GuiIdPushString(Gui, "Copis_Cheats")

-- Top bar
Gui_fns["TopBar"](Gui, NewID)

-- Show tab
Gui_fns[Tab](Gui, NewID)

GuiIdPop(Gui)