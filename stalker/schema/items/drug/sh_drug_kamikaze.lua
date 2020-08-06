ITEM.name = "Kamikaze"
ITEM.model = "models/warz/items/syringe.mdl"--"models/mosi/fallout4/props/aid/xcell.mdl"--"models/stalker/item/medical/antidote.mdl"
ITEM.skin = 7
ITEM.desc = "This drug gives you 5 endurance, 8 quickness, 4 stamina, and 5 strength for 3 minutes. When you crash you lose 4 quickness and 2 stamina for 3 minutes, and permanently lose 0.5 stamina. A tailored combat stimulant. Users are near-crazed, filled with a feeling of imperviousness and invincibility, exhibiting almost no regard to their own well-being. Repeated use has a destructive effect on the user's metabolism. Large doses can cause excitement, tremors, momentary euphoria, and dilated pupils. Excess doses cause anxiety, hallucinations, and uncontrolled muscular movements. Even higher doses can lead to death. When the drug wears off, they crash."
ITEM.flag = "m"
ITEM.noBusiness = true
ITEM.useName = "Swallow"
ITEM.duration = 180
ITEM.price = 360
local drugid = "kamikaze" --for later use?
ITEM.drugid = drugid
--[[
ITEM:hook("_use", function(item)
    item.player:setRagdolled(true, 180)
end)]]
ITEM.attribBoosts = {
	["end"] = 5,
	["qkn"] = 8,
	["stm"] = 4,
	["str"] = 5,
}

ITEM.funcadd = function(item, char)
	item.player:EmitSound("player/suit_sprint.wav", 60)
end

function ITEM:funcremove(char, id)
	if(char) then
	char:addBoost(id.."crash", "qkn", -4)
	char:addBoost(id.."crash", "stm", -2)
	char:updateAttrib("stm", -0.5)
	timer.Create("DrugEffectBreak_" .. id, 180, 1, function()
	--	if (client and IsValid(client)) then
			--local curChar = client:getChar()
			--if (curChar and curChar:getID() == charID) then
			if(char) then
				char:removeBoost(id.."crash", "qkn")
				char:removeBoost(id.."crash", "stm")
			end
	--	end
	end)
	end
end