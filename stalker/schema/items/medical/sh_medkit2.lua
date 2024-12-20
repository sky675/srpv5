ITEM.name = "Army Medkit"
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_high.mdl"--stalker/item/medical/medkit2.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.25
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.46412658691, 154.82537841797, 113.36277008057),
	ang = Angle(25, 220, 0),
	entAng = Angle(10.982773780823, -5.8737111091614, -4.1379284858704),
	fov = 2.5245093576938,
	
	drawHook = function(ent, w, h)
		ent:SetSkin(1)
	end,
	--[[drawPostHook = function(ent, w, h)
		ent:SetSkin(0)
	end,]]
}

ITEM.uses = 2
ITEM.useTime = 3
ITEM.healAmount = 50
ITEM.healSeconds = 35
ITEM.healLeg = true
ITEM.canRevive = false
ITEM.bleedStop = 3
ITEM.price = 4500
ITEM.desc = "Includes medicine for faster blood coagulation, as well as painkillers, antibiotics, immunity stimulators, and more. Heals "..ITEM.healAmount.." in "..ITEM.healSeconds.." seconds. Also applies "..ITEM.bleedStop.." bleed reduction."
ITEM.flag = "u"

local function onUse(item)
	item.player:EmitSound("interface/inv_medkit_short.ogg", 60)
	
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)
