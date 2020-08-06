ITEM.name = "Nitro"
ITEM.model = "models/props_junk/garbage_metalcan001a.mdl"--"models/mosi/fallout4/props/aid/jet.mdl"--"models/stalker/item/medical/antidote.mdl"
ITEM.desc = "This drug gives 6 strength, 8 endurance and 5 stamina for 3 minutes. When it wears off, they lose 4 endurance and 2 strength for 3 minutes and take 20 damage. A powerful stimulant that is a dangerous combination of potent drugs that can easily kill a user. Users feel infused with energy, suffer a diminished attention span, and talk incessantly (even to themselves)."
ITEM.flag = "m"
ITEM.noBusiness = true
ITEM.useName = "Swallow"
ITEM.duration = 180
ITEM.price = 80
local drugid = "nitro" --for later use?
ITEM.drugid = drugid
--[[
ITEM:hook("_use", function(item)
    item.player:setRagdolled(true, 180)
end)]]
ITEM.attribBoosts = {
	["end"] = 8,
	["stm"] = 5,
	["str"] = 6,
}

ITEM.funcadd = function(item, char)
	item.player:EmitSound("player/suit_sprint.wav", 60)
end

function ITEM:funcremove(char, id)
	if(char) then
	char:addBoost(id.."crash", "end", -4)
	char:addBoost(id.."crash", "str", -2)
	if(char:getPlayer()) then
	char:getPlayer():TakeDamage(20, char:getPlayer(), nil)
	end
	timer.Create("DrugEffectBreak_" .. id, 180, 1, function()
		--if (client and IsValid(client)) then
		--	local curChar = client:getChar()
		--	if (curChar and curChar:getID() == charID) then
			if(char) then
				char:removeBoost(id.."crash", "end")
				char:removeBoost(id.."crash", "str")
			end
		--end
	end)
	end
end