ITEM.name = "suit base"
ITEM.desc = "wtf"
ITEM.model = "models/tnb/stalker/items/anorak.mdl"
ITEM.price = 400
ITEM.flag = "y"
ITEM.category = "Suits"
ITEM.pacData = {}

--[[--for seperate female/male pacs, replace pacData with pacF or pacM
ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
					["Angles"] = Angle(12.919322967529, 6.5696062847564e-006, -1.0949343050015e-005),
					["Position"] = Vector(-2.099609375, 0.019973754882813, 1.0180969238281),
					["UniqueID"] = "4249811628",
					["Size"] = 1.25,
					["Bone"] = "eyes",
					["Model"] = "models/Gibs/HGIBS.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "907159817",
			["EditorExpand"] = true,
		},
	},
}

-- This will change a player's skin after changing the model. Keep in mind it starts at 0.
ITEM.newSkin = 1
-- This will change a certain part of the model.
ITEM.replacements = {"group01", "group02"}
-- This will change the player's model completely.
ITEM.replacements = "models/manhack.mdl"
-- This will have multiple replacements.
ITEM.replacements = {
	{"male", "female"},
	{"group01", "group02"}
}
--can use this too
function ITEM:onGetReplacement()
	local model = self.player:getChar():getModel()

	if(self.player:isFemale()) then
		return "models/tnb/stalker/female_sunrise_balaclava.mdl"
	end

	return "models/tnb/stalker/male_sunrise_balaclava.mdl"
end
--can also be blank to not replace model

-- This will apply body groups.
ITEM.bodyGroups = {
	["blade"] = 1,
	["bladeblur"] = 1
}
u can set specific bodygroups by adding a getBodyGroups(ply) function on the item, 
use this instead of bodyGroups

--required
ITEM.armor = { 
	["chest"] = ARMOR_NONE,
	--etc.. see main plugin for armor values and part values
}
ITEM.resists = {
	["phys"] = 0.1,
	--etc.. same as above
}
ITEM.upgradePath = {
	--upgrade paths that it uses should be in here
}

gs stuff:
ITEM.gs = {
	type, <- required, string, top, bot, seperate
	bg,  <- required, int, 0 ind bodygroup
	model, <- custom model, string
	skin,  <- skin of model, int
	custombg, <- other ind bodygroups, table, [ind] = bg
	submat <- submaterials to set, table, [originalmat] = replacementmat
}
or they can be dynamically returned via
function ITEM:getCustomGS() end
return a table
]]


-- Inventory drawing
if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
		--todo add durability here too
	end
end

--PUTTING IT IN HERE TOO BECAUSE IM TRYING REALLY HARD NOT TO EDIT DEFAULT NS
--AND IT LOADS PLUGIN.LUA AAAAAAAFTER EVERYTHING ELSE
--SO THE ENUMS DONT GET LOADED YET AGH DEFEATS THE ENTIRE FUCKING POINT
ARMOR_NONE = 0
ARMOR_IIA = 1
ARMOR_II = 2
ARMOR_IIIA = 3
ARMOR_III = 4
ARMOR_IV = 5
ARMOR_V = 6 
ARMOR_I = 7 --lol
local stringtoenum = {
	[ARMOR_NONE] = "none",
	[ARMOR_I] = "I",
	[ARMOR_IIA] = "IIA",
	[ARMOR_II] = "II",
	[ARMOR_IIIA] = "IIIA",
	[ARMOR_III] = "III",
	[ARMOR_IV] = "IV",
	[ARMOR_V] = "V",
}

--should be armorenum to string lol
local function StringToArmorEnum(string)
	if(type(string) == "string") then return string end
	if(stringtoenum[string]) then
		return stringtoenum[string]
	end
	return ARMOR_NONE
end
--[[
function ITEM:calcPrice(origprice)
	local price = origprice
	local prices = {}
	local relprice = 0
	
	local lvls = self:getData("armor")
	if(lvls) then
		local rat = 1/#lvls
		for k,v in pairs(lvls) do
			if(v.durability) then
				prices[k] = price * ((v.durability/100)*rat)
			else
				prices[k] = price * rat
			end
		end
	end
	
	for k,v in pairs(prices) do
		relprice = relprice + v
	end
	if(relprice == 0) then
		relprice = price
	end

	return relprice
end
]]

function ITEM:getName()
	return self:getData("customName", self.name)
end

