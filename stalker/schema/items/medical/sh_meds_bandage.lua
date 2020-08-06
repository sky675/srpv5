ITEM.name = "Bandage"
ITEM.model = "models/sky/items/bandage.mdl"--stalker/item/medical/bandage.mdl"
ITEM.skin = 0
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.04
ITEM.healAmount = 15
ITEM.healSeconds = 20
ITEM.bleedStop = 9
ITEM.price = 1000
ITEM.desc = "A roll of bandages. Heals "..ITEM.healAmount.." in "..ITEM.healSeconds.." seconds. Also applies "..ITEM.bleedStop.." bleed reduction."
ITEM.flag = "0"
ITEM.permit = "med"

local function onUse(item)
	item.player:EmitSound("interface/inv_bandage.ogg", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)