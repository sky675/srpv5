ITEM.name = "Caffeine Tablets" --MOORE energy"
ITEM.desc = "A package of caffeine tablets."
ITEM.price = 2550
ITEM.model = "models/wick/wrbstalker/anomaly/items/wick_dev_caffeine.mdl"
ITEM.uses = 5
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.01
ITEM.hungerAmt = 3
ITEM.thirstAmt = -2
ITEM.dontalch = true
ITEM.alcrem = -2

ITEM.useSound = "player/items/pain_pills/pills_deploy_2.wav"

ITEM.regenStam = {
	--amount, seconds
	30, 50
}

local function onUse(item)
	--item.player:restoreStamina(80)
	 
	--item.player:EmitSound("items/medshot4.wav", 80, 110)
	--item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
	local itemid = item.id
	local uniq = "caffstminc"..item.player:SteamID()
	local char = item.player:getChar()
	char:addBoost(uniq, "stm", 3)
	char:getInv():setData("maxWeight", char:getInv():getMaxWeight()+7)
	timer.Create("resRem"..itemid, 300, 1, function()
		char:removeBoost(uniq, "stm")
		char:getInv():setData("maxWeight", char:getInv():getMaxWeight()-7)

    end)
end
ITEM:hook("use", onUse)
