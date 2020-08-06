ITEM.name = "Milk Carton"
ITEM.desc = "A carton of milk. Maybe out of date."
ITEM.price = 600
ITEM.model = "models/props_junk/garbage_milkcarton002a.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 4.4
ITEM.hungerAmt = 0
ITEM.thirstAmt = 15
ITEM.radGive = 10
ITEM.radGiveTime = 5

local function onUse(item)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end
ITEM:hook("use", onUse)
