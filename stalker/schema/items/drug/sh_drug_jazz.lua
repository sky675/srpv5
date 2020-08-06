ITEM.name = "Jazz"
ITEM.model = "models/props_junk/garbage_metalcan001a.mdl"--"models/mosi/fallout4/props/aid/jet.mdl"--"models/stalker/item/medical/antidote.mdl"
ITEM.desc = "This drug gives 10 quickness and 3 strength for 2 minutes. When you crash, you lose 5 quickness for 2 more minutes. A stimulant usually taken from a single-dose inhaler. It makes poeple jumpy and hyper as caffeinated two-year-olds. Users seem like they have too much energy to burn. When the drug wears off, they crash and is flooded with despondent and miserable emotions and get fairly disoriented."
ITEM.flag = "m"
ITEM.noBusiness = true
ITEM.useName = "Swallow"
ITEM.duration = 120
ITEM.price = 110
local drugid = "jazz" --for later use?
ITEM.drugid = drugid
--[[
ITEM:hook("_use", function(item)
    item.player:setRagdolled(true, 180)
end)]]
ITEM.attribBoosts = {
	["qkn"] = 10,
	["str"] = 3,
}

ITEM.funcadd = function(item, char)
	item.player:EmitSound("player/suit_sprint.wav", 60)
end

function ITEM:funcremove(char, id)
	if(char) then
	char:addBoost(id.."crash", "qkn", -5)
	timer.Create("DrugEffectBreak_" .. id, 120, 1, function()
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