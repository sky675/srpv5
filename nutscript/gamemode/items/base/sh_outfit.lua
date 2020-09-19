ITEM.name = "Outfit"
ITEM.desc = "A Outfit Base."
ITEM.category = "Outfit"
ITEM.model = "models/props_c17/BriefCase001a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "model"
ITEM.pacData = {}

-- ITEM.armor = 25 -- How much armor to add/remove upon wearing/removing.

--[[
-- This will change a player's skin after changing the model.
-- Keep in mind it starts at 0.
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

-- This will apply body groups.
ITEM.bodyGroups = {
	["blade"] = 1,
	["bladeblur"] = 1
}
u can set specific bodygroups by adding a getBodyGroups(ply) function on the item, 
use this instead of bodyGroups

-- You can also use PAC (if installed) to setup an outfit. Go to your outfit's
-- file in your GMod's data folder. Copy the contents.
ITEM.pacData = {
	-- PASTE CONTENT HERE>
}
]]

-- Inventory drawing
if (CLIENT) then
	-- Draw camo if it is available.
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

function ITEM:removeOutfit(client)
	local character = client:getChar()

	self:setData("equip", nil)

	--newchar support fuck you
	if(self.gs) then
		nut.newchar.setBody(client, self.gs.type, -1, self.gs.model, 0)
	end

	-- Revert the model, skin, and bodygroups.
	character:setModel(character:getData("oldMdl", character:getModel()))
	character:setData("oldMdl", nil)

	client:SetSkin(character:getData("oldSkin", character:getData("skin", 0)))
	character:setData("oldSkin", nil)

	local bgs = self.bodyGroups or {}
	if(self.getBodyGroups) then
		bgs = self:getBodyGroups(client)
	end

	for k, v in pairs(bgs) do
		local index = client:FindBodygroupByName(k)

		if (index > -1) then
			client:SetBodygroup(index, 0)

			local groups = character:getData("groups", {})

			if (groups[index]) then
				groups[index] = nil
				character:setData("groups", groups)
			end
		end
	end

	-- Then, remove PAC parts from this outfit.
	if (self.pacData and client.removePart) then
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

		client:removePart(uni)
	end

	-- Remove any boosts.
	if (self.attribBoosts) then
		for k, _ in pairs(self.attribBoosts) do
			character:removeBoost(self.uniqueID, k)
		end
	end

	-- Remove armor added by this item.
	if (isnumber(self.armor)) then
		client:SetArmor(math.max(client:Armor() - self.armor, 0))
	end

	self:call("onTakeOff", client)
end

function ITEM:wearOutfit(client, isForLoadout)
	if (isnumber(self.armor)) then
		client:SetArmor(client:Armor() + self.armor)
	end
	local uni
	if(self.pacF and self.pacM) then

		if(item.player:isFemale()) then
			uni = self.uniqueID.."_fem"
		else
			uni = self.uniqueID.."_male"
		end
	elseif(self.pacData) then
		uni = self.uniqueID
	end

	if (uni and client.addPart) then
		client:addPart(uni)
	end

	self:call("onWear", client, nil, isForLoadout)
end

