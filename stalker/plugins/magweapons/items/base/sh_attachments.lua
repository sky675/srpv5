ITEM.name = "attachbase"
ITEM.desc = "Drag this over a valid weapon to attach it."
ITEM.model = "models/Items/BoxMRounds.mdl"
ITEM.price = 150
ITEM.flag = "M"
ITEM.category = "Attachments"

--[[
ITEM.cat = 1
ITEM.attID = ""
ITEM.expand = {
	wh = "", --w or h
	sizemod = 0,
	posmod = 0,
}
]]

function ITEM:attachTo(target, ply)
	if(target.base != "base_mweapons") then return false end
	
	local item = self

	--biolock
	if(self.specialAtt) then
		return self:specialAtt(target)
	end

	local wep
	if(ply:GetActiveWeapon().nutItem == target) then
		wep = ply:GetActiveWeapon()
	else
		wep = ply:GetWeapon(target.class)
	end
	local ats = target:getData("atts", {})
	if(ats[item.cat] != nil) then
		ply:notify("Category already filled!", 3)
		return false
	end
	--if(!wep or !IsValid(wep)) then
	--	ply:notify("You must equip the weapon.")
	--	return false
	--end

	local val
	--check if the wep actually has it lol
	if(wep and wep.Attachments) then
		if(wep.Attachments[item.cat]) then
			if(!wep:CanAttach(item.attID)) then
				ply:notify("You cannot attach this onto this weapon!")
				return false
			end
			val = table.KeyFromValue(wep.Attachments[item.cat].atts, item.attID)
		end
	else
		local stored = weapons.GetStored(target.class)
		if(!stored.Attachments) then return false end
		if(stored.Attachments[item.cat]) then
			if(stored.AttachmentExclusions[item.attID]) then
				for k,v in ipairs(stored.AttachmentExclusions[item.attID]) do
					if(table.KeyFromValue(ats, v)) then
						ply:notify("You cannot attach this onto this weapon!", 3)
						return false
					end
				end
			end
			if(stored.AttachmentDependencies[item.attID]) then
				for k,v in ipairs(stored.AttachmentDependencies[item.attID]) do
					if(table.KeyFromValue(ats, v) == nil) then
						ply:notify("You cannot attach this onto this weapon!", 3)
						return false
					end
				end
			end
	
			val = table.KeyFromValue(wep.Attachments[item.cat].atts, item.attID)
		end


	end

	if(!val) then
		ply:notify("You cannot use this on this weapon!", 3)
		return false
	end

	if(item.expand) then
		local succ = target:expand(item.expand.wh, item.expand.sizemod, item.expand.posmod, ply)
		if(!succ) then ply:notify("couldnt expand") return false end
	end

	if(wep) then    
		--apply attachment to wep
		wep:SetTFAAttachment(item.cat, val, true)
	end


	--add atts weight onto item
	target:setData("maxWeight", target:getData("maxWeight", target.weight)+self.weight)

	--save on item
	ats[item.cat] = item.attID
	target:setData("atts", ats)



end

function ITEM:onCombineTo(target)
	if(self:attachTo(target, self.player) != false) then
		self:remove()
	end
end

--[[
--sound can be done by adding sound to the table
ITEM.functions.--combine = {
    name = "Combine",
    tip = "Equip to active weapon",
    icon = "icon16/wrench.png",
    sound = "cw/attach.wav", --like this
    onRun = function(item, id)
        local target = nut.item.instances[id]
        local ply = item.player

        if(id and target) then
            local wep
            if(ply:GetActiveWeapon().nutItem == target) then
                wep = ply:GetActiveWeapon()
            else
                wep = ply:GetWeapon(target.class)
			end
			if(!wep or !IsValid(wep)) then
				ply:notify("You must equip the weapon.")
				return false
			end
			local ats = target:getData("atts", {})
			if(ats[item.cat] != nil) then
				ply:notify("Category already filled!")
				return false
			end

            local val
            --check if the wep actually has it lol
            if(wep and wep.Attachments) then
                if(wep.Attachments[item.cat]) then
                    val = table.KeyFromValue(wep.Attachments[item.cat].atts, item.attID)
					if(!wep:CanAttach(item.attID)) then
                        ply:notify("You cannot attach this onto this weapon!")
                        return false
                    end
                end
            end

            if(!val) then
                ply:notify("You cannot use this on this weapon!")
                return false
            end

            if(wep) then    
                --apply attachment to wep
                wep:SetTFAAttachment(item.cat, val, true)
            end

            --save on item
            ats[item.cat] = item.attID
            target:setData("atts", ats)

            return true
        end
    end,
    onCanRun = function(item, id)
        local target = nut.item.instances[id]

        if(id and target) then
            if(!IsValid(item.entity) and target.isWeapon) then    
                return true
            end
        end

        return false
    end
}
]]