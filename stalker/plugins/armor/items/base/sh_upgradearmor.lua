ITEM.name = "upgrade temp"
ITEM.desc = "suit upgrade yes"
ITEM.model = "models/warz/attachments/optic_acog.mdl"
ITEM.category = "Suit Upgrades"


function ITEM:getDesc()
    return self.desc
end

--apply to item looking at function

// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.usef = { -- sorry, for name order.
	name = "Apply to Looking At",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	onRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor() -- We don't need cursors.
		local realtarget = trace.Entity

		if(realtarget:GetClass() == "nut_item") then
			local target = realtarget:getItemTable()
			if(target) then
				item:onCombineTo(target)
			end
		else
			client:notify("You need to be looking at an armor item for this!", 3)
		end

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

function ITEM:onCombineTo(target)
	if(target.base != "base_armor" or target:getData("equip") == true) then return end

	
	local ply = self.player
	local item = self

	if(item.traitreq) then
		local t = nut.traits.hasTrait(ply, item.traitreq.trait)
		if(type(item.traitreq.val) == "number") then
			if(!t) then t = 0 end
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
	local check = ents.FindInSphere(ply:GetPos(), 120)

	local rdy = false
	for k,v in pairs(check) do
		if(v:GetClass() == "sky_craft_armor") then
			rdy = true 
			break
		end
	end
	if(!rdy) then
		ply:notify("Suit upgrades require an armor workbench nearby to install!", 3)
		return false
	end

	--check for requirement tools?
	local up = suit_getUpgradeReq(item.upid)
	if(!ply:getChar():getInv():hasItem("junk_toolkit"..up)) then
		local it = nut.item.get("junk_toolkit"..up)
		ply:notify("A "..it:getName().." is required to install this upgrade!", 3)
		return false
	end

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