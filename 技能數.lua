local Players = game:GetService("Players")

local Menus = Players.LocalPlayer.PlayerGui.Main.Menus

local skillTreeGroups = {
	amethystCrate = {}, auraStorage = {}, augments = {}, augmentReroll = {}, augmentSlot = {}, autoCollect = {},
	autoRebirth = {}, autoRoll = {}, autoTraitRoll = {}, betterCosmicWish = {}, betterOnyxes = {}, betterPotions = {},
	coinPotionDrops = {}, corruptedCrate = {}, cosmicWishDrops = {}, crateLuck = {}, decayChance = {}, diamond = {},
	diamondRolls = {}, doubleAura = {}, extraRoll = {}, fastAuto = {}, fastRoll = {}, friendLuck = {}, gamespeed = {},
	glitchedTrait = {}, goldenCrate = {}, goldenRolls = {}, holyCrate = {}, infernalCrate = {}, instaRoll = {},
	invertedTrait = {}, levelReq = {}, levelSelector = {}, lootSave = {}, luck = {}, luckPotionDrops = {},
	onyxDrops = {}, onyxIncrease = {}, onyxLuckyRolls = {}, potionDuration = {}, progression = {}, radioactiveCrate = {},
	rareTraitChance = {}, rollSpeedPotionDrops = {}, rubyDrops = {}, rubyIncrease = {}, rubyLuck = {},
	rubyRolls = {}, shinyTrait = {}, traitRollSpeed = {}, trophies = {}, ultraLuckPotionDrops = {}, voidRolls = {},
	walkspeed = {}, woodenCrate = {}
}

local skilltreeframe = Menus.UpgradeTree.Frame.Frame.Frame
local items = {}

-- 收集所有子項目（排除 UIDragDetector）
for _, item in ipairs(skilltreeframe:GetChildren()) do
	if item:IsA("Instance") and item.Name ~= "UIDragDetector" and item.Name ~= "progression" then
		table.insert(items, item)
	end
end

-- 根據名稱前綴排序（去除數字部分）
table.sort(items, function(a, b)
	local nameA = a.Name:match("^(.-)%d*$") or a.Name
	local nameB = b.Name:match("^(.-)%d*$") or b.Name
	return nameA:lower() < nameB:lower()
end)

-- 重新命名為 名稱 + 數字（強制從1開始）
local nameCounter = {}
for _, item in ipairs(items) do
	local baseName = item.Name:match("^(.-)%d*$") or item.Name
	nameCounter[baseName] = (nameCounter[baseName] or 0) + 1
	item.Name = baseName .. tostring(nameCounter[baseName])
end

-- 自動分類
local unclassified = {}

for _, item in ipairs(items) do
	local matched = false
	for groupName in pairs(skillTreeGroups) do
		if string.sub(item.Name, 1, #groupName) == groupName then
			table.insert(skillTreeGroups[groupName], item)
			matched = true
			break
		end
	end
	if not matched then
		table.insert(unclassified, item.Name)
	end
end

-- 輸出未分類項目
if #unclassified > 0 then
	warn("⚠️ 未分類項目：")
	for _, name in ipairs(unclassified) do
		warn("- " .. name)
	end
else
	print("✅ 所有項目已成功分類")
end

-- 輸出分類結果
--[[
for groupName, items in pairs(skillTreeGroups) do
    print("✅ " .. groupName .. "：")
    for _, item in ipairs(items) do
        print("- " .. item.Name)
    end
end
]]

local function Updskill(name)
    name = tostring(name)
    print(name .. " 已升級✅")
    local args = {[1] = "upgrade",[2] = name}
    game:GetService("ReplicatedStorage")._NetworkServiceContainer.UpgradeService:FireServer(unpack(args))
end
Useruby = false
UseCosmicGem = false
UseTrophies = false
Usedice = false
Usecoin = false
Useonyx = false
function __SelectUpgskill()
	for _, items in pairs(skillTreeGroups) do
		for _, item in ipairs(items) do
			local itemName = item.Name
			local frame = item.Frame
			local bgImage = frame.background.Image

			if bgImage == "rbxassetid://88163281281385" or bgImage == "rbxassetid://134102627356586" then
				--print(itemName .. " 已升級❎，跳過❌")
			elseif frame.Question.Visible then
				--print(itemName .. " 未解鎖，跳過⛔")
			else
				local costType = frame.Frame.Cost.PrefixImage.Image
				local skip = false

				if costType == "rbxassetid://104106007524029" and not Useruby then
					--print(itemName .. " 跳過🩸紅寶石升級⛔")
                    skip = true
				elseif costType == "rbxassetid://94471283680852" and not UseCosmicGem then
					--print(itemName .. " 跳過💎宇宙寶石升級⛔")
                    skip = true
                elseif costType == "rbxassetid://100594914564412" and not Useonyx then
                    --print(itemName .. " 跳過💎💎瑪瑙礦石升級⛔")
                    skip = true
                elseif costType == "rbxassetid://70395215463469" and not UseTrophies then
					--print(itemName .. " 跳過🏆獎盃升級⛔")
                    skip = true
				elseif costType == "rbxassetid://110169018534051" and not Usedice then
					--print(itemName .. " 跳過🎲骰子升級⛔")
                    skip = true
				elseif costType == "rbxassetid://18642455935" and not Usecoin then
					--print(itemName .. " 跳過💰硬幣升級⛔")
                    skip = true
				end
				if not skip then
					if frame.Frame.Cost.Text.TextColor3 == Color3.fromRGB(255, 113, 113) then
						print(itemName .. " 材料不足❌")
					else
						print(itemName .. " 可升級✅")
						Updskill(itemName)
					end
				end
			end
		end
	end
end

__SelectUpgskill()