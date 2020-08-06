ITEM.name = "Energy Drink" --MOORE energy"
ITEM.desc = "A can of a branded energy drink."
ITEM.price = 610
ITEM.model = "models/kali/miscstuff/stalker/food/energy drink.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.33
ITEM.hungerAmt = 5
ITEM.thirstAmt = 21
ITEM.dontalch = true
ITEM.alcrem = -3

ITEM.regenStam = {
	--amount, seconds
	75, 60
}

local function onUse(item)
	--item.player:restoreStamina(80)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
	local itemid = item.id
	local uniq = "drinkstminc"..item.player:SteamID()
	local char = item.player:getChar()
	char:addBoost(uniq, "stm", 8)
	char:getInv():setData("maxWeight", char:getInv():getMaxWeight()+15)
	timer.Create("resRem"..itemid, 300, 1, function()
		char:removeBoost(uniq, "stm")
		char:getInv():setData("maxWeight", char:getInv():getMaxWeight()-15)

    end)
end
ITEM:hook("use", onUse)