function ITEM:getDesc()

	local str = self.desc
	str = str.."\n\n"
	
	--list parts and resists
	local lvls = self:getData("armor")
	if(lvls) then
		--str = str.."Durability: "..math.floor(self:getData("durability", 1)*100).."%\n"
		str = str.."ARMOR LEVELS:\n"
		for k,v in pairs(lvls) do
			if(type(v) == "string") then print(k.." is string woops") continue end
			if(v.level == ARMOR_NONE) then continue end
			str = str.."    •"..k:upper()..": "..StringToArmorEnum(v.level).."\n"-- ("..(math.Round((v.durability or 1)*100) or 100).."%)\n"
		end
		--str = str.."\n"

	elseif(self.armor) then
		str = str.."ARMOR LEVELS:\n"
		for k,v in pairs(self.armor) do
			if(type(v) == "string") then print(k.." is string woops") continue end
			if(v.level == ARMOR_NONE) then continue end
			str = str.."    "..k:upper()..": "..StringToArmorEnum(v.level).."\n"
		end
		--str = str.."\n"

	end
	str = str.."\nSLOTS USED: "..suit_getUpgradeMaxes(self).."\n\n"


	local ar = self:getData("artcnt", self.artifactCnt or 0) 

	str = str.."PROPERTIES:\n    •Condition: "..math.floor((self:getData("durability", self:getMaxDura())/self:getMaxDura())*100).."%\n"
	if(self.size) then
		str=str.."    •Armor Size: "..self.size.."\n"
	end
	if(ar != 0) then
		str=str.."    •Artifact Storage: Max of "..(ar+1).." artifacts.\n"
	end
	str = str.."\n"



		--list upgrades, table should look like: ["id"] = "display name"

	-- if(table.Count(self:getData("upgrades", {})) != 0) then
	-- 	str = str.."Upgrades: \n    "
	-- 	for k,v in pairs(self:getData("upgrades")) do
	-- 		str = str..suit_getUpgradeName(k)..", "
	-- 	end
	  
	-- 	str = str:sub(1, -3)
	-- 	str = str.."\n"

	-- end


	--
	
	local res = self:getData("resists")
	if(res) then
		for k,v in pairs(res) do
			if(!ARTIFACT_TRANS[k] or ARTIFACT_TRANS[k].hidden) then continue end
			local ttx = ARTIFACT_TRANS[k].icon:GetName()
			str = str.. " <img="..ttx..","..ARTIFACT_TRANS[k].icon:Width().."x"..ARTIFACT_TRANS[k].icon:Height().."> "..(ARTIFACT_TRANS[k] and ARTIFACT_TRANS[k].name or "???")..": "..math.Round(v*100).."%\n"
		end
		--str = str.."\n"
	end




	

	--old thing, might as well keep it i guess
	if(self:getData("flavor")) then
		str = str.."\n\n<font=nutItemDescItalicFont>"..self:getData("flavor").."</font>"
	end

	return str
end

local basedura = {
	["vest"] = 35,
	["vestl"] = 80,
	["light"] = 90,
	["medium"] = 130,
	["gorka"] = 130,
	["heavy"] = 180,
	["exo"] = 200,
	["sci"] = 35,
	["seva"] = 120,
	["mask"] = 30,
	["helm"] = 80,
}

function ITEM:getMaxDura()
	--unsure how to do this?
	return (basedura[self.size] or 100) * self:getData("duram", 1)
end

function ITEM:getWeight()
	return self:getData("weight", self.weight)
end

