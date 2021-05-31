ITEM.name = "upgrade temp"
ITEM.desc = "suit upgrade yes"
ITEM.model = "models/warz/attachments/optic_acog.mdl"
ITEM.category = "Suit Upgrades"


function ITEM:getDesc()
    return self.desc
end

--apply to item looking at function


function ITEM:onCombineTo(target)
	if(target.base != "base_armor" or target:getData("equip") == true) then return end

	
	local ply = self.player
	local item = self

	if(item.traitreq) then
		local t = nut.traits.hasTrait(ply, item.traitreq.trait)
		if(type(item.traitreq.val) == "number") then
			if(t < item.traitreq.val) then
				ply:notify("You do not meet the trait requirements for this item!", 3)
				return
			end
		else
			if(t != item.traitreq.val) then
				ply:notify("You do not meet the trait requirements for this item!", 3)
				return
			end
		end
	end

	--check for armor workbench

	--check for requirement tools?

	local lvls = applySuitUpgrade(ply, target, self)

	if(lvls) then
		ply:notify("adding")

		if(nut.traits and item.traitreq) then
			nut.traits.addXp(item.player, item.traitreq.trait, item.xpinc or 1)
		end

		if(item.useSound) then
			item.player:EmitSound(item.useSound, 60)
		end
		--target:setData("armor", lvls)

		item:remove()
	end
end