ITEM.name = "Antiseptic Bandage"
ITEM.model = "models/sky/items/bandage.mdl"--stalker/item/medical/bandage.mdl"
ITEM.skin = 1
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.06
ITEM.healAmount = 25
ITEM.healSeconds = 20
ITEM.bleedStop = 9
ITEM.price = 5200
ITEM.desc = "A higher quality roll of bandages. Heals "..ITEM.healAmount.." in "..ITEM.healSeconds.." seconds. Also applies "..ITEM.bleedStop.." bleed reduction."
ITEM.flag = "6"
ITEM.noBusiness = true --crafting only

local function onUse(item)
	item.player:EmitSound("interface/inv_bandage.ogg", 60)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)