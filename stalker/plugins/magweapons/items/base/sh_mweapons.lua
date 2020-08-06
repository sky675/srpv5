ITEM.name = "Weapon"
ITEM.desc = "A Weapon."
ITEM.category = "Weapons"
ITEM.model = "models/weapons/w_pistol.mdl"
ITEM.class = "weapon_pistol"
ITEM.width = 2
ITEM.height = 2
ITEM.isWeapon = true
ITEM.weaponCategory = "sidearm"

--[[
	ITEM.magType = ""
ITEM.otherMagTypes = { --optional
	["attid"] = "name to display"
}

for conv things:
ITEM.convMagNames = {
	["attid"] = "name to display on desc",
}
ITEM.convMagTypes = {
	["attid"] = "id of the mag item it should take",
}
]]

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
		if(item:getData("durability")) then
			surface.SetDrawColor(color_white)
			surface.SetTextPos(1, h - 14)
			surface.SetFont("DermaDefault")
			surface.DrawText(tostring(math.floor(item:getData("durability"))).."%")
		end
	end
end

function ITEM:calcPrice(origprice)
	local price = origprice
	local ups = self:getData("atts")
	local dura = self:getData("durability")
	
	if(dura) then
		price = price * (dura/100)
	end
	--if theyre selling it with stuff still attached, 
	--give them some of the price back, but not all
	if(ups) then
		for k,v in pairs(ups) do
			local item = nut.item.get(v)
			if(item) then 
				price = price+(item:getPrice()*0.8)
			end
		end
	end

	return price
end

function ITEM:getWeight()
	return self:getData("maxWeight", self.weight)
end

local magVals = {
	["sky_usp_9mm"] = 18
}

function ITEM:getDesc()
	local str = self.desc
	local wep = weapons.GetStored(self.class)
	local amm
	if(wep and wep.Primary) then
		amm = tostring(wep.Primary.ClipSize)
	else
		amm = "??"
	end

	if(self.biolock or self:getData("biolock")) then --data for like atts and stuff
		if(self:getData("bioowner")) then
			str = str.."\nThis weapon is locked and only the person who locked it can use it."
		else
			str = str.."\nThis weapon has an unassigned biolock."
		end
	end

	local ups = self:getData("atts")
	
	if(ups) then
		str = str.."\nAttachments:"
		for k,v in pairs(ups) do
			if(k == 3||k == 4||k == 5) then continue end --skip the nut att
			
			str = str.." "..TFA.Attachments.Atts[v].Name..","
		end
		str = str:sub(1, -2)
		str = str.."."
	end

	local up = false
	if(ups and ups[4]) then
		up = true
	end
	local basemag = nut.item.get(self.magType)
	
	if(self.convMagNames) then
		str = str.."\nAccepted Mag Type: "..((ups and ups[12]) and self.convMagNames[ups[12]] or (basemag and basemag.name or "NONEXISTANT MAG"))
	else
		if(!self.cantBeUnloaded) then
			str = str.."\nAccepted Mag Type: "..(basemag and basemag.name or "NONEXISTANT MAG")
		end
	end

	str = str.."\nSpecial Ammo Type: "..((up and self.otherMagTypes[ups[4]]) or "Normal")

	if(!self:getData("equip")) then
	str = str.."\nMag: "..tostring(self:getData("ammo", 0)).."/"..tostring((ups and ups[11]) and magVals[ups[11]] or amm)
	end
	
	str = str.."\nDurability: "..tostring(math.floor(self:getData("durability", 100))).."%"
	
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

		ply.carryWeapons = ply.carryWeapons or {}


		local weapon = ply.carryWeapons[item.weaponCategory]
		
		if (!IsValid(weapon)) then
			weapon = ply:GetWeapon(item.class)	
		end

		if (IsValid(weapon)) then
			item:setData("ammo", weapon:Clip1())

			ply:StripWeapon(item.class)
			ply.carryWeapons[item.weaponCategory] = nil
			ply:EmitSound(item.unequipSound or "items/ammo_pickup.wav", 80)
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

