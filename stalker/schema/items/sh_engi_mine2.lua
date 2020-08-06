ITEM.name = "Bouncing Mortar Landmine"
ITEM.model = "models/props_junk/cardboard_box004a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "A simple bouncing mine. Automatically armed at where you look at. If the position is not valid, it will not be removed from your inventory."
ITEM.price = 2100
ITEM.weight = 0.6
--same as 1
ITEM.flag = "m"

// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.use = { -- sorry, for name order.
	name = "Use",
	tip = "useTip",
	icon = "icon16/pencil.png",
	onRun = function(item)
		local client = item.player
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local trace = util.TraceLine(data)

		if (trace.HitPos) then
			local note = ents.Create("bouncingmortar")
			note:SetPos(trace.HitPos + trace.HitNormal * 1)
			note:Spawn()

			--to add others, make a function like this but take the bit
				--in the statement that checks if its already welded
			local amt = note:AutoAtt(client)
			if(!amt) then
				note:Remove()
				return false
			end
		end

		return true
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
