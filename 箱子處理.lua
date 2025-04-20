local Players = game:GetService("Players").LocalPlayer

-- UI 路徑
local BoxMenu = Players.PlayerGui.Main.Menus.LootMenu.Frame2.ScrollingFrame

-- 寶箱數量表
local BoxCounts = {}

local function getBoxCount(box)
    local Boxvalue = box.CrateButton.Amount.Text
    local number = string.match(Boxvalue, "%d+")
    return tonumber(number) or 0
end
--獲取箱子數量
local function getBoxquantity()
    BoxCounts = {
        Wooden = getBoxCount(BoxMenu.Wooden),
        Golden = getBoxCount(BoxMenu.Golden),
        Diamond = getBoxCount(BoxMenu.Diamond),
        Radioactive = getBoxCount(BoxMenu.Radioactive),
        Amethyst = getBoxCount(BoxMenu.Amethyst),
        Infernal = getBoxCount(BoxMenu.Infernal),
        Holy = getBoxCount(BoxMenu.Holy),
        Corrupted = getBoxCount(BoxMenu.Corrupted)
    }

    -- 打印結果
    for name, count in pairs(BoxCounts) do
        print(name .. " 箱數量:", count)
    end
end

--開啟箱子(我無法知道打開箱子的遠程腳本所以無法製作)
print(BoxCounts.Golden) -- 直接存取金箱數量
getBoxquantity()
