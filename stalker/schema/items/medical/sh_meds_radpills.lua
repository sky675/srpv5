ITEM.name = "Radioprotectant"
ITEM.model = "models/stalker/item/medical/rad_pills.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.01
ITEM.uses = 2
ITEM.useTime = 1
ITEM.price = 1720
ITEM.desc = "B190 Indraline radioprotectant, reduces the effects of radiation for around 5 minutes."
ITEM.flag = "6"
ITEM.hungerAmt = -5
ITEM.thirstAmt = -6


local function onUse(item)
    item.player:EmitSound("player/items/pain_pills/pills_deploy_2.wav", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)


function ITEM:customUse(char)
    local itemid = item.id
    hook.Add("CustomArmorResists", "itemuse"..itemid, function(client, levels)
        levels[DMG_RADIATION] = (levels[DMG_RADIATION] or 1)*0.6
    end)
    timer.Create("resRem"..itemid, 330, 1, function()
        hook.Remove("CustomArmorResists", "itemuse"..itemid)
    end)
end