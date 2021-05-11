ITEM.name = "Weapon"
ITEM.desc = "A Weapon."
ITEM.category = "Weapons"
ITEM.model = "models/weapons/w_pistol.mdl"
ITEM.class = "weapon_pistol"
ITEM.width = 2
ITEM.height = 2
ITEM.isWeapon = true

--default atts: ITEM.defaultMods
--default ammo (autofill): ITEM.defaultAmmo

-- Inventory drawing
if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		elseif(item:getData("broken")) then
			surface.SetDrawColor(220, 70, 70, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

function ITEM:calcPrice(origprice)
	local price = origprice
	local ups = self:getData("atts")
	--if theyre selling it with stuff still attached, 
	--give them some of the price back, but not all
	if(ups) then
		for k,v in pairs(ups) do
			local item = nut.item.get(v)
			if(item) then 
				price = price+item:getPrice()
			end
		end
	end

	return price
end

function ITEM:getWeight()
	return self:getData("maxWeight", self.weight)
end

function ITEM:getName()
	return self:getData("customName", self.name)
end

function ITEM:getDesc()
	local str = self.desc

	if(!self:getData("equip")) then
		str = str.."\nMag: "..tostring(self:getData("ammo", 0))
	end
	
	str = str.."\nDurability: "..tostring(math.floor(self:getData("durability", 100))).."%"
	
	local ups = self:getData("atts")
	
	if(ups) then
		local addstr = "Attachments:"
		for k,v in pairs(ups) do
			--if(k == 3||k == 4||k == 5) then continue end --skip the nut att
			if(!ArcCW.AttachmentTable[v]) then continue end
			
			addstr = addstr.." "..ArcCW.AttachmentTable[v].PrintName..","
		end
		addstr = addstr:sub(1, -2)
		addstr = addstr.."."
		--this is what happens when theres no valid atts, so make sure its not that
		if(addstr != "Attachments.") then
			str = str.."\n"..addstr
		end
	end

	--old thing, might as well keep it i guess
	if(self:getData("flavor")) then
		str = str.."\n\n<font=nutItemDescItalicFont>"..self:getData("flavor").."</font>"
	end

	return str
end

-- On item is dropped, Remove a weapon from the player and keep the ammo in the item.
ITEM:hook("drop", function(item)
	if (item:getData("equip")) then
		item:setData("equip", nil)

		local ply = item.player

		--helix had a good idea, make sure the owner is the same as the 1 calling this
		if(item.player != item:getOwner()) then
			ply = item:getOwner()
		end

		if(EQTBL) then
			local succ, res = equipTblRem(ply:getChar(), "weapon", item)
		end

		local weapon = ply:GetWeapon(item.class)	

		if (IsValid(weapon)) then
			item:setData("ammo", weapon:Clip1())

			ply:StripWeapon(item.class)
			ply:EmitSound(item.unequipSound or "interface/inv_items_generic_1.ogg", 80)
		end
	end
end)

-- On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/cross.png",
	onRun = function(item)
		item:Unequip(item.player, true)
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") == true)
	end
}
-- On player eqipped the item, Gives a weapon to player and load the ammo data from the item.
ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	onRun = function(item)
		item:Equip(item.player, true)
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") != true and item:getData("broken") != true)
	end
}

function ITEM:Equip(client, playSound)
	local char = client:getChar()
	local item = self
	if (client:HasWeapon(self.class)) then
		client:notify("Same type of weapon equipped", 3)
		return
	end

	local succ, res = equipTblAdd(char, "weapon", self)
	if(succ == false) then
		client:notify(res, 3)
		return
	end

	local weapon = client:Give(self.class, true)

	if (IsValid(weapon)) then
		weapon.ForceDefaultAmmo = 0 --ye this works
		local ammoType = weapon:GetPrimaryAmmoType()

		timer.Simple(0, function()
			client:SelectWeapon(weapon:GetClass())
			--client:SetActiveWeapon(weapon)
		end)

		if(playSound) then
			client:EmitSound(self.equipSound or "interface/inv_items_wpn_1.ogg", 80)
		end

		local ammoCount =  client:GetAmmoCount(weapon:GetPrimaryAmmoType())
		if (
			ammoCount == weapon:Clip1() and
			item:getData("ammo", 0) == 0
		) then
			client:RemoveAmmo(weapon:Clip1(), weapon:GetPrimaryAmmoType())
		end
		item:setData("equip", true)

		weapon:SetClip1(item:getData("ammo", 0))
		
		weapon.nutItem = item

		item:doAttach(weapon)
		
		if (item.onEquipWeapon) then
			item:onEquipWeapon(client, weapon)
		end
	else
		print(Format("[Nutscript] Weapon %s does not exist!", item.class))
	end