ITEM.functions.BioOn = {
	name = "Lock Weapon",
	tip = "Lock the weapon from being used by others",
	icon = "icon16/lock_add.png",
	onRun = function(item)
		item:setData("bioowner", item.player:getChar():getID())
		item.player:notify("This weapon is now locked to you, only you can use it.")

		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity) and (item.biolock or item:getData("biolock")) and !item:getData("bioowner") and !item:getData("equip")
	end
}
ITEM.functions.BioOff = {
	name = "Unlock Weapon",
	tip = "unlock the weapon to be used by others",
	icon = "icon16/lock_add.png",
	onRun = function(item)
		item:setData("bioowner")
		item.player:notify("This weapon is now unlocked, anyone can use it.")

		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity) and (item.biolock or item:getData("biolock")) and item:getData("bioowner") and !item:getData("equip")
	end
}

function ITEM:HackUnlockBio()
	self:setData("bioowner")
end


-- On player eqipped the item, Gives a weapon to player and load the ammo data from the item.
ITEM.functions.Equip = {
	name = "Equip",
	tip = "equipTip",
	icon = "icon16/tick.png",
	onRun = function(item)
		if((item.biolock or item:getData("biolock")) and item:getData("bioowner")) then
			if(item:getData("bioowner") != item.player:getChar():getID()) then
				--sound?
				item.player:notify("The weapon's biolock prevents you from using it.")
				return false
			end
		end

		item:Equip(item.player)
		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") != true and item:getData("broken") != true)
	end
}

function ITEM:Equip(client)
	local items = client:getChar():getInv():getItems()

	client.carryWeapons = client.carryWeapons or {}

	for k, v in pairs(items) do
		if (v.id != self.id) then
			local itemTable = nut.item.instances[v.id]
			
			if (!itemTable) then
				client:notifyLocalized("tellAdmin", "wid!xt")

				return false
			else
				if (itemTable.isWeapon and client.carryWeapons[self.weaponCategory] and IsValid(client.carryWeapons[self.weaponCategory]) and itemTable:getData("equip")) then
					client:notifyLocalized("weaponSlotFilled")

					return false
				end
			end
		end
	end
	
	if (client:HasWeapon(self.class)) then
		client:StripWeapon(self.class)
	end

	local weapon = client:Give(self.class, true)

	if (IsValid(weapon)) then
		local ammoType = weapon:GetPrimaryAmmoType()

		timer.Simple(0, function()
			client:SelectWeapon(weapon:GetClass())
			--client:SetActiveWeapon(weapon)
		end)
		client.carryWeapons[self.weaponCategory] = weapon
		--client:SelectWeapon(weapon:GetClass())
		--client:SetActiveWeapon(weapon)
		client:EmitSound("items/ammo_pickup.wav", 80)

		-- Remove default given ammo.
		if (!self.cantBeUnloaded and client:GetAmmoCount(ammoType) == weapon:Clip1() and self:getData("ammo", 0) == 0) then
			client:RemoveAmmo(weapon:Clip1(), ammoType)
		end

		-- assume that a weapon with -1 clip1 and clip2 would be a throwable (i.e hl2 grenade)
		-- T ODO: figure out if this interferes with any other weapons
		if (!self.cantBeUnloaded and weapon:GetMaxClip1() == -1 and weapon:GetMaxClip2() == -1 and client:GetAmmoCount(ammoType) == 0) then
			client:SetAmmo(1, ammoType)
		end

		self:setData("equip", true)

		weapon:SetClip1(self:getData("ammo", 0))
		weapon.nutItem = self

		--apply current atts
			local ups = self:getData("atts")
			--apply current atts
			if(ups) then
				for k,v in pairs(ups) do   
					if(v == nil) then continue end

					timer.Simple(1, function()
						--ok i give up eugh
						weapon:Attach(v)
						--[[ --more broken code
						local val = table.KeyFromValue(weapon.Attachments[k].atts, v)
						if(val) then
							weapon:SetTFAAttachment(k, val, true)
						end
							]]
					end)
				end
			end

		if (self.OnEquipWeapon) then
			self:OnEquipWeapon(client, weapon)
		end
	else
		print(Format("[Nutscript] Weapon %s does not exist!", self.class))
	end
