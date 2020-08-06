ITEM.name = "Anti-Rad"
ITEM.model = "models/stalker/item/medical/antirad.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.05
ITEM.useTime = 0.7
ITEM.price = 1860
ITEM.desc = "Common anti-radiation drugs."
ITEM.flag = "0"
ITEM.hungerAmt = -10
ITEM.thirstAmt = -5
ITEM.radGive = -35
ITEM.radGiveTime = 10


local function onUse(item)
    --new sound needed
    item.player:EmitSound("player/items/pain_pills/pills_deploy_2.wav", 60)
    item.player:TakeDamage(2)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)