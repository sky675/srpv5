ITEM.name = "artifact container base"
ITEM.model = "models/props_junk/PopCan01a.mdl"
ITEM.desc = ""
--ITEM.category = "Miscellaneous"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1
ITEM.isSafe = false --if true, the artifact(s) inside wont add to radiation
ITEM.contSlots = 1

function ITEM:getDesc()
	local str = self.desc.."\n"
	local ind = self:getData("res", {})
	for i=1,self.contSlots do
		str = str.."\nSlot: "..tostring(i)..": "
		if(ARTIFACT_DESCS[ind[i]]) then
			str = str..ARTIFACT_DESCS[ind[i]].name
		else
			str = str.."Empty"
		end
	end

	return str
end

--adding/removing overtime stuff like heals and such
function ITEM:removeBuffs()
	local res = self:getData("res", {})
	for k,v in pairs(res) do
		if(ARTIFACT_DESCS[v] and ARTIFACT_DESCS[v].onRem) then
			ARTIFACT_DESCS[v].onRem(self, self.player or self:getOwner())
		end
	end
end
function ITEM:addBuffs()
	local res = self:getData("res", {})
	for k,v in pairs(res) do
		if(ARTIFACT_DESCS[v] and ARTIFACT_DESCS[v].onAdd) then
			ARTIFACT_DESCS[v].onAdd(self, self.player or self:getOwner())
		end
	end
end
function ITEM:addLoadoutBuffs()
	local res = self:getData("res", {})
	for k,v in pairs(res) do
		if(ARTIFACT_DESCS[v] and ARTIFACT_DESCS[v].onAddLoadout) then
			ARTIFACT_DESCS[v].onAddLoadout(self, self.player or self:getOwner())
		end
	end
end

function ITEM:onLoadout()
	if(self:getData("equip")) then
		self:addLoadoutBuffs()
	end
end

ITEM:hook("drop", function(item)
	local client = item.player
	local wep = client:GetActiveWeapon()
	if(item:getData("equip")) then
		item:setData("equip", nil)
		item:removeBuffs()
	end
end)

ITEM.functions.EquipUn = { --i hate this lol
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	onRun = function(item)
		item:setData("equip", nil)

		item:removeBuffs()

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") == true)
	end
}

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	onRun = function(item)
		local client = item.player

		item:setData("equip", true)

		item:addBuffs()

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") != true and !item.isSafe)
	end
}

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory and self:getData("equip")) then
		return false
	end

	return true
end

function ITEM:onRemoved()
	local client = self:getOwner()
	if (IsValid(client)) then
		self:removeBuffs()
	end
end

--this should still work lol
for n=1, 5 do
	local i = tostring(n)
	ITEM.functions["store"..i] = {
		name = "Store ["..i.."]",
		tip = "store artifact",
		icon = "icon16/cart_put.png",
		isMulti = true,
		multiOptions = function(item, ply)
			local options = {}
			local inv = ply:getChar():getInv()
			for k,v in pairs(inv:getItems()) do
				if(v.base == "base_artifact" and !v.junkArt) then
					options[v.artid] = {
						name = v.name,
						data = v.id
					}
				end
			end

			return options
		end,
		onRun = function(item, sub)
			local art = {}
			local inv = item.player:getChar():getInv():getItems()
			local res = item:getData("res", {})
			if(inv[sub]) then
				res[n] = inv[sub].artid
				inv[sub]:remove()
			end
			--[[for k,v in pairs(inv:getItems()) do
				if(v.base == "base_artifacts") then
					if(v.artifactID == sub) then
						art = v
						break
					end
				end
			end]]

			--item:setData("slot"..i, art.uniqueID)
			--art:remove()

			return false
		end,
		onCanRun = function(item, sub)
			local cnt = item.contSlots or 1
			if(cnt < n) then
				return false
			end

			if(item:getData("res", {})[n]) then return false end
			local done = false

			local ply
			if(IsValid(item.player)) then
				ply = item.player
			else
				ply = LocalPlayer()
			end

			local inv = ply:getChar():getInv()
			for k,v in pairs(inv:getItems()) do
				if(v.base == "base_artifact") then
					done = true
					break
				end
			end

			return !IsValid(item.entity) and !item:getData("equip") and done
		end
	}

	ITEM.functions["lemove"..i] = {
		name = "Remove ["..i.."]",
		tip = "remove lol",
		icon = "icon16/cart_remove.png",
		onRun = function(item)
			local res = item:getData("res", {})
			if(res[n]) then
				local uni = ARTIFACT_DESCS[res[n]].itemid
				local succ = item.player:getChar():getInv():add(uni)
				if(succ) then
					res[n] = nil
				end
				item:setData("res", res)
			end

			return false
		end,
		onCanRun = function(item)
			return(!IsValid(item.entity) and !item:getData("equip") and (item:getData("res", {})[n] != nil))
		end
	}
end