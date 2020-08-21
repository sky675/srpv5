ITEM.name = "Radio"
ITEM.model = "models/stalker/item/handhelds/radio.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.4
ITEM.category = "Communication"
ITEM.price = 1400
ITEM.flag = "N"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.46412658691, 155.1947479248, 116.58136749268),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, -22.133018493652, 0),
	fov = 2.1810190695629,
}

ITEM.destroyval = {
	["comp_scrap_metal"] = 1,
	["comp_tech1"] = 2,
	["comp_wire1"] = 1,
}

function ITEM:getDesc()
	local str
	
	if (!self.entity or !IsValid(self.entity)) then
		str = "A radio that allows you to send a signal to other characters in distance.\nPower: %s\nFrequency: %s%s"
		return Format(str, (self:getData("power") and "On" or "Off"), self:getData("freq", "000.0"), self:getData("listenonly") and "\nWill not transmit on this radio's frequency." or "")
	else
		local data = self.entity:getData()
		
		str = "A functional radio. Power: %s Frequency: %s"
		return Format(str, (self.entity:getData("power") and "On" or "Off"), self.entity:getData("freq", "000.0"))
	end
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("power", false)) then
			surface.SetDrawColor(110, 255, 110, 100)
		else
			surface.SetDrawColor(255, 110, 110, 100)
		end

		surface.DrawRect(w - 14, h - 14, 8, 8)
	end

	local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
	local COLOR_ACTIVE = Color(0, 255, 0)
	local COLOR_INACTIVE = Color(255, 0, 0)

	function ITEM:drawEntity(entity, item)
		entity:DrawModel()
		local rt = RealTime()*100
		local position = entity:GetPos() + entity:GetForward() * 0 + entity:GetUp() * 2 + entity:GetRight() * 0

		if (entity:getData("power", false) == true) then
			if (math.ceil(rt/14)%10 == 0) then
				render.SetMaterial(GLOW_MATERIAL)
				render.DrawSprite(position, rt % 14, rt % 14, entity:getData("power", false) and COLOR_ACTIVE or COLOR_INACTIVE)
			end
		end
	end
end

// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.toggle = { -- sorry, for name order.
	name = "Toggle",
	tip = "useTip",
	icon = "icon16/connect.png",
	onRun = function(item)
		item:setData("power", !item:getData("power", false), player.GetAll(), false, true)
		item.player:EmitSound("buttons/button14.wav", 70, 150)

		return false
	end,
}
ITEM.functions.togglel = { -- sorry, for name order.
name = "Toggle Listen Only",
tip = "useTip",
icon = "icon16/connect.png",
onRun = function(item)
	item:setData("listenonly", !item:getData("listenonly", false), player.GetAll(), false, true)
	item.player:EmitSound("buttons/button14.wav", 70, 150)

	return false
end,
}

ITEM.functions.use = { -- sorry, for name order.
	name = "Freq",
	tip = "useTip",
	icon = "icon16/wrench.png",
	onRun = function(item)
		netstream.Start(item.player, "radioAdjust", item:getData("freq", "000,0"), item.id)

		return false
	end,
}
