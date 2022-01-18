ITEM.name = "Matches"
ITEM.desc = ""
ITEM.model = "models/wick/wrbstalker/anomaly/items/dez_drink_match0.mdl"
ITEM.price = 50
ITEM.flag = "0"
ITEM.uses = 6
ITEM.weight = 0.02

function ITEM:getDesc()
	local str = self.desc
	if(self.uses) then
    local ammo = tostring(self:getData("uses", self.uses))

	str = str..(str != "" and "\n" or "")..ammo.." out of "..tostring(self.uses or 1).." uses left."
	end

    return str
end

function ITEM:getWeight()
	--for multiuse items, the weight is per use
    return self.uses and self.weight*self:getData("uses", self.uses) or self.weight
end
function ITEM:calcPrice(origprice)
	local price = origprice

	local mag = self:getData("uses")
	if(mag) then
		price = price * (mag/self.uses)
	end

	return price
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if(item.uses) then
			draw.SimpleText(item:getData("uses", item.uses).."/"..item.uses, "DermaDefault", w - 5 , h - 5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
		end
	end
end