end

function ITEM:Unequip(client, bPlaySound, bRemoveItem)
	client.carryWeapons = client.carryWeapons or {}

	local weapon = client.carryWeapons[self.weaponCategory]

	if (!IsValid(weapon)) then
		weapon = client:GetWeapon(self.class)	
	end

	if (IsValid(weapon)) then
		weapon.nutItem = nil

		self:setData("ammo", weapon:Clip1())
		client:SetAmmo(0, weapon.GetStat and weapon:GetStat("Primary.Ammo") or weapon.Primary.Ammo)
		client:StripWeapon(self.class)
	else
		print(Format("[Nutscript] Weapon %s does not exist!", self.class))
	end

	if (bPlaySound) then
		client:EmitSound("items/ammo_pickup.wav", 80)
	end

	client.carryWeapons[self.weaponCategory] = nil
	self:setData("equip", nil)

	if (self.OnUnequipWeapon) then
		self:OnUnequipWeapon(client, weapon)
	end

	if (bRemoveItem) then
		self:remove()
	end
end

local mann = {
	["ammo_buckshot"] = {
		["slug"] = "ammo_slug",
		["frag"] = "ammo_frag",
		["db"] = "ammo_dragon",
		["nslug"] = "ammo_nslug"
	},
	["ammo_23"] = {
		["slug"] = "ammo_23slug",
	},
	["ammo_762x54"] = {
		["ap"] = "ammo_762x54_ap",
		["hp"] = "ammo_762x54_hp"
	},
	["ammo_338"] = {
		["ap"] = "ammo_338_ap",
		["hp"] = "ammo_338_hp"
	}
}

ITEM.functions.Unload = {
	name = "Unload",
	tip = "unload",
	icon = "icon16/arrow_undo.png",
	sound = "interface/inv_properties.ogg",
	onRun = function(item)
		local ply = item.player
		local inv = ply:getChar():getInv()
		local wep = weapons.GetStored(item.class)
		local chamber = 0
		if(!item.disableChamber) then
			chamber = -1
		end
		--local ats = item:getData("atts", {})

		local type = item.magType-- item.convMagTypes and item.convMagTypes[ats[12]] or mann[ats[4]] or item.magType
		if(item:getData("specammo") and type:find("ammo_")) then
			if(mann[type] and mann[type][item:getData("specammo")]) then
				type = mann[type][item:getData("specammo")]
			end
		end
		local mag = nut.item.get(type)
		local magw, magh = mag.width, mag.height
		local am = item:getData("ammo", 0)+chamber
		
		--if(am == 0) then return false end
	  --  if(inv:findEmptySlot(magw, magh)) then
		if(!inv:add(type, 1, {mag = math.max(item:getData("ammo", 0)+chamber, 0), type = item:getData("specammo")})) then
		--else
			nut.item.spawn(type, ply:GetPos(), nil, ply:GetAngles(), {mag = math.max(item:getData("ammo", 0)+chamber, 0), type = item:getData("specammo")})
		end

		if(!item.disableChamber) then
			item:setData("ammo", 1)
		else
			item:setData("ammo", 0)
		end
		
		item:setData("unloaded", true) --this will stop the reload from creating an empty mag, it shouldnt

		ply:EmitSound("weapons/ak47/ak47_clipout.wav", 70)

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") != true and !item:getData("unloaded") and !item.cantBeUnloaded)--(item:getData("ammo", 0) > 1) and item:getData("equip") != true and !item:getData("unloaded"))
	end
}

