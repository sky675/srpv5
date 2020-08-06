ITEM.name = "Headlamp"
ITEM.model = "models/props_junk/cardboard_box004a.mdl"
ITEM.desc = "A headlamp with strap. Doesn't include batteries."
ITEM.price = 4390
ITEM.weight = 0.186
ITEM.flag = "N"

ITEM.destroyval = {
	["comp_scrap_metal"] = 2,
	["comp_tech1"] = 2,
	["comp_wire1"] = 2,
}

-- Inventory drawing
if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

ITEM:hook("drop", function(item)
	local client = item.player
	local wep = client:GetActiveWeapon()
	if(item:getData("equip")) then
		item:setData("equip", nil)
		if (item.player:FlashlightIsOn()) then --change to false
			if(wep and ((wep.GetStat and wep:GetStat("HasFlashlight")) or wep.HasFlashlight)) then-- and !nut.plugin.list["flashlight"]:BatteryIsEmpty(wep.nutItem)) then
				return --dont worry about it if the weapon has a flashlight
			end
		
			item.player:Flashlight(false)
		end
	end
end)

ITEM.functions.EquipUn = { --i hate this lol
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	onRun = function(item)
		item:setData("equip", nil)

		if (item.player:FlashlightIsOn()) then --change to false
			local wep = client:GetActiveWeapon()
			if(wep and ((wep.GetStat and wep:GetStat("HasFlashlight")) or wep.HasFlashlight)) then-- and !nut.plugin.list["flashlight"]:BatteryIsEmpty(wep.nutItem)) then
				return --dont worry about it if the weapon has a flashlight
			end
		
			item.player:Flashlight(false)
		end

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

		local items = client:getChar():getInv():getItems()
		for k,v in pairs(items) do
			if((v.uniqueID == "headlamp" or v.uniqueID == "flashlight") and v:getData("equip") == true) then
				client:notify("You already have a flashlight or headlamp equipped!")
				return
			end
		end

		item:setData("equip", true)

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") != true)
	end
}

function ITEM:onTransfered()
	local client = self:getOwner()
	if(!IsValid(client)) then return end
	local wep = client:GetActiveWeapon()
	if(wep and ((wep.GetStat and wep:GetStat("HasFlashlight")) or wep.HasFlashlight)) then-- and !nut.plugin.list["flashlight"]:BatteryIsEmpty(wep.nutItem)) then
		return --dont worry about it if the weapon has a flashlight
	end

	if (IsValid(client) and client:FlashlightIsOn()) then
		client:Flashlight(false)
	end
end

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory and self:getData("equip")) then
		return false
	end

	return true
end

function ITEM:onRemoved()
	local client = self:getOwner()
	if (IsValid(client) and client:FlashlightIsOn()) then
		if(wep and ((wep.GetStat and wep:GetStat("HasFlashlight")) or wep.HasFlashlight)) then-- and !nut.plugin.list["flashlight"]:BatteryIsEmpty(wep.nutItem)) then
			return --dont worry about it if the weapon has a flashlight
		end
		client:Flashlight(false)
	end
end