ITEM.name = "Antidote"
--im pretty sure this is the anabiotics, which makes you survive an emission, so idk
ITEM.model = "models/stalker/item/medical/antidote.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.01
ITEM.uses = 3
ITEM.useTime = 1
ITEM.price = 3360
ITEM.desc = "A package of IP2 antitoxin. Gives extra chemical resistance for around 5 minutes."
ITEM.flag = "6"
ITEM.hungerAmt = -4
ITEM.thirstAmt = -9


local function onUse(item)
    --new sound needed
    item.player:EmitSound("player/items/pain_pills/pills_deploy_2.wav", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)


function ITEM:customUse(char)
    local itemid = item.id
    hook.Add("CustomArmorResists", "itemuse"..itemid, function(client, levels)
        levels[DMG_POISON] = (levels[DMG_POISON] or 1)*0.65
        levels[DMG_ACID] = (levels[DMG_ACID] or 1)*0.65
    end)
    timer.Create("resRem"..itemid, 300, 1, function()
        hook.Remove("CustomArmorResists", "itemuse"..itemid)
    end)
end