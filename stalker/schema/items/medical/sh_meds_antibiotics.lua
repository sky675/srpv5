ITEM.name = "Potassium Iodide"
ITEM.model = "models/warz/consumables/medicine.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.05
ITEM.uses = 3
ITEM.useTime = 1.25
ITEM.price = 3080
ITEM.desc = "A bottle of a pharmacological compound, used to cheaply counteract radiation. Can have numerous harmful side effects."
ITEM.flag = "6"
ITEM.hungerAmt = -10
ITEM.thirstAmt = -6
ITEM.radGive = -25
ITEM.radGiveTime = 10


local function onUse(item)
    item.player:EmitSound("player/items/pain_pills/pills_deploy_2.wav", 60)
    item.player:TakeDamage(5)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)