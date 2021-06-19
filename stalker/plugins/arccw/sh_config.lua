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
		desc = "A popular pistol chambered in 9x19mm.",
		price = 10960,
		model = "models/weapons/arccw_go/v_pist_glock.mdl",
		width = 2,
		height = 1,
		weight = 0.62,
		class = "arccw_go_glock",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.6, 12.5, -4.08),
			ang = Angle(0,270,0),
			entAng = Angle(0,0,0),
			fov = 45,
			--drawHook = function(ent)
			--end
		}, --pretty icons
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
		desc = "A compact pistol chambered in 9x19mm.",
		price = 9200,
		model = "models/weapons/arccw_go/v_pist_glock.mdl",
		groups = {
			[0] = 1,
			[1] = 1,
			[2] = 1
		},
		width = 1,
		height = 1,
		weight = 0.56,
		class = "arccw_go_glock",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.0, 10.95, -3.19),
			ang = Angle(0,270,45),
			entAng = Angle(0,0,0),
			fov = 45,
			drawHook = function(ent)
				ent:SetBodygroup(0, 1)
				ent:SetBodygroup(1, 1)
				ent:SetBodygroup(2, 1)
			end
		}, --pretty icons
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
		desc = "A machine pistol chambered in 9x19mm.",
		price = 14040,
		model = "models/weapons/arccw_go/v_pist_glock.mdl",
		groups = {
			[1] = 2,
		},
		width = 2,
		height = 1,
		weight = 0.62,
		class = "arccw_go_glock",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.6, 12.5, -4.08),
			ang = Angle(0,270,0),
			entAng = Angle(0,0,0),
			fov = 45,
			drawHook = function(ent)
				ent:SetBodygroup(1,2)
			end
		}, --pretty icons
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
		desc = "A pistol chambered in .45 ACP.",
		price = 11010,
		model = "models/weapons/arccw_go/v_pist_glock.mdl",
		width = 2,
		height = 1,
		weight = 0.83,
		class = "arccw_go_glock",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.6, 12.5, -4.08),
			ang = Angle(0,270,0),
			entAng = Angle(0,0,0),
			fov = 45,
			--drawHook = function(ent)
			--end
		}, --pretty icons
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
		desc = "A compact pistol chambered in .45 ACP.",
		price = 8900,
		model = "models/weapons/arccw_go/v_pist_glock.mdl",
		groups = {
			[0] = 1,
			[1] = 1,
			[2] = 1
		},
		width = 1,
		height = 1,
		weight = 0.68,
		class = "arccw_go_glock",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.0, 10.95, -3.19),
			ang = Angle(0,270,45),
			entAng = Angle(0,0,0),
			fov = 45,
			drawHook = function(ent)
				ent:SetBodygroup(0, 1)
				ent:SetBodygroup(1, 1)
				ent:SetBodygroup(2, 1)
			end
		}, --pretty icons
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
		desc = "A pistol chambered in 9x19mm.",
		price = 7120,
		model = "models/weapons/arccw_go/v_pist_m9.mdl",
		width = 2,
		height = 1,
		weight = 0.95,
		class = "arccw_go_m9",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(18.731195449829, 16.043054580688, -3.9337403774261),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A machine pistol that can fire in 3 round bursts chambered in 9x19mm.",
		price = 13500,
		model = "models/weapons/arccw_go/v_pist_m9.mdl",
		groups = {
			[1] = 3,
		},
		width = 2,
		height = 1,
		weight = 1.17,
		class = "arccw_go_m9",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(18.731195449829, 16.043054580688, -3.9337403774261),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
			drawHook = function(ent)
				ent:SetBodygroup(1, 3)
			end
		}, --pretty icons
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
		desc = "A pistol chambered in .45 ACP.",
		price = 10960,
		model = "models/weapons/arccw_go/v_pist_usp.mdl",
		width = 2,
		height = 1,
		weight = 0.9,
		class = "arccw_go_usp",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(18.384498596191, 15.392320632935, -4.8282413482666),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A pistol chambered in 9x19mm.",
		price = 11050,
		model = "models/weapons/arccw_go/v_pist_usp.mdl",
		width = 2,
		height = 1,
		weight = 0.8,
		class = "arccw_go_usp",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(18.384498596191, 15.392320632935, -4.8282413482666),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A pistol with a match compensator chambered in 9x19mm.",
		price = 15360,
		model = "models/weapons/arccw_go/v_pist_usp.mdl", --extras phys is fucked
		width = 2,
		height = 1,
		weight = 1.2,
		class = "arccw_go_usp",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "2",--any flag in this will make it return true
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
		iconmodel = "models/weapons/arccw_go/v_pist_usp_extras.mdl",
		iconCam = {
			pos = Vector(18.384498596191, 15.392320632935, -4.8282413482666),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
			drawHook = function(ent)
				ent:SetBodygroup(3, 1)
			end
		}, --pretty icons
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
		desc = "A pistol chambered in 9x19mm.",
		price = 9850,
		model = "models/weapons/arccw_go/v_pist_cz75.mdl",
		width = 2,
		height = 1,
		weight = 1.12,
		class = "arccw_go_cz75",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(18.384498596191, 13.933465957642, -4.123233795166),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--i made this an upgrade forgetting i had this and figured its better that way
	--[[["cwep_cz75a"] = {
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
	},]]
	--p2000
	["cwep_p2000"] = {
		--exclusive upgrade ideas: 
		--unsure if should have different slides as upgrades or as other guns
		--ext mag go_p2000_mag_24
		name = "P2000",
		desc = "A pistol chambered in 9x19mm.",
		price = 10600,
		model = "models/weapons/arccw_go/v_pist_p2000.mdl",
		width = 2,
		height = 1,
		weight = 0.62,
		class = "arccw_go_p2000",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.618604660034, 12.443369865417, -3.809428691864),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A pistol chambered in 9x19mm.",
		price = 10900,
		model = "models/weapons/arccw_go/v_pist_p250.mdl",
		width = 2,
		height = 1,
		weight = 0.72,
		class = "arccw_go_p250",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.618604660034, 12.443369865417, -3.809428691864),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A pistol chambered in .45 ACP.",
		price = 11900,
		model = "models/weapons/arccw_go/v_pist_p250.mdl",
		width = 2,
		height = 1,
		weight = 0.72,
		class = "arccw_go_p250",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.618604660034, 12.443369865417, -3.809428691864),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A pistol chambered in .50 Action Express.",
		price = 19680,
		model = "models/weapons/arccw_go/v_pist_deagle.mdl",
		width = 2,
		height = 1,
		weight = 1.99,
		class = "arccw_go_deagle",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(18.515466690063, 12.443369865417, -3.7277569770813),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A pistol chambered in 9x19mm.",
		price = 13600,
		model = "models/weapons/arccw_go/v_pist_tec9.mdl",
		width = 2,
		height = 1,
		weight = 1.4,
		class = "arccw_go_tec9",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(21.25661277771, 13.784277915955, -6.1245994567871),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A pistol chambered in 5.7x28mm.",
		price = 15280,
		model = "models/weapons/arccw_go/v_pist_fiveseven.mdl",
		width = 2,
		height = 1,
		weight = 0.61,
		class = "arccw_go_fiveseven",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "4",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(18.289180755615, 12.501372337341, -3.7187769412994),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A SMG chambered in 9x19mm.",
		price = 20380,
		model = "models/weapons/arccw_go/v_smg_mp5.mdl",
		width = 3,
		height = 2,
		weight = 2.88,
		class = "arccw_go_mp5",
		category = "Weapons - SMGs",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(19.445014953613, 31.309049606323, -7.4937539100647),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "An internally suppressed SMG chambered in 9x19mm.",
		price = 21880,
		model = "models/weapons/arccw_go/v_smg_mp5.mdl",
		groups = {
			[1] = 3
		},
		width = 3,
		height = 2,
		weight = 3.4,
		class = "arccw_go_mp5",
		category = "Weapons - SMGs",
		type = "pistol",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(19.445014953613, 31.309049606323, -7.4937539100647),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,	
			drawHook = function(ent)
				ent:SetBodygroup(1, 3)
			end	
		}, --pretty icons
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
		desc = "A SMG chambered in 9x18mm.",
		price = 18560,
		model = "models/weapons/arccw_go/v_smg_bizon.mdl",
		width = 3,
		height = 2,
		weight = 2.1,
		class = "arccw_go_bizon",
		category = "Weapons - SMGs",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.950517654419, 32.369216918945, -5.3891682624817),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A SMG chambered in .45 ACP.",
		price = 28980,
		model = "models/weapons/arccw_go/v_smg_ump45.mdl",
		width = 3,
		height = 2,
		weight = 2.5,
		class = "arccw_go_ump",
		category = "Weapons - SMGs",
		type = "pistol",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(19.620599746704, 32.029941558838, -7.9073195457458),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A SMG chambered in 9x19mm.",
		price = 28620,
		model = "models/weapons/arccw_go/v_smg_ump45.mdl",
		groups = {
			[2] = 2
		},
		width = 3,
		height = 2,
		weight = 2.3,
		class = "arccw_go_ump",
		category = "Weapons - SMGs",
		type = "pistol",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(19.620599746704, 32.029941558838, -7.9073195457458),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
			drawHook = function(ent)
				ent:SetBodygroup(2, 2)
			end	
		}, --pretty icons
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
		desc = "A SMG chambered in .45 ACP.",
		price = 29450,
		model = "models/weapons/arccw_go/v_smg_mac10.mdl",
		width = 3,
		height = 2,
		weight = 2.84,
		class = "arccw_go_mac10",
		category = "Weapons - SMGs",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(16.69352722168, 24.55179977417, -7.2232813835144),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A SMG chambered in 9x19mm.",
		price = 30650,
		model = "models/weapons/arccw_go/v_smg_mp9.mdl",
		width = 3,
		height = 2,
		weight = 1.4,
		class = "arccw_go_mp9",
		category = "Weapons - SMGs",
		type = "pistol",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(11.692200660706, 23.636199951172, -6.1238646507263),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A SMG chambered in 5.7x28mm.",
		price = 39880,
		model = "models/weapons/arccw_go/v_smg_p90.mdl",
		width = 3,
		height = 2,
		weight = 2.6,
		class = "arccw_go_p90",
		category = "Weapons - SMGs",
		type = "pistol",
		flag = "5",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(13.691186904907, 19.518894195557, -4.0268001556396),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A SMG chambered in 4.6x30mm.",
		price = 23300,
		model = "models/weapons/arccw_go/v_smg_mp7.mdl",
		width = 3,
		height = 2,
		weight = 2.1,
		class = "arccw_go_mp7",
		category = "Weapons - SMGs",
		type = "pistol",
		flag = "5",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(16.001016616821, 22.399394989014, -6.3756237030029),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A pump-action shotgun chambered in 12 gauge.",
		price = 23600,
		model = "models/weapons/arccw_go/v_shot_870.mdl",
		width = 4,
		height = 1,
		weight = 3.4,
		class = "arccw_go_870",
		category = "Weapons - Shotguns",
		type = "shotgun",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(20.654806137085, 42.598125457764, -5.3670082092285),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A sawn-off pump-action shotgun chambered in 12 gauge.",
		price = 21600,
		model = "models/weapons/arccw_go/v_shot_870.mdl",
		groups = {
			[1] = 1,
			[2] = 1,
			[3] = 2,
			[4] = 1
		},
		width = 3,
		height = 1,
		weight = 2.6,
		class = "arccw_go_870",
		category = "Weapons - Shotguns",
		type = "shotgun",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(22.765592575073, 28.758544921875, -4.4122796058655),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 1)
				ent:SetBodygroup(2, 1)
				ent:SetBodygroup(3, 2)
				ent:SetBodygroup(4, 1)
			end	
		}, --pretty icons
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
		desc = "A pump-action shotgun chambered in 12 gauge.",
		price = 25600,
		model = "models/weapons/arccw_go/v_shot_nova.mdl",
		width = 4,
		height = 1,
		weight = 3.3,
		class = "arccw_go_nova",
		category = "Weapons - Shotguns",
		type = "shotgun",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(21.861333847046, 45.979419708252, -6.5863227844238),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A semi-auto shotgun chambered in 12 gauge.",
		price = 34600,
		model = "models/weapons/arccw_go/v_shot_m1014.mdl",
		width = 4,
		height = 1,
		weight = 3.82,
		class = "arccw_go_m1014",
		category = "Weapons - Shotguns",
		type = "shotgun",
		flag = "4",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(22.170606613159, 42.621028900146, -6.5863227844238),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m1014sawn"] = {
		--exclusive upgrade ideas: 
		--ext mag go_m1014_mag_7
		--long barrel go_m1014_barrel_long
		--tube stocks
		name = "M1014 Sawn-off",
		desc = "A sawn-off semi-auto shotgun chambered in 12 gauge.",
		price = 34600,
		model = "models/weapons/arccw_go/v_shot_m1014.mdl",
		groups = {
			[1] = 1,
			[2] = 2,
			[3] = 1,
			[4] = 1
		},
		width = 3,
		height = 1,
		weight = 2.1,
		class = "arccw_go_m1014",
		category = "Weapons - Shotguns",
		type = "shotgun",
		--flag = "4",--any flag in this will make it return true
		defaultMods = {
			["go_m1014_barrel"] = "go_m1014_barrel_short",
			["go_m1014_mag"] = "go_m1014_mag_4",
			["go_stock_none"] = "go_stock_none"
		},
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
		iconCam = {
			pos = Vector(23.25, 25.620000839233, -6.5),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
			drawHook = function(ent)
				ent:SetBodygroup(1, 1)
				ent:SetBodygroup(2, 2)
				ent:SetBodygroup(3, 1)
				ent:SetBodygroup(4, 1)
			end	
		}, --pretty icons
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
		desc = "A mag-fed pump-action shotgun chambered in 12 gauge.",
		price = 36800,
		model = "models/weapons/arccw_go/v_shot_mag7.mdl",
		width = 3,
		height = 2,
		weight = 4,
		class = "arccw_go_mag7",
		category = "Weapons - Shotguns",
		type = "shotgun",
		flag = "5",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(26.740421295166, 25.044569015503, -8.5014142990112),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,		
		}, --pretty icons
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
		desc = "A light machinegun chambered in 5.56x45mm.",
		price = 56580,
		model = "models/weapons/arccw_go/v_mach_m249para.mdl",
		width = 5,
		height = 2,
		weight = 7.5,
		class = "arccw_go_m249",
		category = "Weapons - MGs",
		type = "n",
		flag = "5",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(29.290349960327, 52.037742614746, -6.8791856765747),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A light machine gun chambered in 7.62x51mm.",
		price = 57560,
		model = "models/weapons/arccw_go/v_mach_negev.mdl",
		width = 5,
		height = 2,
		weight = 7.9,
		class = "arccw_go_negev",
		category = "Weapons - MGs",
		type = "ws",
		flag = "5",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(26.384387969971, 44.935997009277, -6.8791856765747),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A bullpup assault rifle chambered in 5.56x45mm.",
		price = 43600,
		model = "models/weapons/arccw_go/v_rif_aug.mdl",
		width = 4,
		height = 2,
		weight = 3.6,
		class = "arccw_go_aug",
		category = "Weapons - ARs",
		type = "n",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(15.424696922302, 35.443309783936, -6.5571432113647),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A bullpup SMG chambered in 9x19mm.",
		price = 39650,
		model = "models/weapons/arccw_go/v_rif_aug.mdl",
		groups = {
			[2] = 2,
			[3] = 1,
			[4] = 1
		},
		width = 3,
		height = 2,
		weight = 3.3,
		class = "arccw_go_aug",
		category = "Weapons - SMGs",
		type = "pistol",
		flag = "4",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(12.733955383301, 28.472164154053, -6.5571432113647),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(2, 2)
				ent:SetBodygroup(3, 1)
				ent:SetBodygroup(4, 1)
			end	
		}, --pretty icons
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
		desc = "A bolt-action rifle chambered in .338 Lapua.",
		price = 76580,
		model = "models/weapons/arccw_go/v_snip_awp.mdl",
		width = 5,
		height = 1,
		weight = 6.9,
		class = "arccw_go_awp",
		category = "Weapons - Rifles",
		type = "ws",
		flag = "5",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(23.336740493774, 50.801338195801, -6.238438129425),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A battle rifle chambered by 7.62x51mm NATO.",
		price = 31300,
		model = "models/weapons/arccw_go/v_rif_fnfal.mdl",
		groups = {
			[1] = 3,
		},
		width = 5,
		height = 2,
		weight = 4.25,
		class = "arccw_go_fnfal",
		category = "Weapons - Rifles",
		type = "ws",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(20.506650924683, 44.188327789307, -6.238438129425),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A battle rifle chambered in 7.62x51mm NATO.",
		price = 31600,
		model = "models/weapons/arccw_go/v_rif_fnfal.mdl",
		groups = {
			[5] = 2,
		},
		width = 4,
		height = 2,
		weight = 3.75,
		class = "arccw_go_fnfal",
		category = "Weapons - Rifles",
		type = "ws",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(19.208177566528, 40.9814453125, -6.238438129425),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(5, 2)
			end	
		}, --pretty icons
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
		desc = "A battle rifle in 7.62x51mm NATO.",
		price = 55880,
		model = "models/weapons/arccw_go/v_rif_scar.mdl",
		width = 5,
		height = 2,
		weight = 3.6,
		class = "arccw_go_scar",
		category = "Weapons - Rifles",
		type = "ws",
		flag = "4",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(21.765264511108, 41.110202789307, -6.238438129425),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "An assault rifle chambered in 5.56x45mm.",
		price = 35600,
		model = "models/weapons/arccw_go/v_rif_scar.mdl",
		groups = {
			[1] = 2,
			[5] = 4
		},
		width = 4,
		height = 2,
		weight = 3.3,
		class = "arccw_go_scar",
		category = "Weapons - ARs",
		type = "ws",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(19.629592895508, 36.714275360107, -6.238438129425),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 2)
				ent:SetBodygroup(5, 4)
			end	
		}, --pretty icons
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
		desc = "An assault rifle in 5.56x45mm.",
		price = 31580,
		model = "models/weapons/arccw_go/v_rif_ace.mdl",
		width = 4,
		height = 2,
		weight = 3.4,
		class = "arccw_go_ace",
		category = "Weapons - ARs",
		type = "n",
		flag = "4",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(18.263643264771, 31.99076461792, -6.5646567344666),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "An assault rifle chambered in 7.62x39mm.",
		price = 36530,
		model = "models/weapons/arccw_go/v_rif_ace.mdl",
		groups = {
			[3] = 4
		},
		width = 4,
		height = 2,
		weight = 3.5,
		class = "arccw_go_ace",
		category = "Weapons - ARs",
		type = "ws",
		flag = "4",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(18.263643264771, 31.99076461792, -6.5646567344666),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(3, 4)
			end	
		}, --pretty icons
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
		desc = "An assault rifle chambered in 7.62x39mm.",
		price = 38580,
		model = "models/weapons/arccw_go/v_rif_galil_ar.mdl",
		width = 4,
		height = 2,
		weight = 3.95,
		class = "arccw_go_galil_ar",
		category = "Weapons - Rifles",
		type = "n",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(21.256837844849, 42.912899017334, -6.5646567344666),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A bolt-action rifle modified to take 7.62x51mm NATO.",
		price = 70400,
		model = "models/weapons/w_snip_scout.mdl",
		width = 5,
		height = 1,
		weight = 5.5,
		class = "arccw_go_ssg08",
		category = "Weapons - Rifles",
		type = "ws",
		flag = "4",--any flag in this will make it return true
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
		itemmodel = "models/weapons/arccw_go/v_snip_ssg08.mdl",
		iconCam = {
			pos = Vector(20.614532470703, 51.960647583008, -6.5646567344666),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "An over/under double barrel shotgun.",
		price = 14800,
		model = "models/weapons/arccw/mifl/fas2/c_toz34.mdl",
		width = 4,
		height = 1,
		weight = 3.2,
		class = "arccw_mifl_fas2_toz34",
		category = "Weapons - Shotguns",
		type = "shotgun",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(21.654796600342, 81.147842407227, -8.4564208984375),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		name = "TOZ-34 Sawn-off",
		desc = "A sawn-off over/under double barrel shotgun.",
		price = 9860,
		model = "models/weapons/arccw/mifl/fas2/c_toz34.mdl",
		groups = {
			[1] = 1,
			[2] = 1,
			[3] = 1
		},
		width = 2,
		height = 1,
		weight = 2.1,
		class = "arccw_mifl_fas2_toz34",
		category = "Weapons - Shotguns",
		type = "shotgun",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(20.453935623169, 46.046485900879, -7.5933661460876),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 1)
				ent:SetBodygroup(2, 1)
				ent:SetBodygroup(3, 1)
			end	
		}, --pretty icons
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
		desc = "A shotgun chambered in 23mm shells.",
		price = 72150,
		model = "models/weapons/arccw/mifl/fas2/c_ks23.mdl",
		width = 4,
		height = 1,
		weight = 3.85,
		class = "arccw_mifl_fas2_ks23",
		category = "Weapons - Shotguns",
		type = "shotgun",
		flag = "5",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(25.555322647095, 59.775932312012, -7.5933661460876),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A pistol chambered in .45 ACP.",
		price = 8560,
		model = "models/weapons/arccw/mifl/fas2/c_m1911.mdl",
		width = 2,
		height = 1,
		weight = 1.1,
		class = "arccw_mifl_fas2_m1911",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(19.392942428589, 18.443452835083, -5.4884171485901),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A pistol chambered in 9x19mm.",
		price = 12480,
		model = "models/weapons/arccw/mifl/fas2/c_p226.mdl",
		width = 4,
		height = 1,
		weight = 0.96,
		class = "arccw_mifl_fas2_p226",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(21.521520614624, 18.443452835083, -5.4884171485901),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A bolt-action rifle chambered in 7.62x51mm NATO.",
		price = 76680,
		model = "models/weapons/arccw/mifl/fas2/c_m24.mdl",
		width = 5,
		height = 1,
		weight = 5.4,
		class = "arccw_mifl_fas2_m24",
		category = "Weapons - Rifles",
		type = "ws",
		flag = "4",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(31.261442184448, 76.990692138672, -6.3477101325989),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A semi-auto rifle chambered in 7.62x51mm NATO.",
		price = 70780, --50780
		model = "models/weapons/arccw/mifl/fas2/c_sr25.mdl",
		width = 5,
		height = 2,
		weight = 4.3,
		class = "arccw_mifl_fas2_sr25",
		category = "Weapons - Rifles",
		type = "ws",
		flag = "5",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(23.677639007568, 56.603218078613, -6.3477101325989),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A battle rifle chambered in 7.62x51mm NATO.",
		price = 39880,
		model = "models/weapons/arccw/mifl/fas2/c_g3.mdl",
		width = 5,
		height = 2,
		weight = 4.38,
		class = "arccw_mifl_fas2_g3",
		category = "Weapons - Rifles",
		type = "ws",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(25.763973236084, 63.631862640381, -6.3477101325989),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "An assault rifle chambered in 7.62x39mm.",
		price = 28780,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		width = 4,
		height = 2,
		weight = 3.3,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "ws",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(24.862462997437, 54.968238830566, -7.2976293563843),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "An assault rifle with a wooden stock chambered in 5.45x39mm.",
		price = 26950,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 5,
		},
		width = 4,
		height = 2,
		weight = 3.1,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(24.862462997437, 54.968238830566, -7.2976293563843),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 5)
			end	
		}, --pretty icons
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
		desc = "An assault rifle with a folding stock chambered in 5.45x39mm.",
		price = 25860,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 5,
			[5] = 3,
		},
		width = 4,
		height = 2,
		weight = 3,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(24.862462997437, 54.968238830566, -7.2976293563843),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 5)
				ent:SetBodygroup(5, 3)
			end	
		}, --pretty icons
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
		desc = "A carbine with a folding stock chambered in 5.45x39mm.",
		price = 20870,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 5,
			[2] = 13,
			[5] = 3,
		},
		width = 3,
		height = 2,
		weight = 2.7,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(24.862462997437, 54.968238830566, -7.2976293563843),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 5)
				ent:SetBodygroup(2, 13)
				ent:SetBodygroup(5, 3)
			end	
		}, --pretty icons
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
		desc = "A kinda bootleg version of a semi-auto rifle chambered in 7.62x54mmR.",
		price = 40550,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 11,
			[2] = 7,
			[5] = 4,
			[7] = 1
		},
		width = 5,
		height = 2,
		weight = 4.3,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - Rifles",
		type = "ws",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(29.304014205933, 65.462059020996, -7.7976293563843),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 11)
				ent:SetBodygroup(2, 7)
				ent:SetBodygroup(5, 4)
				ent:SetBodygroup(7, 1)
			end	
		}, --pretty icons
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
		desc = "A kinda bootleg version of an assault rifle chambered in 9x39mm.",
		price = 38860,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 4,
			[2] = 1,
			[5] = 3
		},
		width = 4,
		height = 2,
		weight = 2.5,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		flag = "4",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(24.862462997437, 54.968238830566, -7.2976293563843),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 4)
				ent:SetBodygroup(2, 1)
				ent:SetBodygroup(5, 3)
			end	
		}, --pretty icons
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
		desc = "A kinda bootleg version of a rifle chambered in 9x39mm.",
		price = 40560,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 4,
			[2] = 1,
			[5] = 4,
			[7] = 1
		},
		width = 4,
		height = 2,
		weight = 2.6,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		flag = "4",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(24.862462997437, 54.968238830566, -7.2976293563843),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 4)
				ent:SetBodygroup(2, 1)
				ent:SetBodygroup(5, 4)
				ent:SetBodygroup(7, 1)
			end	
		}, --pretty icons
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
		desc = "A kinda bootleg version of an assault rifle chambered in 5.45x39mm. Does not have the 2 round burst, sorry.",
		price = 35850,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 5,
			[2] = 12,
			[5] = 7
		},
		width = 4,
		height = 2,
		weight = 3.85,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		flag = "4",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(24.862462997437, 54.968238830566, -7.2976293563843),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 5)
				ent:SetBodygroup(2, 12)
				ent:SetBodygroup(5, 7)
			end	
		}, --pretty icons
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
		desc = "A kinda bootleg version of an assault rifle chambered in 5.45x39mm.",
		price = 36880,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 5,
			[2] = 10,
			[5] = 7
		},
		width = 4,
		height = 2,
		weight = 3.3,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - ARs",
		type = "n",
		flag = "4",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(24.862462997437, 54.968238830566, -7.2976293563843),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 5)
				ent:SetBodygroup(2, 10)
				ent:SetBodygroup(5, 7)
			end	
		}, --pretty icons
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
		desc = "A kinda bootleg version of a mag-fed semi-auto shotgun chambered in 12 gauge. Please note: this fucks up hard sometimes just reequip when it does sorry",
		price = 31680,
		model = "models/weapons/arccw/mifl/fas2/c_ak47.mdl",
		groups = {
			[1] = 13,
			[2] = 9,
			[5] = 3
		},
		width = 4,
		height = 2,
		weight = 3.6,
		class = "arccw_mifl_fas2_ak47",
		category = "Weapons - Shotguns",
		type = "shotgun",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(24.862462997437, 54.968238830566, -7.2976293563843),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 13)
				ent:SetBodygroup(2, 9)
				ent:SetBodygroup(5, 3)
			end	
		}, --pretty icons
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
		desc = "A light machine gun chambered in 7.62x39mm.",
		price = 35860,
		model = "models/weapons/arccw/mifl/fas2/c_rpk.mdl",
		width = 5,
		height = 2,
		weight = 4.8,
		class = "arccw_mifl_fas2_rpk",
		category = "Weapons - MGs",
		type = "ws",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(26.815870285034, 63.40096282959, -8.2976293563843),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "An assault rifle chambered in 5.56x45mm.",
		price = 44900,
		model = "models/weapons/arccw/mifl/fas2/c_famas.mdl",
		width = 4,
		height = 2,
		weight = 3.6,
		class = "arccw_mifl_fas2_famas",
		category = "Weapons - ARs",
		type = "n",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(20.887014389038, 38.760242462158, -6.7976293563843),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "An assault rifle chambered in 5.56x45mm.",
		price = 42880,
		model = "models/weapons/arccw/mifl/fas2/c_g36c.mdl",
		width = 4,
		height = 2,
		weight = 2.82,
		class = "arccw_mifl_fas2_g36c",
		category = "Weapons - ARs",
		type = "n",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(21.866317749023, 42.128940582275, -8.7621984481812),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "An assault rifle that's a little bootleg that is chambered in 5.56x45mm.",
		price = 0,
		model = "models/weapons/arccw/mifl/fas2/c_g36c.mdl",
		groups = {
			[3] = 4
		},
		width = 4,
		height = 2,
		weight = 3.63,
		class = "arccw_mifl_fas2_g36c",
		category = "Weapons - ARs",
		type = "n",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(23.730588912964, 49.291538238525, -8.7621984481812),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(3, 4)
			end	
		}, --pretty icons
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
		desc = "An assault rifle chambered by 5.56x45mm.",
		price = 32580,
		model = "models/weapons/arccw/mifl/fas2/c_sg552.mdl",
		width = 4,
		height = 2,
		weight = 3.2,
		class = "arccw_mifl_fas2_sg55x",
		category = "Weapons - ARs",
		type = "n",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(14.476577758789, 44.496852874756, -6.7977514266968),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A rifle chambered in 5.56x45mm.",
		price = 43580,
		model = "models/weapons/arccw/mifl/fas2/c_sg552.mdl",
		groups = {
			[1] = 1,
			[2] = 2
		},
		width = 5,
		height = 2,
		weight = 4.1,
		class = "arccw_mifl_fas2_sg55x",
		category = "Weapons - ARs",
		type = "n",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(19.705701828003, 57.514347076416, -6.7977514266968),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 1)
				ent:SetBodygroup(2, 2)
			end	
		
		}, --pretty icons
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
		desc = "A rifle chambered in 5.56x45mm.",
		price = 49560,
		model = "models/weapons/arccw/mifl/fas2/c_sg552.mdl",
		groups = {
			[1] = 1,
			[2] = 1,
			[3] = 7
		},
		width = 5,
		height = 2,
		weight = 7,
		class = "arccw_mifl_fas2_sg55x",
		category = "Weapons - Rifles",
		type = "n",
		flag = "5",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(19.705701828003, 57.514347076416, -6.7977514266968),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 1)
				ent:SetBodygroup(2, 1)
				ent:SetBodygroup(3, 7)
			end	
		
		}, --pretty icons
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
		desc = "An assault rifle chambered in 5.56x45mm.",
		price = 29560,
		model = "models/weapons/arccw/mifl/fas2/c_m4a1.mdl",
		width = 4,
		height = 2,
		weight = 3,
		class = "arccw_mifl_fas2_m4a1",
		category = "Weapons - ARs",
		type = "n",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(21.874122619629, 50.13890838623, -6.7977514266968),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,

		}, --pretty icons
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
		desc = "An assault rifle chambered in 5.56x45mm.",
		price = 35690,
		model = "models/weapons/arccw/mifl/fas2/c_m4a1.mdl",
		groups = {
			[1] = 4,
			[2] = 4,
			[5] = 1
		},
		width = 4,
		height = 2,
		weight = 2.9,
		class = "arccw_mifl_fas2_m4a1",
		category = "Weapons - ARs",
		type = "n",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(21.874122619629, 50.13890838623, -6.7977514266968),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 4)
				ent:SetBodygroup(2, 4)
				ent:SetBodygroup(5, 1)
			end	
		
		}, --pretty icons
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
		desc = "A 3 round burst assault rifle chambered by 5.56x45mm.",
		price = 35880,
		model = "models/weapons/arccw/mifl/fas2/c_m4a1.mdl",
		groups = {
			[1] = 1,
			[2] = 1,
			[5] = 1
		},
		width = 4,
		height = 2,
		weight = 3.77,
		class = "arccw_mifl_fas2_m4a1",
		category = "Weapons - ARs",
		type = "n",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(21.874122619629, 50.13890838623, -6.7977514266968),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 1)
				ent:SetBodygroup(2, 1)
				ent:SetBodygroup(5, 1)
			end	
		
		}, --pretty icons
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
		desc = "A 3 round burst assault rifle chambered in 5.56x45mm.",
		price = 37500,
		model = "models/weapons/arccw/mifl/fas2/c_m4a1.mdl",
		groups = {
			[1] = 13,
			[2] = 12,
			[5] = 1
		},
		width = 4,
		height = 2,
		weight = 3.4,
		class = "arccw_mifl_fas2_m4a1",
		category = "Weapons - ARs",
		type = "n",
		flag = "2",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(21.874122619629, 50.13890838623, -6.7977514266968),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 13)
				ent:SetBodygroup(2, 12)
				ent:SetBodygroup(5, 1)
			end	
		
		}, --pretty icons
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
		desc = "A grenade launcher using M203 rounds.",
		price = 36840,--26840,
		model = "models/weapons/arccw/mifl/fas2/c_m79.mdl",
		width = 3,
		height = 1,
		weight = 2.7,
		class = "arccw_mifl_fas2_m79",
		category = "Weapons - Misc",
		type = "shotgun",
		flag = "5",--any flag in this will make it return true
		disableSpecial = true,
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
		iconCam = {
			pos = Vector(25.772714614868, 57.741764068604, -5.8444123268127),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["cwep_m3"] = {
		--exclusive upgrade ideas: 
		--?
		name = "M3 Super 90",
		desc = "A semi-auto shotgun chambered in 12 gauge.",
		price = 34150,
		model = "models/weapons/arccw/mifl/fas2/c_m3s90.mdl",
		width = 4,
		height = 1,
		weight = 3.27,
		class = "arccw_mifl_fas2_m3",
		category = "Weapons - Shotguns",
		type = "shotgun",
		flag = "4",--any flag in this will make it return true
		--defaultMods = {
		--},
		--slots above should probably also be below
		cantDetach = {
			--["slot"] = true,
			--["m249_bipod"] =true,
			["mifl_fas2_m3_mag"] = true,
			["mifl_fas2_m3_barrel"] = true, --upgrade
			["mifl_fas2_m3_stock"] = true, --upgrade
			["mifl_fas2_uni_stock"] = true, --upgrade
			["go_perk"] = true, --upgrade
			["perk_fas2"] = true, --upgrade
		},
		iconCam = {
			pos = Vector(27.938598632813, 74.700958251953, -9.6152772903442),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "An assault rifle chambered in 5.45x39mm.",
		price = 38950,
		model = "models/weapons/arccw/eap/c_aek971.mdl",
		width = 4,
		height = 2,
		weight = 3.3,
		class = "arccw_eap_aek",
		category = "Weapons - ARs",
		type = "n",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(18.796047210693, 39.669815063477, -4.0912389755249),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "An assault rifle with an integrated foregrip chambered in 9x39mm.",
		price = 36860,
		model = "models/weapons/arccw/eap/c_groza.mdl",
		groups = {
			[1] = 9
		},
		width = 3,
		height = 2,
		weight = 2.93,
		class = "arccw_eap_groza",
		category = "Weapons - ARs",
		type = "n",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.287338256836, 25.372138977051, -5.9090309143066),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 9)
			end	
		}, --pretty icons
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
		desc = "An assault rifle with an integrated suppressor chambered in 9x39mm.",
		price = 39650,
		model = "models/weapons/arccw/eap/c_groza.mdl",
		groups = {
			[1] = 9,
			[3] = 2
		},
		width = 4,
		height = 2,
		weight = 3.22,
		class = "arccw_eap_groza",
		category = "Weapons - ARs",
		type = "n",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.287338256836, 25.372138977051, -5.9090309143066),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 9)
				ent:SetBodygroup(3, 2)
			end	
		}, --pretty icons
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
		desc = "An assault rifle with an integrated foregrip chambered in 7.62x39mm.",
		price = 35600,
		model = "models/weapons/arccw/eap/c_groza.mdl",
		width = 3,
		height = 2,
		weight = 2.93,
		class = "arccw_eap_groza",
		category = "Weapons - ARs",
		type = "ws",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.287338256836, 25.372138977051, -5.9090309143066),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		}, --pretty icons
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
		desc = "An assault rifle with an integrated suppressor chambered in 7.62x39mm.",
		price = 37500,
		model = "models/weapons/arccw/eap/c_groza.mdl",
		groups = {
			[3] = 2
		},
		width = 4,
		height = 2,
		weight = 3.22,
		class = "arccw_eap_groza",
		category = "Weapons - ARs",
		type = "ws",
		flag = "3",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(17.287338256836, 25.372138977051, -5.9090309143066),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(3, 2)
			end	
		}, --pretty icons
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
		desc = "A pistol chambered in 9x19.",
		price = 8650,
		model = "models/weapons/arccw/c_bo2_bhp.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_bo2_browninghp",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(15.588308334351, 14.237869262695, -3.9141964912415),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A double barreled shotgun in chambered in 12 gauge.",
		price = 15480,
		model = "models/weapons/arccw/c_waw_doublebarrel.mdl",
		width = 4,
		height = 1,
		weight = 3.4,
		class = "arccw_waw_doublebarrel",
		category = "Weapons - Shotguns",
		type = "shotgun",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(25.427587509155, 65.175735473633, -5.5245261192322),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		name = "Double Barrel Sawn-off",
		desc = "A sawn-off double barreled shotgun chambered in 12 gauge.",
		price = 10650,
		model = "models/weapons/arccw/c_waw_doublebarrel.mdl",
		groups = {
			[1] = 1,
			[2] = 1
		},
		width = 2,
		height = 1,
		weight = 1.92,
		class = "arccw_waw_doublebarrel",
		category = "Weapons - Shotguns",
		type = "shotgun",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(23.791379928589, 37.242267608643, -5.5245261192322),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(1, 1)
				ent:SetBodygroup(2, 1)
			end	
		}, --pretty icons
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
		desc = "A SMG chambered in 9x19mm.",
		price = 21100,
		model = "models/weapons/arccw/c_bo1_uzi.mdl",
		groups = {
			[3] = 2
		},
		width = 3,
		height = 2,
		weight = 3.5,
		class = "arccw_bo1_uzi",
		category = "Weapons - SMGs",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(15.572422027588, 22.063659667969, -5.5245261192322),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
			drawHook = function(ent)
				ent:SetBodygroup(3, 2)
			end	
		}, --pretty icons
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
		desc = "A SMG chambered in 7.62x25mm.",
		price = 15840,
		model = "models/weapons/arccw/c_waw_ppsh41.mdl",
		width = 3,
		height = 2,
		weight = 3.63,
		class = "arccw_waw_ppsh41",
		category = "Weapons - SMGs",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(15.62401676178, 42.472026824951, -5.5245261192322),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A light machine gun chambered in 7.62x51mm NATO.",
		price = 67000,
		model = "models/weapons/arccw/c_bo1_m60.mdl",
		width = 5,
		height = 2,
		weight = 10.5,
		class = "arccw_bo1_m60",
		category = "Weapons - MGs",
		type = "ws",
		flag = "4",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(19.850973129272, 48.772769927979, -5.5245261192322),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A pistol chambered in 9x18mm.",
		price = 4890,
		model = "models/weapons/w_bo1_makarov.mdl",
		width = 2,
		height = 1,
		weight = 0.73,
		class = "arccw_temp_makarov",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(3.6481177806854, 21.607614517212, 1.229171872139),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A pistol chambered in 7.62x25mm.",
		price = 9860,
		model = "models/weapons/w_waw_tokarev.mdl",
		width = 2,
		height = 1,
		weight = 0.85,
		class = "arccw_temp_tt33",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(3.6481177806854, 21.607614517212, 1.229171872139),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		name = "Skorpion vz.82",
		desc = "A machine pistol chambered in 9x18mm.",
		price = 15680,
		model = "models/weapons/w_bo1_skorpion.mdl",
		width = 2,
		height = 1,
		weight = 1.44,
		class = "arccw_temp_skorpion",
		category = "Weapons - Pistols",
		type = "pistol",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(5.1284055709839, 23.483392715454, 1.8043434619904),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A bolt-action rifle chambered in 7.62x54mmR. I don't know what model mosin this is sorry.",
		price = 21560,
		model = "models/weapons/w_waw_mosin_irons.mdl",
		width = 5,
		height = 1,
		weight = 4,
		class = "arccw_temp_mosin",
		category = "Weapons - Rifles",
		type = "ws",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(11.684871673584, 68.756477355957, -0.21930034458637),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A semi-auto rifle chambered in 7.62x54mmR.",
		price = 24850,
		model = "models/weapons/w_waw_svt40.mdl",
		width = 5,
		height = 1,
		weight = 3.85,
		class = "arccw_temp_svt",
		category = "Weapons - Rifles",
		type = "ws",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(15.213098526001, 73.322257995605, 1.4752556085587),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45.096441351889,
		
		}, --pretty icons
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
		desc = "A semi-auto rifle with an internal magazine chambered in 7.62x39mm.",
		price = 19580,
		model = "models/weapons/fas2wm/rifles/w_sks.mdl",
		width = 4,
		height = 1,
		weight = 3.75,
		class = "arccw_temp_sks",
		category = "Weapons - Rifles",
		type = "ws",
		flag = "1",--any flag in this will make it return true
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
		iconCam = {
			pos = Vector(-2.8815112113953, 54.744823455811, -0.35844379663467),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 180, 0),
			fov = 45,
		
		}, --pretty icons
		exRender = false, --overriding for old icon way if above exists
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
		desc = "An axe.",
		price = 10550,
		model = "models/weapons/hl2meleepack/w_axe.mdl",
		width = 3,
		height = 1,
		weight = 1,
		class = "arccw_melee_axe",
		category = "Weapons - Melee",
		type = "knife",
		flag = "2",--any flag in this will make it return true
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee",
		iconCam = {
			pos = Vector(0.34593138098717, 43.341918945313, -0.98572045564651),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 90),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A kitchen cleaver.",
		price = 8500,
		model = "models/danguyen/cleaver.mdl",
		width = 2,
		height = 1,
		weight = 1,
		class = "arccw_melee_cleaver",
		category = "Weapons - Melee",
		type = "knife",
		flag = "1",--any flag in this will make it return true
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee",
		iconCam = {
			pos = Vector(-1.4736837148666, 22.459537506104, 0.30920764803886),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 180, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A crowbar.",
		price = 9500,
		model = "models/weapons/w_crowbar.mdl",
		width = 3,
		height = 1,
		weight = 1,
		class = "arccw_melee_axe",
		category = "Weapons - Melee",
		type = "knife",
		flag = "1",--any flag in this will make it return true
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee",
		iconCam = {
			pos = Vector(-1.1131901741028, 43.019058227539, 0.82128018140793),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A hand hatchet.",
		price = 10050,
		model = "models/danguyen/hatchet.mdl",
		width = 3,
		height = 1,
		weight = 1,
		class = "arccw_melee_hatchet",
		category = "Weapons - Melee",
		type = "knife",
		flag = "1",--any flag in this will make it return true
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee",
		iconCam = {
			pos = Vector(-2.5722432136536, 44.778411865234, 0.82128018140793),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 180, 0),
			fov = 45,
		
		}, --pretty icons
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
		name = "Combat Knife",
		desc = "A combat knife.",
		price = 2085,
		model = "models/weapons/w_knife_t.mdl",
		width = 2,
		height = 1,
		weight = 0.2,
		class = "arccw_melee_knife",
		category = "Weapons - Melee",
		type = "knife",
		flag = "2",--any flag in this will make it return true
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee",
		iconCam = {
			pos = Vector(-8.123480796814, 20.5305519104, -0.9744987487793),
			ang = Angle(0, 270, 0),
			entAng = Angle(90, -180, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A huge knife (possibly M9 bayonet but idk thats why its large knife)",
		price = 12050,
		model = "models/danguyen/commandoknife.mdl",
		width = 2,
		height = 1,
		weight = 0.28,
		class = "arccw_melee_knifelarge",
		category = "Weapons - Melee",
		type = "knife",
		flag = "2",--any flag in this will make it return true
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee",
		iconCam = {
			pos = Vector(-5.8045196533203, 17.255588531494, -0.56233596801758),
			ang = Angle(0, 270, 0),
			entAng = Angle(90, -180, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A frying pan.",
		price = 6500,
		model = "models/weapons/hl2meleepack/w_pan.mdl",
		width = 2,
		height = 2,
		weight = 1.4,
		class = "arccw_melee_pan",
		category = "Weapons - Melee",
		type = "knife",
		flag = "1",--any flag in this will make it return true
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee",
		iconCam = {
			pos = Vector(-4.2881336212158, 23.521097183228, -0.23260572552681),
			ang = Angle(0, 270, 0),
			entAng = Angle(-90, 90, 180),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A lead pipe.",
		price = 3500,
		model = "models/props_canal/mattpipe.mdl",
		width = 3,
		height = 1,
		weight = 1,
		class = "arccw_melee_pipe",
		category = "Weapons - Melee",
		type = "knife",
		flag = "1",--any flag in this will make it return true
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee",
		iconCam = {
			pos = Vector(-2.3319249153137, 43.068500518799, 0.92968988418579),
			ang = Angle(0, 270, 0),
			entAng = Angle(-90, 0, 180),
			fov = 45,
		
		}, --pretty icons
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
		desc = "An assembled knife.",
		price = 1250,
		model = "models/danguyen/knife_shank.mdl",
		width = 2,
		height = 1,
		weight = 0.25,
		class = "arccw_melee_axe",
		category = "Weapons - Melee",
		type = "knife",
		flag = "1",--any flag in this will make it return true
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee",
		iconCam = {
			pos = Vector(-1.0130589008331, 16.523653030396, 0.0088834837079048),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, -90, -90),
			fov = 45,
		
		}, --pretty icons
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
		name = "Knife",
		desc = "A knife.",
		price = 3850,
		model = "models/weapons/w_csgo_default_t.mdl",
		width = 2,
		height = 1,
		weight = 0.2,
		class = "arccw_melee_knife_t",
		category = "Weapons - Melee",
		type = "knife",
		flag = "1",--any flag in this will make it return true
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee",
		iconCam = {
			pos = Vector(-4.0175848007202, 18.242444992065, -3.5360536575317),
			ang = Angle(0, 270, 0),
			entAng = Angle(57.446681976318, -180, 0),
			fov = 45,
		
		}, --pretty icons
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
		name = "Folding Knife",
		desc = "A folding knife.",
		price = 8950,
		model = "models/weapons/w_csgo_falchion.mdl",
		width = 1,
		height = 1,
		weight = 0.45,
		class = "arccw_melee_knife_fal",
		category = "Weapons - Melee",
		type = "knife",
		flag = "1",--any flag in this will make it return true
		--defaultMods = {
		--},
		--slots above should probably also be below
		equipTbl = "melee",
		iconCam = {
			pos = Vector(-2.4932010173798, 18.827472686768, -4.4148588180542),
			ang = Angle(0, 270, 0),
			entAng = Angle(57.446681976318, -180, 0),
			fov = 45,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--transferSound = "", --i think this is transferring between invs
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},

	--these are all of them i think
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
		desc = "A flashlight that can be attached to a weapon. bind a key to toggleatt to easily toggle",
		price = 3200,
		model = "models/weapons/arccw_go/atts/flashlight.mdl",
		width = 1,
		height = 1,
		weight = 0.14,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "tac", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.69938111305237, 6.7560019493103, -1.0573437213898),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A laser/flashlight combo to be attached to a weapon. bind a key to toggleatt to easily toggle",
		price = 5500,
		model = "models/weapons/arccw_go/atts/laser_surefire.mdl",
		width = 1,
		height = 1,
		weight = 0.14,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "tac", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.32967588305473, 6.7560019493103, -1.0573437213898),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A high power laser sight. bind a key to toggleatt to easily toggle",
		price = 15000,
		model = "models/weapons/arccw_go/atts/laser_peq.mdl",
		width = 1,
		height = 1,
		weight = 0.21,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
		cat = "tac", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.20668679475784, 6.4379873275757, -0.10934870690107),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 90),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A laser sight. bind a key to toggleatt to easily toggle",
		price = 5500,
		model = "models/weapons/arccw_go/atts/laser.mdl",
		width = 1,
		height = 1,
		weight = 0.05,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "tac", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.4563392996788, 5.8034429550171, -0.65434861183167),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A foregrip.",
		price = 3850,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 0.07,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "foregrip", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.063020892441273, 6.4136052131653, -1.7118104696274),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A canted foregrip.",
		price = 7000,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 0.18,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "foregrip", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.97416949272156, 7.9860305786133, -1.7118104696274),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, -90, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A foregrip.",
		price = 3400,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 0.07,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "foregrip", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.053027264773846, 6.422972202301, -1.8839550018311),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "An attachable bipod.",
		price = 4500,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 0.25,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "foregrip", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.053027264773846, 11.307095527649, -2.5871560573578),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 90, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "An angled foregrip.",
		price = 2850,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 0.08,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "foregrip", --attid should be id of item
		--traitreq = {trait = "trait", val = 0},
		--requireEnt = {class = "class", name = "a nicename", radius = 120},
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-1.6912804841995, 10.018113136292, -0.53828299045563),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A custom stock attachable to certain weapons.",
		price = 4000,
		model = "models/weapons/arccw_go/atts/stock_moe.mdl",
		width = 1,
		height = 1,
		weight = 0.23,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
		cat = "go_stock", --attid should be id of item
		--traitreq = {trait = "trait", val = 0},
		requireEnt = {class = "sky_craft_weapons", name = "a Weapon Crafting Bench", radius = 120},
		techReq = 1,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-6.806037902832, 12.231944084167, -1.9609030485153),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A custom stock attachable to certain weapons.",
		price = 2600,
		model = "models/weapons/arccw_go/atts/stock_ergo.mdl",
		width = 1,
		height = 1,
		weight = 0.27,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
		cat = "go_stock", --attid should be id of item
		--traitreq = {trait = "trait", val = 0},
		requireEnt = {class = "sky_craft_weapons", name = "a Weapon Crafting Bench", radius = 120},
		techReq = 1,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-6.3262267112732, 12.231944084167, -1.9609030485153),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A custom stock attachable to certain weapons.",
		price = 4500,
		model = "models/weapons/arccw_go/atts/stock_contractor.mdl",
		width = 1,
		height = 1,
		weight = 0.15,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
		cat = "go_stock", --attid should be id of item
		--traitreq = {trait = "trait", val = 0},
		requireEnt = {class = "sky_craft_weapons", name = "a Weapon Crafting Bench", radius = 120},
		techReq = 1,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-6.9452791213989, 12.231944084167, -1.9609030485153),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A custom stock attachable to certain weapons.",
		price = 2750,
		model = "models/weapons/arccw_go/atts/stock_basilisk.mdl",
		width = 1,
		height = 1,
		weight = 0.27,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
		cat = "go_stock", --attid should be id of item
		--traitreq = {trait = "trait", val = 0},
		requireEnt = {class = "sky_craft_weapons", name = "a Weapon Crafting Bench", radius = 120},
		techReq = 1,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-6.3657789230347, 12.231944084167, -1.9609030485153),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A custom stock specifically for the SuperNova.",
		price = 3950,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 0.23,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
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
		desc = "A railed underbarrel grenade launcher.",
		price = 25000,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 1.4,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
		cat = "foregrip", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.35838401317596, 20.193195343018, -1.9609030485153),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A railed underbarrel grenade launcher.",
		price = 25000,
		model = "models/items/boxmrounds.mdl",
		width = 1,
		height = 1,
		weight = 1.4,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
		cat = "foregrip", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.24589762091637, 19.577030181885, -2.3785078525543),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A suppressor used for weapons chambered in: .45 ACP, 5.7x28mm, 7.62x51mm NATO.",
		price = 13500,
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 0.3,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(4.0337090492249, 11.854196548462, -0.18307828903198),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A suppressor used for weapons chambered in: 9x19mm.",
		price = 15500,
		model = "models/weapons/arccw_go/atts/supp_osprey.mdl",
		width = 2,
		height = 1,
		weight = 0.27,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(4.5077776908875, 11.854196548462, -0.18307828903198),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A suppressor used for weapons chambered in: 4.6x30mm, 5.56x45mm.",
		price = 15000,
		model = "models/weapons/arccw_go/atts/supp_monster.mdl",
		width = 2,
		height = 1,
		weight = 0.5,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(4.21653175354, 11.854196548462, -0.18307828903198),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A suppressor used for weapons chambered in: 5.56x45mm.",
		price = 13500,
		model = "models/weapons/arccw_go/atts/supp_ntr.mdl",
		width = 2,
		height = 1,
		weight = 0.68,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(3.240923166275, 9.0263833999634, -0.15374037623405),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A suppressor used for weapons chambered in: 5.56x45mm, also accepts 7.62x39mm AK and ACE models, and the SVD",
		price = 17500,
		model = "models/weapons/arccw_go/atts/supp_large.mdl",
		width = 2,
		height = 1,
		weight = 0.57,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(5.2156047821045, 15.173662185669, -0.15374037623405),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A suppressor used for 7.62x39mm AK models.",
		price = 14500,
		model = "models/weapons/arccw_go/atts/supp_pbs1.mdl",
		width = 2,
		height = 1,
		weight = 0.44,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(5.3737602233887, 15.173662185669, -0.15374037623405),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A suppressor used for 5.45x39mm AK models, and the mosin.",
		price = 15000,
		model = "models/weapons/arccw_go/atts/supp_tgpa.mdl",
		width = 2,
		height = 1,
		weight = 0.7,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(4.7715792655945, 13.874286651611, -0.15374037623405),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A suppressor used for 5.45x39mm AK models.",
		price = 14500,
		model = "models/weapons/arccw_go/atts/supp_pbs4.mdl",
		width = 2,
		height = 1,
		weight = 0.7,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "muzzle", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(5.7794923782349, 17.331748962402, -0.15374037623405),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A small optic that can be attached on almost any weapon.",
		price = 10000,
		model = "models/weapons/arccw_go/atts/t1lp.mdl",
		width = 1,
		height = 1,
		weight = 0.08,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic_lp", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.10706943273544, 7.3452558517456, 0.65953516960144),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 24.145461174843,
		
		}, --pretty icons
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
		desc = "A small optic that can be attached on almost any weapon.",
		price = 10000,
		model = "models/weapons/arccw_go/atts/rmr.mdl",
		width = 1,
		height = 1,
		weight = 0.03,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic_lp", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.10725029557943, 7.3452558517456, 0.65953516960144),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 24.145461174843,
		
		}, --pretty icons
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
		desc = "A scope with IR capabilities.",
		price = 55000,
		model = "models/weapons/arccw_go/atts/pvs4.mdl",
		width = 2,
		height = 1,
		weight = 0.95,
		category = "Attachments",
		flag = "l",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-2.8022437095642, 15.686842918396, 1.6358258724213),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A huge scope with variable zoom, nightvision and thermal capabilities, with a backup holographic sight.",
		price = 450000,
		model = "models/weapons/arccw/mifl_atts/fas2/felin_scope.mdl",
		width = 2,
		height = 1,
		weight = 3.7,
		category = "Attachments",
		--flag = "",
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-1.214580655098, 19.681219100952, 2.5284895896912),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
		exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["go_optic_awp"] = {
		name = "Arctic Warfare Scope (10x)",
		desc = "A scope commonly found on the AWM.",
		price = 15000,
		model = "models/weapons/arccw_go/atts/awp.mdl",
		width = 2,
		height = 1,
		weight = 0.9,
		category = "Attachments",
		flag = "k",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.26167789101601, 18.769844055176, 1.4121470451355),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A variable zoom scope.",
		price = 15500,
		model = "models/weapons/arccw/mifl_atts/fas2_optic_lmk4.mdl",
		width = 2,
		height = 1,
		weight = 0.9,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(2.4083116054535, 18.769844055176, 1.4121470451355),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A scope.",
		price = 15000,
		model = "models/weapons/arccw_go/atts/schmidt.mdl",
		width = 2,
		height = 1,
		weight = 0.9,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.071127727627754, 18.769844055176, 1.4121470451355),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A scope with thermal capabilities.",
		price = 400000,
		model = "models/weapons/arccw/mifl_atts/fas2_optic_xm25.mdl",
		width = 2,
		height = 1,
		weight = 1.1,
		category = "Attachments",
		flag = "l",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.69015091657639, 14.86914730072, 1.5661097764969),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A scope.",
		price = 15000,
		model = "models/weapons/arccw/mifl_atts/fas2_optic_551.mdl",
		width = 2,
		height = 1,
		weight = 1,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(2.4212951660156, 19.203254699707, 1.5661097764969),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A scope.",
		price = 14500,
		model = "models/weapons/arccw/mifl_atts/fas2_optic_pso1.mdl",
		width = 2,
		height = 1,
		weight = 0.6,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.81472390890121, 12.751099586487, 1.3503861427307),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A scope with backup ironsights.",
		price = 14500,
		model = "models/weapons/arccw/mifl_atts/fas2_optic_acog.mdl",
		width = 2,
		height = 1,
		weight = 0.4,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.51205009222031, 9.7812957763672, 1.0817892551422),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A scope with backup ironsights.",
		price = 14500,
		model = "models/weapons/arccw_go/atts/elcan.mdl",
		width = 2,
		height = 1,
		weight = 0.5,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2184629291296, 9.7812957763672, 1.0817892551422),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A hybrid scope.",
		price = 16000,
		model = "models/weapons/arccw_go/atts/hamr.mdl",
		width = 2,
		height = 1,
		weight = 0.4,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.80923044681549, 10.660333633423, 1.5862311124802),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		
		}, --pretty icons
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
		desc = "A red dot sight.",
		price = 12000,
		model = "models/weapons/arccw/mifl_atts/fas2_optic_g36.mdl",
		width = 1,
		height = 1,
		weight = 0.4,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.25165918469429, 6.773983001709, 0.57720476388931),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 21.139198571605,
		
		}, --pretty icons
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
		desc = "A red dot sight.",
		price = 12000,
		model = "models/weapons/arccw_go/atts/t1.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.17056550085545, 8.8402919769287, 0.8173451423645),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 21.139198571605,
		
		}, --pretty icons
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
		desc = "A holographic sight.",
		price = 16000,
		model = "models/weapons/arccw_go/atts/eotech.mdl",
		width = 1,
		height = 1,
		weight = 0.35,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.33277961611748, 10.087456703186, 0.69176882505417),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 21.139198571605,
		
		}, --pretty icons
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
		desc = "An optic.",
		price = 12000,
		model = "models/weapons/arccw_go/atts/kobra.mdl",
		width = 1,
		height = 1,
		weight = 0.27,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.13747149705887, 12.129191398621, 0.69176882505417),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 21.139198571605,
		
		}, --pretty icons
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
		desc = "A red dot sight.",
		price = 14000,
		model = "models/weapons/arccw_go/atts/compm4.mdl",
		width = 2,
		height = 1,
		weight = 0.36,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.22412826120853, 11.376020431519, 0.93893367052078),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 21.139198571605,
		
		}, --pretty icons
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
		desc = "An optic.",
		price = 14000,
		model = "models/weapons/arccw_go/atts/cmore.mdl",
		width = 2,
		height = 1,
		weight = 0.3,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.03400830924511, 12.579445838928, 0.93893367052078),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 21.139198571605,
		
		}, --pretty icons
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
		desc = "A red dot sight.",
		price = 14000,
		model = "models/weapons/arccw_go/atts/barska.mdl",
		width = 2,
		height = 1,
		weight = 0.1,
		category = "Attachments",
		flag = "j",--any flag in this will make it return true
		cat = "optic", --attid should be id of item
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.51285761594772, 8.9643268585205, 0.7454177737236),
			ang = Angle(0, 270, 0),
			entAng = Angle(0, 0, 0),
			fov = 21.139198571605,
		
		}, --pretty icons
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
		name = "9x19mm Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 2150, --43ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x19_fmj.mdl",
		width = 1,
		height = 1,
		weight = 0.012,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky9x19",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.16811694204807, 11.062747955322, 0.25030392408371),
			ang = Angle(0, 270, 0),
			entAng = Angle(-43.543315887451, -40.780067443848, -35.422058105469),
			fov = 39.071077276148,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_9x18"] = {
		name = "9x18 Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 1750, --35ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x18_fmj.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky9x18",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.16811694204807, 11.062747955322, 0.25030392408371),
			ang = Angle(0, 270, 0),
			entAng = Angle(-43.543315887451, -40.780067443848, -35.422058105469),
			fov = 39.071077276148,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_9x39"] = {
		name = "9x39mm Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 3330,--166.67ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x39_pab9.mdl",
		width = 2,
		height = 1,
		weight = 0.025,
		--category = "Attachments",
		flag = "3",--any flag in this will make it return true
		ammo = "sky9x39",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2997687458992, 16.542030334473, 0.6551451086998),
			ang = Angle(0, 270, 0),
			entAng = Angle(-30.724361419678, -46.184467315674, -23.122215270996),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_46"] = {
		name = "4.6x30mm Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 2130,--106.67ea
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 0.006,
		--category = "Attachments",
		flag = "5",--any flag in this will make it return true
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
		name = "5.7x28mm Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 2130,
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 0.006,
		--category = "Attachments",
		flag = "4",--any flag in this will make it return true
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
		name = "45 ACP Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 3250,--65ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_1143x23_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.02,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky45acp",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2997687458992, 16.542030334473, 0.6551451086998),
			ang = Angle(0, 270, 0),
			entAng = Angle(-30.724361419678, -46.184467315674, -23.122215270996),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_50ae"] = {
		name = "50 AE Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 3750,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_50_ae.mdl",
		width = 2,
		height = 1,
		weight = 0.02,
		--category = "Attachments",
		flag = "2",--any flag in this will make it return true
		ammo = "sky50ae",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2997687458992, 16.542030334473, 0.31425142288208),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x25"] = {
		name = "7.62x25mm Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 2340,--46.875ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x25_p.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky762x25",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.26382744312286, 11.425048828125, 0.25030392408371),
			ang = Angle(0, 270, 0),
			entAng = Angle(-43.543315887451, -40.780067443848, -35.422058105469),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x39"] = {
		name = "7.62x39mm Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 2040,--102ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x39_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.016,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky762x39",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.33957388997078, 20.552410125732, 1.3846484422684),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x51"] = {
		name = "7.62x51mm NATO Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 3000,--150ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x51_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.025,
		--category = "Attachments",
		flag = "3",--any flag in this will make it return true
		ammo = "sky762x51",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.33957388997078, 20.552410125732, 1.3846484422684),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x54"] = {
		name = "7.62x54mmR Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 2800,--140ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_7h1.mdl",
		width = 2,
		height = 1,
		weight = 0.022,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky762x54",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.17477670311928, 14.309669494629, 0.59221971035004),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_556"] = {
		name = "5.56x45mm Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 3000,--100ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_556x45_ss190.mdl",
		width = 2,
		height = 1,
		weight = 0.011,
		--category = "Attachments",
		flag = "2",--any flag in this will make it return true
		ammo = "sky556",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.62745332717896, 19.62232208252, 0.95279800891876),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_545"] = {
		name = "5.45x39mm Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 1800,--90ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_545x39_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky545",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.62745332717896, 19.62232208252, 0.95279800891876),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_338"] = {
		name = "338 Lapua Ammo Box",
		desc = "A box of ammo currently containing %s rounds.", --use %s for number
		price = 8500,--425
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_ap.mdl",
		width = 2,
		height = 1,
		weight = 0.044,
		--category = "Attachments",
		flag = "5",--any flag in this will make it return true
		ammo = "sky338",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.17477670311928, 14.309669494629, 0.59221971035004),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--none of the eas here are correct
	--+200
	["ammo_9x19_jhp"] = {
		name = "9x19mm JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 2350, --43ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x19_fmj.mdl",
		width = 1,
		height = 1,
		weight = 0.012,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky9x19_jhp",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.16811694204807, 11.062747955322, 0.25030392408371),
			ang = Angle(0, 270, 0),
			entAng = Angle(-43.543315887451, -40.780067443848, -35.422058105469),
			fov = 39.071077276148,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_9x18_jhp"] = {
		name = "9x18 JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 1950, --35ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x18_fmj.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky9x18_jhp",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.16811694204807, 11.062747955322, 0.25030392408371),
			ang = Angle(0, 270, 0),
			entAng = Angle(-43.543315887451, -40.780067443848, -35.422058105469),
			fov = 39.071077276148,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_9x39_jhp"] = {
		name = "9x39mm JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 3530,--166.67ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x39_pab9.mdl",
		width = 2,
		height = 1,
		weight = 0.025,
		--category = "Attachments",
		flag = "3",--any flag in this will make it return true
		ammo = "sky9x39_jhp",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2997687458992, 16.542030334473, 0.6551451086998),
			ang = Angle(0, 270, 0),
			entAng = Angle(-30.724361419678, -46.184467315674, -23.122215270996),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_46_jhp"] = {
		name = "4.6x30mm JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 2330,--106.67ea
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 0.006,
		--category = "Attachments",
		flag = "5",--any flag in this will make it return true
		ammo = "sky46_jhp",
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
	["ammo_57_jhp"] = {
		name = "5.7x28mm JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 2330,
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 0.006,
		--category = "Attachments",
		flag = "4",--any flag in this will make it return true
		ammo = "sky57_jhp",
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
	["ammo_45acp_jhp"] = {
		name = "45 ACP JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 3450,--65ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_1143x23_hydro.mdl",
		width = 2,
		height = 1,
		weight = 0.02,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky45acp_jhp",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2997687458992, 16.542030334473, 0.6551451086998),
			ang = Angle(0, 270, 0),
			entAng = Angle(-30.724361419678, -46.184467315674, -23.122215270996),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_50ae_jhp"] = {
		name = "50 AE JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 3950,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_50_ae.mdl",
		width = 2,
		height = 1,
		weight = 0.02,
		--category = "Attachments",
		flag = "2",--any flag in this will make it return true
		ammo = "sky50ae_jhp",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2997687458992, 16.542030334473, 0.31425142288208),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x25_jhp"] = {
		name = "7.62x25mm JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 2540,--46.875ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x25_p.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky762x25_jhp",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.26382744312286, 11.425048828125, 0.25030392408371),
			ang = Angle(0, 270, 0),
			entAng = Angle(-43.543315887451, -40.780067443848, -35.422058105469),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x39_jhp"] = {
		name = "7.62x39mm JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 2240,--102ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x39_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.016,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky762x39_jhp",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.33957388997078, 20.552410125732, 1.3846484422684),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x51_jhp"] = {
		name = "7.62x51mm NATO JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 3200,--150ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x51_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.025,
		--category = "Attachments",
		flag = "3",--any flag in this will make it return true
		ammo = "sky762x51_jhp",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.33957388997078, 20.552410125732, 1.3846484422684),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x54_jhp"] = {
		name = "7.62x54mmR JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 3000,--140ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_7h1.mdl",
		width = 2,
		height = 1,
		weight = 0.022,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky762x54_jhp",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.17477670311928, 14.309669494629, 0.59221971035004),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_556_jhp"] = {
		name = "5.56x45mm JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 3200,--100ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_556x45_ss190.mdl",
		width = 2,
		height = 1,
		weight = 0.011,
		--category = "Attachments",
		flag = "2",--any flag in this will make it return true
		ammo = "sky556_jhp",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.62745332717896, 19.62232208252, 0.95279800891876),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_545_jhp"] = {
		name = "5.45x39mm JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 2000,--90ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_545x39_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky545_jhp",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.62745332717896, 19.62232208252, 0.95279800891876),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_338_jhp"] = {
		name = "338 Lapua JHP Ammo Box",
		desc = "A box of JHP ammo currently containing %s rounds.", --use %s for number
		price = 8700,--425
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_ap.mdl",
		width = 2,
		height = 1,
		weight = 0.044,
		--category = "Attachments",
		flag = "5",--any flag in this will make it return true
		ammo = "sky338_jhp",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.17477670311928, 14.309669494629, 0.59221971035004),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--+100
	["ammo_9x19_match"] = {
		name = "9x19mm MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 2550, --not correct43ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x19_fmj.mdl",
		width = 1,
		height = 1,
		weight = 0.012,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky9x19_match",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.16811694204807, 11.062747955322, 0.25030392408371),
			ang = Angle(0, 270, 0),
			entAng = Angle(-43.543315887451, -40.780067443848, -35.422058105469),
			fov = 39.071077276148,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_9x18_match"] = {
		name = "9x18 MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 1850, --35ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x18_fmj.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky9x18_match",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.16811694204807, 11.062747955322, 0.25030392408371),
			ang = Angle(0, 270, 0),
			entAng = Angle(-43.543315887451, -40.780067443848, -35.422058105469),
			fov = 39.071077276148,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_9x39_match"] = {
		name = "9x39mm MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 3430,--166.67ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x39_pab9.mdl",
		width = 2,
		height = 1,
		weight = 0.025,
		--category = "Attachments",
		flag = "3",--any flag in this will make it return true
		ammo = "sky9x39_match",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2997687458992, 16.542030334473, 0.6551451086998),
			ang = Angle(0, 270, 0),
			entAng = Angle(-30.724361419678, -46.184467315674, -23.122215270996),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_46_match"] = {
		name = "4.6x30mm MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 2230,--106.67ea
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 0.006,
		--category = "Attachments",
		flag = "5",--any flag in this will make it return true
		ammo = "sky46_match",
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
	["ammo_57_match"] = {
		name = "5.7x28mm MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 2230,
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 0.006,
		--category = "Attachments",
		flag = "4",--any flag in this will make it return true
		ammo = "sky57_match",
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
	["ammo_45acp_match"] = {
		name = "45 ACP MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 3350,--65ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_1143x23_hydro.mdl",
		width = 2,
		height = 1,
		weight = 0.02,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky45acp_match",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2997687458992, 16.542030334473, 0.6551451086998),
			ang = Angle(0, 270, 0),
			entAng = Angle(-30.724361419678, -46.184467315674, -23.122215270996),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_50ae_match"] = {
		name = "50 AE MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 3850,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_50_ae.mdl",
		width = 2,
		height = 1,
		weight = 0.02,
		--category = "Attachments",
		flag = "2",--any flag in this will make it return true
		ammo = "sky50ae_match",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2997687458992, 16.542030334473, 0.31425142288208),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x25_match"] = {
		name = "7.62x25mm MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 2440,--46.875ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x25_p.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky762x25_match",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.26382744312286, 11.425048828125, 0.25030392408371),
			ang = Angle(0, 270, 0),
			entAng = Angle(-43.543315887451, -40.780067443848, -35.422058105469),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x39_match"] = {
		name = "7.62x39mm MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 2140,--102ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x39_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.016,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky762x39_match",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.33957388997078, 20.552410125732, 1.3846484422684),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x51_match"] = {
		name = "7.62x51mm NATO MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 3100,--150ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x51_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.025,
		--category = "Attachments",
		flag = "3",--any flag in this will make it return true
		ammo = "sky762x51_match",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.33957388997078, 20.552410125732, 1.3846484422684),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x54_match"] = {
		name = "7.62x54mmR MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 2900,--140ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_7h1.mdl",
		width = 2,
		height = 1,
		weight = 0.022,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky762x54_match",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.17477670311928, 14.309669494629, 0.59221971035004),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_556_match"] = {
		name = "5.56x45mm MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 3100,--100ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_556x45_ss190.mdl",
		width = 2,
		height = 1,
		weight = 0.011,
		--category = "Attachments",
		flag = "2",--any flag in this will make it return true
		ammo = "sky556_match",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.62745332717896, 19.62232208252, 0.95279800891876),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_545_match"] = {
		name = "5.45x39mm MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 1900,--90ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_545x39_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky545_match",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.62745332717896, 19.62232208252, 0.95279800891876),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_338_match"] = {
		name = "338 Lapua MATCH Ammo Box",
		desc = "A box of MATCH ammo currently containing %s rounds.", --use %s for number
		price = 8600,--425
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_ap.mdl",
		width = 2,
		height = 1,
		weight = 0.044,
		--category = "Attachments",
		flag = "5",--any flag in this will make it return true
		ammo = "sky338_match",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.17477670311928, 14.309669494629, 0.59221971035004),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--500
	["ammo_9x19_ap"] = {
		name = "9x19mm AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 2950, --not correct43ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x19_pbp.mdl",
		width = 1,
		height = 1,
		weight = 0.012,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky9x19_ap",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.16811694204807, 11.062747955322, 0.25030392408371),
			ang = Angle(0, 270, 0),
			entAng = Angle(-43.543315887451, -40.780067443848, -35.422058105469),
			fov = 39.071077276148,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_9x18_ap"] = {
		name = "9x18 AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 2250, --35ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x18_pmm.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky9x18_ap",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.16811694204807, 11.062747955322, 0.25030392408371),
			ang = Angle(0, 270, 0),
			entAng = Angle(-43.543315887451, -40.780067443848, -35.422058105469),
			fov = 39.071077276148,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_9x39_ap"] = {
		name = "9x39mm AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 3830,--166.67ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_9x39_ap.mdl",
		width = 2,
		height = 1,
		weight = 0.025,
		--category = "Attachments",
		flag = "3",--any flag in this will make it return true
		ammo = "sky9x39_ap",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2997687458992, 16.542030334473, 0.6551451086998),
			ang = Angle(0, 270, 0),
			entAng = Angle(-30.724361419678, -46.184467315674, -23.122215270996),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_46_ap"] = {
		name = "4.6x30mm AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 2630,--106.67ea
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 0.006,
		--category = "Attachments",
		flag = "5",--any flag in this will make it return true
		ammo = "sky46_ap",
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
	["ammo_57_ap"] = {
		name = "5.7x28mm AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 2630,
		model = "models/items/boxmrounds.mdl",
		width = 2,
		height = 1,
		weight = 0.006,
		--category = "Attachments",
		flag = "4",--any flag in this will make it return true
		ammo = "sky57_ap",
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
	["ammo_45acp_ap"] = {
		name = "45 ACP AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 3750,--65ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_1143x23_fmj.mdl",
		width = 2,
		height = 1,
		weight = 0.02,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky45acp_ap",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2997687458992, 16.542030334473, 0.6551451086998),
			ang = Angle(0, 270, 0),
			entAng = Angle(-30.724361419678, -46.184467315674, -23.122215270996),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_50ae_ap"] = {
		name = "50 AE AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 4250,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_50_ae.mdl",
		width = 2,
		height = 1,
		weight = 0.02,
		--category = "Attachments",
		flag = "2",--any flag in this will make it return true
		ammo = "sky50ae_ap",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.2997687458992, 16.542030334473, 0.31425142288208),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x25_ap"] = {
		name = "7.62x25mm AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 2840,--46.875ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x25_ps.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky762x25_ap",
		maxQuantity = 50,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.26382744312286, 11.425048828125, 0.25030392408371),
			ang = Angle(0, 270, 0),
			entAng = Angle(-43.543315887451, -40.780067443848, -35.422058105469),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x39_ap"] = {
		name = "7.62x39mm AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 2540,--102ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x39_ap.mdl",
		width = 2,
		height = 1,
		weight = 0.016,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky762x39_ap",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.33957388997078, 20.552410125732, 1.3846484422684),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x51_ap"] = {
		name = "7.62x51mm NATO AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 3500,--150ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x51_ap.mdl",
		width = 2,
		height = 1,
		weight = 0.025,
		--category = "Attachments",
		flag = "3",--any flag in this will make it return true
		ammo = "sky762x51_ap",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.33957388997078, 20.552410125732, 1.3846484422684),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_762x54_ap"] = {
		name = "7.62x54mmR AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 3300,--140ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_ap.mdl",
		width = 2,
		height = 1,
		weight = 0.022,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky762x54_ap",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.17477670311928, 14.309669494629, 0.59221971035004),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_556_ap"] = {
		name = "5.56x45mm AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 3500,--100ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_556x45_ap.mdl",
		width = 2,
		height = 1,
		weight = 0.011,
		--category = "Attachments",
		flag = "2",--any flag in this will make it return true
		ammo = "sky556_ap",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.62745332717896, 19.62232208252, 0.95279800891876),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_545_ap"] = {
		name = "5.45x39mm AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 2300,--90ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_545x39_ap.mdl",
		width = 2,
		height = 1,
		weight = 0.01,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "sky545_ap",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.62745332717896, 19.62232208252, 0.95279800891876),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_338_ap"] = {
		name = "338 Lapua AP Ammo Box",
		desc = "A box of AP ammo currently containing %s rounds.", --use %s for number
		price = 9000,--425
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_762x54_ap.mdl",
		width = 2,
		height = 1,
		weight = 0.044,
		--category = "Attachments",
		flag = "5",--any flag in this will make it return true
		ammo = "sky338_ap",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(0.17477670311928, 14.309669494629, 0.59221971035004),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_23mm"] = {
		name = "23mm Ammo Box",
		desc = "A box of ammo currently containing %s shells.", --use %s for number
		price = 3000,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x70_buck.mdl",
		width = 2,
		height = 1,
		weight = 0.065,
		--category = "Attachments",
		flag = "5",--any flag in this will make it return true
		ammo = "sky23mm",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.026200776919723, 14.994012832642, 0.82984000444412),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_buckshot"] = {
		name = "12 Gauge Ammo Box",
		desc = "A box of ammo currently containing %s shells.", --use %s for number
		price = 1500,--75ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x70_buck_2.mdl",
		width = 2,
		height = 1,
		weight = 0.045,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "buckshot",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.026200776919723, 14.994012832642, 0.82984000444412),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--200
	["ammo_23mm_slug"] = {
		name = "23mm Slug Ammo Box",
		desc = "A box of Slug ammo currently containing %s shells.", --use %s for number
		price = 3200,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x76_zhekan.mdl",
		width = 2,
		height = 1,
		weight = 0.065,
		--category = "Attachments",
		flag = "5",--any flag in this will make it return true
		ammo = "sky23mm_slug",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.026200776919723, 14.994012832642, 0.82984000444412),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_buckshot_slug"] = {
		name = "12 Gauge Slug Ammo Box",
		desc = "A box of Slug ammo currently containing %s shells.", --use %s for number
		price = 1700,--75ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x76_zhekan_2.mdl",
		width = 2,
		height = 1,
		weight = 0.045,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "buckshot_slug",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.026200776919723, 14.994012832642, 0.82984000444412),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	--500
	["ammo_23mm_sabot"] = {
		name = "23mm Sabot Ammo Box",
		desc = "A box of Sabot ammo currently containing %s shells.", --use %s for number
		price = 3500,
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x76_zhekan_2.mdl",
		width = 2,
		height = 1,
		weight = 0.065,
		--category = "Attachments",
		flag = "5",--any flag in this will make it return true
		ammo = "sky23mm_sabot",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.026200776919723, 14.994012832642, 0.82984000444412),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
		--exRender = false, --overriding for old icon way if above exists
		--iconmodel = "", --will use this model for icon making instead of normal model
		--icon = "", --premade icons
		--noBusiness = true, --doesnt appear in business menu
		--destroyval = { --creates an automatic destruction func
		--	["item"] = 1, --these are the results
		--},
	},
	["ammo_buckshot_sabot"] = {
		name = "12 Gauge Sabot Ammo Box",
		desc = "A box of Sabot ammo currently containing %s shells.", --use %s for number
		price = 2000,--75ea
		model = "models/wick/wrbstalker/anomaly/items/wick_ammo_12x70_buck_2.mdl",
		width = 2,
		height = 1,
		weight = 0.045,
		--category = "Attachments",
		flag = "1",--any flag in this will make it return true
		ammo = "buckshot_sabot",
		maxQuantity = 20,
		--defQuantity = 50,
		--useSound = "", --sound to use instead of atts own
		iconCam = {
			pos = Vector(-0.026200776919723, 14.994012832642, 0.82984000444412),
			ang = Angle(0, 270, 0),
			entAng = Angle(-13.908400535583, -38.924156188965, -16.338712692261),
			fov = 45.325249134121,
		
		}, --pretty icons
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
		ITEM.disableSpecial = data.disableSpecial
		if(data.iconCam) then --prob wont be used for anything else so
			ITEM.exRender = true
			ITEM.iconCam = data.iconCam
		end
		if(data.exRender != nil) then
			ITEM.exRender = data.exRender
		end
		ITEM.icon = data.icon
		ITEM.iconmodel = data.iconmodel
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
		if(data.exRender != nil) then
			ITEM.exRender = data.exRender
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
		if(data.exRender != nil) then
			ITEM.exRender = data.exRender
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