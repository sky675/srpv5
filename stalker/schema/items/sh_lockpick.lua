ITEM.name = "Lockpick"
--ITEM.desc = RarityText(RARITY_COMMON)..[[
ITEM.desc = "A single-use lockpick to temporarily unlock a locked door. Unlock lasts for 3 minutes."--]]
ITEM.model = "models/props_junk/cardboard_box004a.mdl"
ITEM.category = "misc"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.1
ITEM.price = 1900
ITEM.flag = "0"
ITEM.noBusiness = true

--[[ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(127.39831542969, 106.89987945557, 77.550094604492),
	ang = Angle(25, 220, 0),
	fov = 6.4829684151473,
	outline = true,
	outlineColor = RARITY_COLORS[RARITY_COMMON],
}]]


ITEM.functions.usef = {
    name = "Use Forward",
    tip = "use on who youre looking at",
    icon = "icon16/arrow_up.png",
    --sound = "ambient/energy/weld1.wav", --like this
	onRun = function(item)
		local ply = item.player
		local tr = ply:GetEyeTrace()
		local door = tr.Entity
		--.lock is a cmb lock
		if(door and door:isDoor() and door:GetClass() != "func_door" and !door.lock) then
			local val = 2
			
			val = val * nut.traits.getMod(ply, "actiontime")

			ply:setAction("Lockpicking", val) --orig 2
			ply:doStaredAction(door, function()
				if(door:GetInternalVariable("m_bLocked")) then 
					door:Fire("Unlock")
				end
				item:remove()
				ply:EmitSound("doors/door_latch1.wav")
				timer.Simple(180, function()
					if(!door) then return end
					if(!door:GetInternalVariable("m_bLocked")) then 
					door:Fire("Close")
					door:Fire("Lock")
					end
				end)
			end, val, function() --orig was 2
				ply:setAction()
			end)
		end

		return false
	end,
    onCanRun = function(item)
		return !IsValid(item.entity)
	end
}