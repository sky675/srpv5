local PLUGIN = PLUGIN

local ammoSounds = {
	["pistol"] = "interface/inv_items_ammo_2.ogg",
	["ws"] = "interface/inv_items_ammo_5.ogg",
	["shotgun"] = "interface/inv_items_ammo_4.ogg",
	["n"] = "interface/inv_items_ammo_5.ogg",
	["knife"] = "interface/inv_items_ammo_2.ogg",
}
--lua_run for k,v in pairs(Entity(1):GetActiveWeapon().Attachments) do print(k, istable(v.Slot) and table.concat(v.Slot, ",") or v.Slot, v.PrintName, v.Installed) end


local weaponList = {
	--[[
	["id"] = {
		name = "name of wep",
		desc = "desc",
		price = 0,
		model = "",
		width = 1,
		height = 1,
		weight = 1,
		category = "Weapons (cat)",
		type = "unused curr, will be for repair",
		flag = "flagunder",
		--defaultMods = {
		--	["slot"] = "attid"
		--},
		--slots above should probably also be below
		--cantDetach = {
		--	["slot"] = true,
		--},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	]]
	--go
	--glocks
	["cwep_g17"] = {
		--exclusive upgrade ideas: 
		--long slide go_glock_slide_long, 
		--ext mag go_glock_mag_28
		name = "Glock 17",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_glock.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_glock",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--	["slot"] = "attid"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_glock_slide"] = true,
			["go_glock_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_g26"] = {
		--exclusive upgrade ideas: 
		--ext mag go_glock_mag_28
		name = "Glock 26",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_glock.mdl",
		groups = {
			[0] = 1,
			[1] = 1,
			[2] = 1
		},
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_glock",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["go_glock_slide"] = "go_glock_slide_short"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_glock_slide"] = true,
			["go_glock_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_g18"] = {
		--exclusive upgrade ideas: 
		--ext mag go_glock_mag_28
		name = "Glock 18",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_glock.mdl",
		groups = {
			[1] = 2,
		},
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_glock",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["go_glock_slide"] = "go_glock_slide_auto"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_glock_slide"] = true,
			["go_glock_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_g21"] = {
		--exclusive upgrade ideas: 
		--long slide go_glock_slide_long, 
		--ext mag go_glock_mag_26_45acp
		name = "Glock 21",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_glock.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_glock",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["go_glock_mag"] = "go_glock_mag_13_45acp"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_glock_slide"] = true,
			["go_glock_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_g30"] = {
		--exclusive upgrade ideas: 
		--ext mag go_glock_mag_26_45acp
		name = "Glock 30",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_glock.mdl",
		groups = {
			[0] = 1,
			[1] = 1,
			[2] = 1
		},
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_glock",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["go_glock_mag"] = "go_glock_mag_13_45acp",
			["go_glock_slide"] = "go_glock_slide_short"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_glock_slide"] = true,
			["go_glock_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--m9
	["cwep_m9"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_m9_mag_24
		name = "M92FS",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_m9.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_m9",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--	["slot"] = "attid"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_m9_slide"] = true,
			["go_m9_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m93r"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_m9_mag_24
		name = "M93R",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_m9.mdl",
		groups = {
			[1] = 3,
		},
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_m9",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["go_m9_slide"] = "go_m9_slide_auto"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_m9_slide"] = true,
			["go_m9_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--usp
	["cwep_usp"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_usp_mag_20 go_usp_mag_30
		name = "USP-45",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_usp.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_usp",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--	["slot"] = "attid"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_usp_slide"] = true,
			--["go_muzzle_usp"] = true,
			["go_usp_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_usp9"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_usp_mag_25_9 go_usp_mag_40_9 
		name = "USP-9",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_usp.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_usp",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["go_usp_mag"] = "go_usp_mag_15_9"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_usp_slide"] = true,
			--["go_muzzle_usp"] = true,
			["go_usp_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_uspm"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_usp_mag_25_9 go_usp_mag_40_9 
		name = "USP Match",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_usp.mdl", --extras phys is fucked
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_usp",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["go_usp_mag"] = "go_usp_mag_15_9",
			["go_muzzle_usp"] = "go_usp_muzzle_match"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_usp_slide"] = true,
			["go_muzzle_usp"] = true,
			["go_usp_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--cz75
	["cwep_cz75"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_cz75_mag_30
		name = "CZ-75",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_cz75.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_cz75",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--	["slot"] = "attid"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_cz75_slide"] = true,
			["go_cz75_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_cz75a"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_cz75_mag_30
		name = "CZ-75 Auto",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_cz75.mdl",
		groups = {
			[1] = 3
		},
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_cz75",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["go_cz75_slide"] = "go_cz75_slide_auto"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_cz75_slide"] = true,
			["go_cz75_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--p2000
	["cwep_p2000"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_p2000_mag_24
		name = "P2000",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_p2000.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_p2000",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--	["slot"] = "attid"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_p2000_slide"] = true,
			["go_p2000_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--p250
	["cwep_p250"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_p250_mag_24_9mm
		name = "P250",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_p250.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_p250",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["go_p250_mag"] = "go_p250_mag_15_9mm"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_p250_slide"] = true,
			["go_p250_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_p25045"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_p250_mag_15_45acp
		name = "P250 .45",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_p250.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_p250",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["go_p250_mag"] = "go_p250_mag_9_45acp"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_p250_slide"] = true,
			["go_p250_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--deagle
	["cwep_deagle"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_deagle_mag_9
		name = "Desert Eagle",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_deagle.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_deagle",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--	["slot"] = "attid"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_deagle_slide"] = true,
			["go_deagle_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--tec9
	["cwep_tec9"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_tec9_mag_32
		--auto go_homemade_auto - tbh could do the auto elsewhere, tho this one is exclusive to this and ar15
		name = "TEC-9",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_tec9.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_tec9",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--	["slot"] = "attid"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_tec9_barrel"] = true,
			["go_tec9_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
			["go_homemade_auto"] = true,
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--fiveseven
	["cwep_fiveseven"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_fiveseven_mag_30
		name = "Five-seveN",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_pist_fiveseven.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_fiveseven",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--	["slot"] = "attid"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_fiveseven_slide"] = true,
			["go_fiveseven_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["go_perk_pistol"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--mp5
	["cwep_mp5"] = {
		--exclusive upgrade ideas: 
		--ext mag go_mp5_mag_40
		name = "MP5A3",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_smg_mp5.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_mp5",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_mp5_barrel"] = true,
			["go_mp5_mag"] = true, --upgrade
			["go_mp5_stock"] = true,
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_mp5sd"] = {
		--exclusive upgrade ideas: 
		--ext mag go_mp5_mag_40
		name = "MP5SD3",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_smg_mp5.mdl",
		groups = {
			[1] = 3
		},
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_mp5",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle",
			["go_mp5_barrel"] = "go_mp5_barrel_sd"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_mp5_barrel"] = true,
			["go_mp5_mag"] = true, --upgrade
			["go_mp5_stock"] = true,
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_mp5hk"] = {
		--exclusive upgrade ideas: 
		--ext mag go_mp5_mag_40
		name = "HK94A3",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_smg_mp5.mdl",
		groups = {
			[1] = 2
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_mp5",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle",
			["go_mp5_barrel"] = "go_mp5_barrel_long",
			["go_perk"] = "go_perk_semi"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_mp5_barrel"] = true,
			["go_mp5_mag"] = true, --upgrade
			["go_mp5_stock"] = true,
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--bizon
	["cwep_bizon"] = {
		--exclusive upgrade ideas: 
		--?
		name = "PP-19 Bizon",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_smg_bizon.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_bizon",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_bizon_barrel"] = true,
			["go_bizon_mag"] = true, --upgrade
			["go_bizon_stock"] = true,
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--ump
	["cwep_ump45"] = {
		--exclusive upgrade ideas: 
		--?
		name = "UMP-45",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_smg_ump45.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_ump",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_ump_barrel"] = true,
			["go_ump_mag"] = true, --upgrade
			["go_ump_stock"] = true,
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_usc45"] = {
		--exclusive upgrade ideas: 
		--?
		name = "USC-45",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_smg_ump45.mdl",
		groups = {
			[1] = 1
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_ump",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle",
			["go_ump_barrel"] = "go_ump_barrel_long",
			["go_perk"] = "go_perk_semi"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_ump_barrel"] = true,
			["go_ump_mag"] = true, --upgrade
			["go_ump_stock"] = true,
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_ump9"] = {
		--exclusive upgrade ideas: 
		--?
		name = "UMP-9",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_smg_ump45.mdl",
		groups = {
			[2] = 2
		},
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_ump",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle",
			["go_ump_mag"] = "go_ump_mag_30_9mm"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_ump_barrel"] = true,
			["go_ump_mag"] = true, --upgrade
			["go_ump_stock"] = true,
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_usc9"] = {
		--exclusive upgrade ideas: 
		--?
		name = "USC-9",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_smg_ump45.mdl",
		groups = {
			[1] = 1,
			[2] = 2
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_ump",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle",
			["go_ump_mag"] = "go_ump_mag_30_9mm",
			["go_ump_barrel"] = "go_ump_barrel_long",
			["go_perk"] = "go_perk_semi"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_ump_barrel"] = true,
			["go_ump_mag"] = true, --upgrade
			["go_ump_stock"] = true,
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--mac10
	["cwep_mac10"] = {
		--exclusive upgrade ideas: 
		--ext mag go_mac10_mag_48
		--heavy stock go_mac10_stock_heavy
		name = "MAC-10",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_smg_mac10.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_mac10",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_mac10_barrel"] = true,
			["go_mac10_mag"] = true, --upgrade
			["go_mac10_stock"] = true,
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--mp9
	["cwep_mp9"] = {
		--exclusive upgrade ideas: 
		--?
		name = "MP9",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_smg_mp9.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_mp9",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_mp9_barrel"] = true,
			["go_mp9_mag"] = true, --upgrade
			["go_mp9_stock"] = true,
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--p90
	["cwep_p90"] = {
		--exclusive upgrade ideas: 
		--?
		name = "P90",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_smg_p90.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_p90",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_p90_barrel"] = true,
			["go_p90_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--mp7
	["cwep_mp7"] = {
		--exclusive upgrade ideas: 
		--ext mag go_mp7_mag_40
		name = "MP7",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_smg_mp7.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_mp7",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_mp7_stock"] = true,
			["go_stock"] = true,
			["go_mp7_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--r870
	["cwep_870"] = {
		--exclusive upgrade ideas: 
		--ext mag go_870_mag_8
		--long barrel go_870_barrel_long
		--tube stocks
		name = "Remington Model 870",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_shot_870.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_go_870",
		category = "Weapons - Shotguns",
		type = "shotgun",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_870_barrel"] = true,
			["go_870_mag"] = true, --upgrade
			["go_870_stock"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_870sawn"] = {
		--exclusive upgrade ideas: 
		--idk
		name = "Remington Model 870 Sawn-off",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_shot_870.mdl",
		groups = {
			[1] = 1,
			[2] = 1,
			[3] = 2,
			[4] = 1
		},
		width = 3,
		height = 1,
		weight = 1,
		class = "arccw_go_870",
		category = "Weapons - Shotguns",
		type = "shotgun",
		--flag = "",
		defaultMods = {
			["go_870_barrel"] = "go_870_barrel_short",
			["go_870_mag"] = "go_870_mag_4",
			["go_870_stock"] = "go_870_stock_sawnoff"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_870_barrel"] = true,
			["go_870_mag"] = true, --upgrade
			["go_870_stock"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--nova
	["cwep_nova"] = {
		--exclusive upgrade ideas: 
		--ext mag go_nova_mag_8
		--long barrel go_nova_barrel_long
		--sport stock go_nova_stock_sport + tube stocks
		name = "SuperNova",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_shot_nova.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_go_nova",
		category = "Weapons - Shotguns",
		type = "shotgun",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_nova_barrel"] = true,
			["go_nova_mag"] = true, --upgrade
			["go_nova_stock"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--m1014
	["cwep_m1014"] = {
		--exclusive upgrade ideas: 
		--ext mag go_m1014_mag_7
		--long barrel go_m1014_barrel_long
		--tube stocks
		name = "M1014",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_shot_m1014.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_go_m1014",
		category = "Weapons - Shotguns",
		type = "shotgun",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_m1014_barrel"] = true,
			["go_m1014_mag"] = true, --upgrade
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--mag7
	["cwep_mag7"] = {
		--exclusive upgrade ideas: 
		--eh
		name = "MAG-7",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_shot_mag7.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_mag7",
		category = "Weapons - Shotguns",
		type = "shotgun",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_mag7_barrel"] = true,
			["go_mag7_mag"] = true, --upgrade
			["go_mag7_stock"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--m249 - some way to switch to the bipod would be cool tbh, maybe toggleable on wep base?
	["cwep_m249"] = {
		--exclusive upgrade ideas: 
		--9mm go_m249_mag_9_200 shotgun go_m249_mag_12g_45
		name = "M249 SAW",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_mach_m249para.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_go_m249",
		category = "Weapons - MGs",
		type = "n",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_m249_barrel"] = true,
			["go_m249_mag"] = true, --upgrade
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--negev
	["cwep_negev"] = {
		--exclusive upgrade ideas: 
		--?
		name = "IWI Negev",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_mach_negev.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_go_negev",
		category = "Weapons - MGs",
		type = "ws",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_negev_barrel"] = true,
			["go_negev_belt"] = true, --upgrade
			["go_negev_stock"] = true,
			["go_stock_none"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--aug
	["cwep_aug"] = {
		--this shit is not 36 rounds!! needs to be changed!!
		--exclusive upgrade ideas: 
		--?
		name = "AUG A3",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_rif_aug.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_aug",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_aug_barrel"] = true,
			["go_aug_9mm"] = true, --upgrade
			["go_ammo_556_60"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_augpara"] = {
		--exclusive upgrade ideas: 
		--?
		name = "AUG Para",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_rif_aug.mdl",
		groups = {
			[2] = 2,
			[3] = 1,
			[4] = 1
		},
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_aug",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["go_aug_barrel"] = "go_aug_barrel_short",
			["go_aug_9mm"] = "go_aug_ammo_9mm",
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_aug_barrel"] = true,
			["go_aug_9mm"] = true, --upgrade
			["go_ammo_556_60"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--awm
	["cwep_awm"] = {
		--exclusive upgrade ideas: 
		--obrez lol go_awp_barrel_short go_awp_stock_obrez
		name = "AWM",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_snip_awp.mdl",
		width = 5,
		height = 1,
		weight = 1,
		class = "arccw_go_awp",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		defaultMods = {
			["optic"] = "", --should unequip the optic
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_awp_barrel"] = true,
			["go_awp_mag"] = true, --upgrade
			["go_awp_stock"] = true,
			["go_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--fal
	["cwep_fal"] = {
		--exclusive upgrade ideas: 
		--?
		name = "FN FAL",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_rif_fnfal.mdl",
		groups = {
			[1] = 3,
		},
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_go_fnfal",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle2",
			["go_fal_barrel"] = "go_fal_barrel_long",
			["go_perk"] = "go_homemade_auto", --the fal has an automatic mode dummies
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			
			["go_fal_barrel"] = true,
			["go_fal_mag"] = true, --upgrade
			["go_fal_stock"] = true,
			["go_stock"] = true,
			["go_stock_none"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_falpara"] = {
		--exclusive upgrade ideas: 
		--?
		name = "FN FAL Para",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_rif_fnfal.mdl",
		groups = {
			[5] = 2,
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_fnfal",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle2",
			["go_fal_stock"] = "go_fal_stock_skeleton",
			["go_perk"] = "go_homemade_auto", --the fal has an automatic mode dummies
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_fal_barrel"] = true,
			["go_fal_mag"] = true, --upgrade
			["go_fal_stock"] = true,
			["go_stock"] = true,
			["go_stock_none"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--scar
	["cwep_scarh"] = {
		--exclusive upgrade ideas: 
		--sniper cfg: go_scar_barrel_long go_scar_stock_sniper
		name = "FN SCAR-H",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_rif_scar.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_go_scar",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle2",
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_scar_barrel"] = true,
			["go_scar_mag"] = true, --upgrade
			["go_scar_stock"] = true,
			["go_stock"] = true,
			["go_stock_none"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_scarl"] = {
		--exclusive upgrade ideas: 
		--?
		name = "FN SCAR-L",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_rif_scar.mdl",
		groups = {
			[1] = 2,
			[5] = 4
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_scar",
		category = "Weapons - ARs",
		type = "ws",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle2",
			["go_scar_barrel"] = "go_scar_barrel_short",
			["go_scar_mag"] = "go_scar_mag_30_556",
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_scar_barrel"] = true,
			["go_scar_mag"] = true, --upgrade
			["go_scar_stock"] = true,
			["go_stock"] = true,
			["go_stock_none"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--ace
	["cwep_ace22"] = {
		--exclusive upgrade ideas: 
		name = "ACE 22",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_rif_ace.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_ace",
		category = "Weapons - Rifles",
		type = "n",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle3",
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_ace_barrel"] = true,
			["go_ace_mag"] = true, --upgrade
			["go_ak47_stock"] = true,
			["go_stock"] = true,
			["go_stock_none"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_ace32"] = {
		--exclusive upgrade ideas: 
		name = "ACE 32",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_rif_ace.mdl",
		groups = {
			[3] = 4
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_ace",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		defaultMods = {
			["foregrip"] = "go_extras_boondoggle3",
			["go_ace_mag"] = "go_ace_mag_30_762",
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_ace_barrel"] = true,
			["go_ace_mag"] = true, --upgrade
			["go_ak47_stock"] = true,
			["go_stock"] = true,
			["go_stock_none"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--galil
	["cwep_galil"] = {
		--exclusive upgrade ideas: 
		name = "IWI Galil AR",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/v_rif_galil_ar.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_galil_ar",
		category = "Weapons - Rifles",
		type = "n",
		--flag = "",
		--defaultMods = {
		--	["foregrip"] = "go_extras_boondoggle3",
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_galil_ar_barrel"] = true,
			["go_stock"] = true,
			["go_stock_none"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--ssg08
	["cwep_ssg08"] = {
		--exclusive upgrade ideas: 
		--obrez go_ssg08_barrel_short go_stock_none
		--ehhhh maybe an upgrade to change it back to 308?
		name = "SSG08",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_snip_scout.mdl",
		width = 5,
		height = 1,
		weight = 1,
		class = "arccw_go_ssg08",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		defaultMods = {
			["go_ssg08_mag"] = "go_ssg08_mag_10_762", --ehhh?
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			["go_ssg08_barrel"] = true,
			["go_ssg08_mag"] = true, --upgrade
			["go_ssg08_stock"] = true,
			["go_stock"] = true,
			["go_stock_none"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--fas2
	--toz34
	["cwep_toz34"] = {
		--exclusive upgrade ideas: 
		--?
		name = "TOZ-34",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_toz34.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_toz34",
		category = "Weapons - Shotguns",
		type = "shotgun",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_toz34_bar"] = true,
			["mifl_fas2_toz34_mag"] = true, --upgrade
			["mifl_fas2_ks23_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_toz34sawn"] = {
		--exclusive upgrade ideas: 
		--?
		name = "TOZ-34 Sawnoff",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_toz34.mdl",
		groups = {
			[1] = 1,
			[2] = 1,
			[3] = 1
		},
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_toz34",
		category = "Weapons - Shotguns",
		type = "shotgun",
		--flag = "",
		defaultMods = {
			["mifl_fas2_toz34_bar"] = "mifl_fas2_toz_bar_2x_s",
			["mifl_fas2_ks23_stock"] = "mifl_fas2_ks23_stock_k",
			
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_toz34_bar"] = true,
			["mifl_fas2_toz34_mag"] = true, --upgrade
			["mifl_fas2_ks23_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--ks23
	["cwep_ks23"] = {
		--exclusive upgrade ideas: 
		--?
		name = "KS-23",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_ks23.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_ks23",
		category = "Weapons - Shotguns",
		type = "shotgun",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_ks23_barrel"] = true,
			["mifl_fas2_ks23_mag"] = true, --upgrade
			["mifl_fas2_ks23_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--m1911
	["cwep_m1911"] = {
		--exclusive upgrade ideas: 
		--?
		name = "M1911",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_m1911.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_m1911",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_m1911_slide"] = true,
			["mifl_fas2_m1911_mag"] = true, --upgrade
			["mifl_fas2_m1911_stock"] = true,
			["mifl_roni_conv"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--p226
	["cwep_p226"] = {
		--exclusive upgrade ideas: 
		--?
		name = "P226",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_p226.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_p226",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_p226_slide"] = true,
			["mifl_fas2_p226_mag"] = true, --upgrade
			["mifl_fas2_g20_stock"] = true,
			["mifl_roni_conv"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--m24
	["cwep_m24"] = {
		--exclusive upgrade ideas: 
		--?
		name = "M24",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_m24.mdl",
		width = 5,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_m24",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_m24_hg"] = true,
			["mifl_fas2_m24_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--sr25
	["cwep_sr25"] = {
		--exclusive upgrade ideas: 
		--?
		name = "SR-25",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_sr25.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_sr25",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_sr25_hg"] = true,
			["mifl_fas2_sr25_mag"] = true, --upgrade
			["mifl_fas2_sr25_stock"] = true, --upgrade
			["mifl_fas2_uni_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--g3
	["cwep_g3"] = {
		--exclusive upgrade ideas: 
		--?
		name = "G3A3",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_g3.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_g3",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_g3_hg"] = true,
			["mifl_fas2_g3_mag"] = true, --upgrade
			["mifl_fas2_g3_stock"] = true, --upgrade
			["mifl_fas2_uni_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--aks
	["cwep_akm"] = {
		--exclusive upgrade ideas: 
		--?
		name = "AKM",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "ws",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_ak_hg"] = true,
			["mifl_fas2_ak_mag"] = true, --upgrade
			["mifl_fas2_ak47_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_ak74"] = {
		--exclusive upgrade ideas: 
		--?
		name = "AK74",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 5,
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_ak_mag"] = "mifl_fas2_ak_mag_545"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_ak_hg"] = true,
			["mifl_fas2_ak_mag"] = true, --upgrade
			["mifl_fas2_ak47_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_aks74"] = {
		--exclusive upgrade ideas: 
		--?
		name = "AKS74",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 5,
			[5] = 3,
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_ak_mag"] = "mifl_fas2_ak_mag_545",
			["go_stock"] = "mifl_fas2_ak_stock_ske"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_ak_hg"] = true,
			["mifl_fas2_ak_mag"] = true, --upgrade
			["mifl_fas2_ak47_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_aks74u"] = {
		--exclusive upgrade ideas: 
		--?
		name = "AKS74U",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 5,
			[2] = 13,
			[5] = 3,
		},
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_ak_hg"] = "mifl_fas2_ak_hg_u",
			["mifl_fas2_ak_mag"] = "mifl_fas2_ak_mag_545",
			["go_stock"] = "mifl_fas2_ak_stock_ske"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_ak_hg"] = true,
			["mifl_fas2_ak_mag"] = true, --upgrade
			["mifl_fas2_ak47_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--removed pp19, it actually looked awful
	["cwep_svd"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Dragunov SVD",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 11,
			[2] = 7,
			[5] = 4,
			[7] = 1
		},
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		defaultMods = {
			["mifl_fas2_ak_hg"] = "mifl_fas2_ak_hg_svd",
			["mifl_fas2_ak_mag"] = "mifl_fas2_ak_mag_82",
			["go_stock"] = "mifl_fas2_ak_stock_svd"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_ak_hg"] = true,
			["mifl_fas2_ak_mag"] = true, --upgrade
			["mifl_fas2_ak47_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_asval"] = {
		--exclusive upgrade ideas: 
		--?
		name = "AS Val",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 4,
			[2] = 1,
			[5] = 3
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_ak_hg"] = "mifl_fas2_ak_hg_sd",
			["mifl_fas2_ak_mag"] = "mifl_fas2_ak_mag_939_20",
			["go_stock"] = "mifl_fas2_ak_stock_ske"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_ak_hg"] = true,
			["mifl_fas2_ak_mag"] = true, --upgrade
			["mifl_fas2_ak47_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_vss"] = {
		--exclusive upgrade ideas: 
		--?
		name = "VSS Vintorez",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 4,
			[2] = 1,
			[5] = 4,
			[7] = 1
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_ak_hg"] = "mifl_fas2_ak_hg_sd",
			["mifl_fas2_ak_mag"] = "mifl_fas2_ak_mag_939_20", --unsure if should use 10 or 20 tbh
			["go_stock"] = "mifl_fas2_ak_stock_svd"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_ak_hg"] = true,
			["mifl_fas2_ak_mag"] = true, --upgrade
			["mifl_fas2_ak47_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_an94"] = {
		--exclusive upgrade ideas: 
		--?
		name = "AN94",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 5,
			[2] = 12,
			[5] = 7
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_ak_hg"] = "mifl_fas2_ak_hg_an94",
			["mifl_fas2_ak_mag"] = "mifl_fas2_ak_mag_545",
			["go_stock"] = "mifl_fas2_ak_stock_fold"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_ak_hg"] = true,
			["mifl_fas2_ak_mag"] = true, --upgrade
			["mifl_fas2_ak47_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_ak12"] = {
		--exclusive upgrade ideas: 
		--?
		name = "AK12",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 5,
			[2] = 10,
			[5] = 7
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_ak_hg"] = "mifl_fas2_ak_hg_12",
			["mifl_fas2_ak_mag"] = "mifl_fas2_ak_mag_545",
			["go_stock"] = "go_stock_moe"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_ak_hg"] = true,
			["mifl_fas2_ak_mag"] = true, --upgrade
			["mifl_fas2_ak47_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_saiga"] = {
		--need to change to 5 rounds lol
		--exclusive upgrade ideas: 
		--?
		name = "Saiga-12",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 13,
			[2] = 9,
			[5] = 3
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - Shotguns",
		type = "shotgun",
		--flag = "",
		defaultMods = {
			["mifl_fas2_ak_hg"] = "mifl_fas2_ak_hg_saiga",
			["mifl_fas2_ak_mag"] = "mifl_fas2_ak_mag_20g",
			["go_stock"] = "mifl_fas2_ak_stock_ske"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_ak_hg"] = true,
			["mifl_fas2_ak_mag"] = true, --upgrade
			["mifl_fas2_ak47_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_rpk"] = {
		--exclusive upgrade ideas: 
		--?
		name = "RPK",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_rpk.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_rpk",
		category = "Weapons - MGs",
		type = "ws",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_rpk_hg"] = true,
			["mifl_fas2_rpk_mag"] = true, --upgrade
			["mifl_fas2_rpk_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--famas
	["cwep_famas"] = {
		--exclusive upgrade ideas: 
		--?
		name = "FAMAS F1",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_famas.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_famas",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_famas_hg"] = true,
			["mifl_fas2_famas_mag"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--g36c
	["cwep_g36c"] = {
		--exclusive upgrade ideas: 
		--?
		name = "G36C",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_g36c.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_g36c",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		--defaultMods = {
			
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_g36c_hg"] = true,
			["mifl_fas2_g36c_mag"] = true, --upgrade
			["mifl_fas2_g36_stock"] = true, --upgrade
			["mifl_fas2_uni_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_g36"] = {
		--exclusive upgrade ideas: 
		--?
		name = "G36",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_g36c.mdl",
		groups = {
			[3] = 4
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_g36c",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_g36c_hg"] = "mifl_fas2_g36_barrel_scope"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_g36c_hg"] = true,
			["mifl_fas2_g36c_mag"] = true, --upgrade
			["mifl_fas2_g36_stock"] = true, --upgrade
			["mifl_fas2_uni_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--sg55x
	["cwep_sg552"] = {
		--exclusive upgrade ideas: 
		--?
		name = "SG552",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_sg552.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_sg55x",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		--defaultMods = {
			--["mifl_fas2_sg55x_mag"] = "mifl_fas2_g36_barrel_scope"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_sg55x_hg"] = true,
			["mifl_fas2_sg55x_mag"] = true, --upgrade
			["mifl_fas2_sg55x_stock"] = true, --upgrade
			["mifl_fas2_uni_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_sg550"] = {
		--exclusive upgrade ideas: 
		--?
		name = "SG550",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_sg552.mdl",
		groups = {
			[1] = 1,
			[2] = 2
		},
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_sg55x",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_sg55x_hg"] = "mifl_fas2_sg55x_barrel_551",
			["mifl_fas2_sg55x_mag"] = "mifl_fas2_m4a1_mag_556_20",
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_sg55x_hg"] = true,
			["mifl_fas2_sg55x_mag"] = true, --upgrade
			["mifl_fas2_sg55x_stock"] = true, --upgrade
			["mifl_fas2_uni_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_sg5501"] = {
		--exclusive upgrade ideas: 
		--?
		name = "SG550-1",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_sg552.mdl",
		groups = {
			[1] = 1,
			[2] = 1,
			[3] = 7
		},
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_sg55x",
		category = "Weapons - Rifles",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_sg55x_hg"] = "mifl_fas2_sg55x_barrel_550",
			["mifl_fas2_sg55x_mag"] = "mifl_fas2_m4a1_mag_556_20",
			["mifl_fas2_sg55x_stock"] = "mifl_fas2_sg55x_stock_sniper",
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_sg55x_hg"] = true,
			["mifl_fas2_sg55x_mag"] = true, --upgrade
			["mifl_fas2_sg55x_stock"] = true, --upgrade
			["mifl_fas2_uni_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--m4
	["cwep_m4a1"] = {
		--exclusive upgrade ideas: 
		--?
		name = "M4A1",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_m4a1.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_m4a1",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		--defaultMods = {
			--["mifl_fas2_sg55x_mag"] = "mifl_fas2_g36_barrel_scope"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_m4a1_hg"] = true,
			["mifl_fas2_m4a1_mag"] = true, --upgrade
			["mifl_fas2_m4a1_stock"] = true, --upgrade
			["mifl_fas2_uni_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m16a1"] = {
		--exclusive upgrade ideas: 
		--?
		name = "M16A1",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_m4a1.mdl",
		groups = {
			[1] = 4,
			[2] = 4,
			[5] = 1
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_m4a1",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_m4a1_hg"] = "mifl_fas2_m4a1_barrel_a1",
			["mifl_fas2_m4a1_stock"] = "mifl_fas2_m4a1_stock_a2",
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_m4a1_hg"] = true,
			["mifl_fas2_m4a1_mag"] = true, --upgrade
			["mifl_fas2_m4a1_stock"] = true, --upgrade
			["mifl_fas2_uni_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m16a2"] = {
		--exclusive upgrade ideas: 
		--?
		name = "M16A2",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_m4a1.mdl",
		groups = {
			[1] = 1,
			[2] = 1,
			[5] = 1
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_m4a1",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_m4a1_hg"] = "mifl_fas2_m4a1_barrel_a2",
			["mifl_fas2_m4a1_stock"] = "mifl_fas2_m4a1_stock_a2",
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_m4a1_hg"] = true,
			["mifl_fas2_m4a1_mag"] = true, --upgrade
			["mifl_fas2_m4a1_stock"] = true, --upgrade
			["mifl_fas2_uni_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m16a4"] = {
		--exclusive upgrade ideas: 
		--?
		name = "M16A4",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_m4a1.mdl",
		groups = {
			[1] = 13,
			[2] = 12,
			[5] = 1
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_m4a1",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["mifl_fas2_m4a1_hg"] = "mifl_fas2_m4a1_barrel_a4",
			["mifl_fas2_m4a1_stock"] = "mifl_fas2_m4a1_stock_a2",
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_m4a1_hg"] = true,
			["mifl_fas2_m4a1_mag"] = true, --upgrade
			["mifl_fas2_m4a1_stock"] = true, --upgrade
			["mifl_fas2_uni_stock"] = true, --upgrade
			["go_stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m79"] = {
		--exclusive upgrade ideas: 
		--?
		name = "M79",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_m79.mdl",
		width = 3,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_m79",
		category = "Weapons - Misc",
		type = "shotgun",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_m79_tube"] = true,
			["mifl_fas2_m79_stock"] = true, --upgrade
			["mifl_fas2_m79_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--exotic
	--aek
	["cwep_aek"] = {
		--exclusive upgrade ideas: 
		--?
		name = "AEK-971",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/eap/c_aek971.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_eap_aek",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["eap_aek_barrel"] = true,
			["eap_aek_handguard"] = true, --upgrade
			["eap_aek_mag"] = true, --upgrade
			["eap_aek_stock"] = true, --upgrade
			["eap_stock_wood"] = true,
			["go_stock"] = true, --upgrade
			["go_stock_none"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--groza
	["cwep_groza"] = {
		--exclusive upgrade ideas: 
		--?
		name = "OTs-14-4A-01 Groza",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/eap/c_groza.mdl",
		groups = {
			[1] = 9
		},
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_eap_groza",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			--["eap_groza_barrel"] = "",
			["eap_groza_mag"] = "eap_groza_mag_939_20"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["eap_groza_barrel"] = true,
			["eap_groza_mag"] = true, --upgrade
			["stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_grozas"] = {
		--exclusive upgrade ideas: 
		--?
		name = "OTs-14-4A-02 Groza",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/eap/c_groza.mdl",
		groups = {
			[1] = 9,
			[3] = 2
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_eap_groza",
		category = "Weapons - ARs",
		type = "n",
		--flag = "",
		defaultMods = {
			["eap_groza_barrel"] = "eap_groza_barrel_sd",
			["eap_groza_mag"] = "eap_groza_mag_939_20"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["eap_groza_barrel"] = true,
			["eap_groza_mag"] = true, --upgrade
			["stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_groza1"] = {
		--exclusive upgrade ideas: 
		--?
		name = "OTs-14-1A-01 Groza",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/eap/c_groza.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_eap_groza",
		category = "Weapons - ARs",
		type = "ws",
		--flag = "",
		defaultMods = {
			--["eap_groza_barrel"] = "",
			--["eap_groza_mag"] = "eap_groza_mag_939_20"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["eap_groza_barrel"] = true,
			["eap_groza_mag"] = true, --upgrade
			["stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_groza1s"] = {
		--exclusive upgrade ideas: 
		--?
		name = "OTs-14-1A-02 Groza",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/eap/c_groza.mdl",
		groups = {
			[3] = 2
		},
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_eap_groza",
		category = "Weapons - ARs",
		type = "ws",
		--flag = "",
		defaultMods = {
			["eap_groza_barrel"] = "eap_groza_barrel_sd",
			--["eap_groza_mag"] = "eap_groza_mag_939_20"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["eap_groza_barrel"] = true,
			["eap_groza_mag"] = true, --upgrade
			["stock"] = true, --upgrade
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},

	--blackops
	--browning
	["cwep_browninghp"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Browning HP",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/c_bo2_bhp.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_bo2_browninghp",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--	["eap_groza_barrel"] = "eap_groza_barrel_sd",
			--["eap_groza_mag"] = "eap_groza_mag_939_20"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--db
	["cwep_doublebarrel"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Double Barrel",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/c_waw_doublebarrel.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_waw_doublebarrel",
		category = "Weapons - Shotguns",
		type = "shotgun",
		--flag = "",
		defaultMods = {
			["bo1_mp5stock"] = "bo1_solider_stock",
			--["eap_groza_mag"] = "eap_groza_mag_939_20"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["waw_dbs_barrel"] = true,
			["bo1_mp5stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_doublebarrelsawn"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Double Barrel Sawnoff",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/c_waw_doublebarrel.mdl",
		groups = {
			[1] = 1,
			[2] = 1
		},
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_waw_doublebarrel",
		category = "Weapons - Shotguns",
		type = "shotgun",
		--flag = "",
		defaultMods = {
			["waw_dbs_barrel"] = "bo1_dbs_barrel_sawnoff",
			--["eap_groza_mag"] = "eap_groza_mag_939_20"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["waw_dbs_barrel"] = true,
			["bo1_mp5stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--uzi
	["cwep_uzi"] = {
		--exclusive upgrade ideas: 
		--?
		name = "IWI Uzi",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/c_bo1_uzi.mdl",
		groups = {
			[3] = 2
		},
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_bo1_uzi",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["bo1_stock"] = "bo1_light_stock",
			--["eap_groza_mag"] = "eap_groza_mag_939_20"
		},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["bo1_stock"] = true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--ppsh
	["cwep_ppsh"] = {
		--exclusive upgrade ideas: 
		--?
		name = "PPSh-41",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/c_waw_ppsh41.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_waw_ppsh41",
		category = "Weapons - SMGs",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--	["bo1_stock"] = "bo1_light_stock",
			--["eap_groza_mag"] = "eap_groza_mag_939_20"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--m60?
	["cwep_m60"] = {
		--exclusive upgrade ideas: 
		--?
		name = "M60",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/c_bo1_m60.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_bo1_m60",
		category = "Weapons - MGs",
		type = "ws",
		--flag = "",
		--defaultMods = {
		--	["bo1_stock"] = "bo1_light_stock",
			--["eap_groza_mag"] = "eap_groza_mag_939_20"
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},

	--temp - need decompiled modified models for these, the physics model for all of these are fucked
	--makarov
	["cwep_makarov"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Makarov",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_bo1_makarov.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_temp_makarov",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
			["go_perk_pistol"] = true, 
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--tt33
	["cwep_tt33"] = {
		--exclusive upgrade ideas: 
		--?
		name = "TT-33",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_waw_tokarev.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_temp_tt33",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
			["go_perk_pistol"] = true, 
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--skorpion
	["cwep_skorpion"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Skorpion vz.65",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_bo1_skorpion.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_temp_skorpion",
		category = "Weapons - Pistols",
		type = "pistol",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--mosin
	["cwep_mosin"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Mosin Nagant",
		desc = "desc i dont know what model mosin this is sry",
		price = 0,
		model = "models/weapons/w_waw_mosin_irons.mdl",
		width = 5,
		height = 1,
		weight = 1,
		class = "arccw_temp_mosin",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--svt40
	["cwep_svt40"] = {
		--exclusive upgrade ideas: 
		--?
		name = "SVT40",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_waw_svt40.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_temp_svt",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--sks
	["cwep_sks"] = {
		--exclusive upgrade ideas: 
		--?
		name = "SKS",
		desc = "desc",
		price = 0,
		model = "models/weapons/fas2wm/rifles/w_sks.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_temp_sks",
		category = "Weapons - Rifles",
		type = "ws",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["go_ammo"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--melee
	["cwep_m_axe"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Axe",
		desc = "desc",
		price = 0,
		model = "models/weapons/hl2meleepack/w_axe.mdl",
		width = 3,
		height = 1,
		weight = 1,
		class = "arccw_melee_axe",
		category = "Weapons - Melee",
		type = "knife",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee"
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m_cleaver"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Cleaver",
		desc = "desc",
		price = 0,
		model = "models/danguyen/cleaver.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_melee_cleaver",
		category = "Weapons - Melee",
		type = "knife",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee"
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m_crowbar"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Crowbar",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_crowbar.mdl",
		width = 3,
		height = 1,
		weight = 1,
		class = "arccw_melee_axe",
		category = "Weapons - Melee",
		type = "knife",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee"
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m_hatchet"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Hatchet",
		desc = "desc",
		price = 0,
		model = "models/danguyen/hatchet.mdl",
		width = 3,
		height = 1,
		weight = 1,
		class = "arccw_melee_hatchet",
		category = "Weapons - Melee",
		type = "knife",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee"
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m_knife"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Knife",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_knife_t.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_melee_knife",
		category = "Weapons - Melee",
		type = "knife",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee"
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m_knifelarge"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Large Knife",
		desc = "desc",
		price = 0,
		model = "models/danguyen/commandoknife.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_melee_knifelarge",
		category = "Weapons - Melee",
		type = "knife",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee"
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m_pan"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Pan",
		desc = "desc",
		price = 0,
		model = "models/weapons/hl2meleepack/w_pan.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_melee_pan",
		category = "Weapons - Melee",
		type = "knife",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee"
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m_pipe"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Lead Pipe",
		desc = "desc",
		price = 0,
		model = "models/props_canal/mattpipe.mdl",
		width = 3,
		height = 1,
		weight = 1,
		class = "arccw_melee_pipe",
		category = "Weapons - Melee",
		type = "knife",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee"
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m_shank"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Shank",
		desc = "desc",
		price = 0,
		model = "models/danguyen/knife_shank.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_melee_axe",
		category = "Weapons - Melee",
		type = "knife",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee"
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m_knife_t"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Knife T (?)",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_csgo_default_t.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_melee_knife_t",
		category = "Weapons - Melee",
		type = "knife",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee"
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m_knife_falchion"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Falchion Knife (?)",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_csgo_falchion.mdl",
		width = 1,
		height = 1,
		weight = 1,
		class = "arccw_melee_knife_fal",
		category = "Weapons - Melee",
		type = "knife",
		--flag = "",
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee"
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},

	--these are all of them i think, next is models and swep editing


	--decided against: go: ace, galil
}
local attList = {
	--[[
	["id"] = {
		name = "name of att",
		desc = "desc",
		price = 0,
		model = "",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		flag = "flagunder",
		cat = "slot", --attid should be id of item
		--restrictWeps = {["wep"]=true} --if exists, will only be able to att to specified weapons, currently useless
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	]]
	--tac
	["go_flashlight"] = {
		name = "Rail Flashlight",
		desc = "desc bind a key to toggleatt to easily toggle",
		price = 0,
		model = "models/weapons/arccw_go/atts/flashlight.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "tac", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_flashlight_combo"] = {
		name = "Combo Flashlight",
		desc = "desc bind a key to toggleatt to easily toggle",
		price = 0,
		model = "models/weapons/arccw_go/atts/laser_surefire.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "tac", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_laser_peq"] = {
		name = "PEQ Laser Sight",
		desc = "desc bind a key to toggleatt to easily toggle",
		price = 0,
		model = "models/weapons/arccw_go/atts/laser_peq.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "tac", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_laser"] = {
		name = "Laser Sight",
		desc = "desc bind a key to toggleatt to easily toggle",
		price = 0,
		model = "models/weapons/arccw_go/atts/laser.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "tac", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--foregrip
	["go_foregrip_stubby"] = {
		name = "Stubby Foregrip",
		desc = "desc",
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		iconmodel = "models/weapons/arccw_go/atts/foregrip.mdl", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_foregrip_snatch"] = {
		name = "Snatch Foregrip",
		desc = "desc",
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		iconmodel = "models/weapons/arccw_go/atts/foregrip_snatch.mdl", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_foregrip_ergo"] = {
		name = "Ergo Foregrip",
		desc = "desc",
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		iconmodel = "models/weapons/arccw_go/atts/foregrip_ergo.mdl", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_fore_bipod"] = {
		name = "Rail Bipod",
		desc = "desc",
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		iconmodel = "models/weapons/arccw_go/atts/bipod.mdl", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_foregrip_angled"] = {
		name = "Angled Foregrip",
		desc = "desc",
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
		--traitreq = {trait = "trait", val = 0},
		--requireEnt = {class = "class", name = "a nicename", radius = 120},
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		iconmodel = "models/weapons/arccw_go/atts/foregrip_angled.mdl", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--stock
	["go_stock_moe"] = {
		name = "MOE Stock",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/stock_moe.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "go_stock", --attid should be id of item
		--traitreq = {trait = "trait", val = 0},
		requireEnt = {class = "sky_craft_weapons", name = "a Weapon Crafting Bench", radius = 120},
		techReq = 1,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_stock_ergo"] = {
		name = "Ergonomic Stock",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/stock_ergo.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "go_stock", --attid should be id of item
		--traitreq = {trait = "trait", val = 0},
		requireEnt = {class = "sky_craft_weapons", name = "a Weapon Crafting Bench", radius = 120},
		techReq = 1,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_stock_contractor"] = {
		name = "Contractor Stock",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/stock_contractor.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "go_stock", --attid should be id of item
		--traitreq = {trait = "trait", val = 0},
		requireEnt = {class = "sky_craft_weapons", name = "a Weapon Crafting Bench", radius = 120},
		techReq = 1,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_stock_basilisk"] = {
		name = "Basilisk Stock",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/stock_basilisk.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "go_stock", --attid should be id of item
		--traitreq = {trait = "trait", val = 0},
		requireEnt = {class = "sky_craft_weapons", name = "a Weapon Crafting Bench", radius = 120},
		techReq = 1,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_nova_stock_sport"] = {
		name = "SuperNova Sport-TAC Stock",
		desc = "desc specifically for supernova",
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "go_nova_stock", --attid should be id of item
		--traitreq = {trait = "trait", val = 0},
		requireEnt = {class = "sky_craft_weapons", name = "a Weapon Crafting Bench", radius = 120},
		techReq = 1,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},

	--ubgl
	["mifl_fas2_ubw_m203"] = {
		name = "Railed M203",
		desc = "desc",
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		iconmodel = "models/weapons/arccw/mifl_atts/fas2/ubgl_m203.mdl", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["mifl_fas2_ubw_gp25"] = {
		name = "Railed GP25",
		desc = "desc",
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		iconmodel = "models/weapons/arccw/mifl_atts/fas2/ubgl_kastet.mdl", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},

	--muzzle
	["go_supp_ssq"] = {
		name = "SSQ Suppressor",
		desc = "desc 45, 57, 762x51",
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		iconmodel = "models/weapons/arccw_go/atts/supp_ssq.mdl", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_supp_osprey"] = {
		name = "Osprey Suppressor",
		desc = "desc 9x19",
		price = 0,
		model = "models/weapons/arccw_go/atts/supp_osprey.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_supp_monster"] = {
		name = "Monster Suppressor",
		desc = "desc 46 556",
		price = 0,
		model = "models/weapons/arccw_go/atts/supp_monster.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_supp_nt4"] = {
		name = "NT4 Suppressor",
		desc = "desc 556",
		price = 0,
		model = "models/weapons/arccw_go/atts/supp_ntr.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_supp_rotor43"] = {
		name = "Rotor43 Suppressor",
		desc = "desc 556, 762x39 aks, ace, svd",
		price = 0,
		model = "models/weapons/arccw_go/atts/supp_large.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_supp_pbs1"] = {
		name = "PBS1 Suppressor",
		desc = "desc 762x39 aks",
		price = 0,
		model = "models/weapons/arccw_go/atts/supp_pbs1.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_supp_tgpa"] = {
		name = "TGP-A Suppressor",
		desc = "desc 545 aks, mosin",
		price = 0,
		model = "models/weapons/arccw_go/atts/supp_tgpa.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_supp_pbs4"] = {
		name = "PBS4 Suppressor",
		desc = "desc 545 aks",
		price = 0,
		model = "models/weapons/arccw_go/atts/supp_pbs4.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},

	--sights
	["go_optic_lp_t1"] = {
		name = "Micro T1 Sight",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/t1lp.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic_lp", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_optic_lp_rmr"] = {
		name = "Trijicon RMR Sight",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/rmr.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic_lp", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},--[[	--decided against these, but theyre here
	["go_optic_hunter"] = {
		name = "Hunter Compact Scope (2.5x)",
		desc = "desc",
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic_lp", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["mifl_fas2_optic_lmk4s"] = {
		name = "Leupold Compact Scope (2.5x)",
		desc = "desc",
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic_lp", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},]]
	["go_optic_pvs4"] = {
		name = "PVS-4 Scope (2xIR)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/pvs4.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--[[["optic_eompts"] = { --decided against
		name = "EOMPTS Scope (FLIR)",
		desc = "desc makeshift",
		price = 0,
		model = "models/weapons/arccw/atts/eompts_4b.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},]]
	["mifl_fas2_optic_felin"] = {
		name = "FRF2 Scope (3-12xIR)",
		desc = "desc makeshift",
		price = 0,
		model = "models/weapons/arccw/mifl_atts/fas2/felin_scope.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_optic_awp"] = {
		name = "Arctic Warfare Scope (10x)",
		desc = "desc commonly found on the awm",
		price = 0,
		model = "models/weapons/arccw_go/atts/awp.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["mifl_fas2_optic_lmk4"] = {
		name = "Leupold Mk.4 Scope (3.5-8x)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl_atts/fas2_optic_lmk4.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},--skipped ssr
	["go_optic_schmidt"] = {
		name = "PM-II Scope (7x)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/schmidt.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["mifl_fas2_optic_xm25"] = {
		name = "Xleris Scope (6xIR)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl_atts/fas2_optic_xm25.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["mifl_fas2_optic_551"] = {
		name = "MRCS Scope (6x)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl_atts/fas2_optic_551.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["mifl_fas2_optic_pso1"] = {
		name = "PSO-1 Scope (4x)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl_atts/fas2_optic_pso1.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["mifl_fas2_optic_acog"] = {
		name = "ACOG Scope (4x)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl_atts/fas2_optic_acog.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_optic_elcan"] = {
		name = "Elcan C79 Scope (3.5x)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/elcan.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_optic_hamr"] = {
		name = "Leupold HAMR Scope (4xHYBR)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/hamr.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["mifl_fas2_optic_g36"] = {
		name = "N43 High Sight (RDS)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw/mifl_atts/fas2_optic_g36.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_optic_t1"] = {
		name = "Micro T1 Riser Sight (RDS)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/t1.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_optic_eotech"] = {
		name = "EoTech 553 Sight (RDS)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/eotech.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_optic_kobra"] = {
		name = "EKP-8-18 Kobra Sight (RDS)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/kobra.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_optic_compm4"] = {
		name = "CompM4 Sight (RDS)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/compm4.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_optic_cmore"] = {
		name = "C-More Sight (RDS)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/cmore.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_optic_barska"] = {
		name = "Barska Red Dot Sight (RDS)",
		desc = "desc",
		price = 0,
		model = "models/weapons/arccw_go/atts/barska.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
}
local ammoList = {
	--[[[""] = {
		name = "Barska Red Dot Sight (RDS)",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		ammo = "ammotype",
		maxQuantity = 50,
		defQuantity = 5,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},]]
	["ammo_9x19"] = {
		name = "9x19 ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x19_fmj.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky9x19",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_9x18"] = {
		name = "9x18 ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x18_fmj.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky9x18",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_9x39"] = {
		name = "9x39 ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x39_pab9.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky9x39",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_46"] = {
		name = "4.6 ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky46",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_57"] = {
		name = "5.7 ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky57",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_45acp"] = {
		name = "45 acp ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_1143x23_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky45acp",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_50ae"] = {
		name = "50 ae ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_50_ae.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky50ae",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x25"] = {
		name = "762x25 ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x25_p.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky762x25",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x39"] = {
		name = "762x39 ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x39_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky762x39",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x51"] = {
		name = "762x51 ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x51_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky762x51",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x54"] = {
		name = "762x54 ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_7h1.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky762x54",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_556"] = {
		name = "556 ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_556x45_ss190.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky556",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_545"] = {
		name = "545 ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_545x39_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky545",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_338"] = {
		name = "338 ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_ap.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky338",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_23mm"] = {
		name = "23mm ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x70_buck.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "sky23mm",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_buckshot"] = {
		name = "buckshot ammo",
		desc = "desc", --use %s for number
		price = 0,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x70_buck_2.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		--flag = "",
		ammo = "buckshot",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		--iconCam = {}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
}

function PLUGIN:InitializedItems()
	for id, data in pairs(weaponList) do
		local ITEM = nut.item.register(id, "base_cweapon", nil, nil, true)
		ITEM.name = data.name
		ITEM.desc = data.desc
		ITEM.price = data.price or 0
		ITEM.model = data.model
		ITEM.groups = data.groups
		ITEM.width = data.width
		ITEM.height = data.height
		ITEM.weight = data.weight
		ITEM.category = data.category
		ITEM.class = data.class
		ITEM.type = data.type
		ITEM.flag = data.flag or "m"
		ITEM.defaultMods = table.Copy(data.defaultMods)
		ITEM.defaultAmmo = data.defaultAmmo
		ITEM.cantDetach = data.cantDetach
		if(data.iconCam) then --prob wont be used for anything else so
			ITEM.exRender = true
			ITEM.iconCam = data.iconCam
		end
		if(data.exRender != nil) then
			ITEM.exRender = data.exRender
		end
		ITEM.icon = data.icon
		ITEM.noBusiness = data.noBusiness
		ITEM.equipTbl = data.equipTbl
		ITEM.transferSound = data.transferSound or ammoSounds[data.type]
		
		if(data.destroyval) then
			ITEM.destroyval = data.destroyval --in case i wanna add more
			ITEM = EZADDDESTROYFUNC(ITEM)
		end
	end
	for id, data in pairs(attList) do
		local ITEM = nut.item.register(id, "base_cattachment", nil, nil, true)
		ITEM.name = data.name
		ITEM.desc = data.desc
		ITEM.price = data.price or 0
		ITEM.model = data.model
		ITEM.width = data.width
		ITEM.height = data.height
		ITEM.weight = data.weight
		ITEM.flag = data.flag or "m"
		ITEM.cat = data.cat
		ITEM.attID = id--data.attID
		ITEM.restrictWeps = data.restrictWeps
		ITEM.requireEnt = data.requireEnt
		ITEM.traitreq = data.traitreq
		if(data.iconCam) then --prob wont be used for anything else so
			ITEM.exRender = true
			ITEM.iconCam = data.iconCam
		end
		if(data.destroyval) then
			ITEM.destroyval = data.destroyval --in case i wanna add more
			ITEM = EZADDDESTROYFUNC(ITEM)
		end
		ITEM.icon = data.icon
		ITEM.noBusiness = data.noBusiness
		ITEM.iconmodel = data.iconmodel
		ITEM.useSound = data.useSound or "cw/attach.wav"
	end
	for id, data in pairs(ammoList) do
		local ITEM = nut.item.register(id, "base_ammo", nil, nil, true)
		ITEM.name = data.name
		ITEM.desc = data.desc
		ITEM.price = data.price or 0
		ITEM.model = data.model
		ITEM.width = data.width
		ITEM.height = data.height
		ITEM.weight = data.weight
		ITEM.flag = data.flag or "m"
		if(data.iconCam) then --prob wont be used for anything else so
			ITEM.exRender = true
			ITEM.iconCam = data.iconCam
		end
		if(data.destroyval) then
			ITEM.destroyval = data.destroyval --in case i wanna add more
			ITEM = EZADDDESTROYFUNC(ITEM)
		end
		ITEM.icon = data.icon
		ITEM.noBusiness = data.noBusiness
		ITEM.iconmodel = data.iconmodel
		ITEM.useSound = data.useSound
		ITEM.ammo = data.ammo
		ITEM.maxQuantity = data.maxQuantity
		ITEM.defQuantity = data.defQuantity

		ITEM.getWeight = function(self)
			return self.weight*self:getQuantity()
		end
	end
end