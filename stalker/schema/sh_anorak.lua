--use this in suits and stuff to determine what to change it to
TEXTURETABLE = { 
	--[[ --all default mats
		["models/sky/stalker/anorak_lone"]
		["models/sky/stalker/beri_lone"]
		["models/sky/stalker/cs1_lone"]
		["models/sky/stalker/cs2_lone"]
		["models/sky/stalker/eco_orang"]
		["models/sky/stalker/exo_lone"]
		["models/sky/stalker/io7a_lone"]
		["models/sky/stalker/seva_lone"]
		["models/sky/stalker/skat_lone"]
		["models/sky/stalker/sunrise_lone"]
		--this is the sunrise mask, and the gas tank
		["models/sky/stalker/sunrise_null"]
	]]
	--**decided against doing this, just use submats in gs on item, but
	--leave this for ^ for now




	--factions first
	["duty"] = {
		["models/sky/stalker/beri_lone"] = "models/sky/stalker/beri_duty",
		["models/sky/stalker/cs1_lone"] = "models/sky/stalker/cs1_duty",
		["models/sky/stalker/cs2_lone"] = "models/sky/stalker/cs2_blak",
		["models/sky/stalker/exo_lone"] = "models/sky/stalker/exo_duty",
		["models/sky/stalker/io7a_lone"] = "models/sky/stalker/io7a_duty",
		["models/sky/stalker/seva_lone"] = "models/sky/stalker/seva_duty",
		["models/sky/stalker/skat_lone"] = "models/sky/stalker/skat_duty",
		["models/sky/stalker/sunrise_lone"] = "models/sky/stalker/psz9d_duty",
		["models/sky/stalker/sunrise_null"] = "models/sky/stalker/psz9d_duty",

	},
	["free"] = {
		["models/sky/stalker/beri_lone"] = "models/sky/stalker/beri_free",
		["models/sky/stalker/cs1_lone"] = "models/sky/stalker/cs1_free",
		["models/sky/stalker/cs2_lone"] = "models/sky/stalker/cs2_free",
		["models/sky/stalker/exo_lone"] = "models/sky/stalker/exo_free",
		["models/sky/stalker/io7a_lone"] = "models/sky/stalker/io7a_free",
		["models/sky/stalker/seva_lone"] = "models/sky/stalker/seva_free",
		["models/sky/stalker/skat_lone"] = "models/sky/stalker/skat_free",
		["models/sky/stalker/sunrise_lone"] = "models/sky/stalker/wind_free",
		["models/sky/stalker/sunrise_null"] = "models/sky/stalker/wind_free",

	},
	["merc"] = {
		["models/sky/stalker/beri_lone"] = "models/sky/stalker/beri_blak",
		["models/sky/stalker/cs1_lone"] = "models/sky/stalker/cs1_dawn",
		["models/sky/stalker/cs2_lone"] = "models/sky/stalker/cs2_merc",
		["models/sky/stalker/exo_lone"] = "models/sky/stalker/exo_merc",
		["models/sky/stalker/io7a_lone"] = "models/sky/stalker/io7a_merc",
		["models/sky/stalker/seva_lone"] = "models/sky/stalker/seva_midn",
		["models/sky/stalker/skat_lone"] = "models/sky/stalker/skat_merc",
		["models/sky/stalker/sunrise_lone"] = "models/sky/stalker/sunrise_merc",
		["models/sky/stalker/sunrise_null"] = "models/sky/stalker/sunrise_blak",

	},
	["mili"] = {
		["models/sky/stalker/beri_lone"] = "models/sky/stalker/beri_mili",
		["models/sky/stalker/cs1_lone"] = "models/sky/stalker/cs1_dawn",
		["models/sky/stalker/cs2_lone"] = "models/sky/stalker/cs2_blak",
		["models/sky/stalker/exo_lone"] = "models/sky/stalker/exo_wood",
		["models/sky/stalker/io7a_lone"] = "models/sky/stalker/io7a_military",
		["models/sky/stalker/seva_lone"] = "models/sky/stalker/seva_midn",
		["models/sky/stalker/skat_lone"] = "models/sky/stalker/skat_mili",
		["models/sky/stalker/sunrise_lone"] = "models/sky/stalker/psz9d_acu1",
		["models/sky/stalker/sunrise_null"] = "models/sky/stalker/psz9d_acu1",

	},
	["mono"] = {
		["models/sky/stalker/beri_lone"] = "models/sky/stalker/beri_blak",
		["models/sky/stalker/cs1_lone"] = "models/sky/stalker/cs1_dawn",
		["models/sky/stalker/cs2_lone"] = "models/sky/stalker/cs2_blak",
		["models/sky/stalker/exo_lone"] = "models/sky/stalker/exo_mono",
		["models/sky/stalker/io7a_lone"] = "models/sky/stalker/io7a_monolith",
		["models/sky/stalker/seva_lone"] = "models/sky/stalker/seva_mono",
		["models/sky/stalker/skat_lone"] = "models/sky/stalker/skat_monolith",
		["models/sky/stalker/sunrise_lone"] = "models/sky/stalker/wind_mono",
		["models/sky/stalker/sunrise_null"] = "models/sky/stalker/wind_mono",

	},
	["ecol"] = {
		["models/sky/stalker/beri_lone"] = "models/sky/stalker/beri_eco",
		["models/sky/stalker/cs1_lone"] = "models/sky/stalker/cs1_dawn",
		["models/sky/stalker/cs2_lone"] = "models/sky/stalker/cs2_blak",
		["models/sky/stalker/exo_lone"] = "models/sky/stalker/exo_blue",
		["models/sky/stalker/io7a_lone"] = "models/sky/stalker/io7a_scientific",
		["models/sky/stalker/seva_lone"] = "models/sky/stalker/seva_midn",
		["models/sky/stalker/skat_lone"] = "models/sky/stalker/skat_scientific",
		["models/sky/stalker/sunrise_lone"] = "models/sky/stalker/psz9d_eco1",
		["models/sky/stalker/sunrise_null"] = "models/sky/stalker/sunrise_scientific",

	},
	--?
	["band"] = {

	},
	["csky"] = {
		--["models/sky/stalker/beri_lone"] = "models/sky/stalker/beri_duty",
		["models/sky/stalker/cs1_lone"] = "models/sky/stalker/cs1_csky",
		["models/sky/stalker/cs2_lone"] = "models/sky/stalker/cs2_csky",
		["models/sky/stalker/exo_lone"] = "models/sky/stalker/exo_cs",
		--["models/sky/stalker/io7a_lone"] = "models/sky/stalker/io7a_duty",
		["models/sky/stalker/seva_lone"] = "models/sky/stalker/seva_csky",
		["models/sky/stalker/skat_lone"] = "models/sky/stalker/skat_csky",
		["models/sky/stalker/sunrise_lone"] = "models/sky/stalker/sunrise_csky",
		["models/sky/stalker/sunrise_null"] = "models/sky/stalker/sunrise_csky",

	},
	--now colors/flavors/faction variants
	["blak"] = {

	},
	["flek"] = {

	},
	["tan"] = {

	},
	["urba"] = {

	},
	--might be more but these all i can think of rn
}

