ITEM.name = "Cram"
ITEM.model = "models/stalker/item/medical/psy_pills.mdl"
ITEM.desc = "This increases your quickness by 6 for four minutes and then lowers it by 10 for three. An extremely popular stimulant. Users appear hyper-alert, almost to the point of paranoia. They react quickly, often without thought, and they're prone to irrational outbursts. Other common side effects are jitteriness and fidgeting. When it wears off, users tend to crash."
ITEM.flag = "m"
ITEM.noBusiness = true
ITEM.useName = "Swallow"
ITEM.duration = 240
ITEM.price = 27
local drugid = "cram" --for later use?
ITEM.drugid = drugid
--[[
ITEM:hook("_use", function(item)
    item.player:setRagdolled(true, 180)
end)]]
ITEM.attribBoosts = {
	["qkn"] = 6,
}

ITEM.funcadd = function(item, char)
	item.player:EmitSound("npc/barnacle/barnacle_gulp1.wav", 60)
end

function ITEM:funcremove(char, id)
	if(char) then
	char:addBoost(id.."crash", "qkn", -10)
	timer.Create("DrugEffectBreak_" .. id, 180, 1, function()
		--if (client and IsValid(client)) then
			--local curChar = client:getChar()
			--if (curChar and curChar:getID() == charID) then
			if(char) then
				char:removeBoost(id.."crash", "qkn")
			end
		--end
	end)	
	end
end