--detach atts
ITEM.functions.zDetach = {
	name = "Detach",
	tip = "unload",
	icon = "icon16/cross.png",
	sound = "cw/detach.wav",
	isMulti = true,
	multiOptions = function(item, ply)
		local options = {}
		local atts = item:getData("atts")
		for k,v in pairs(atts) do
			if(k == 3||k == 4||k == 5||k > 9) then continue end
			if(!TFA.Attachments.Atts[v]) then continue end
			if(item.cantDetach and item.cantDetach[k]) then continue end --integrated supp
			options[v] = {
				name = TFA.Attachments.Atts[v].Name,
				--sound = "",
				data = k
			}
		end
		return options
	end,
	onRun = function(item, sub)
		local ply = item.player
		local wep
		if(ply:GetActiveWeapon().nutItem == item) then
			wep = ply:GetActiveWeapon()
		else
			wep = ply:GetWeapon(item.class)
		end
		--save on item
		local ats = item:getData("atts", {})
		if(IsValid(wep)) then   
			local att = nut.item.get(ats[sub])
			if(att.expand) then
				local succ = item:expand(att.expand.wh, att.expand.sizemodd, att.expand.posmodd, ply)
				if(!succ) then ply:notify("couldnt expand") return false end
			end
			if(!ply:getChar():getInv():add(ats[sub])) then
				ply:notify("No room!")
				--reexpand fuck
				if(att.expand) then
					local succ = item:expand(att.expand.wh, att.expand.sizemod, att.expand.posmod, ply)
					if(!succ) then ply:notify("couldnt expand") return false end
				end
				return false
			else
				--add atts weight onto item
				item:setData("maxWeight", item:getData("maxWeight", item.weight)-att.weight)
				
			end
 
			--apply attachment to wep
	--		wep:SetTFAAttachment(sub, -1, true)
			timer.Simple(0.06, function()
				wep:SetTFAAttachment(sub, -1, true)
			end)
		else
			return false
		end

		ats[sub] = nil
		item:setData("atts", ats)

		return false
	end,
	onCanRun = function(item, sub)
		return (!IsValid(item.entity) and table.Count(item:getData("atts", {})) != 0)
	end
}

--change magtypes
ITEM.functions.zChangeMag = {
	name = "Change Special Ammo",
	tip = "unload",
	icon = "icon16/arrow_switch.png",
	sound = "interface/inv_properties.ogg",
	isMulti = true,
	multiOptions = function(item, ply)
		local options = {}
		for k,v in pairs(item.otherMagTypes) do
			table.insert(options, {
				name = v,
				--sound = "",
				data = k
			})
		end
		return options
	end,
	onRun = function(item, sub)
		local ply = item.player
		local wep
		if(ply:GetActiveWeapon().nutItem == item) then
			wep = ply:GetActiveWeapon()
		else
			wep = ply:GetWeapon(item.class)
		end
		if(!wep or !IsValid(wep)) then
			ply:notify("You must equip the weapon.")
			return false
		end
		local val
		--check if the wep actually has it lol
		if(sub != "default") then
		if(IsValid(wep)) then
			if(wep.Attachments and wep.Attachments[4]) then
				val = table.KeyFromValue(wep.Attachments[4].atts, sub)
				if(!wep:CanAttach(sub)) then
					ply:notify("Something you have attached is conflicting, or the weapon isnt equipped.")
					return false
				end
			end
		end

		if(!val) then
			ply:notify("Just double checking, this weapon doesnt have this magtype! tell sky.")
			return false
		end
		end

		local inv = ply:getChar():getInv()
		local chamber = -1
		if(item.disableChamber) then
			chamber = 0
		end
		
		local ats = item:getData("atts", {})

		local type = (wep and wep:GetStat("MagType")) or item.magType
		if(!item:getData("unloaded")) then
			--if(wep:Clip1() != 0) then
			local mag = nut.item.get(type)
			if(mag.ammoBox and wep:Clip1()+chamber <= 0) then
				--dont produce an item in this case
			else
				local magw, magh = mag.width, mag.height
		   		--if(inv:findEmptySlot(magw, magh)) then
   				if(!inv:add(type, 1, {mag = math.max(wep:Clip1()+chamber, 0), type = wep:GetStat("SpecAmmo")})) then
				--else
					nut.item.spawn(type, ply:GetPos(), nil, ply:GetAngles(), {mag = math.max(wep:Clip1()+chamber, 0), type = wep:GetStat("SpecAmmo")})
				end
			end
		end
		wep:SetClip1(0)

		if(wep) then    
			--apply attachment to wep
			if(!val) then val = -1 end
			timer.Simple(0.06, function()
				wep:SetTFAAttachment(4, val, true)
				timer.Simple(0, function()
				item:setData("specammo", wep:GetStat("SpecAmmo"))
				end)
			end)
		  --  wep:SetTFAAttachment(4, val, true)
		end
		item:setData("unloaded", true) --this will stop the reload from creating an empty mag, it shouldnt

		--save on item
		ats[4] = ((sub != "default") and sub) or nil
		item:setData("atts", ats)

		netstream.Start(item.player, "DoMagCount") --calling to get the new mag count here

		return false
	end,
	onCanRun = function(item, sub)
		return (!IsValid(item.entity) and (item.otherMagTypes != nil and table.Count(item.otherMagTypes) != 0))
	end
}


