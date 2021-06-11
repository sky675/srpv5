FACTION.name = "Freedom"
FACTION.desc = "Freedom is a clan of stalkers who fight for free access to the Zone, and their views are somewhat anarchistic, believing nobody can own the Zone and seeing it both as a scientific marvel and as a free life inside the Zone's borders. In contrast to the regimented, highly disciplined atmosphere of Duty, the members of Freedom have a much more relaxed, informal attitude."
FACTION.color = Color(18, 99, 0)

FACTION.isDefault = false

FACTION.hasanorak = true
FACTION.anorak = 11 --setting this will force their anorak to be this skin

FACTION.defaultBGs = {
	["female"] = {
		[3] = 3,
		[4] = 3,
	},
	["male"] = {
		[3] = 3,
		[4] = 4,
	}
}

FACTION.skins = {
	["models/sky/heads/male_01.mdl"] = {
		{0,7}
	},
	["models/sky/heads/male_02.mdl"] = {
		{0,7}
	},
	["models/sky/heads/male_03.mdl"] = {
		{0,6}
	},
	["models/sky/heads/male_04.mdl"] = {
		{0,7}
	},
	["models/sky/heads/male_05.mdl"] = {
		{0,6}
	},
	["models/sky/heads/male_06.mdl"] = {
		{0,6}
	},
	["models/sky/heads/male_07.mdl"] = {
		{0,7}
	},
	["models/sky/heads/male_08.mdl"] = {
		{0,7}
	},
	["models/sky/heads/male_09.mdl"] = {
		{0,7}
	},
	["models/sky/heads/male_11.mdl"] = {
		{0,3}
	},
	["models/sky/heads/male_12.mdl"] = {
		{0,2}
	},
	["models/sky/heads/male_27.mdl"] = {
		{0,1}
	},
	["models/sky/heads/male_28.mdl"] = {
		{0,1}
	},
	["models/sky/heads/male_29.mdl"] = {
		{0,1}
	},
	["models/sky/heads/male_30.mdl"] = {
		{0,1}
	},
	["models/sky/heads/male_31.mdl"] = {
		{0,2}
	},
	["models/sky/heads/male_32.mdl"] = {
		{0,1}
	},
	["models/sky/heads/female_01.mdl"] = {
		{0,5}
	},
	["models/sky/heads/female_02.mdl"] = {
		{0,5}
	},
	["models/sky/heads/female_03.mdl"] = {
		{0,6}
	},
	["models/sky/heads/female_04.mdl"] = {
		{0,4}
	},
	["models/sky/heads/female_05.mdl"] = {
		{0,2}
	},
	["models/sky/heads/female_06.mdl"] = {
		{0,5}
	},
	["models/sky/heads/female_07.mdl"] = {
		{0,3}
	},
}

--there has to be an easier way to do this
FACTION.models = {
	"models/sky/heads/male_01.mdl", --26
	"models/sky/heads/male_02.mdl",
	"models/sky/heads/male_03.mdl",
	"models/sky/heads/male_04.mdl",
	"models/sky/heads/male_05.mdl",
	"models/sky/heads/male_06.mdl",
	"models/sky/heads/male_07.mdl",
	"models/sky/heads/male_08.mdl",
	"models/sky/heads/male_09.mdl",
	"models/sky/heads/male_10.mdl",
	"models/sky/heads/male_11.mdl",
	"models/sky/heads/male_12.mdl",
	"models/sky/heads/male_13.mdl",
	"models/sky/heads/male_14.mdl",
	"models/sky/heads/male_15.mdl",
	"models/sky/heads/male_16.mdl",
	"models/sky/heads/male_17.mdl",
	"models/sky/heads/male_18.mdl",
	"models/sky/heads/male_19.mdl",
	"models/sky/heads/male_20.mdl",
	"models/sky/heads/male_21.mdl",
	"models/sky/heads/male_22.mdl",
	"models/sky/heads/male_23.mdl",
	"models/sky/heads/male_24.mdl",
	"models/sky/heads/male_25.mdl",
	"models/sky/heads/male_26.mdl",
	"models/sky/heads/male_27.mdl",
	"models/sky/heads/male_28.mdl",
	"models/sky/heads/male_29.mdl",
	"models/sky/heads/male_30.mdl",
	"models/sky/heads/male_31.mdl",
	"models/sky/heads/male_32.mdl",
	"models/sky/heads/male_33.mdl",
	"models/sky/heads/male_34.mdl",
	"models/sky/heads/male_35.mdl",
	"models/sky/heads/female_01.mdl", --23
	"models/sky/heads/female_02.mdl",
	"models/sky/heads/female_03.mdl",
	"models/sky/heads/female_04.mdl",
	"models/sky/heads/female_05.mdl",
	"models/sky/heads/female_06.mdl",
	"models/sky/heads/female_07.mdl",
	"models/sky/heads/female_08.mdl",
	"models/sky/heads/female_09.mdl",
	"models/sky/heads/female_10.mdl",
	"models/sky/heads/female_11.mdl",
	"models/sky/heads/female_12.mdl",
	"models/sky/heads/female_13.mdl",
	"models/sky/heads/female_14.mdl",
	"models/sky/heads/female_15.mdl",
	"models/sky/heads/female_16.mdl",
	"models/sky/heads/female_17.mdl",
	"models/sky/heads/female_18.mdl",
	"models/sky/heads/female_19.mdl",
	"models/sky/heads/female_20.mdl",
	"models/sky/heads/female_21.mdl",
	"models/sky/heads/female_22.mdl",
	"models/sky/heads/female_23.mdl",
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

FACTION_FREEDOM = FACTION.index