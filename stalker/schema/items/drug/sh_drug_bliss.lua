ITEM.name = "Bliss"
ITEM.model = "models/warz/items/syringe.mdl"--"models/stalker/item/medical/antidote.mdl"
ITEM.skin = 2
ITEM.desc = "Increases your endurance by 5 for around five minutes but can have after effects. Known as a 'tranquilizing' narcotic, this is an opiate synthesized from poppy plants. It takes its name from the senstations its users feel."
ITEM.flag = "m"
ITEM.noBusiness = true
ITEM.useName = "Swallow"
ITEM.duration = 300
ITEM.price = 35
local drugid = "bliss" --for later use?
ITEM.drugid = drugid
--[[
ITEM:hook("_use", function(item)
    item.player:setRagdolled(true, 180)
end)]]
ITEM.attribBoosts = {
	["end"] = 5,
}

ITEM.funcadd = function(item, char)
	item.player:EmitSound("interface/inv_stim_3p2.ogg", 60)
end

ITEM.funcremove = function(char)
	
end