function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (oldInventory:getID() != 0 and newInventory and self:getData("equip")) then
		return false
	end

	return true
end

function ITEM:doAttach(weapon)
	if(!self:getData("equip")) then return end
	local ups = self:getData("atts")
	--apply current atts
	--timer.Simple(1, function()
	if(ups) then
		weapon.toadd = ups
		--[[
		for k,v in pairs(ups) do   
			if(v == nil) then continue end
				--ok i give up eugh
				if(!weapon.Attach) then
					print("attach is nil why does this happen")
					return
				end
				weapon:Attach(v)
				--[[ --more broken code
				local val = table.KeyFromValue(weapon.Attachments[k].atts, v)
				if(val) then
					local succ = weapon:SetTFAAttachment(k, val, true)
					if(succ == false) then
						print("something went wrong when attaching")
					end
				end
					]]
				--[[
				local succ = weapon:SetTFAAttachment(k, val, true)
				if(succ == false) then
					print("something went wrong when attaching")
				end
				]]
		--end
	end
	--end)
end

function ITEM:onLoadout()
	if (self:getData("equip")) then
		local client = self.player
		client.carryWeapons = client.carryWeapons or {}

		local weapon = client:Give(self.class)

		if (IsValid(weapon)) then
			client:RemoveAmmo(weapon:Clip1(), weapon:GetPrimaryAmmoType())
			client.carryWeapons[self.weaponCategory] = weapon

			weapon.nutItem = self
			weapon:SetClip1(self:getData("ammo", 0))
			
			local ups = self:getData("atts")
			--apply current atts
			if(ups) then
				weapon.toadd = ups
				--[[ --3 seperate broken codes wow
				for k,v in pairs(ups) do   
					if(v == nil) then continue end
					timer.Simple(1, function()
						--ok i give up eugh
						if(!weapon.Attach) then
							print("attach is nil why does this happen")
							return
						end
						local vl = weapon:Attach(v)
						print(vl)
						--[[ --more broken code
						local val = table.KeyFromValue(weapon.Attachments[k].atts, v)
						if(val) then
							local succ = weapon:SetTFAAttachment(k, val, true)
							if(succ == false) then
								print("something went wrong when attaching")
							end
						end
							]]
						--[[
						local succ = weapon:SetTFAAttachment(k, val, true)
						if(succ == false) then
							print("something went wrong when attaching")
						end
						]]
				--	end)
				--end
				
			end
		else
			print(Format("[Nutscript] Weapon %s does not exist!", self.class))
		end
	end
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


function ITEM:onInstanced()
	if(!self:getData("durability")) then
		self:setData("durability", 100) --default max
	end

	if(self.defaultMods) then
		self:setData("atts", self.defaultMods)
	end

	--default ammo for nonrefillable guns ie ar3
	if(self.defaultAmmo) then
		self:setData("ammo", self.defaultAmmo)
	end
end

hook.Add("PlayerDeath", "nutStripClip", function(client)
	client.carryWeapons = {}

	for k, v in pairs(client:getChar():getInv():getItems()) do
		if (v.isWeapon and v:getData("equip")) then
			v:setData("ammo", nil)
			v:setData("equip", nil)
		end
	end
end)

function ITEM:onRemoved()
	local inv = nut.item.inventories[self.invID]
	if(!inv) then return end --uh
	local receiver = inv.getReceiver and inv:getReceiver()

	if (IsValid(receiver) and receiver:IsPlayer()) then
		local weapon = receiver:GetWeapon(self.class)

		if (IsValid(weapon)) then
			weapon:Remove()
		end
	end
end 

--width = x, add right == 1, 0; add left == 1, -1;
--			remove right == -1, 0; remove left == -1, 1
--height = y, same as above but instead of left its down, and right is up
--item: item to modify, rec: recievers of networking (owner), 
--worh: width or height, sizemod: what to modify the item by, 
--posmod: how to modify the position (0 is right and down, check above this)
function ITEM:expand(worh, sizemod, posmod, ply)
	local item = self
	local ply = ply or item.player or item:getOwner()
	local oldinv = nut.inventory.instances[item.invID]
	local x,y = item:getData("x"), item:getData("y")
	local succ = false
	
	if(worh == "width" or worh == "w") then
		x = x + posmod
		item:removeFromInventory(true):next( --so were removing it from the inv
			function() --resolved
				item.width = item.width + sizemod --modifying it
				item:setData("width", item.width)
				netstream.Start(ply, "updateitem", item.id, "width", item.width)
				if(oldinv:doesItemFitAtPos(item, x, y)) then
					oldinv:add(item, x, y):next( --and readding at old place
						function()
							succ = true
						end,
						function() --rejected
							--but if cant, we undo the changes and
							item.width = item.width - sizemod
							item:setData("width", item.width)
							netstream.Start(ply, "updateitem", item.id, "width", item.width)
							oldinv:add(item, x-posmod, y) --readd as normal
							succ = false
						end
					)
				else
					--same thing here as rejected
					item.width = item.width - sizemod
					item:setData("width", item.width)
					netstream.Start(ply, "updateitem", item.id, "width", item.width)
					oldinv:add(item, x-posmod, y) --readd as normal
					succ = false
				end
			end
		)

	elseif(worh == "height" or worh == "h") then
		y = y + posmod
		item:removeFromInventory(true):next(
			function() --resolved
				item.height = item.height + sizemod
				item:setData("height", item.height)
				netstream.Start(ply, "updateitem", item.id, "height", item.height)
				if(oldinv:doesItemFitAtPos(item, x, y)) then
					oldinv:add(item, x, y):next( --readd at old place
						function() --uh lol
							succ = true
						end,
						function() --rejected
							--undo?
							item.height = item.height - sizemod
							item:setData("height", item.height)
							netstream.Start(ply, "updateitem", item.id, "height", item.height)
							oldinv:add(item, x, y-posmod) --readd as normal
							succ = false
						end
					)
				else
					
					item.height = item.height - sizemod
					item:setData("height", item.height)
					netstream.Start(ply, "updateitem", item.id, "height", item.height)
					oldinv:add(item, x, y-posmod) --readd as normal
					succ = false
				end
			end
		)

	else
		print("worh was not valid", worh)
	end
	return succ
end

function ITEM:onRestored()
	local item = self
	if(item:getData("height")) then
		item.height = item:getData("height")
		netstream.Start(item:getOwner(), "updateitem", item.id, "height", item.height)
	end
	if(item:getData("width")) then
		item.width = item:getData("width")
		netstream.Start(item:getOwner(), "updateitem", item.id, "width", item.width)
	end
end

function ITEM:onSync(recip)
	local item = self
	netstream.Start(recip, "updateitem", item.id, "height", item.height)
	netstream.Start(recip, "updateitem", item.id, "width", item.width)

end