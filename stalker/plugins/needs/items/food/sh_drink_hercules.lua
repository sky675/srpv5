ITEM.name = "Hercules" --MOORE energy"
ITEM.desc = "A long lasting drug made with an artificial steroid, used for reducing muscle fatigue."
ITEM.price = 2382
ITEM.model = "models/kek1ch/drug_booster.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.18
ITEM.hungerAmt = 10
ITEM.thirstAmt = 10
ITEM.dontalch = true
ITEM.alcrem = -2

ITEM.regenStam = {
	--amount, seconds
	100, 120
}

local function onUse(item)
	--item.player:restoreStamina(80)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
	local itemid = item.id
	local uniq = "hercstminc"..item.player:SteamID()
	local char = item.player:getChar()
	char:addBoost(uniq, "stm", 10)
	char:getInv():setData("maxWeight", char:getInv():getMaxWeight()+30)
	timer.Create("resRem"..itemid, 600, 1, function()
		char:removeBoost(uniq, "stm")
		char:getInv():setData("maxWeight", char:getInv():getMaxWeight()-30)

    end)
end
ITEM:hook("use", onUse)
