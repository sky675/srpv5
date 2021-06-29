FACTION.name = "Mutants"
FACTION.desc = "Mutants are animals or humans who have been warped by the Zone, changing both their physical appearance and behavior, usually making them more aggressive. Some humanoid mutants are by-products of C-Consciousness experiments and they all possess psychic powers."
FACTION.color = Color(54, 44, 20)--Color(204, 204, 204)
FACTION.noflavoritem = true
FACTION.isDefault = false

FACTION.hasanorak = false
--FACTION.anorak = 14 --setting this will force their anorak to be this skin


--[[FACTION.skins = {
	["models/sky/heads/male_01.mdl"] = {
		{0,7}
	},
}]]

--doing this here should be fine lol
nut.anim.setModelClass("models/tnb/stalker/kontroler1.mdl", "player")

--there has to be an easier way to do this
FACTION.models = {
	"models/tnb/stalker/kontroler1.mdl", --26
}

local SCHEMA = SCHEMA --will this work?
--[[
function FACTION:onGetDefaultName(client)
	local pay
	if(SERVER) then return end
	if(IsValid(nut.gui.charCreate)) then
		pay = nut.gui.charCreate.payload
	end
	if(pay) then
		print("okay")
		PrintTable(pay)
		if(!pay.name) then
			print("no name")
			return "Select a model first", true
		end
		print(pay.name)
		print(pay.model)
		if(pay.model and self.models[pay.model][1]) then
			return SCHEMA:getRandomName(self.models[pay.model][1], client)
		end
	end
end
]]

FACTION_MUTANT = FACTION.index