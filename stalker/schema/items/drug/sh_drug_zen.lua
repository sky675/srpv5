ITEM.name = "Zen"
ITEM.model = "models/props_junk/garbage_metalcan001a.mdl"--"models/mosi/fallout4/props/aid/jet.mdl"--"models/stalker/item/medical/antidote.mdl"
ITEM.desc = "ITEM IS LEFT OVER FROM OASIS, SHOULD BE FUNCTIONAL BUT MAY BE DELETED LATER\nThis drug gives you -12 quickness for 3 minutes. A psychedelic hallucinogen. It is popular among those looking to escape reality or seeking trance-like states."
ITEM.flag = "m"
ITEM.noBusiness = true
ITEM.useName = "Swallow"
ITEM.duration = 300
ITEM.price = 16
local drugid = "zen" --for later use?
ITEM.drugid = drugid
--[[
ITEM:hook("_use", function(item)
    item.player:setRagdolled(true, 180)
end)]]
ITEM.attribBoosts = {
	["qkn"] = -12,
}

ITEM.funcadd = function(item, char)
	char:getPlayer():EmitSound("player/suit_sprint.wav", 60)
end

function ITEM:funcremove(char)
	
end