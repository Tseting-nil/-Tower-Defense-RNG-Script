local Player = game:GetService("Players")
-- ========================================================================== --
-- UI定義
local Menus = Player.LocalPlayer.PlayerGui.Main.Menus
-- ========================================================================== --
-- 重生資料夾名稱更改
local Rebirthchangetext = Menus.Rebirth
local Rebirthchange = false
local function Rebirth1change()
	if Rebirthchangetext then
        local i = 0
        while true do
            i = i + 1
            local Rebirthc = Rebirthchangetext:FindFirstChild("ImageLabel")
            if Rebirthc then
                Rebirthc.Name = "Rebirthtext" .. i
            else
                if not Rebirthchange then
                    print("重生-名稱-已更改")
                    Rebirthchange = true
                end
                break
            end
        end
    end
end
-- ========================================================================== --
-- 上升資料夾名稱更改
local Ascendchangetext = Menus.Ascend
local Ascendchange = false
local function Ascend1change()
    if Ascendchangetext then
        local i = 0
        while true do
            i = i + 1
            local Ascendc = Ascendchangetext:FindFirstChild("ImageLabel")
            if Ascendc then
                Ascendc.Name = "Ascendtext" .. i
            else
                if not Ascendchange then
                    print("上升-名稱-已更改")
                    Ascendchange = true
                end
                break
            end
        end
    end
end
-- ========================================================================== --
-- 靈氣資料夾名稱更改
local LootMenu = Menus.LootMenu
local LootMenuchange = false
local function LootMenu1change()
    if LootMenu then
        local i = 0
        while true do
            i = i + 1
            local LootMenuc = LootMenu:FindFirstChild("Frame")
            if LootMenuc then
                LootMenuc.Name = "Frame" .. i
            else
                if not LootMenuchange then
                    print("箱子-名稱-已更改")
                    LootMenuchange = true
                end
                break
            end
        end
    end
end

Rebirth1change()
Ascend1change()
LootMenu1change()
