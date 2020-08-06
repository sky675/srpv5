ITEM.name = "skillbook"
ITEM.desc = "give skill"
ITEM.model = "models/props_lab/binderblue.mdl"
ITEM.price = 200
ITEM.flag = "m"
ITEM.noBusiness = true
ITEM.category = "Skillbooks (dep)"

--[[
ITEM.skillgive = "" --skill to give
ITEM.skillval = true --value to set, true for non-level abilities, number for level to set to
ITEM.skillreq = {["skill"] = true} --requirements for using the book, value would be similar to skillval

]]
ITEM.functions.read = {
	name = "Use",
    tip = "use book",
    icon = "icon16/add.png",
    onRun = function(item)
		local char = item.player:getChar()
		if(nut.traits.hasTrait(item.player, "big_illit")) then
			item.player:notify("You are illiterate and cannot use skillbooks!")
			return false
		end
		--hasTrait
		if(type(item.skillgive) == "string") then
			if(type(item.skillval) == "number") then
				if((nut.traits.hasTrait(item.player, item.skillgive) or 0) >= item.skillval) then
					item.player:notify("You meet or exceed the skill level this item gives you!")
					return false
				end
			else
				if(nut.traits.hasTrait(item.player, item.skillgive) == item.skillval) then
					item.player:notify("You have this trait already!")
					return false
				end
			end
		else
			for k,v in pairs(item.skillgive) do
				if(type(v) == "number") then
					if((nut.traits.hasTrait(item.player, k) or 0) >= v) then
						item.player:notify("You meet or exceed the skill level this item gives you!")
						return false
					end
				else
					if(nut.traits.hasTrait(item.player, k) == v) then
						item.player:notify("You have this trait already!")
						return false
					end
				end
			end
		end


		if(item.skillreq) then
			for k,v in pairs(item.skillreq) do
				if(type(v) == "number") then
					if((nut.traits.hasTrait(item.player, k) or 0) < v) then
						item.player:notify("You do not meet the requirements for this item!")
						return false
					end
				else
					if(nut.traits.hasTrait(item.player, k) == v) then
						item.player:notify("You do not have a required trait!")
						return false
					end
				end
			end
		end

		if(item.skillconflict) then
			for k,v in pairs(item.skillconflict) do
				if(type(v) == "number") then
					if((nut.traits.hasTrait(item.player, k) or 0) >= v) then
						item.player:notify("You have a trait that conflicts!")
						return false
					end
				else
					if(nut.traits.hasTrait(item.player, k) == v) then
						item.player:notify("You have a trait that conflicts!")
						return false
					end
				end
			end
		end


		if(type(item.skillgive) == "string") then
			if(type(item.skillval) == "number") then
				nut.traits.setTrait(item.player, item.skillgive, nil, item.skillval)
			else
				nut.traits.setTrait(item.player, item.skillgive)
			end
		else
			for k,v in pairs(item.skillgive) do
				if(type(v) == "number") then
					nut.traits.setTrait(item.player, k, nil, v)
				else
					nut.traits.setTrait(item.player, k)
				end

			end
		end
		item.player:notify("You have learned "..item.name)
		nut.log.addRaw(item.player:Name().." used skillbook "..item.uniqueID..".", FLAG_WARNING)
    end,
    onCanRun = function(item)
        return (!IsValid(item.entity))
    end
}