ITEM:hook("drop", function(item)
	if (item:getData("equip")) then
		item:removeOutfit(item.player)
	end
end)

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	onRun = function(item)
		item:removeOutfit(item.player)
		
		if(item.unequipSound) then
			item.player:EmitSound(item.unequipSound, 60)
		end

		return false
	end,
	onCanRun = function(item)
		return not IsValid(item.entity) and item:getData("equip") == true
	end
}

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	onRun = function(item)
		local char = item.player:getChar()
		local items = char:getInv():getItems()

		if(item.canWear) then
			local succ, err = item:canWear(item.player)
			if(!succ) then
				item.player:notify(err, 3)
				return false
			end
		end

		for id, other in pairs(items) do
			if (
				item ~= other and
				--multi category support?
				string.find(other.outfitCategory or "", item.outfitCategory) and
				--item.outfitCategory == other.outfitCategory and
				other:getData("equip")
			) then
				item.player:notifyLocalizedL("sameOutfitCategory", 3)
				return false
			end
		end

		item:setData("equip", true)

		--again newchar stuff fuck you
		if(item.gs) then --model is optional
			nut.newchar.setBody(item.player, item.gs.type, item.gs.bg, item.gs.model, item.gs.skin, item.gs.custombg, item.gs.submat) --YOU DID THIS
		end

		char:setData(
			"oldMdl",
			char:getData("oldMdl", item.player:GetModel())
		)

		-- Do model substitutions.
		if (type(item.onGetReplacement) == "function") then
			char:setModel(item:onGetReplacement())
		elseif (item.replacement or item.replacements) then
			if (type(item.replacements) == "table") then
				if (
					#item.replacements == 2 and isstring(item.replacements[1])
				) then
					local newModel = item.player:GetModel():lower():gsub(
						item.replacements[1],
						item.replacements[2]
					):lower()
					char:setModel(newModel)
				else
					for k, v in ipairs(item.replacements) do
						char:setModel(item.player:GetModel():gsub(v[1], v[2]))
					end
				end
			else
				char:setModel(tostring(item.replacement or item.replacements))
			end
		end

		-- Then apply the new skin for the model.
		if (isnumber(item.newSkin)) then
			char:setData("oldSkin", item.player:GetSkin())
			char:setData("skin", item.newSkin)
			item.player:SetSkin(item.newSkin)
		end

		-- Then set appropriate body groups for the model.
		local bgs = item.bodyGroups-- or {}
		if(item.getBodyGroups) then
			bgs = item:getBodyGroups(item.player)
		end

		if (istable(bgs)) then
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

		-- And add any attribute boosts.
		if (istable(item.attribBoosts)) then
			for attribute, boost in pairs(item.attribBoosts) do
				char:addBoost(item.uniqueID, attribute, boost)
			end
		end

		if(item.equipSound) then
			item.player:EmitSound(item.equipSound, 60)
		end

		item:wearOutfit(item.player, false)

		return false
	end,
	onCanRun = function(item)
		return not IsValid(item.entity) and item:getData("equip") ~= true
	end
}

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory and self:getData("equip")) then
		return false
	end

	return true
end

function ITEM:onLoadout()
	if (self:getData("equip")) then
		self:wearOutfit(self.player, true)

		--again newchar stuff
		if(self.gs) then
			nut.newchar.setBody(self.player, self.gs.type, self.gs.bg, self.gs.model, self.gs.skin, self.gs.custombg, self.gs.submat)
		end

		local char = self.player:getChar()
		if(!char:getData("groups")) then --becuz there were issues
			local bgs = self.bodyGroups-- or {}
			if(self.getBodyGroups) then
				bgs = self:getBodyGroups(self.player)
			end
	
			if (istable(bgs)) then
				local groups = {}
	
				for k, value in pairs(bgs) do
					local index = self.player:FindBodygroupByName(k)
	
					if (index > -1) then
						groups[index] = value
					end
				end
	
				local newGroups = char:getData("groups", {})
	
				for index, value in pairs(groups) do
					newGroups[index] = value
					self.player:SetBodygroup(index, value)
				end
	
				if (table.Count(newGroups) > 0) then
					char:setData("groups", newGroups)
				end
			end
		end
	end
end

function ITEM:onRemoved()
	local inv = nut.item.inventories[self.invID]
	if (inv) then
		local receiver = inv.getReceiver and inv:getReceiver()
		if (IsValid(receiver) and receiver:IsPlayer()) then
			if (self:getData("equip")) then
				self:removeOutfit(receiver)
			end
		end
	end
end

function ITEM:onWear(isFirstTime)
end

function ITEM:onTakeOff()
end