end
function ITEM:Unequip(client, playSound)
	local succ, res = equipTblRem(client:getChar(), "weapon", self)
	if(succ == false) then
		client:notify(res, 3)
		return false
	end

	local weapon = client:GetWeapon(self.class)	

	if (IsValid(weapon)) then
		weapon.nutItem = nil

		self:setData("ammo", weapon:Clip1())
		client:StripWeapon(self.class)
	else
		print(Format("[Nutscript] Weapon %s does not exist!", self.class))
	end
	
	if (playSound) then
		client:EmitSound(self.unequipSound or "interface/inv_items_generic_1.ogg", 80)
	end
	
	self:setData("equip", nil)

	if (self.OnUnequipWeapon) then
		self:OnUnequipWeapon(client, weapon)
	end
end

--detach atts
ITEM.functions.zDetach = {
	name = "Detach",
	tip = "unload",
	icon = "icon16/cross.png",
	isMulti = true,
	multiOptions = function(item, ply)
		local options = {}
		local atts = item:getData("atts", {})
		for k,v in pairs(atts) do
			--if(k == 3||k == 4||k == 5||k > 9) then continue end
			--if(!TFA.Attachments.Atts[v]) then continue end
			if(item.cantDetach and item.cantDetach[k]) then continue end --integrated supp
			options[v] = {
				name = ArcCW.AttachmentTable[v].PrintName,--TFA.Attachments.Atts[v].Name,
				--sound = "",
				data = k
			}
		end
		if(table.Count(options) == 0) then
			options["none"] = {
				name = "None Available",
				data = "notav"
			}
		end
		return options
	end,
	onRun = function(item, sub)
		if(sub == "notav" or sub == "" or sub == nil) then return false end
		local ply = item.player
		local wep
		if(ply:GetActiveWeapon().nutItem == item) then
			wep = ply:GetActiveWeapon()
		else
			wep = ply:GetWeapon(item.class)
		end
		local ats = item:getData("atts", {})
		local att = nut.item.get(ats[sub])
		if(!att) then
			ply:notify("the attachment you just tried to detach doesnt have an item, therefore shouldnt be detachable and its slot needs to be set as cantDetach, let an admin know pls, the att and slot was "..ats[sub].." and "..sub, 3)
			return false
		end
		if(IsValid(wep)) then   
			local slotids = {}
			for key, value in ipairs(wep.Attachments) do
				if(istable(value.Slot)) then
					for _, s in ipairs(value.Slot) do
						slotids[s] = key
					end
				else
					slotids[value.Slot] = key
				end
			end
			--remove attachment from wep
			ply.isattaching = true
			wep:Detach(slotids[sub])
			--this seems to be the only way i can check this
			local inst = wep.Attachments[slotids[sub]].Installed
			if(inst != nil and inst != wep.Attachments[slotids[sub]].EmptyFallback) then
				print("failed")
				return false
			end
		end
		local itd = ats[sub]
		if(!ply:getChar():getInv():add(itd)) then
			ply:notify("No room! item was dropped", 3)
			nut.item.spawn(itd, ply:getItemDropPos())
		end
		--add atts weight onto item
		item:sync(ply)
		item:setData("maxWeight", item:getData("maxWeight", item.weight)-att.weight)
		--ply:EmitSound("cw/detach.wav")
		if(item.defaultMods and item.defaultMods[sub] and item.defaultMods[sub] != "") then
			ats[sub] = item.defaultMods[sub] --return it to default
		else
			ats[sub] = nil
		end
		item:setData("atts", ats)

		return false
	end,
	onCanRun = function(item, sub)
		return (!IsValid(item.entity) and table.Count(item:getData("atts", {})) != 0)
	end
}

