ITEM.name = "Novacoke"
ITEM.model = "models/warz/items/syringe.mdl"--"models/mosi/fallout4/props/aid/medx.mdl"--"models/stalker/item/medical/antidote.mdl"
ITEM.skin = 5
ITEM.desc = "ITEM IS LEFT OVER FROM OASIS, SHOULD BE FUNCTIONAL BUT MAY BE DELETED LATER\nThis drug gives you 2 endurance and 4 quickness for 5 minutes. After the drug wears off, you lose 2 endurance for 5 minutes. A highly addictive social drug. It is a stimulant derived from coca plants."
ITEM.flag = "m"
ITEM.noBusiness = true
ITEM.useName = "Swallow"
ITEM.duration = 300
ITEM.price = 30
local drugid = "novacoke" --for later use?
ITEM.drugid = drugid
--[[
ITEM:hook("_use", function(item)
    item.player:setRagdolled(true, 180)
end)]]
ITEM.attribBoosts = {
	["end"] = 2,
	["qkn"] = 4,
}

ITEM.funcadd = function(item, char)
	item.player:EmitSound("interface/inv_stim_3p2.ogg", 60)
end

function ITEM:funcremove(char, id)
	if(char) then
	char:addBoost(id.."crash", "end", -2)
	timer.Create("DrugEffectBreak_" .. id, 300, 1, function()
		if(char) then
	--	if (client and IsValid(client)) then
	--		local curChar = client:getChar()
	--		if (curChar and curChar:getID() == charID) then
				char:removeBoost(id.."crash", "end")
	--		end
		end
	end)
	end
end