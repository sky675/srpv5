ITEM.name = "Zip Tie"
ITEM.desc = "An orange zip-tie used to restrict players."
ITEM.price = 300
ITEM.weight = 0.01
ITEM.model = "models/items/crossbowrounds.mdl"
ITEM.flag = "0"
ITEM.functions.Use = {
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

			client:EmitSound("physics/plastic/plastic_barrel_strain"..math.random(1, 3)..".wav")
			
			local val = 5
			val = val * nut.traits.getMod(client, "actiontime")

			client:setAction("@tying", val)
			client:doStaredAction(target, function()
				item:remove()

				target:setRestricted(true)
				target:setNetVar("tying")
				target:StartHandcuffAnim()
				

				client:EmitSound("physics/rubber/rubber_tire_impact_bullet1.wav", 100, 90)
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
		return !IsValid(item.entity)
	end
}

function ITEM:onCanBeTransfered(inventory, newInventory)
	return !self.beingUsed
end