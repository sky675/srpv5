ITEM.name = "Psy-Block"
ITEM.model = "models/stalker/item/medical/psy_pills.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.01
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(184.46412658691, 154.82962036133, 112.22286987305),
	ang = Angle(25, 220, 0),
	entAng = Angle(-16.444862365723, -92.06111907959, -19.979295730591),
	fov = 2.022695806094,
}

ITEM.uses = 5
ITEM.useTime = 1
ITEM.price = 4450
ITEM.desc = "A drug used to counteract psy-fields. Induces short-term loss of all emotion. Effective for approximately 20 minutes."
ITEM.flag = "6"
ITEM.hungerAmt = -8
ITEM.thirstAmt = -5


local function onUse(item)
    item.player:EmitSound("player/items/pain_pills/pills_deploy_2.wav", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)


function ITEM:customUse(char)
    local itemid = item.id
    hook.Add("CustomArmorResists", "itemuse"..itemid, function(client, levels)
        levels[DMG_SONIC] = (levels[DMG_SONIC] or 1)*0.8
        levels["psy"] = (levels["psy"] or 1)*0.8 --idk
    end)
    timer.Create("resRem"..itemid, 1200, 1, function()
        hook.Remove("CustomArmorResists", "itemuse"..itemid)
    end)
end