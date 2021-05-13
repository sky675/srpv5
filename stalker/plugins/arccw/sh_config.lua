local PLUGIN = PLUGIN

local ammoSounds = {
	["pistol"] = "interface/inv_items_ammo_2.ogg",
	["ws"] = "interface/inv_items_ammo_5.ogg",
	["shotgun"] = "interface/inv_items_ammo_4.ogg",
	["n"] = "interface/inv_items_ammo_5.ogg",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_glock",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_glock",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_glock",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_glock",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_glock",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_m9",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_m9",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_usp",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_usp",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_usp",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_cz75",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_cz75",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_p2000",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_p250",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_p250",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_deagle",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_tec9",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_go_fiveseven",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_mp5",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_mp5",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_mp5",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_bizon",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_ump",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_ump",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_ump",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_ump",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_mac10",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_mp9",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_p90",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_mp7",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_go_870",
		category = "Weapons (Shotguns)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 1,
		weight = 1,
		class = "arccw_go_870",
		category = "Weapons (Shotguns)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_go_nova",
		category = "Weapons (Shotguns)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_go_m1014",
		category = "Weapons (Shotguns)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_mag7",
		category = "Weapons (Shotguns)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_go_m249",
		category = "Weapons (MGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_go_negev",
		category = "Weapons (MGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_aug",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_go_aug",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 6,
		height = 1,
		weight = 1,
		class = "arccw_go_awp",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_go_fnfal",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_fnfal",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_go_scar",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_scar",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_ace",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_ace",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_go_galil_ar",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 1,
		weight = 1,
		class = "arccw_go_ssg08",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_toz34",
		category = "Weapons (Shotguns)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_toz34",
		category = "Weapons (Shotguns)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_ks23",
		category = "Weapons (Shotguns)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_m1911",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_p226",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_m24",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_sr25",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_g3",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons (ARs)",
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
	["cwep_pp19"] = {
		--exclusive upgrade ideas: 
		--?
		name = "PP-19 Vityaz",
		desc = "desc bootleg",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons (ARs)",
		type = "pistol",
		--flag = "",
		defaultMods = {
			["mifl_fas2_ak_hg"] = "mifl_fas2_ak_hg_12u",
			["mifl_fas2_ak_mag"] = "mifl_fas2_ak_mag_919_30",
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
	["cwep_svd"] = {
		--exclusive upgrade ideas: 
		--?
		name = "Dragunov SVD",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons (Shotguns)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_rpk",
		category = "Weapons (MGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_famas",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_g36c",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_g36c",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_sg55x",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_sg55x",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_sg55x",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_m4a1",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_m4a1",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_m4a1",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_mifl_fas2_m4a1",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 1,
		weight = 1,
		class = "arccw_mifl_fas2_m79",
		category = "Weapons (Misc)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_eap_aek",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_eap_groza",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_eap_groza",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_eap_groza",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 2,
		weight = 1,
		class = "arccw_eap_groza",
		category = "Weapons (ARs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_bo2_browninghp",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_waw_doublebarrel",
		category = "Weapons (Shotguns)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_waw_doublebarrel",
		category = "Weapons (Shotguns)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_bo1_uzi",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 3,
		height = 2,
		weight = 1,
		class = "arccw_waw_ppsh41",
		category = "Weapons (SMGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 2,
		weight = 1,
		class = "arccw_bo1_m60",
		category = "Weapons (MGs)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_temp_makarov",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_temp_tt33",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_temp_skorpion",
		category = "Weapons (Pistols)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 5,
		height = 1,
		weight = 1,
		class = "arccw_temp_mosin",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_temp_svt40",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
		width = 4,
		height = 1,
		weight = 1,
		class = "arccw_temp_sks",
		category = "Weapons (Rifles)",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
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
	["go_foregrip_snatch"] = {
		name = "Snatch Foregrip",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
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
	["go_foregrip_ergo"] = {
		name = "Ergo Foregrip",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
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
	["go_fore_bipod"] = {
		name = "Rail Bipod",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
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
	["go_foregrip_angled"] = {
		name = "Angled Foregrip",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
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
		--iconmodel = "", --will use this model for icon making instead of normal model
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
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
	["mifl_fas2_ubw_gp25"] = {
		name = "Railed GP25",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
		width = 1,
		height = 1,
		weight = 1,
		category = "Attachments",
		--flag = "",
		cat = "foregrip", --attid should be id of item
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

	--muzzle
	["go_supp_ssq"] = {
		name = "SSQ Suppressor",
		desc = "desc 45, 57, 762x51",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
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
	["go_supp_osprey"] = {
		name = "Osprey Suppressor",
		desc = "desc 9x19",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
	["optic_eompts"] = {
		name = "EOMPTS Scope (FLIR)",
		desc = "desc makeshift",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
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
	["mifl_fas2_optic_felin"] = {
		name = "FRF2 Scope (3-12xIR)",
		desc = "desc makeshift",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
	["go_optic_t1"] = {
		name = "Micro T1 Riser Sight (RDS)",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
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
	["go_optic_eotech"] = {
		name = "EoTech 553 Sight (RDS)",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
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
	["go_optic_kobra"] = {
		name = "EKP-8-18 Kobra Sight (RDS)",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
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
	["go_optic_compm4"] = {
		name = "CompM4 Sight (RDS)",
		desc = "desc",
		price = 0,
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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
		model = "models/weapons/w_pistol.mdl",
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

function PLUGIN:InitializedItems()
	for id, data in pairs(weaponList) do
		local ITEM = nut.item.register(id, "base_cweapon", nil, nil, true)
		ITEM.name = data.name
		ITEM.desc = data.desc
		ITEM.price = data.price or 0
		ITEM.model = data.model
		ITEM.width = data.width
		ITEM.height = data.height
		ITEM.weight = data.weight
		ITEM.category = data.category
		ITEM.class = data.class
		ITEM.type = data.type
		ITEM.flag = data.flag
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
		ITEM.flag = data.flag
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
end