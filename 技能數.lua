local Players = game:GetService("Players")
local Menus = Players.LocalPlayer.PlayerGui.Main.Menus

-- 分類表：每種技能分類都放在對應表格中
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

-- 自動分類（不更改名稱）
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

-- 發送升級請求函數
local function Updskill(name)
	name = tostring(name)
	print(name .. " 已升級✅")
	local args = { [1] = "upgrade", [2] = name }
	game:GetService("ReplicatedStorage")._NetworkServiceContainer.UpgradeService:FireServer(unpack(args))
end

-- 升級素材的使用開關
Useruby = false
UseCosmicGem = false
UseTrophies = false
Usedice = false
Usecoin = false
Useonyx = false

-- 主函數：自動判斷哪些技能可以升級
function __SelectUpgskill()
	for _, items in pairs(skillTreeGroups) do
		for _, item in ipairs(items) do
			local itemName = item.Name
			local frame = item.Frame
			local bgImage = frame.background.Image

			-- 判斷是否已升級
			if bgImage == "rbxassetid://88163281281385" or bgImage == "rbxassetid://134102627356586" then
				--print(itemName .. " 已升級❎，跳過❌")
			-- 判斷是否未解鎖
			elseif frame.Question.Visible then
				--print(itemName .. " 未解鎖，跳過⛔")
			else
				-- 判斷升級所需素材類型與使用限制
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

				-- 如果不跳過，且資源足夠，執行升級
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

-- 啟動自動升級
__SelectUpgskill()
