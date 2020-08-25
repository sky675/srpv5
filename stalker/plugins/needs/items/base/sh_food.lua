ITEM.name = "food base"
ITEM.desc = "u shouldnt see this"
ITEM.model = "models/props_junk/garbage_metalcan002a.mdl"
ITEM.price = 1
ITEM.flag = "0"
ITEM.isFood = true
ITEM.category = "Food"
ITEM.permit = "food"
--ITEM.hungerAmt = 0
--ITEM.thirstAmt = 0

local function healPlayer(client, amount, seconds, itemid)
	local neg = amount < 0
	amount = math.abs(amount)

	if (client:Alive()) then
		local id = "nutStam_"..itemid..CurTime() --why did this use frametime before wtf
		timer.Create(id, (seconds/amount), amount, function() --changed it to repeat whenever 1 should be added, the other way wasnt working with slow heals (as in less than 1 per rep)
			if (!client:IsValid() or !client:Alive()) then
				timer.Destroy(id)	
			end

			client:restoreStamina(neg and -1 or 1)
		end)
	end
end
local function radPlayer(client, amount, seconds, itemid)
	local neg = amount < 0
	amount = math.abs(amount)
	if (client:Alive()) then
		local id = "nutRad_"..itemid..CurTime() --why did this use frametime before wtf
		timer.Create(id, (seconds/amount), amount, function() --changed it to repeat whenever 1 should be added, the other way wasnt working with slow heals (as in less than 1 per rep)
			if (!client:IsValid() or !client:Alive()) then
				timer.Destroy(id)	
			end

			client:getChar():addRad(neg and -1 or 1)
		end)
	end
end

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

ITEM.functions.use = {
	name = "Eat/Drink",
    tip = "Eat or drink this food.",
    icon = "icon16/cup.png",
    onRun = function(item)
		local char = item.player:getChar()

		local soundto = item.playsound
		if(soundto) then
			item.player:EmitSound(soundto)
		end

        if(item.hungerAmt) then
		char:SetHunger(math.Clamp(char:GetHunger()+item.hungerAmt, 0, 100))
		end
        if(item.thirstAmt) then
		char:SetThirst(math.Clamp(char:GetThirst()+item.thirstAmt, 0, 100))
		end
		if(item.regenStam) then
			healPlayer(item.player, item.regenStam[1], item.regenStam[2], item.id)
		end
		if(item.alcrem) then
			if(nut.traits.hasTrait(item.player, "big_alcohol") and !item.dontalch) then
				--remove
				char:setData("alcoh", math.max(0, char:getData("alcoh", 0)-item.alcrem))
			else
				--add
				char:setVar("alcoh", math.max(0, char:getVar("alcoh", 0)+item.alcrem))
				if(item.alcrem > 0) then
				timer.Simple(item.alcrem*180, function()
				char:setVar("alcoh", math.max(0, char:getVar("alcoh", 0)-item.alcrem))
				end)
				end
			end
		end
		--artifact radiation support
		if(char.addRad and item.radGive) then
			if(!item.radGiveTime) then
				char:addRad(item.radGive)
			else
				radPlayer(item.player, item.radGive, item.radGiveTime, item.id)
			end
		end

		if(item.uses) then
			if(item:getData("uses", item.uses) == 1) then
				return true
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
				return false
			end
		end
    end,
    onCanRun = function(item)
        return (!IsValid(item.entity))
    end
}