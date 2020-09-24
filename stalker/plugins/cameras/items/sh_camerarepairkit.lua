ITEM.name = "Camera Repair Kit"
ITEM.model = "models/props_junk/PopCan01a.mdl"
ITEM.desc = "special repair kit with stuff to repair remote cameras (todo)"
ITEM.category = "misc"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1

--todo: eyetrace to repair looking at camera

// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.usef = { -- sorry, for name order.
	name = "Give",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	onRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor() -- We don't need cursors.
		local target = trace.Entity
		
		--[[if(nut.traits.hasTrait(item.player, "tech_med") < item.skillval) then
			item.player:notify("You don't meet trait requirements for this item!")
			return false
		end]]
		print("hello ",target)
		local val = (2 * nut.traits.getMod(client, "actiontime")) + 3

		item.player:EmitSound("interface/inv_repair_kit_use_fast.ogg")

		client:setAction("Repairing...", val)
		client:doStaredAction(target, function()
			if(!client:Alive() or client:getNetVar("neardeath") or item:getOwner() != client) then return end
			if (IsValid(target)) then
				target:FixCamera()

				item:remove()
				return
			end
		end, val, function()
			client:setAction()
		end)

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}