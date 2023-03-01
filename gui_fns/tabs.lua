local tabs = {
    {
        id = "Spells",
        icon = "mods/Copis_Cheats/files/ui_gfx/spells.png",
        name = "Spell Spawner",
        tooltip = "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to give to player."
    },
    {
        id = "Perks",
        icon = "mods/Copis_Cheats/files/ui_gfx/perks.png",
        name = "Perk Spawner",
        tooltip = "[LMB] perk icons to spawn in-world,\n[RMB] perk icons to give to player."
    },
    {
        id = "Items",
        icon = "mods/Copis_Cheats/files/ui_gfx/spells.png",
        name = "Spell Spawner",
        tooltip = "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to give to player."
    },
}





function Gui_fn(gui, id_fn)

    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 19, Bar.y - 11, "",
            "mods/Copis_Cheats/files/ui_gfx/items.png")
        GuiTooltip(gui, "Item Spawner", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 28, Bar.y - 11, "",
            "mods/Copis_Cheats/files/ui_gfx/money.png")
        GuiTooltip(gui, "Wallet Editor", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Money")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 37, Bar.y - 11, "",
            "mods/Copis_Cheats/files/ui_gfx/health.png")
        GuiTooltip(gui, "Health Editor", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 46, Bar.y - 11, "",
            "mods/Copis_Cheats/files/ui_gfx/hacks.png")
        GuiTooltip(gui, "Quick Cheats", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 55, Bar.y - 11, "",
            "mods/Copis_Cheats/files/ui_gfx/teleports.png")
        GuiTooltip(gui, "Teleport Menu", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Teleport")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 64, Bar.y - 11, "",
            "mods/Copis_Cheats/files/ui_gfx/secrets.png")
        GuiTooltip(gui, "Progress Manager",
            "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 73, Bar.y - 11, "",
            "mods/Copis_Cheats/files/ui_gfx/stats.png")
        GuiTooltip(gui, "Wand Editor", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to spawn in-inventory.")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "Spells")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 82, Bar.y - 11, "",
            "mods/Copis_Cheats/files/ui_gfx/materials.png")
        GuiTooltip(gui, "Collapse cheat menu", "[LMB] other icons to open their tabs")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "None")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 91, Bar.y - 11, "",
            "mods/Copis_Cheats/files/ui_gfx/fungal.png")
        GuiTooltip(gui, "Collapse cheat menu", "[LMB] other icons to open their tabs")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "None")
        end
    end
    do
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local clicked = GuiImageButton(gui, id_fn(), Bar.x + 100, Bar.y - 11, "",
            "mods/Copis_Cheats/files/ui_gfx/none.png")
        GuiTooltip(gui, "Collapse cheat menu", "[LMB] other icons to open their tabs")
        if clicked then
            ModSettingSet("Copis_Cheats.Tab", "None")
        end
    end


    local function buttonpos(bar, num)
        local dist = bar.w / #tabs
        return bar.x + (num * dist)
    end

    for index = 1, #tabs do
        local tab = tabs[index]
        tab.lmb_fn = tab.lmb_fn or function ()
            ModSettingSet("Copis_Cheats.Tab", tab.id)
        end
        GuiConfigForNextWidget(gui, { 6 }, nil, 4.8)
        local lmb, rmb = GuiImageButton(gui, id_fn(), Bar.x + 1, Bar.y - 11, "", "mods/Copis_Cheats/files/ui_gfx/spells.png")
        if lmb then
            tab.lmb_fn()
        end
        if rmb and tab.rmb_fn ~= nil then
            tab.rmb_fn()
        end
        GuiTooltip(gui, "Spell Spawner", "[LMB] spell icons to spawn in-world,\n[RMB] spell icons to give to player.")
    end
end

return Gui_fn