--global textures of anorak skins, easier to be stored as number
ANORAKTEXTURES = {
	--[numid] = "texturepath", --desc
	[0] = "models/sky/stalker/anorak_lone", --just in case

	[1] = "models/sky/stalker/anorak_band", --bandit black (used as bandits anorak)
	[2] = "models/sky/stalker/anorak_blak", --all black
	[3] = "models/sky/stalker/anorak_brun", --brown plaid
	[4] = "models/sky/stalker/anorak_chav", --white
	[5] = "models/sky/stalker/anorak_dull", --dark green
	[6] = "models/sky/stalker/anorak_flek", --flecktarn
	[7] = "models/sky/stalker/anorak_redd", --red plaid
	[8] = "models/sky/stalker/anorak_sand", --tan?

	[9] = "models/sky/stalker/anorak_clearsky", --clear sky
	[10] = "models/sky/stalker/anorak_duty", --duty
	[11] = "models/sky/stalker/anorak_freedom", --freedom
	[12] = "models/sky/stalker/anorak_merc", --merc
	[13] = "models/sky/stalker/anorak_military", --military
	[14] = "models/sky/stalker/anorak_mono", --monolith
	[15] = "models/sky/stalker/anorak_duty2", --like an officer duty kinda thing? idk
}

--this is the hood type on the seperate model
ANORAKHOODGROUP = {
	["models/sky/heads/male_01.mdl"] = 2,
	["models/sky/heads/male_02.mdl"] = 1,
	["models/sky/heads/male_03.mdl"] = 1,
	["models/sky/heads/male_04.mdl"] = 2,
	["models/sky/heads/male_05.mdl"] = 1,
	["models/sky/heads/male_06.mdl"] = 3,
	["models/sky/heads/male_07.mdl"] = 1,
	["models/sky/heads/male_08.mdl"] = 1,
	["models/sky/heads/male_09.mdl"] = 2,
	["models/sky/heads/male_10.mdl"] = 1,
	["models/sky/heads/male_11.mdl"] = 2,
	["models/sky/heads/male_12.mdl"] = 2,
	["models/sky/heads/male_13.mdl"] = 2,
	["models/sky/heads/male_14.mdl"] = 2,
	["models/sky/heads/male_15.mdl"] = 2,
	["models/sky/heads/male_16.mdl"] = 2,
	["models/sky/heads/male_17.mdl"] = 2,
	["models/sky/heads/male_18.mdl"] = 2,
	["models/sky/heads/male_19.mdl"] = 2,
	["models/sky/heads/male_20.mdl"] = 2,
	["models/sky/heads/male_21.mdl"] = 2,
	["models/sky/heads/male_22.mdl"] = 2,
	["models/sky/heads/male_23.mdl"] = 2,
	["models/sky/heads/male_24.mdl"] = 2,
	["models/sky/heads/male_25.mdl"] = 2,
	["models/sky/heads/male_26.mdl"] = 2,
	["models/sky/heads/male_27.mdl"] = 3,
	["models/sky/heads/male_28.mdl"] = 3,
	["models/sky/heads/male_29.mdl"] = 2,
	["models/sky/heads/male_30.mdl"] = 2,
	["models/sky/heads/male_31.mdl"] = 3,
	["models/sky/heads/male_32.mdl"] = 3,
	["models/sky/heads/male_33.mdl"] = 2,
	["models/sky/heads/male_34.mdl"] = 2,
	["models/sky/heads/male_35.mdl"] = 2,

}
--this is bodygroups on the main model
ANORAKBODYGROUPS = {

	["models/sky/heads/female_01.mdl"] = {
		head = 2
	},
	["models/sky/heads/female_02.mdl"] = {
		head = 2
	},
	["models/sky/heads/female_03.mdl"] = {
		head = 2
	},
	["models/sky/heads/female_04.mdl"] = {
		head = 2
	},
	["models/sky/heads/female_05.mdl"] = {
		hair = 1
	},
	["models/sky/heads/female_06.mdl"] = {
		head = 2
	},
	["models/sky/heads/female_07.mdl"] = {
		head = 2
	},
	["models/sky/heads/female_08.mdl"] = {
		hair = 2
	},
	["models/sky/heads/female_09.mdl"] = {
		hair = 2
	},
	["models/sky/heads/female_10.mdl"] = {
		hair = 2
	},
	["models/sky/heads/female_11.mdl"] = {
		hair = 2
	},
	["models/sky/heads/female_12.mdl"] = {
		hair = 1
	},
	["models/sky/heads/female_13.mdl"] = {
		hair = 1
	},
	["models/sky/heads/female_14.mdl"] = {
		head = 2,
		hair = 2
	},
	["models/sky/heads/female_15.mdl"] = {
		head = 1,
		hair = 1
	},
	["models/sky/heads/female_16.mdl"] = {
		head = 1,
		hair = 1
	},
	["models/sky/heads/female_17.mdl"] = {
		hair = 2
	},
	["models/sky/heads/female_18.mdl"] = {
		hair = 1
	},
	["models/sky/heads/female_19.mdl"] = {
		hair = 1
	},
	["models/sky/heads/female_20.mdl"] = {
		hair = 1
	},
	["models/sky/heads/female_21.mdl"] = {
		hair = 1
	},
	["models/sky/heads/female_22.mdl"] = {
		hair = 2
	},
	["models/sky/heads/female_23.mdl"] = {
		hair = 2
	},
	["models/sky/heads/female_26.mdl"] = {
		head = 2
	},

	["models/sky/heads/neo.mdl"] = {
		hair = 2
	},
	["models/sky/heads/quiet.mdl"] = {
		hair = 2
	},
	["models/sky/heads/greekin.mdl"] = {
		hair = 1
	},

	["models/sky/heads/male_27.mdl"] = {
		hair = 1
	},
	["models/sky/heads/male_28.mdl"] = {
		hair = 1
	},
	["models/sky/heads/male_29.mdl"] = {
		hair = 1
	},
	["models/sky/heads/male_30.mdl"] = {
		hair = 1
	},
	["models/sky/heads/male_31.mdl"] = {
		head = 1,
		hair = 1
	},
	["models/sky/heads/male_32.mdl"] = {
		head = 1,
		hair = 1,
	},
	["models/sky/heads/male_34.mdl"] = {
		hair = 1
	},
	["models/sky/heads/male_35.mdl"] = {
		hair = 1
	},


	--npcs
	["models/sky/npcs/female_01.mdl"] = {
		head = 2
	},
	["models/sky/npcs/female_02.mdl"] = {
		head = 2
	},
	["models/sky/npcs/female_03.mdl"] = {
		head = 2
	},
	["models/sky/npcs/female_04.mdl"] = {
		head = 2
	},
	["models/sky/npcs/female_05.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/female_06.mdl"] = {
		head = 2
	},
	["models/sky/npcs/female_07.mdl"] = {
		head = 2
	},
	["models/sky/npcs/female_08.mdl"] = {
		hair = 2
	},
	["models/sky/npcs/female_09.mdl"] = {
		hair = 2
	},
	["models/sky/npcs/female_10.mdl"] = {
		hair = 2
	},
	["models/sky/npcs/female_11.mdl"] = {
		hair = 2
	},
	["models/sky/npcs/female_12.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/female_13.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/female_14.mdl"] = {
		head = 2,
		hair = 2
	},
	["models/sky/npcs/female_15.mdl"] = {
		head = 1
	},
	["models/sky/npcs/female_16.mdl"] = {
		head = 1,
		hair = 1
	},
	["models/sky/npcs/female_17.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/female_18.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/female_19.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/female_20.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/female_21.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/female_22.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/female_23.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/female_26.mdl"] = {
		head = 2
	},
	["models/sky/npcs/male_27.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/male_28.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/male_29.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/male_30.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/male_31.mdl"] = {
		head = 1,
		hair = 1
	},
	["models/sky/npcs/male_32.mdl"] = {
		head = 1,
		hair = 1,
	},
	["models/sky/npcs/male_34.mdl"] = {
		hair = 1
	},
	["models/sky/npcs/male_35.mdl"] = {
		hair = 1
	},
	["models/sky/heads/dokkaebi.mdl"] = {
		dokkbeanie = 1
	},
	["models/sky/heads/maverick.mdl"] = {
		hat = 1
	},
}