function ITEM:RemoveOutfit(client)
	local character = client:getChar()

	self:setData("equip", false)
	
	local res = client:GetArmorResists()
	if(!res["nv"]) then
		net.Start("PlayerOffNV")
		net.Send(client)
	end
	--[[if(!res["hud"]) then
		net.Start("PlayerOffHud")
		net.Send(client)
	end]]
	local uni
	if(self.pacF and self.pacM) then
		if(client:isFemale()) then
			uni = self.uniqueID.."_fem"
		else
			uni = self.uniqueID.."_male"
		end
	else
		uni = self.uniqueID
	end

	if(client.removePart) then
		client:removePart(uni)
	end
	
	if(self.gs or self.getCustomGS) then
		if(!self.getCustomGS) then
		nut.newchar.setBody(client, self.gs.type, -1, self.gs.model, self.gs.skin, self.gs.custombg, self.gs.submat)
		else
			
			local gs, bgsonly = self:getCustomGS()
			
			if(!bgsonly) then
				if(gs.remove or gs.removebg) then
					--specific bits to undo
					nut.newchar.setBody(client, gs.type, gs.removebg or gs.bg, gs.model, gs.skin, gs.remove, gs.remsubmat or gs.submat)
				else
					nut.newchar.setBody(client, gs.type, -1, gs.model, gs.skin, gs.custombg, gs.remsubmat or gs.submat)
				end
			else
				nut.newchar.setBodygroups(client, gs.type, gs.remove or gs.custombg or gs.rem, gs.remsubmat or gs.submat or gs.sub)
			end
		end

		if(self.gsresetsubmat and client.bm) then
			--manually ugh
			character:setData("gsub")
			client.bm.t:SetSubMaterial()
			client.bm.b:SetSubMaterial()
		end
	end

	if (character:getData("oldMdl")) then
		character:setModel(character:getData("oldMdl"))
		character:setData("oldMdl", nil)

		--reapply submaterials
		local ply = client
		local char = character

		ply:SetSubMaterial()

		local mats = ply:GetMaterials()
		local mat = {}
		for k,v in ipairs(mats) do
			if(string.find(v, "eyeball_l")) then
				mat[#mat+1] = {mat = k-1, type = "l"}
			end
			if(string.find(v, "eyeball_r")) then
				mat[#mat+1] = {mat = k-1, type = "r"}
			end
		end
	
		if(char:getData("eyes")) then
			if(char:getData("eyes") == "blue") then
				for k,v in ipairs(mat) do
					ply:SetSubMaterial(v.mat, v.type == "l" and "models/bloo_ltcom_zel/citizens/eyeball_l_blue" or "models/bloo_ltcom_zel/citizens/eyeball_r_blue")
				end
			elseif(char:getData("eyes") == "green") then
				for k,v in ipairs(mat) do
					ply:SetSubMaterial(v.mat, v.type == "l" and "models/bloo_ltcom_zel/citizens/eyeball_l_green" or "models/bloo_ltcom_zel/citizens/eyeball_r_green")
				end
			elseif(char:getData("eyes") == "cyber") then
				for k,v in ipairs(mat) do
					ply:SetSubMaterial(v.mat, v.type == "l" and "models/sky/eyeball_cyber_l" or "models/sky/eyeball_cyber_r")
				end
			else
				for k,v in ipairs(mat) do
					ply:SetSubMaterial(v.mat)
				end
			end
		else
			for k,v in ipairs(mat) do
				ply:SetSubMaterial(v.mat)
			end
		end
		
		--submaterials from items
		for k,v in pairs(char:getData("submat", {})) do
		local mat
		for k2,v2 in ipairs(mats) do
			if(string.find(v2, k)) then
				mat = k2-1
			end
		end
		if(mat) then
			ply:SetSubMaterial(mat, v)
		end
		end
		
		ply:SetupHands()

		hook.Run("PlayerRemoveOutfitModel", ply, self)
	end
	
	if (self.newSkin) then
		if (character:getData("oldSkin")) then
			client:SetSkin(character:getData("oldSkin"))
			character:setData("skin", character:getData("oldSkin"))
			character:setData("oldSkin", nil)
		else
			client:SetSkin(character:getData("skin", 0))--0)
		end
	end

	local bgs = self.bodyGroups or {}
	if(!self.getBodygroupsKeep and self.getBodyGroups) then
		bgs = self:getBodyGroups(client)
	elseif(self.getBodygroupsKeep) then
		bgs = self:getBodygroupsKeep(client)
	end

	local groups = character:getData("groups", {})
	for k, v in pairs(bgs) do
		if(k == "keep") then continue end
		local index = client:FindBodygroupByName(k)

		if (index > -1) then
			client:SetBodygroup(index, bgs.keep and v or 0)


			if(bgs.keep) then
				groups[index] = v
			else
				if (groups[index]) then	
					groups[index] = nil
				end
			end
		end
	end
	character:setData("groups", groups)

	if (self.attribBoosts) then
		for k, _ in pairs(self.attribBoosts) do
			character:removeBoost(self.uniqueID, k)
		end
	end

	if(self.isBag) then
		netstream.Start(client, "closeBag", self:getData("id"))
	end

	if(self.addWeight or self:getData("addWeight")) then
		character:getInv():setData("maxWeight", character:getInv():getMaxWeight()-self:getData("addWeight", self.addWeight or 0))
	end

	if(self.overlaytype) then
		character:setData("ovr")
	end
	
	if(self:getData("artcnt") or self.artifactCnt) then
		character:setData("exart")
	end

	--if this goes away on reconnection, 
	--can always use initial spawn to check through everyone 
	--and make sure this gets networked to the new player
	if(self.fakeFaction or self:getData("fakeFaction")) then
		character:setData("fakeFac", nil, nil, player.GetAll())
	end

	hook.Run("PlayerRemoveOutfitEnd", client, self)
end

-- On item is dropped, Remove a weapon from the player and keep the ammo in the item.
ITEM:hook("drop", function(item)
	if (item:getData("equip")) then
		item:RemoveOutfit(item.player)
		item:setData("wasequipped", true)
	end
end)

ITEM.functions.UpDisplay = { -- sorry, for name order.
	name = "Display Upgrade List",
	tip = "equipTip",
	icon = "icon16/report.png",
	sound = "interface/inv_properties.ogg",
	onClick = function(item)
		if(table.Count(item:getData("upgrades", {})) != 0) then
			local str = "Upgrade List: "
			for k,v in pairs(item:getData("upgrades")) do
				str = str..suit_getUpgradeName(k)..", "
			end
		  
			str = str:sub(1, -3)
			print(str)
		else
			print("The suit has no upgrades.")
		end
	end,
	onRun = function(item)
		item.player:notify("The list of upgrades was printed into console")
		
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
-- On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	sound = "interface/inv_properties.ogg",
	onRun = function(item)
		if(item.canRemove) then
			local ply = item.player
			local succ, err = item:canRemove(ply)
			if(!succ) then
				item.player:notify(err, 3)
				return false
			end
		end
		
		if((item:getData("artcnt") or item.artifactCnt)
			and equipTblCount(item.player:getChar(), "art", 0) > 1) then
			item.player:notify("Cannot unequip due to artifact containers.", 3)
			return false
		end

		item:RemoveOutfit(item.player)
		
		if(item.unequipSound) then
			item.player:EmitSound(item.unequipSound, 60)
		end
		
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") == true)
	end
}
ITEM.functions.deathun = { -- unequip for death for gs bodygroups
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	onRun = function(item)
		--[[
		if(item.player:getChar():getData("groups") and !item.player:getChar():getData("dedgroups")) then
			item.player:getChar():setData("dedgroups", item.player:getChar():getData("groups"))
		end
		]]
		item:setData("deathun", true)

		item:RemoveOutfit(item.player)
		if(item.gs) then
			if(item.gs.type == "top") then
			item.player:getChar():setData("gdtop", item.gs.bg, nil, player.GetAll())
			item.player:getChar():setData("gdtopskin", item.gs.skin, nil, player.GetAll())
			if(item.gs.model) then
				item.player:getChar():setData("gcustomtop", item.gs.model, nil, player.GetAll())
			end
			end
			if(item.gs.type == "seperate") then
			item.player:getChar():setData("gdtop", item.gs.bg, nil, player.GetAll())
			item.player:getChar():setData("gdtopskin", item.gs.skin, nil, player.GetAll())
			item.player:getChar():setData("gdbot", -1, nil, player.GetAll())
			if(item.gs.model) then
				item.player:getChar():setData("gcustomtop", item.gs.model, nil, player.GetAll())
			end
			end
			if(item.gs.type == "bot") then
			item.player:getChar():setData("gdbot", item.gs.bg, nil, player.GetAll())
			item.player:getChar():setData("gdbotskin", item.gs.skin, nil, player.GetAll())
			if(item.gs.model) then
				item.player:getChar():setData("gcustombot", item.gs.model, nil, player.GetAll())
			end
			end
		end
		
		return false
	end,
	onCanRun = function(item)
		return false
	end
}

-- On player eqipped the item, Gives a weapon to player and load the ammo data from the item.
ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	sound = "interface/inv_properties.ogg",
	onRun = function(item)
		local char = item.player:getChar()
		local items = char:getInv():getItems()

		if(item.canWear) then
			local ply = item.player
			local succ, err = item:canWear(ply)
			if(!succ) then
				item.player:notify(err, 3)
				return false
			end
		end

		for k, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = nut.item.instances[v.id]

				if(!itemTable:getData("equip") or !v.outfitCategory) then 
					continue --dont even bother
				end 

				local sameout = false
				local vout = {}
				for k2,v2 in pairs(string.Split(v.outfitCategory, ";")) do
					vout[v2] = true
				end
				for k2,v2 in pairs(string.Split(item.outfitCategory, ";")) do
					if(vout[v2]) then
						sameout = true
						break
					end
				end
					--old to replace if sameout doesnt work v.outfitCategory == item.outfitCategory
				if ((itemTable.pacData or itemTable.pacF) and sameout and itemTable:getData("equip")) then
					item.player:notify("You're already equipping something that conflicts with this outfit.", 3)

					return false
				end
			end
		end

		item:setData("equip", true)
		
		if(item.pacF and item.pacM) then
			if(item.player:isFemale()) then
				item.player:addPart(item.uniqueID.."_fem", item)
			else
				item.player:addPart(item.uniqueID.."_male", item)
			end
		elseif(#item.pacData != 0) then
			item.player:addPart(item.uniqueID, item)
		end


		if(item.gs or item.getCustomGS) then --model is optional
			if(!item.getCustomGS) then
			nut.newchar.setBody(item.player, item.gs.type, item.gs.bg, item.gs.model, item.gs.skin, item.gs.custombg, item.gs.submat) --YOU DID THIS
			else
				local gs, bgsonly = item:getCustomGS()
				if(!bgsonly) then
					nut.newchar.setBody(item.player, gs.type, gs.bg, gs.model, gs.skin, gs.custombg, gs.submat) --YOU DID THIS
				else
					nut.newchar.setBodygroups(item.player, gs.type, gs.custombg or gs.bgs, gs.submat or gs.sub)
				end
			end
		end

		if (type(item.onGetReplacement) == "function") then
			char:setData("oldMdl", char:getData("oldMdl", item.player:GetModel()))
			char:setModel(item:onGetReplacement())
			--wipe 0 and 1 submaterials just incase
			item.player:SetSubMaterial()
			item.player:SetupHands()
		elseif (item.replacement or item.replacements) then
			char:setData("oldMdl", char:getData("oldMdl", item.player:GetModel()))

			if (type(item.replacements) == "table") then
				if (#item.replacements == 2 and type(item.replacements[1]) == "string") then
					char:setModel(item.player:GetModel():gsub(item.replacements[1], item.replacements[2]))
				else
					for k, v in ipairs(item.replacements) do
						char:setModel(item.player:GetModel():gsub(v[1], v[2]))
					end
				end
				
			else
				char:setModel(item.replacement or item.replacements)
			end
			--wipe 0 and 1 submaterials just incase
			item.player:SetSubMaterial()
			item.player:SetupHands()
		end

		if(item:getData("skin")) then --dynamic skins (via crafting or watever)
			char:setData("oldSkin", item.player:GetSkin())
			char:setData("skin", item:getData("skin")) --aha fixd
			item.player:SetSkin(item:getData("skin"))
		elseif (item.newSkin) then
			char:setData("oldSkin", item.player:GetSkin())
			char:setData("skin", item.newSkin) --aha fixd
			item.player:SetSkin(item.newSkin)
		end

		if(item.wipebgs) then
			item.player:SetBodyGroups("00000000")
		end

		local bgs = item.bodyGroups or {}
		if(item.getBodyGroups) then
			bgs = item:getBodyGroups(item.player)
		end
		
		if (table.Count(bgs) != 0) then
			local groups = {}

			for k, value in pairs(bgs) do
				local index = item.player:FindBodygroupByName(k)

				if (index > -1) then
					groups[index] = value
				end
			end

			local newGroups = char:getData("groups", {})

			for index, value in pairs(groups) do
				newGroups[index] = value
				item.player:SetBodygroup(index, value)
			end

			if (table.Count(newGroups) > 0) then
				char:setData("groups", newGroups)
			end
		end

		local res = item:GetResists()
		if(res["hud"]) then
			net.Start("PlayerSetHud")
			net.WriteBool(true)
			net.Send(client)
		end

		if (item.attribBoosts) then
			for k, v in pairs(item.attribBoosts) do
				char:addBoost(item.uniqueID, k, v)
			end
		end
		
		if(item.addWeight or item:getData("addWeight")) then
			char:getInv():setData("maxWeight", char:getInv():getMaxWeight()+item:getData("addWeight", item.addWeight or 0))
		end
		
		if(item.overlaytype) then
			char:setData("ovr", item.overlaytype)
		end

		if(item:getData("artcnt")) then
			char:setData("exart", item:getData("artcnt"))
		elseif(item.artifactCnt) then
			char:setData("exart", item.artifactCnt)
		end
		
		if(item.fakeFaction or item:getData("fakeFaction")) then
			char:setData("fakeFac", item:getData("fakeFaction", item.fakeFaction), nil, player.GetAll())
		end
		
		if(item.equipSound) then
			item.player:EmitSound(item.equipSound, 60)
		end
		
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") != true)
	end
}
function ITEM:onLoadout()
	if(self:getData("equip")&&(self.gs or self.getCustomGS)) then
		print("uhhh", self.player)
		if(!self.getCustomGS) then
		nut.newchar.setBody(self.player, self.gs.type, self.gs.bg, self.gs.model, self.gs.skin, self.gs.custombg, self.gs.submat) --YOU DID THIS
		else
			local gs, bgsonly = self:getCustomGS()
			if(!bgsonly) then
				nut.newchar.setBody(self.player, gs.type, gs.bg, gs.model, gs.skin, gs.custombg, gs.submat) --YOU DID THIS
			else
				local ply = self.player
				timer.Simple(0, function() --lets try this
					nut.newchar.setBodygroups(ply, gs.type, gs.bgs, gs.submat)
				end)
			end
		end

	end
	local char = self:getOwner():getChar()
	if(self:getData("equip") and !char:getData("groups")) then
		local bgs = self.bodyGroups or {}
		if(self.getBodyGroups) then
			bgs = self:getBodyGroups(self:getOwner())
		end
		
		if (table.Count(bgs) != 0) then
			local groups = {}

			for k, value in pairs(bgs) do
				local index = self:getOwner():FindBodygroupByName(k)

				if (index > -1) then
					groups[index] = value
				end
			end

			local newGroups = char:getData("groups", {})

			for index, value in pairs(groups) do
				newGroups[index] = value
				self:getOwner():SetBodygroup(index, value)
			end

			if (table.Count(newGroups) > 0) then
				char:setData("groups", newGroups)
			end
		end
	end
end

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory and self:getData("equip")) then
		return false
	end

	return true
end

function ITEM:onTransfered(oldInventory, newInventory)

	if(self:getData("deathun")) then
		--undressing the ragdoll if a clothing item is moved out of the corpse inventory
		if(oldInventory and oldInventory.vars and oldInventory.vars.invType and string.find(oldInventory.vars.invType, "corpse.")) then
			local rgs = ents.FindByClass("prop_ragdoll")
			local rag
			for k,v in pairs(rgs) do
				if(v:GetNWInt("nut_inventoryID", -1) == oldInventory:getID()) then
					rag = v
					break
				end
			end
			print(rag)
			self:setData("deathun")

			if(self.gs) then
				local data = {}
				if(self.gs.type == "top") then
					data.top = 0
					data.topskin = 0
				end
				if(self.gs.type == "seperate") then
					data.top = 0
					data.topskin = 0
					data.bot = 0
				end
				if(self.gs.type == "bot") then
					data.bot = 0
					data.botskin = 0
				end
				if(rag) then
					--this should change the bodygroup to nothing
					clothesnonply(rag, data, newInventory:getReceiver()) --shouldnt need the player
				end
			end

		
			local bgs = self.bodyGroups or {}
			if(self.getBodyGroups) then
				bgs = self:getBodyGroups(rag)
			end

			for k, v in pairs(bgs) do
				local index = rag:FindBodygroupByName(k)

				if (index > -1) then
					rag:SetBodygroup(index, 0)
				end
			end
		end
	end
end

function ITEM:onRemoved()
	local inv = nut.item.inventories[self.invID]
	if(inv) then
	local receiver = inv.getReceiver and inv:getReceiver()

	if (IsValid(receiver) and receiver:IsPlayer()) then
		if (self:getData("equip")) then
			self:RemoveOutfit(receiver)
		end
	end
	end
	
	local invID = self:getData("id")
	if (invID) then
		nut.inventory.deleteByID(invID)
	end
end

local INVENTORY_TYPE_ID = "grid"
--defaults
ITEM.invWidth = 2
ITEM.invHeight = 2

function ITEM:onInstanced()
	if(!self:getData("armor")) then
		self:setData("armor", self.armor)
	end
	if(!self:getData("resists")) then
		self:setData("resists", self.resists)
	end
	if(!self:getData("upgrades")) then
		self:setData("upgrades", {})
	end
	
	if(self.isBag) then
		local data = {
			item = self:getID(),
			w = self.invWidth,
			h = self.invHeight
		}
		nut.inventory.instance(INVENTORY_TYPE_ID, data)
			:next(function(inventory)
				self:setData("id", inventory:getID())
				hook.Run("SetupBagInventoryAccessRules", inventory)
				inventory:sync()
				self:resolveInvAwaiters(inventory)
			end)
	end
end

--uh inv shit here  
function ITEM:onRestored()
	local invID = self:getData("id")
	if (invID) then
		nut.inventory.loadByID(invID)
			:next(function(inventory)
				hook.Run("SetupBagInventoryAccessRules", inventory)
				self:resolveInvAwaiters(inventory)
			end)
	end
end  

function ITEM:getInv()
	return nut.inventory.instances[self:getData("id")]
end
function ITEM:onSync(recipient)
	local inventory = self:getInv()
	if (inventory) then
		inventory:sync(recipient)
	end
end
function ITEM.postHooks:drop()
	local invID = self:getData("id")
	if (invID) then
		net.Start("nutInventoryDelete")
			net.WriteType(invID)
		net.Send(self.player)
	end
end

function ITEM:onCombine(other)
	local client = self.player
	local invID = self:getInv() and self:getInv():getID() or nil
	if (not invID) then return end

	-- If other item was combined onto this item, put it in the bag.
	local res = hook.Run(
		"HandleItemTransferRequest",
		client,
		other:getID(),
		nil,
		nil,
		invID
	)
	if (not res) then return end

	-- If an attempt was made, either report the error or make a
	-- "success" sound.
	res:next(function(res)
		if (not IsValid(client)) then return end
		if (istable(res) and type(res.error) == "string") then
			return client:notifyLocalizedL(res.error, 3)
		end
		client:EmitSound(
			"physics/cardboard/cardboard_box_impact_soft2.wav",
			50
		)
	end)
end

if (SERVER) then
	function ITEM:onDisposed()
		local inventory = self:getInv()
		if (inventory) then
			inventory:destroy()
		end
	end

	function ITEM:resolveInvAwaiters(inventory)
		if (self.awaitingInv) then
			for _, d in ipairs(self.awaitingInv) do
				d:resolve(inventory)
			end
			self.awaitingInv = nil
		end
	end

	function ITEM:awaitInv()
		local d = deferred.new()
		local inventory = self:getInv()

		if (inventory) then
			d:resolve(inventory)
		else
			self.awaitingInv = self.awaitingInv or {}
			self.awaitingInv[#self.awaitingInv + 1] = d
		end

		return d
	end
end

ITEM.functions.View = {
	icon = "icon16/briefcase.png",
	onClick = function(item)
		local inventory = item:getInv()
		if (not inventory) then return false end

		local panel = nut.gui["inv"..inventory:getID()]
		local parent = item.invID and nut.gui["inv"..item.invID] or nil

		if (IsValid(panel)) then
			panel:Remove()
		end

		if (inventory) then
			local panel = nut.inventory.show(inventory, parent)
			if (IsValid(panel)) then
				panel:ShowCloseButton(true)
				panel:SetTitle(item:getName())
			end
		else
			local itemID = item:getID()
			local index = item:getData("id", "nil")
			ErrorNoHalt(
				"Invalid inventory "..index.." for bag item "..itemID.."\n"
			)
		end
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity) and item.isBag and item:getInv() and item:getData("equip") == true
	end
}

--functions (besides default equip stuff) needed:
--display current upgrades list (to console), also list # of current upgrades on desc
--also:
--display on desc:
--current levels+durabilities,
--resists
--upgrade paths list

--[[
	returns table like:
	{
		chest = {level=ARMOR_II, durability=100},
	}
]]
function ITEM:GetArmor()
	return self:getData("armor", {})
end

--[[
	returns table like:
	{
		["phys"] = 0, --1 = no damage taken, 0 = ignored
	}
]]

function ITEM:GetResists()
	return self:getData("resists", {})
end

--[[
	returns table like this:
	{
		["uniqueid"] = "display name",
	}
]]
function ITEM:GetUpgrades()
	return self:getData("upgrades", {})
end