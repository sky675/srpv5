ITEM.name = "Painkillers"
ITEM.model = "models/warz/consumables/painkillers.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.uses = 4
ITEM.weight = 0.01
ITEM.healAmount = 40
ITEM.healSeconds = 100
ITEM.price = 3800
ITEM.desc = "A bottle of painkillers. Heals "..ITEM.healAmount.." in "..ITEM.healSeconds.." seconds."
ITEM.flag = "6"

local function onUse(item)
	item.player:EmitSound("player/items/pain_pills/pills_deploy_2.wav", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)