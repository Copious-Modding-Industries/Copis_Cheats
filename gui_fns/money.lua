local player = GetUpdatedEntityID()
local wallet = EntityGetFirstComponentIncludingDisabled(player, "WalletComponent")
local amounts = {
    {"100m", 100000000},
    {"10m", 10000000},
    {"1m", 1000000},
    {"100k", 100000},
    {"10k", 10000},
    {"1k", 1000},
    {"100", 100},
    {"10", 10},
    {"1", 1},
}
function Gui_fn(gui, id_fn)
    GuiIdPushString(gui, "CheatsMoney")
    GuiConfigForNextWidget(gui, { 6 }, nil, 5)
    GuiBeginScrollContainer(gui, 2, Bar.x, Bar.y + 25, 100, 100, false, 0, 0)

    if wallet == nil then return end

    do
        local lmb = GuiButton(gui, id_fn(), 0, 0, "[∞ gold ]")
        local infinite = ComponentGetValue2(wallet, "mHasReachedInf")
        GuiTooltip(gui, ("gold is currently %sinfinite"):format(infinite and "" or "not "), "[LMB] to toggle infinite gold.")
        if lmb then
            if infinite then
                local money = ComponentGetValue2(wallet, "money")
                ComponentSetValue2(wallet, "money", math.min(2147483647, money))
                ComponentSetValue2(wallet, "mMoneyPrevFrame", math.min(2147483647, money))
                ComponentSetValue2(wallet, "mHasReachedInf", false)
            else
                ComponentSetValue2(wallet, "mHasReachedInf", true)
            end
        end
    end

    do
        local string = "[0 gold ]"
        local width = GuiGetTextDimensions(gui, string)
        local lmb = GuiButton(gui, id_fn(), 100 - width, 0, string)
        if lmb then
            ComponentSetValue2(wallet, "money", 0)
            ComponentSetValue2(wallet, "mMoneyPrevFrame", 0)
            ComponentSetValue2(wallet, "mHasReachedInf", false)
        end
    end

    do
        local money = ComponentGetValue2(wallet, "money")
        local money_new = GuiSlider(gui, id_fn(), 0, 10, "Gold: ", money, 0, 2147483646, 0, 1, "", 75 )
        if money ~= money_new then
            ComponentSetValue2(wallet, "money", money_new)
            ComponentSetValue2(wallet, "mMoneyPrevFrame", money_new)
        end
    end

    do
        local money_setter = ModSettingGet("Copis_Cheats.money_setter") or ""
        local money_new = GuiTextInput(gui, id_fn(), 0, 20, money_setter, 99, 100, "-1234567890")
        if money_setter ~= money_new then
            ModSettingSet("Copis_Cheats.money_setter", money_new)
        end
    end

    do
        GuiText(gui, 0, 40, "Fine tune gold:")
    end

    local count = 0
    for _, amount in pairs(amounts) do
        if GuiButton(gui, id_fn(), 0, count * 10 + 50, ("[ %s ]"):format(amount[1])) then
            local money = ComponentGetValue2(wallet, "money")
            money = math.min(2147483646, money + amount[2])
            ComponentSetValue2(wallet, "money", money)
            ComponentSetValue2(wallet, "mMoneyPrevFrame", money)
        end
        local string = ("[-%s ]"):format(amount[1])
        local width = GuiGetTextDimensions(gui, string)
        if GuiButton(gui, id_fn(), 100 - width, count * 10 + 50, string) then
            local money = ComponentGetValue2(wallet, "money")
            money = math.max(0, money - amount[2])
            ComponentSetValue2(wallet, "money", money)
            ComponentSetValue2(wallet, "mMoneyPrevFrame", money)
        end
        count = count + 1
    end

    GuiEndScrollContainer(gui)
    GuiIdPop(gui)
end

return Gui_fn
