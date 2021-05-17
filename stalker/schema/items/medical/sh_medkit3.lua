ITEM.name = "Scientific Medkit"
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_aptechka_mid.mdl"--stalker/item/medical/medkit3.mdl"
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
		ent:SetSkin(2)
	end,
	drawPostHook = function(ent, w, h)
		ent:SetSkin(0)
	end,
}

ITEM.uses = 2
ITEM.useTime = 3
ITEM.healAmount = 80
ITEM.healSeconds = 45
ITEM.radGive = -40
ITEM.radGiveTime = 40
ITEM.healLeg = true
ITEM.bleedStop = 7
ITEM.price = 6500
ITEM.desc = "High end medical set. This medkit includes items used to stop bleeding, treat burns, clean wounds, and treat a variety of different injuries. It also includes anti-radiation pills and medicine. Heals "..ITEM.healAmount.." in "..ITEM.healSeconds.." seconds. Also applies "..ITEM.bleedStop.." bleed reduction."
ITEM.flag = "E"

local function onUse(item)
	item.player:EmitSound("interface/inv_medkit_short.ogg", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)

function ITEM:customUse(char)
    local itemid = item.id
    hook.Add("CustomArmorResists", "itemuse"..itemid, function(client, levels)
        levels[DMG_SONIC] = (levels[DMG_SONIC] or 1)*0.8
        levels["psy"] = (levels["psy"] or 1)*0.8 --idk
        levels[DMG_RADIATION] = (levels[DMG_RADIATION] or 1)*0.4
    end)
    timer.Create("resRem"..itemid, 330, 1, function()
        hook.Remove("CustomArmorResists", "itemuse"..itemid)
    end)
end