ITEM.name = "Repair Kit"
ITEM.desc = "repair weapon yes ok"
ITEM.model = "models/warz/attachments/optic_acog.mdl"
ITEM.category = "Repair Kits"

--needed
--[[
ITEM.minDurability = 0
ITEM.baseRepair = 1
ITEM.fixBroken = false
ITEM.repairType = {} --table of allowed repairs, applicable are weapon types (ws n pistol shotgun) or ammotypes
--optional
ITEM.traitreq = {trait = "id", val = true/num}
]]

function ITEM:getDesc()
	return self.desc
end

local multVals = {
	[0] = 1,
	[-1] = 0.8,
	[-2] = 0.65,
	[-3] = 0.5
}

function ITEM:onCombineTo(target)
	if(!target.isWeapon) then return end
	
	local ply = self.player
	local item = self

	local hightr = nut.traits.hasTrait(ply, "crafting_repairw") or 0
	local lowtr = nut.traits.hasTrait(ply, "crafting_repair") or 0
	

	if(target:getData("equip") == true) then
		ply:notify("You must unequip the weapon to repair it.", 3)
		return false
	end
	
	local minMult = 1
	if(!item.traitreq) then
		minMult = multVals[0-lowtr] or 1
	else
		minMult = multVals[item.traitreq.val-(item.traitreq.trait == "crafting_repair" and lowtr or hightr)] or 1
	end

	if(target:getData("durability", 100) < ((item.minDurability or 0)*minMult)) then
		ply:notify("This weapon's durability is lower than the min durability for this item!", 3)
		return false
	end
	if(item.traitreq) then
		local t = nut.traits.hasTrait(ply, item.traitreq.trait)
		if(type(item.traitreq.val) == "number") then
			if((t or 0) < item.traitreq.val) then
				ply:notify("You do not meet the trait requirement for this item!", 3)
				return false
			end
		else
			if(t != item.traitreq.val) then
				ply:notify("You do not meet the trait requirement for this item!", 3)
				return false
			end
		end
	end

	if(!item.repairType[target.type] and !item.repairType[nut.item.get(target.magType).ammoType]) then
		ply:notify("You cannot repair this with this item!", 3)
		return false
	end
	if(item.fixBroken and !target:getData("broken")) then
		ply:notify("This only repairs broken weapons.", 3)
		return false
	elseif(!item.fixBroken and target:getData("broken")) then
		ply:notify("This cannot repair broken weapons!", 3)
		return false
	else --should only be fixbroken = true and then whether wep is broken doesnt matter
	end

	local oldDur = target:getData("durability", 100)
	--todo, better/different math for repair attrib bonus
	local repa = oldDur + (item.baseRepair or 1)
	target:setData("durability", math.Clamp(repa, 0, 100))
	--item.player:updateAttrib("rep", (((item.baseRepair or 1)+(item.minSkill or 0))/95)) 
	--a basic repair kit would raise it by 0.105, hopefully this isnt too much?
	--itd require 10 repairs to get to the next level but who knows how easy it will
	--be to get 10 repairs
	if(target:getData("durability", 100) != 0) then
		target:setData("broken", nil)
	end

	target:setData("incD", target:getData("incD", 1)*(item.duraInc or 0.99))

	if(nut.traits and item.traitreq) then
		nut.traits.addXp(ply, item.traitreq.trait, item.xpinc or 1)
	end

	item:remove()
end

--[[ITEM.functions.--combine = {
	name = "Combine",
	tip = "Repair weapon",
	icon = "icon16/wrench.png",
	sound = "interface/inv_repair_kit_use_fast.ogg",
	onRun = function(item, id)
		local target = nut.item.instances[id]

		if(id and target) then
			local ply = item.player
			if(target:getData("equip") == true) then
				ply:notify("You must unequip the weapon to repair it.")
				return false
			end
			if(target:getData("durability", 100) < (item.minDurability or 0)) then
				ply:notify("This weapon's durability is lower than the min durability for this item!")
				return false
			end
			if(item.traitreq) then
				local t = nut.traits.hasTrait(ply, item.traitreq.trait)
				if(type(item.traitreq.val) == "number") then
					if((t or 0) < item.traitreq.val) then
						ply:notify("You do not meet the trait requirement for this item!")
						return false
					end
				else
					if(t != item.traitreq.val) then
						ply:notify("You do not meet the trait requirement for this item!")
						return false
					end
				end
			end

			if(!item.repairType[target.type] and !item.repairType[nut.item.get(target.magType).ammoType]) then
				ply:notify("You cannot repair this with this item!")
				return false
			end
			if(item.fixBroken and !target:getData("broken")) then
				ply:notify("This only repairs broken weapons.")
				return false
			elseif(!item.fixBroken and target:getData("broken")) then
				ply:notify("This cannot repair broken weapons!")
				return false
			else --should only be fixbroken = true and then whether wep is broken doesnt matter
			end

			local oldDur = target:getData("durability", 100)
			--todo, better/different math for repair attrib bonus
			local repa = oldDur + (item.baseRepair or 1)
			target:setData("durability", math.Clamp(repa, 0, 100))
			--item.player:updateAttrib("rep", (((item.baseRepair or 1)+(item.minSkill or 0))/95)) 
			--a basic repair kit would raise it by 0.105, hopefully this isnt too much?
			--itd require 10 repairs to get to the next level but who knows how easy it will
			--be to get 10 repairs
			if(target:getData("durability", 100) != 0) then
				target:setData("broken", nil)
			end

			if(nut.traits and item.traitreq) then
				nut.traits.addXp(ply, item.traitreq.trait, item.xpinc or 1)
			end

			return true
		end
	end,
	onCanRun = function(item, id)
	  --if(!item.player:getChar():hasFlags("U")) then return false end
		local target = nut.item.instances[id]

		if(id and target) then
			if(!IsValid(item.entity) and target.isWeapon) then
				return true
			else
				return false
			end
		end

		return false
	end
}]]