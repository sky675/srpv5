nut.currency = nut.currency or {}
nut.currency.symbol = nut.currency.symbol or "$"
nut.currency.singular = nut.currency.singular or "dollar"
nut.currency.plural = nut.currency.plural or "dollars"

function nut.currency.set(symbol, singular, plural)
	nut.currency.symbol = symbol
	nut.currency.singular = singular
	nut.currency.plural = plural
end

function nut.currency.get(amount)
	if (amount == 1) then
		return nut.currency.symbol.."1 "..nut.currency.singular
	else
		return nut.currency.symbol..amount.." "..nut.currency.plural
	end
end

function nut.currency.spawn(pos, amount, angle)
	if (!pos) then
		print("[Nutscript] Can't create currency entity: Invalid Position")
	elseif (!amount or amount < 0) then
		print("[Nutscript] Can't create currency entity: Invalid Amount of money")
	else
		local money = ents.Create("nut_money")
		money:SetPos(pos)
		money:setAmount(math.Round(math.abs(amount)))
		money:SetAngles(angle or Angle(0, 0, 0))
		money:Spawn()
		money:Activate()

		return money
	end
end

function GM:OnPickupMoney(client, moneyEntity)
	if (moneyEntity and moneyEntity:IsValid()) then
		local amount = moneyEntity:getAmount()

		client:getChar():giveMoney(amount)
		client:notifyLocalized("moneyTaken", nut.currency.get(amount))
	end
end


local charMeta = nut.meta.character

function charMeta:hasMoney(amount)
	if (amount < 0) then
		print("Negative Money Check Received.")	
	end

	return self:getMoney() >= amount
end

function charMeta:giveMoney(amount, takingMoney)
	if (!takingMoney) then
		nut.log.add(self:getPlayer(), "money", amount)

		hook.Run("OnCharMoney", self:getPlayer(), amount)
	end
		
	self:setMoney(self:getMoney() + amount)

	return true
end

function charMeta:takeMoney(amount)
	nut.log.add(self:getPlayer(), "money", -amount)
	hook.Run("OnCharMoney", self:getPlayer(), -amount)

	amount = math.abs(amount)
	self:giveMoney(-amount, true)

	return true
end