function ITEM:doAttach(weapon)
	if(!self:getData("equip")) then return end
	local ups = self:getData("atts", {})
	local slotids = {}
	for key, value in ipairs(weapon.Attachments) do
		if(istable(value.Slot)) then
			for _, s in ipairs(value.Slot) do
				slotids[s] = key
			end
		else
			slotids[value.Slot] = key
		end
	end

	--add atts
	timer.Simple(0, function()
	for slot,name in pairs(ups) do
		if(!slotids[slot]) then
			nut.log.addRaw("uh something didnt attach correctly "..self:getID().." "..self:getOwner():Name()..", the slot "..slot.." doesnt exist")
			continue 
		end
		local ply = self:getOwner()
		--this has a default thing and needs to be detached
		if(name == "") then
			ply.isattaching = true
			weapon:Detach(slotids[slot])
			if(weapon.Attachments[slotids[slot]].Installed != nil) then
				nut.log.addRaw("uh something didnt attach correctly "..self:getID().." "..self:getOwner():Name())
				self:getOwner():notify("uh something didnt attach correctly lmao", 3)
			end
		else
			ply.isattaching = true
			weapon:Attach(slotids[slot], name)
			if(weapon.Attachments[slotids[slot]].Installed != name) then
				nut.log.addRaw("uh something didnt attach correctly "..self:getID().." "..self:getOwner():Name())
				self:getOwner():notify("uh something didnt attach correctly lmao", 3)
			end
		end
	end
	timer.Simple(1, function()
		if(!weapon.NetworkWeapon) then return end --uhhh it do this
	weapon:NetworkWeapon() --this is doing fucky shit, maybe thisll get it
	end)
	end)
end


function ITEM:onLoadout()
	if (self:getData("equip")) then
		local client = self.player

		local weapon = client:Give(self.class)

		if (IsValid(weapon)) then
			client:RemoveAmmo(weapon:Clip1(), weapon:GetPrimaryAmmoType())

			weapon.nutItem = self
			weapon:SetClip1(self:getData("ammo", 0))
			
			self:doAttach(weapon) //uh? wasnt here before
			--[[local ups = self:getData("atts")
			--apply current atts
			]]
		else
			print(Format("[Nutscript] Weapon %s does not exist!", self.class))
		end
	end
end

function ITEM:onInstanced()
	if(self.defaultMods) then
		self:setData("atts", self.defaultMods)
	end

	--default ammo for nonrefillable guns ie ar3
	if(self.defaultAmmo) then
		self:setData("ammo", self.defaultAmmo)
	end
end

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (oldInventory:getID() != 0 and newInventory and self:getData("equip")
		and newInventory:getID() != oldInventory:getID()) then 
		--above should allow moving around while equipped
		return false
	end

	return true
end

function ITEM:onSave()
	local weapon = self.player:GetWeapon(self.class)

	if (IsValid(weapon)) then
		self:setData("ammo", weapon:Clip1())
	end
end

HOLSTER_DRAWINFO = HOLSTER_DRAWINFO or {}

-- Called after the item is registered into the item tables.
function ITEM:onRegistered()
	if (self.holsterDrawInfo) then
		HOLSTER_DRAWINFO[self.class] = self.holsterDrawInfo
	end
end

function ITEM:onRemoved()
	local inv = nut.item.inventories[self.invID]
	if(!inv) then return end --uh
	local receiver = inv.getReceiver and inv:getReceiver()

	if (IsValid(receiver) and receiver:IsPlayer()) then
		local weapon = receiver:GetWeapon(self.class)
		if(EQTBL) then
			local succ, res = equipTblRem(client:getChar(), "weapon", self)
		end

		if (IsValid(weapon)) then
			weapon:Remove()
		end
	end
end 