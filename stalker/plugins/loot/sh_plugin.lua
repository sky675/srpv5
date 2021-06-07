--do it like now, 
--also make it where npcs will drop parts/patches/low tier ammo/consumables 
--depending on npc
local PLUGIN = PLUGIN
PLUGIN.name = "Loot Spawning"
PLUGIN.author = "sky"
PLUGIN.desc = "randomly spawns loot"

PLUGIN.lootTables = {
	--[[
	["tableid"] = {
		istableloot = false, --with this, the ids in the table should be a 
					--different loot table to use instead, none still works
		loot = {
			{"id", 1},
			{"none", 1}
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
		--randomAmmo works with credsticks too
	},
	]]

	["common_eft"] = {
		loot = {
			{"junk_aa", 3},
			{"junk_cap", 3},
			{"junk_chain", 3},
			{"junk_circuitboard", 1},
			{"junk_coffee", 1},
			{"junk_mcontrol", 1},
			{"junk_drill", 1},
			{"junk_gasa", 1},
			{"junk_geiger", 1},
			{"junk_gpblue", 2},
			{"junk_gpgreen", 1},
			{"junk_gphone", 2},
			{"junk_gphonex", 1},
			{"junk_gyroscope", 1},
			{"junk_hdd", 1},
			{"junk_helix", 1},
			{"junk_horse", 2},
			{"junk_hose", 1},
			{"junk_itape", 3},
			{"junk_lcdc", 1},
			{"junk_lcdd", 2},
			{"junk_lightbulb", 3},
			{"junk_magnet", 1},
			{"junk_matches", 3},
			{"junk_meds", 2},
			{"junk_syringe", 5},
			{"junk_nailpack", 3},
			{"junk_nixxor", 1},
			{"junk_nuts", 3},
			{"junk_screws", 4},
			{"junk_relay", 3},
			{"junk_plexiglass", 2},
			{"junk_pliers", 4},
			{"junk_powerbank", 1},
			{"junk_powercord", 2},
			{"junk_psu", 1},
			{"junk_propane", 1},
			{"junk_screwdriver", 4},
			{"junk_bolts", 3},
			{"junk_silicontube", 2},
			{"junk_sparkplug", 2},
			{"junk_toolset", 1},
			{"junk_toothpaste", 6},
			{"junk_waterfilter", 1},
			{"junk_weaponparts", 1},
			{"junk_wires", 2},
			{"junk_wrench", 5},
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["uncommon_eft"] = {
		loot = {
			{"junk_cat", 1},
			{"junk_ofz", 2},
			{"junk_dryfuel", 1},
			{"junk_motor", 2},
			{"junk_gchain", 2},
			{"junk_gpred", 2},
			{"junk_gyrotachometer", 1},
			{"junk_militaryboard", 1},
			{"junk_militarycable", 1},
			{"junk_paracord", 1},
			{"junk_powerfilter", 2},
			{"junk_pressuregauge", 1},
			{"junk_rfid", 1},
			{"junk_roler", 1},
			{"junk_thermometer", 1},
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["rare_eft"] = {
		loot = {
			{"junk_defib", 1},
			{"junk_diagset", 1},
			{"junk_vpx", 1},
			{"junk_fcond", 1},
			{"junk_graphicscard", 1},
			{"junk_lion", 1},
			{"junk_militarybattery", 1},
			{"junk_asea", 1},
			{"junk_tetriz", 1},
			{"junk_thermalmodule", 1},
			{"junk_virtex", 1},
			{"junk_transmitter", 1},
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["common_junk"] = { --junk, melee, misc stuff
		loot = {
			{"lockpick", 2},
			{"comp_mech1", 4},
			{"comp_scrap_cloth", 7},
			{"comp_scrap_metal", 4},
			{"comp_wire1", 6},
			{"comp_duct_tape", 2},
			{"metalcan", 9},
			{"metalcanl", 7},
			{"rebar", 9},
			{"doll", 5},
			{"shoe", 7},
			{"bleach", 5},
			{"junk_detector", 3},
			{"junk_grease", 3},
			{"flashlight", 7},
			{"cwep_m_cleaver", 1},
			{"cwep_m_crowbar", 1},
			{"cwep_m_hatchet", 1},
			{"cwep_m_knife", 1},
			{"cwep_m_pan", 2},
			{"cwep_m_pipe", 2},
			{"cwep_m_shank", 3},
			{"cwep_m_knife_t", 1},
			{"eyes_glasses", 7},
			--{"eyes_glasses_dark", 8},
			--{"hands_bgloves", 6},
			{"head_beanie", 4},
			{"head_gbeanie", 4},
			{"mask_ggasmask", 2},
			{"mask_bgasmask", 1},
			{"mask_rbandana", 3},
			{"mask_bbandana", 2},
			{"mask_respirator", 2},
			{"mask_surgicalmask", 2},

		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["common_food"] = { --food
		loot = {
			{"drink_beer", 3},
			{"drink_energy", 4},
			{"drink_largesoda", 1},
			{"drink_milkcarton", 1},
			{"drink_milkjug", 1},
			{"drink_waterflask", 2},
			{"drink_sodacan", 3},
			{"drink_tea", 2},
			{"drink_vodka1", 2},
			{"drink_vodkaz", 2},
			{"drink_vodkab", 1},
			{"drink_waterbottle", 4},
			{"drink_whiskey", 2},
			{"food_ration_ukr", 1}, --rare
			{"food_bag_nuts", 3},
			{"food_bag_raisins", 2},
			{"food_barchoc", 4},
			{"food_canbeans", 2},
			{"food_cancorn", 1},
			{"food_cantushonka", 2},
			{"food_cantuna", 4},
			{"food_bread", 4},
			{"food_breadstale", 2},
			{"food_choc_alyonka", 2},
			{"food_ration_ru", 1},
			{"food_sausage", 4},
			
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["uncomm_junk"] = { --rarer junk, meds, etc
		loot = {
			{"comp_tech1", 7},
			{"comp_jar_antiseptic", 6},
			{"datachik1", 2},
			{"datachik2", 2},
			{"datachik3", 1},
			{"radio", 4},
			{"cwep_m_axe", 1},
			{"cwep_m_cleaver", 1},
			{"cwep_m_crowbar", 1},
			{"cwep_m_hatchet", 1},
			{"headlamp", 2},
			{"rep_gunoil", 2},
			{"rep_gunoilru", 3},
			{"rep_solvent", 2},
			{"rep_gunoilrud", 3},
			{"rep_cleaning_p", 2},
			{"rep_cleaning_u", 1},
			{"rep_glue_b", 7},
			{"rep_glue_a", 3},
			{"rep_sewing_b", 5},
			--[[
			{"rep_cleaning_n", 4},
			{"rep_cleaning_p", 6},
			{"rep_cleaning_u", 5},
			{"rep_cleaning_ws", 4},
			]]
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["uncomm_ammo"] = { --pistol, buckshot, etc
		loot = {
			--{"ammo_338", 1},
			{"ammo_45acp", 3},
			--{"ammo_45acp_large", 1},
			--{"ammo_45acp_hp", 1},
			--{"ammo_45acp_ap", 1},
			{"ammo_buckshot", 2},
			{"ammo_slug", 1}, 
			--{"generic_mag", 3}, 
			--{"ammo_dragon", 1},
			--{"ammo_frag", 1},
			--[[{"ammo_545", 1},
			{"ammo_545_large", 1},
			{"ammo_545_ap", 1},
			{"ammo_545_hp", 1},
			{"ammo_556", 1},
			{"ammo_556_large", 1},
			{"ammo_556_ap", 1},
			{"ammo_556_hp", 1},
			{"ammo_762x39", 1},
			{"ammo_762x39_large", 1},
			{"ammo_762x39_ap", 1},
			{"ammo_762x39_hp", 1},
			{"ammo_762x54", 1},
			{"ammo_762x54_ap", 1},
			{"ammo_762x54_hp", 1},]]
			{"ammo_9x19", 3},
			{"ammo_9x18", 4},
			{"ammo_762x54", 1},
			--{"ammo_9x19_large", 1},
			--{"ammo_9x19_hp", 1},
			--{"ammo_9x19_ap", 1},
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["rare_ammo"] = { --other rarer ammo
		loot = {
			--{"ammo_338", 1},
			--{"generic_mag", 5}, 
			{"ammo_45acp", 5},
			--{"ammo_45acp_large", 1},
			--{"ammo_45acp_hp", 1},
			--{"ammo_45acp_ap", 1},
			{"ammo_buckshot", 5},
			--{"ammo_slug", 2}, 
			--{"ammo_dragon", 1},
			--{"ammo_frag", 1},
			{"ammo_545", 2},
			--{"ammo_545_large", 1},
			--{"ammo_545_ap", 1},
			--{"ammo_545_hp", 1},
			{"ammo_556", 1},
			--{"ammo_556_large", 1},
			--{"ammo_556_ap", 1},
			--{"ammo_556_hp", 1},
			{"ammo_762x39", 2},
			--{"ammo_762x39_large", 1},
			--{"ammo_762x39_ap", 1},
			--{"ammo_762x39_hp", 1},
			{"ammo_762x54", 2},
			--{"ammo_762x54_ap", 1},
			--{"ammo_762x54_hp", 1},
			{"ammo_9x19", 5},
			--{"ammo_9x19_large", 1},
			--{"ammo_9x19_hp", 1},
			{"ammo_9x18", 4},
			--{"ammo_9x19_ap", 1},
			
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["rare_meds"] = {
		loot = {
			
			{"medkit", 4},
			{"meds_stim1", 3},
			{"meds_bandage", 5},
			{"meds_painkillers", 3},
			{"meds_antirad", 2},
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["epic_meds"] = {
		loot = {
			
			{"medkit", 5},
			{"medkit2", 4},
			{"meds_stim1", 3},
			{"meds_stim2", 2},
			{"meds_painkillers", 3},
			{"meds_antibiotics", 2},
			{"meds_antirad", 2},
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["rare_wep"] = { --pistols, etc more common stuff
		loot = {
		--	{"wep_ak74", 1},
		--	{"wep_akm", 1},
		--	{"wep_aks", 1},
		--	{"wep_glock", 4},
		--	{"wep_usp", 2},
		--	{"wep_usp9", 3},
		--	{"wep_uspm", 1},
		--	{"wep_izh", 3},
		--	{"wep_izhsawn", 5},
			{"cwep_m1911", 3},
		--	{"wep_m590", 1},
			{"cwep_m9", 4},
		--	{"wep_mp5", 1},
		--	{"wep_mp5k", 1},
		--	{"wep_mp5sd", 1},
			{"cwep_cz75", 6},
		--	{"wep_mosin", 1},
		--	{"wep_knw", 2},
			{"cwep_p226", 4},
		--	{"wep_sks", 1},
		},
		durability = {40, 65}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["rare_atts"] = { --some atts
		loot = {
			{"go_supp_ssq", 4},
			--{"ins2_br_supp_545", 1},
			--{"ins2_br_supp_556", 1},
			--{"ins2_br_supp_762x39", 1},
			--{"ins2_br_supp_762x54", 1},
			{"go_supp_osprey", 6},
			--{"ins2_br_supp_9x18", 2},
			{"go_optic_lp_t1", 1},
			{"go_optic_lp_rmr", 1},
			--{"ins2_si_2xrds", 1},
			{"go_optic_t1", 1},
			{"go_optic_eotech", 1},
			{"go_optic_kobra", 1},
			{"go_optic_compm4", 1},
			{"go_optic_cmore", 1},
			{"go_optic_barska", 1},
			{"go_foregrip_stubby", 1},
			{"go_foregrip_ergo", 1},
			{"go_foregrip_angled", 1},
			{"go_flashlight", 7},
			{"go_laser", 5},
			
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["epic_wep"] = { --rarer weps
		loot = {
		--	{"wep_ak74", 1},
		--	{"wep_akm", 1},
		--	{"wep_aks", 1},
			{"cwep_g17", 2},
			{"cwep_g26", 2},
			{"cwep_usp", 1},
			{"cwep_usp9", 2},
		--	{"wep_uspm", 1},
		--	{"wep_izh", 3},
		--	{"wep_izhsawn", 3},
			{"cwep_m1911", 2},
		--	{"wep_m590", 1},
			{"cwep_m9", 4},
		--	{"wep_mp5", 2},
		--	{"wep_mp5k", 4},
		--	{"wep_mp5sd", 1},
			{"cwep_cz75", 5},
		--	{"wep_mosin", 2},
			{"cwep_g21", 1},
			{"cwep_g30", 2},
			{"cwep_p226", 3},
		--	{"wep_sks", 1},
			
		},
		durability = {35, 60}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["epic_atts"] = { --all atts
		loot = {
			{"go_supp_ssq", 2},
			{"go_supp_tgpa", 1},
			{"go_supp_nt4", 1},
			{"go_supp_rotor43", 1},
			{"go_supp_pbs4", 1},
			{"go_supp_osprey", 2},
			{"go_supp_pbs1", 2},
			{"go_supp_osprey", 6},
			{"go_optic_lp_t1", 1},
			{"go_optic_lp_rmr", 1},
			--{"ins2_si_2xrds", 1},
			{"go_optic_t1", 2},
			{"go_optic_eotech", 2},
			{"go_optic_kobra", 2},
			{"go_optic_compm4", 2},
			{"go_optic_cmore", 2},
			{"go_optic_barska", 2},
			{"mifl_fas2_optic_lmk4", 1},
			{"go_optic_schmidt", 1},
			{"mifl_fas2_optic_pso1", 1},
			{"go_optic_hamr", 1},
			{"go_foregrip_stubby", 2},
			{"go_foregrip_ergo", 2},
			{"go_foregrip_angled", 2},
			{"go_fore_bipod", 1},
			{"go_stock_moe", 2},
			{"go_stock_ergo", 2},
			{"go_stock_contractor", 2},
			{"go_stock_basilisk", 2},
			{"go_flashlight", 4},
			{"go_flashlight_combo", 2},
			{"go_laser", 5},
			
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["legend_wep"] = { --super rare weps
		loot = {
				{"cwep_ak74", 1},
				{"cwep_akm", 1},
				{"cwep_aks74", 2},
				{"cwep_aks74u", 3},
			--	{"wep_glock", 3},
			--	{"wep_usp", 1},
			--	{"wep_usp9", 2},
				{"cwep_uspm", 5},
			--	{"wep_izh", 3},
			--	{"wep_izhsawn", 3},
			--	{"wep_m1911", 2},
				{"cwep_870", 4},
			--	{"wep_m9", 4},
				{"cwep_mp5", 6},
			--	{"wep_mp5k", 4},
				{"cwep_mp5sd", 3},
			--	{"wep_mp443", 5},
				{"cwep_mosin", 6},
			--	{"wep_knw", 2},
			--	{"wep_p226", 3},
				{"cwep_sks", 7},
			
		},
		durability = {25, 55}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	--dumpsters, trash cans, slum areas, rare melee?
	["trash"] = {
		istableloot = true,
		loot = {
			{"none",15},
			["common_eft"] = 3,
			["uncommon_eft"] = 1,
			{"common_junk",4},
			{"common_food",3},
			{"uncomm_junk",1},
			{"rare_meds",2},
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["trashrare"] = {
		istableloot = true,
		loot = {
			{"none",24},
			["common_eft"] = 6,
			["uncommon_eft"] = 3,
			{"common_junk",6},
			{"common_food",4},
			{"uncomm_junk",4},
			{"uncomm_ammo",4},
			{"rare_ammo",2},
			{"rare_meds",6},
		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["tier1"] = {
		istableloot = true,
		loot = {
			{"none",24},
			["uncommon_eft"] = 6,
			["rare_eft"] = 1,
			{"uncomm_junk",5},
			{"uncomm_ammo",7},
			{"rare_ammo",4},
			{"rare_wep",2},
			--{"rare_atts",1},
			{"rare_meds",5},
		},
		durability = {40, 65}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["tier2"] = {
		istableloot = true,
		loot = {
			{"none",23},
			["uncommon_eft"] = 6,
			["rare_eft"] = 2,
			{"rare_ammo",7},
			{"rare_wep",2},
			{"rare_atts",1},
			{"rare_meds",4},
			{"epic_wep",1},
		},
		durability = {35, 65}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["tier3"] = { --expert only
		istableloot = true,
		loot = {
			{"none",19},
			["rare_eft"] = 3,
			{"rare_ammo",6},
			{"epic_atts",1},
			{"epic_meds",3},
			{"epic_wep",3},
			{"legend_wep",1},
		},
		durability = {20, 50}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	
	--[[
	["anom_grav1"] = { --junk, melee, misc stuff
		loot = {
			

		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["anom_grav2"] = { --junk, melee, misc stuff
		loot = {
			

		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["anom_fire1"] = { --junk, melee, misc stuff
		loot = {
			

		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["anom_fire2"] = { --junk, melee, misc stuff
		loot = {
			

		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["anom_elec1"] = { --junk, melee, misc stuff
		loot = {
			

		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["anom_elec2"] = { --junk, melee, misc stuff
		loot = {
			

		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	["anom_chem2"] = { --junk, melee, misc stuff
		loot = {
			

		},
		durability = {100, 100}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0,
	},
	]]
}

PLUGIN.dropTables = {
	--[[
	["npc_class"] = {
		loot = {
			{"id", 1},
			{"none", 1}
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	]]
	["npc_vj_srp_anorak_rogue"] = {
		loot = {
			{"ammo_45acp", 3},
			{"ammo_9x19", 3},
			{"ammo_9x18", 2},
			{"ammo_buckshot", 2},
			{"meds_bandage", 3},
			{"medkit", 5},
			{"meds_painkillers", 1},
			--{"generic_mag", 1}, 
			{"patch_bandit", 10}, 
			{"none", 20},
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},

	["npc_vj_srp_m_boar"] = {
		loot = {
			{"hide_boar", 5},
			{"part_boar", 5},
			{"food_meat_boar", 5},
			{"none", 10},
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_flesh"] = {
		loot = {
			{"hide_flesh", 5},
			{"part_flesh", 5},
			{"food_meat_flesh", 5},
			{"none", 10},
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_rat"] = {
		loot = {
			{"part_rat", 5},
			{"food_meat_rat", 5},
			{"none", 5},
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_zombie"] = {
		loot = {
			{"part_zombie", 5},
			{"ammo_45acp", 2},
			{"ammo_9x19", 2},
			{"ammo_9x18", 2},
			{"ammo_buckshot", 1},
			{"none", 5},
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_bloodsucker"] = {
		loot = {
			{"hide_bloodsucker", 5},
			{"part_bloodsucker", 5},
			{"food_meat_bloodsucker", 5},
			{"none", 10},
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_dog"] = {
		loot = {
			{"part_dog", 5},
			{"food_meat_dog", 5},
			{"none", 5},
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_pseudodog"] = {
		loot = {
			{"hide_pseudodog", 5},
			{"food_meat_pseudodog", 5},
			{"part_pseudofang", 5},
			{"part_pseudotail", 5},
			{"none", 5},
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_psydog"] = {
		loot = {
			{"hide_psydog", 5},
			{"food_meat_pseudodog", 5},
			{"part_pseudofang", 5},
			{"part_pseudotail", 5},
			{"part_controller_brain", 3},
			{"none", 5},
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_snork"] = {
		loot = {
			{"part_snork_leg", 5},
			{"part_snork_mask", 5},
			{"food_meat_snork", 5},
			{"none", 10},
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
}

--config (should move this to the actual config but this works for now)
PLUGIN.maxItems = 40			--this V is not correct anymore
PLUGIN.spawnRate = {5400,9600}--a little over 2 hr to a little under 4 hr, seems like a little too much for me but eh{4800,7200} --1 hr to 2 hr until next spawn
PLUGIN.maxSpawnThresh = 0.5 --if its time for next spawn, and #curItems/maxItems > maxSpawnThresh, items will not be spawned this round
PLUGIN.minplayers = 3

PLUGIN.curSpawnRate = PLUGIN.curSpawnRate or 0
PLUGIN.curSpawnTime = PLUGIN.curSpawnTime or 0
PLUGIN.curItems = PLUGIN.curItems or {} --current items, when one is made its inserted into this with the index being the point it was spawned at
PLUGIN.spawnPos = PLUGIN.spawnPos or {} --spawn positions
--[[ spawnPos table def
{
	pos = vector (the position of the point)
	detectionRange = number (if a player is in the range of this, its removed from the list for spawning then)
	table = string (the tableid of this spawnPos)
}
]]

--nut.util.include("sh_director.lua")
nut.util.include("sh_commands.lua")
nut.util.include("sh_scenes.lua")
--nut.util.include("sh_tempstorage.lua")

--returns true if there is a player not in noclip/observer near the point, 
--p is the point index
--yes its intentional that neardeath players makes it return false
function PLUGIN:IsPointClear(p)
	local point = self.spawnPos[p]

	if(point) then
		local lis = ents.FindInSphere(point.pos, point.detectionRange)
		for k, v in pairs(lis) do
			if(v:IsPlayer() and v:GetMoveType() != MOVETYPE_NOCLIP) then
				return false
			end
		end
	end
	return true
end

--will create a new spawn point and add it to the table
--pos is the position of the point
--range is the detection range, if there are players in this range when it is checked nothing will be spawned
--table is the tableid to use for spawning
function PLUGIN:CreateSpawn(pos, range, tabl)
	local new = {}
	new.pos = pos
	new.detectionRange = range
	if(!self.lootTables[tabl]) then
		nut.log.addRaw("A loot spawn point tried to be made, but the table wasnt valid!")
		return
	end
	new.table = tabl

	table.insert(self.spawnPos, new)

	self:SaveData()
end

--this *might* be outdated if loot gets updated at runtime
local realB = {}
for k,v in pairs(PLUGIN.lootTables) do
	realB[k] = {}
	for k2, v2 in pairs(v.loot) do
		for i=1, v2[2] do
			table.insert(realB[k], v2[1])
		end
	end
end
--todo: use a table and call this function with printtable to true
	--if the table is indexed by numbers, can change it to x[math.random(#x)] yakno
function PLUGIN:SpawnAtPos(tabl, pos, callback, printtable)

	local actualPos = pos + Vector(0,0,28) --make it a little higher
	
	local it = "none"
	if(type(tabl) != "table") then
		if(!realB[tabl]) then
			print("table for "..tabl.." doesnt exist")
			return
		end

		it = table.Random(realB[tabl]) 
	else
		it = tabl[math.random(#tabl)]
	end
	if(it == "none") then return end --dont spawn anything

	if(type(tabl) == "table" and tabl.istableloot) then --doing it again lmao
		it = table.Random(realB[it])
	elseif(type(tabl) == "string" and self.lootTables[tabl].istableloot) then
		if(printtable) then
		PrintTable(realB[it])
		end
		it = table.Random(realB[it])
	end

	local item = nut.item.get(it)
	if(!item) then return end --invalid item
	
	local data = {}
	local durabilityMin, durabilityMax = self.lootTables[tabl].durability[1], self.lootTables[tabl].durability[2]
	-- random mag amt if ammo, random durability if wep
	if(item.base == "base_mweapons") then
		data["durability"] = math.random(durabilityMin, durabilityMax)

		local maxclip = weapons.GetStored(item.class).Primary.ClipSize
		if(self.lootTables[tabl].randomAmmo != 2) then
			data["ammo"] = math.random(0, maxclip)
		else
			data["ammo"] = maxclip
		end

		--randomize atts randomly?

	end
	if(item.base == "base_suit") then
		data["armor"] = {}
		if(item.armor) then
		for k,v in pairs(item.armor) do
			data["armor"][k] = v
			data["armor"][k].durability = math.random(durabilityMin, durabilityMax)
		end
		end
	end
	if(item.base == "base_magazines") then
		if(self.lootTables[tabl].randomAmmo != 2) then
			if(self.lootTables[tabl].randomAmmo == 1) then
				if(!item.ammoBox) then
					data["mag"] = math.random(0, item.ammoMax)
				end
			else
				data["mag"] = math.random((item.ammoBox and 1) or 0, item.ammoMax)
			end
		end
	end
	--random uses left
	if(item.uses) then
		if(self.lootTables[tabl].randomAmmo != 2) then
			data["uses"] = math.random(1, item.uses)
		end
	end
	if(item.base == "base_credstick") then
		if(self.lootTables[tabl].randomAmmo <= 1) then --random money just like loot
			data["money"] = math.random(0, item.moneymax)
		else
			data["money"] = item.moneymax
		end
	end

	nut.item.spawn(it, actualPos, callback, Angle(0, math.random(-180, 180), 0), data)
end

--spawn a round of loot
--will not try to spawn loot at points that have players near them
function PLUGIN:SpawnRound()
	if(!self.spawnPos) then self.spawnPos = {} end
	if(#self.spawnPos == 0) then return end

	--[[
	local realL = {}
	for k,v in pairs(self.lootTables) do
		realL[k] = {}
		for k2, v2 in pairs(v.loot) do
			for i=1, v2[2] do
				table.insert(realL[k], v2[1])
			end
		end
	end
	]]

	for k,v in pairs(self.spawnPos) do
		--changing it so items will get replaced
		if(IsValid(self.curItems[k])) then continue end --dont do anything if theres an item
		if(self:IsPointClear(k)) then 
			if(#self.curItems == self.maxItems) then return end
			if(!realB[v.table]) then --trying to change this to the 1 that is made earlier
				nut.log.addRaw("Loot spawn position "..k.." was deleted: The table it used is invalid now!", FLAG_WARNING)
				table.remove(self.spawnPos, k)
				self:SaveData()
				return
			end

			local actualPos = v.pos + Vector(0,0,28) --make it a little higher

			local it = table.Random(realB[v.table])
			if(it == "none") then continue end --dont spawn anything

			--if(IsValid(self.curItems[k])) then self.curItems[k]:Remove() end --remove the item if its there for another
			
			--this is a table value, get the real one
			if(self.lootTables[v.table].istableloot) then
				it = table.Random(realB[it])
			end

			local item = nut.item.get(it)
			if(!item) then continue end --invalid item
			
			local data = {}
			local durabilityMin, durabilityMax = self.lootTables[v.table].durability[1], self.lootTables[v.table].durability[2]
			-- random mag amt if ammo, random durability if wep
			if(item.base == "base_mweapons") then
				data["durability"] = math.random(durabilityMin, durabilityMax)

				local maxclip = weapons.GetStored(item.class).Primary.ClipSize
				if(self.lootTables[v.table].randomAmmo != 2) then
					data["ammo"] = math.random(0, maxclip)
				else
					data["ammo"] = maxclip
				end

				--randomize atts randomly?

			end
			if(item.base == "base_suit") then
				data["armor"] = {}
				if(item.armor) then
				for k,v in pairs(item.armor) do
					data["armor"][k] = v
					data["armor"][k].durability = math.random(durabilityMin, durabilityMax)
				end
				end
			end
			if(item.base == "base_magazines") then
				if(self.lootTables[v.table].randomAmmo != 2) then
					if(self.lootTables[v.table].randomAmmo == 1) then
						if(!item.ammoBox) then
							data["mag"] = math.random(0, item.ammoMax)
						end
					else
						data["mag"] = math.random((item.ammoBox and 1) or 0, item.ammoMax)
					end
				end
			end
			if(item.base == "base_credstick") then
				if(self.lootTables[v.table].randomAmmo <= 1) then --random money just like loot
					data["money"] = math.random(0, item.moneymax)
				else
					data["money"] = item.moneymax
				end
			end

			nut.item.spawn(it, actualPos, function(item, entity)
				self.curItems[k] = entity 

				--hard overwrite becuz its being annoying
				--its likely never going to be above 1 anyway
				if(item.base == "base_junk") then
					item:setQuantity(1)
				end
				if(item.base == "base_ammo") then
					if(PLUGIN.dropTables[class].randomAmmo != 2) then
						--~33% chance to be max
						if(math.random(0, 2) != 0) then 
							item:setQuantity(math.random(1, item.maxQuantity))
						end
					end
				end

				local ent = entity
				timer.Simple(10800, function()
					if(IsValid(ent)) then
						ent:Remove()
					end
				end)

					
				entity.temp = true
			end, Angle(0, math.random(-180,180), 0), data)
		end
	end
end

if(SERVER) then
	hook.Add("ShutDown", "removeitems", function()
		
	for k, v in ipairs(ents.FindByClass("nut_item")) do
		if (v.nutItemID and v.temp) then --will this work?
			local item = nut.item.instances[v.nutItemID]
			if(item) then
				item:remove()
			end
		end
	end
	end)

	--hook.Add("InitPostEntity", "pleaserunmyinit", function()
	--function PLUGIN:OnLoaded()
	hook.Add("InitializedPlugins", "pleaserunmyinit", function()
		if(timer.Exists("LootSpawningT")) then return end
		timer.Simple(10, function()
			PLUGIN:SpawnRound() --spawn an initial round of items       
		end)
		PLUGIN.curSpawnRate = math.random(PLUGIN.spawnRate[1], PLUGIN.spawnRate[2])
		timer.Create("LootSpawningT", 1, 0, function()
			if(player.GetCount() <= PLUGIN.minplayers) then return end --we dont want stuff to spawn while there is no players
			if(PLUGIN.curSpawnRate > PLUGIN.curSpawnTime) then
				PLUGIN.curSpawnTime = PLUGIN.curSpawnTime + 1 --idk if += or ++ are things in lua still lol
				return --its not time yet
			end
			PLUGIN.curSpawnTime = 0
			PLUGIN.curSpawnRate = math.random(PLUGIN.spawnRate[1], PLUGIN.spawnRate[2])

			--i just almost made this mistake before i caught myself so reminder: 
			--curItems is a table, maxItems is a number
			realItems = {}
			for k,v in pairs(PLUGIN.curItems) do
				if(IsValid(v)) then
					table.insert(realItems, v)
				end
			end

			if((#realItems/PLUGIN.maxItems) > PLUGIN.maxSpawnThresh) then return end --theres still a majority of items left

			PLUGIN:SpawnRound() --do eeeet
		end)
	end)--)
	local realDropTab = {}
	for k,v in pairs(PLUGIN.dropTables) do
		realDropTab[k] = {}
		for k2, v2 in pairs(v.loot) do
			for i=1, v2[2] do
				table.insert(realDropTab[k], v2[1])
			end
		end
	end

	hook.Add("OnNPCKilled", "dropstuff", function(npc, atk, inf)
		local class = npc:GetClass()
		if(PLUGIN.dropTables[class]) then
			local pos = npc:GetPos() + Vector(0,0,28)
			local it = table.Random(realDropTab[class])

			if(it == "none") then return end
			local item = nut.item.get(it)
			if(!item) then return end

			local data = {}
			local durabilityMin, durabilityMax = PLUGIN.dropTables[class].durability[1], PLUGIN.dropTables[class].durability[2]
			-- random mag amt if ammo, random durability if wep
			if(item.base == "base_mweapons") then
				data["durability"] = math.random(durabilityMin, durabilityMax)
			end
			if(item.base == "base_suit") then
				data["armor"] = {}
				for k,v in pairs(item.armor) do
					data["armor"][k] = v
					data["armor"][k].durability = math.random(durabilityMin, durabilityMax)
				end
			end
			if(item.base == "base_magazines") then
				if(PLUGIN.dropTables[class].randomAmmo != 2) then
					if(PLUGIN.dropTables[class].randomAmmo == 1) then
						if(!item.ammoBox) then
							data["mag"] = math.random(0, item.ammoMax)
						end
					else
						data["mag"] = math.random((item.ammoBox and 1) or 0, item.ammoMax)
					end
				end
			end

			nut.item.spawn(it, pos, function(item, entity)
				entity.temp = true
				--hard overwrite becuz its being annoying
				--its likely never going to be above 1 anyway
				if(item.base == "base_junk") then
					item:setQuantity(1)
				end
				if(item.base == "base_ammo") then
					if(PLUGIN.dropTables[class].randomAmmo != 2) then
						--~33% chance to be max
						if(math.random(0, 2) != 0) then 
							item:setQuantity(math.random(1, item.maxQuantity))
						end
					end
				end
				--remove after hour
				timer.Simple(1800, function()
					if(IsValid(entity)) then
						entity:Remove()
					end
				end)
			end, nil, data)
		end
	end)

	function PLUGIN:LoadData()
		if(!self.spawnPos or #self.spawnPos == 0) then
			local data = self:getData() or {scenes = {}, spawns = {}}
			self.spawnPos = data.spawns
			self.scenePos = data.scenes
		end
	end

	function PLUGIN:SaveData()
		self:setData({spawns = self.spawnPos, scenes = self.scenePos})
	end
	util.AddNetworkString("RecLotPoints")
else --client
	local localSpawns = {}
	
	net.Receive("RecLotPoints", function()
		local points = net.ReadTable()
		local time = net.ReadInt(32)
	
		localSpawns = points
	
		timer.Simple(time, function()
			localSpawns = {}
		end)
	end)
	
	function PLUGIN:HUDPaint()
		local client = LocalPlayer()

		local sx, sy = surface.ScreenWidth(), surface.ScreenHeight()
		for type,table in pairs(localSpawns) do
			for k, v in ipairs(localSpawns[type]) do
				local scrPos = v:ToScreen()
				local marginx, marginy = sy*.1, sy*.1
				local x, y = math.Clamp(scrPos.x, marginx, sx - marginx), math.Clamp(scrPos.y, marginy, sy - marginy)
				local distance = client:GetPos():Distance(v)
				local factor = 1 - math.Clamp(distance/1024, 0, 1)
				local size = math.max(10, 32*factor)
				local alpha = math.Clamp(255*factor, 80, 255)

				surface.SetDrawColor(80, 30, 80, alpha)
				surface.DrawRect(x - size/2, y - size/2, size, size)
				local typ = "point"
				if(type == "s") then
					typ = "scene"
				end

				nut.util.drawText(typ.." - id: "..k, x, y-size, ColorAlpha(Color(220,220,220,255),alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
			end
		end
	end
end