ITEM.name = "Gatorade"
ITEM.desc = "A bottle of Gatorade."
ITEM.price = 600
ITEM.model = "models/warz/consumables/gatorade.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.30
ITEM.hungerAmt = 4
ITEM.thirstAmt = 23
ITEM.dontalch = true
ITEM.alcrem = -2

ITEM.useSound = "interface/inv_drink_flask.ogg"

ITEM.regenStam = {
	--amount, seconds
	60, 45
}

local function onUse(item)
--	item.player:restoreStamina(60)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
	local itemid = item.id
	local uniq = "drinkstminc"..item.player:SteamID()
	local char = item.player:getChar()
	char:addBoost(uniq, "stm", 5)
	char:getInv():setData("maxWeight", char:getInv():getMaxWeight()+10)
	timer.Create("resRem"..itemid, 300, 1, function()
		char:removeBoost(uniq, "stm")
		char:getInv():setData("maxWeight", char:getInv():getMaxWeight()-10)

    end)
end
ITEM:hook("use", onUse)
