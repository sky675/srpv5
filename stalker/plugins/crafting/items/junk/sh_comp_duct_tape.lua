ITEM.name = "Duct Tape Roll"
ITEM.desc = "A roll of duct tape."
ITEM.model = "models/props_clutter/duct_tape.mdl"
ITEM.category = "Components"
ITEM.weight = 0.58
ITEM.price = 400
ITEM.flag = "J"
ITEM.countMax = 15
ITEM.maxQuantity = 15

ITEM.functions.Tie = {
	onRun = function(item)
		if (item.beingUsed) then
			return false
		end

		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local target = util.TraceLine(data).Entity

		--this should allow tying of ragdolled ppl
		if(IsValid(target) and target:GetClass() == "prop_ragdoll" and IsValid(target:getNetVar("player"))) then
			target = target:getNetVar("player")
		end

		if (IsValid(target) and target:IsPlayer() and target:getChar() and !target:getNetVar("tying") and !target:getNetVar("restricted")) then
			item.beingUsed = true

			client:EmitSound("physics/metal/metal_solid_strain5.wav")

			local val = 10
			val = val * nut.traits.getMod(client, "actiontime")

			client:setAction("@tying", val)
			client:doStaredAction(target, function()
				if(item:getQuantity() == 1) then
					item:remove()
				else
					item:addQuantity(-1)
				end

				target:setNetVar("tapetied", true)
				target:setRestricted(true)
				target:setNetVar("tying")
				target:StartHandcuffAnim()
				--idk tbh
				--target:notify("/struggle can be used to get out of tape ties.")

				client:EmitSound("physics/cardboard/cardboard_box_impact_soft5.wav", 100, 90)
			end, val, function()
				client:setAction()

				target:setAction()
				target:setNetVar("tying")

				item.beingUsed = false
			end)

			target:setNetVar("tying", true)
			target:setAction("@beingTied", val)
		else
			item.player:notifyLocalized("plyNotValid")
		end

		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity) and item.uniqueID == "comp_duct_tape" --ye
	end
}

function ITEM:onCanBeTransfered(inventory, newInventory)
	return !self.beingUsed
end