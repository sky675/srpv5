ITEM.name = "hack tool"
ITEM.desc = "a hacking tool lmao"
ITEM.model = "models/kali/miscstuff/stalker/usb_b.mdl"
ITEM.price = 20
ITEM.flag = "m"
ITEM.category = "Hacking"
ITEM.noBusiness = true

--[[
	ITEM.programid = id of the program
]]

function ITEM:onCombineTo(target)
	if(target.base != "base_hacktool" or table.Count(target:getData("programs", {})) >= target.maxprograms) then return end
	
	local ply = self.player
	local item = self

	--if(table.Count(target:getData("programs", {})) < target.maxprograms) then --just uh checking again
		local pro = target:getData("programs", {})
		pro[item.programid] = true
		target:setData("programs", pro)
		if(nut.plugin.list["hacking"].programlist[item.programid].oninstall) then
			nut.plugin.list["hacking"].programlist[item.programid].oninstall(target)
		end

		item:remove()
	--end

end

--[[ITEM.functions.--combine = {
    name = "Combine",
    tip = "Equip to active weapon",
    icon = "icon16/wrench.png",
    sound = "labs/ding_on.wav", --like this
    onRun = function(item, id)
        local target = nut.item.instances[id]
        local ply = item.player

		if(id and target) then
			--
			if(table.Count(target:getData("programs", {})) < target.maxprograms) then --just uh checking again
				local pro = target:getData("programs", {})
				pro[item.programid] = true
				target:setData("programs", pro)
				if(nut.plugin.list["hacking"].programlist[item.programid].oninstall) then
					nut.plugin.list["hacking"].programlist[item.programid].oninstall(target)
				end

				return true
			end
		end
		return false
    end,
    onCanRun = function(item, id)
        local target = nut.item.instances[id]

        if(id and target) then
            if(!IsValid(item.entity) and target.base == "base_hacktool" and table.Count(target:getData("programs", {})) < target.maxprograms) then    
                return true
            end
        end

        return false
    end
}]]