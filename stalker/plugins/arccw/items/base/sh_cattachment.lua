ITEM.name = "attachbase"
ITEM.desc = "Drag this over a valid weapon to attach it."
ITEM.model = "models/Items/BoxMRounds.mdl"
ITEM.price = 150
ITEM.flag = "M"
ITEM.category = "Attachments"

--[[
ITEM.cat = "slot"
ITEM.attID = "name"
]]

function ITEM:attachTo(target, ply)
	if(target.base != "base_cweapon") then return false end
	
	local item = self

	--biolock
	if(self.specialAtt) then
		return self:specialAtt(target)
	end

	if(self.requireEnt) then
		local check = ents.FindInSphere(ply:GetPos(), self.requireEnt.radius)

		local rdy = false
		for k,v in pairs(check) do
			if(v:GetClass() == self.requireEnt.class) then
				rdy = true 
				break
			end
		end
		if(!rdy) then
			ply:notify("This attachment requires "..(self.requireEnt.name or "an entity").." nearby to attach")
			return false
		end
	end

	if(self.techReq) then
		local t = nut.traits.hasTrait(ply, "crafting_spec")
		if((t or 0) < self.techReq) then
			ply:notify("You do not meet the tech level for this item!", 3)
			return false
		end
	end

	--todo trait check
	if(self.traitreq) then
		local t = nut.traits.hasTrait(ply, self.traitreq.trait)
		if(type(self.traitreq.val) == "number") then
			if((t or 0) < self.traitreq.val) then
				ply:notify("You do not meet the trait requirement for this item!", 3)
				return false
			end
		else
			if(t != self.traitreq.val) then
				ply:notify("You do not meet the trait requirement for this item!", 3)
				return false
			end
		end
	end

	--this is useless until uniqueids are decoupled from detaching, which idk how id do
	if(self.restrictWeps and !self.restrictWeps[target.uniqueID]) then
		ply:notify("This weapon cannot equip this attachment.", 3)
		return false
	end

	local wep
	if(ply:GetActiveWeapon().nutItem == target) then
		wep = ply:GetActiveWeapon()
	else
		wep = ply:GetWeapon(target.class)
	end
	--[[local donthave = false
	if(!wep) then
		wep = weapons.Get(target.class)
		donthave = true
	end]]
	local ats = target:getData("atts", {})
	if(ats[item.cat] != nil and (ats[item.cat] != "" and !ats[item.cat]:find("go_extras_"))) then
		ply:notify("Category already filled!", 3)
		return false
	end
	--im currently unsure how to detect whether an attachment is compatible
	--so forcing equipped for now
	if(!wep or !IsValid(wep)) then
		ply:notify("You must equip the weapon.")
		return false
	end

	--[[local val
	if (!ArcCW:SlotAcceptsAtt(item.cat, wep, item.attID)) then val = false 
	else
	end
	if(!val) then
		ply:notify("You cannot use this on this weapon!", 3)
		return false
	end]]

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

	--if(IsValid(wep)) then    
		--apply attachment to wep
		ply.isattaching = true
		wep:Attach(slotids[item.cat], item.attID, item.useSound)
		if(wep.Attachments[slotids[item.cat]].Installed != item.attID) then
			ply:notify("something went wrong while equipping, the weapon may not be compatible with the att", 3)
			return false
		end
	--end

	--add atts weight onto item
	target:setData("maxWeight", target:getData("maxWeight", target.weight)+self.weight)

	--save on item
	ats[item.cat] = item.attID
	target:setData("atts", ats)

	if(item.useSound) then
		item.player:EmitSound(item.useSound, 60)
	end


end

function ITEM:onCombineTo(target)
	if(self:attachTo(target, self.player) != false) then
		self:remove()
	end
end