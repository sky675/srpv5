local PLUGIN = PLUGIN

--do here batching edits to weapons
local weaponEdits = {
	--[[
	["class"] = {
		--changing values on the swep itself
		mods = {
		}, 
		--values in the primary table to change (ammo, clipsize)
		primarymods = {
		},
		modatts = {
			--[slotname] = {Slot = "tac"}
		}
	},
	]]
	["arccw_go_870"] = {
		mods = {
			TwoHandedWep =true,
			Type = "shotgun", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
		}
	},
	["arccw_go_nova"] = {
		mods = {
			TwoHandedWep =true,
			Type = "shotgun", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
		}
	},
	["arccw_go_m1014"] = {
		mods = {
			TwoHandedWep =true,
			Type = "shotgun", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
		}
	},
	["arccw_go_mag7"] = {
		mods = {
			TwoHandedWep =true,
			Type = "shotgun", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
		}
	},
	["arccw_go_870"] = {
		mods = {
			TwoHandedWep =true,
			Type = "shotgun", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
		}
	},
	["arccw_go_glock"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
			Ammo = "sky9x19"
		}
	},
	["arccw_go_m9"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
			Ammo = "sky9x19"
		}
	},
	["arccw_go_usp"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
			Ammo = "sky45"
		}
	},
	["arccw_go_cz75"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
			Ammo = "sky9x19"
		}
	},
	["arccw_go_p2000"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
			Ammo = "sky9x19"
		}
	},
	["arccw_go_deagle"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
			Ammo = "sky50ae"
		}
	},
	["arccw_go_tec9"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky9x19"
		}
	},
	["arccw_go_fiveseven"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
			Ammo = "sky57"
		}
	},
	["arccw_go_mp5"] = {
		mods = {
			Type = "smg", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky9x19"
		}
	},
	["arccw_go_bizon"] = {
		mods = {
			Type = "smg", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky9x18"
		}
	},
	["arccw_go_ump"] = {
		mods = {
			Type = "smg", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky45"
		}
	},
	["arccw_go_mac10"] = {
		mods = {
			Type = "smg", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky45"
		}
	},
	["arccw_go_mp9"] = {
		mods = {
			Type = "smg", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky9x19"
		}
	},
	["arccw_go_p90"] = {
		mods = {
			Type = "smg", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky57"
		}
	},
	["arccw_go_mp7"] = {
		mods = {
			Type = "smg", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky46"
		}
	},
	["arccw_go_m249"] = {
		mods = {
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky556"
		}
	},
	["arccw_go_negev"] = {
		mods = {
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x51"
		}
	},
	["arccw_go_aug"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			ClipSize = 30, --why is this 36 wtf
			Ammo = "sky556"
		}
	},
	["arccw_go_awp"] = {
		mods = {
			Type = "sniper", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky338"
		}
	},
	["arccw_go_fnfal"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x51"
		}
	},
	["arccw_go_scar"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x51"
		}
	},
	["arccw_go_ace"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky556"
		}
	},
	["arccw_go_galil_ar"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x39"
		}
	},
	["arccw_mifl_fas2_ks23"] = {
		mods = {
			Type = "shotgun", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky23mm"
		},
		--lua_run weapons.GetStored("class").WorldModelOffset.scale = 1
		wmmods = { --modifying WorldModelOffset
			scale = 0.8,
			pos = Vector(-14, 5, -5)
		},
	},
	["arccw_mifl_fas2_m1911"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
			Ammo = "sky45"
		},
	},
	["arccw_mifl_fas2_p226"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
			Ammo = "sky9x19"
		},
		wmmods = { --modifying WorldModelOffset
			scale = 0.9,
			pos = Vector(-15.5, 5.5, -2.5)
		},
	},
	["arccw_mifl_fas2_m24"] = {
		mods = {
			Type = "sniper", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x51"
		},
		wmmods = { --modifying WorldModelOffset
			scale = 0.8,
			pos = Vector(-15, 7, -6)
		},
	},
	["arccw_mifl_fas2_sr25"] = {
		mods = {
			Type = "sniper", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x51"
		},
		wmmods = { --modifying WorldModelOffset
			scale = 0.9,
			pos = Vector(-12, 5, -6)
		},
	},
	["arccw_mifl_fas2_g3"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x51"
		},
		wmmods = { --modifying WorldModelOffset
			scale = 0.8,
			pos = Vector(-12, 5, -5)
		},
	},
	["arccw_mifl_fas2_ak47"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x39"
		},
		wmmods = { --modifying WorldModelOffset
			scale = 0.75,
			pos = Vector(-12.5, 5, -5)
		}
	},
	["arccw_mifl_fas2_rpk"] = {
		mods = {
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x39"
		},
		wmmods = { --modifying WorldModelOffset
			scale = 0.75,
			pos = Vector(-9.5, 4.5, -5)
		}
	},
	["arccw_mifl_fas2_famas"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky556"
		}
	},
	["arccw_mifl_fas2_g36c"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky556"
		},
		wmmods = {
			scale = 0.8,
			pos = Vector(-15, 5.5, -7)
		}
	},
	["arccw_mifl_fas2_sg55x"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky556"
		},
		wmmods = {
			scale = 0.8,
			pos = Vector(-6.5, 4, -6)
		}
	},
	["arccw_mifl_fas2_m4a1"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky556"
		},
		wmmods = {
			scale = 0.75,
			pos = Vector(-11, 4.5, -6)
		}
	},
	["arccw_mifl_fas2_toz34"] = {
		mods = {
			Type = "shotgun", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
		},
		wmmods = {
			scale = 0.7,
			pos = Vector(-4, 5, -7.5)
		}
	},
	["arccw_mifl_fas2_m3"] = {
		mods = {
			Type = "shotgun", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
		},
		wmmods = {
			scale = 0.75,
			pos = Vector(-12, 5.5, -7)
		}
	},
	["arccw_mifl_fas2_ragingbull"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
		},
		wmmods = {
			scale = 0.8,
			pos = Vector(-15.5, 5.5, -5)
		}
	},
	["arccw_mifl_fas2_m79"] = {
		mods = {
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "skym203"
		},
		wmmods = {
			scale = 0.7,
			pos = Vector(-15, 8, -5)
		}
	},
	["arccw_eap_aek"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky545"
		}
	},
	["arccw_eap_groza"] = {
		mods = {
			Type = "ar", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x39"
		}
	},
	["arccw_bo2_browninghp"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
			Ammo = "sky9x19"
		},
		modatts = {
			["tac_pistol"] = {Slot = "tac"},
			["ammo_pap"] = {Slot = "go_ammo"},
			["bo1_perk"] = {Slot = {"go_perk", "go_perk_pistol"}},
		}
	},
	["arccw_waw_doublebarrel"] = {
		mods = {
			Type = "shotgun", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
		},
		modatts = {
			["bo1_tacslot"] = {Slot = "tac"},
			["ammo_pap_sg"] = {Slot = "go_ammo"},
			["bo1_perk"] = {Slot = "go_perk"},
		}
	},
	["arccw_bo1_uzi"] = {
		mods = {
			Type = "smg", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky9x19"
		},
		modatts = {
			["tac_pistol"] = {Slot = {"tac","foregrip"}},
			["ammo_pap"] = {Slot = "go_ammo"},
			["bo1_perk"] = {Slot = "go_perk"},
		}
	},
	["arccw_waw_ppsh41"] = {
		mods = {
			Type = "smg", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x25"
		},
		modatts = {
			["ammo_pap"] = {Slot = "go_ammo"},
			["bo1_perk"] = {Slot = "go_perk"},
		}
	},
	["arccw_bo1_m60"] = {
		mods = {
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x51"
		},
		modatts = {
			["ammo_pap"] = {Slot = "go_ammo"},
			["bo1_perk"] = {Slot = "go_perk"},
		}
	},
	["arccw_temp_makarov"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
			Ammo = "sky9x18"
		}
	},
	["arccw_temp_tt33"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
		}, 
		primarymods = {
			Ammo = "sky762x25"
		}
	},
	["arccw_temp_skorpion"] = {
		mods = {
			Type = "pistol", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky9x18"
		}
	},
	["arccw_temp_mosin"] = {
		mods = {
			Type = "sniper", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x54"
		}
	},
	["arccw_temp_svt"] = {
		mods = {
			Type = "sniper", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x54"
		}
	},
	["arccw_temp_sks"] = {
		mods = {
			Type = "sniper", --pistol, smg, shotgun, ar, sniper
			TwoHandedWep =true,
		}, 
		primarymods = {
			Ammo = "sky762x39"
		}
	},
}
--lua_run PrintTable(ArcCW.AttachmentTable["fillinat"])
local attEdits = {
	--[[
	--name can be determined by looking at att ents names, acwatt_*name*
	["name"] = {
		mods = {
			--notable things:
			Override_Ammo = ""
		}
	},
	]]
	["go_glock_mag_28"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["go_glock_mag_13_45acp"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky45"
		}
	},
	["go_usp_mag_15_9"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["go_usp_mag_25_9"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["go_usp_mag_40_9"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["go_usp_mag_20"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky45"
		}
	},
	["go_usp_mag_30"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky45"
		}
	},
	["go_p250_mag_15_9mm"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["go_p250_mag_24_9mm"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["go_p250_mag_9_45acp"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky45"
		}
	},
	["go_p250_mag_15_45acp"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky45"
		}
	},
	["go_ump_mag_30_9mm"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["go_m249_mag_9_200"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["go_aug_ammo_9mm"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["go_scar_mag_30_556"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky556"
		}
	},
	["go_scar_mag_30"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky762x51"
		}
	},
	["go_ace_mag_30_762"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky762x39"
		}
	},
	["go_ssg08_mag_10_762"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky762x51"
		}
	},
	["mifl_fas2_ak_mag_545"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky545"
		}
	},
	["mifl_fas2_ak_mag_545_45"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky545"
		}
	},
	["mifl_fas2_ak_mag_556"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky556"
		}
	},
	["mifl_fas2_ak_mag_919_30"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["mifl_fas2_ak_mag_919_50"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["mifl_fas2_ak_mag_82"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky762x54"
		}
	},
	["mifl_fas2_ak_mag_939_20"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x39"
		}
	},
	["mifl_fas2_ak_mag_939_40"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x39"
		}
	},
	["mifl_fas2_ak_mag_939_60"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x39"
		}
	},
	["mifl_fas2_ak_mag_20g"] = {
		mods = {
			Override_ClipSize = 5
		}
	},
	["mifl_fas2_famas_mag_9mm_25"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["mifl_fas2_famas_mag_9mm_50"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["mifl_fas2_m24_mag_23mm"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky23mm"
		}
	},
	["mifl_fas2_m4a1_mag_9mm_21"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["mifl_fas2_m4a1_mag_9mm_32"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["mifl_fas2_m4a1_mag_9mm_50"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["mifl_fas2_ubw_m203"] = {
		mods = {
			--notable things:
			Override_Ammo = "skym203"
		}
	},
	["mifl_fas2_ubw_gp25"] = {
		mods = {
			--notable things:
			Override_Ammo = "skygp25"
		}
	},
	["mifl_fas2_ks23_tube_12"] = {
		mods = {
			--notable things:
			Override_Ammo = "buckshot"
		}
	},
	["mifl_fas2_ks23_tube_x_12"] = {
		mods = {
			--notable things:
			Override_Ammo = "buckshot"
		}
	},
	["mifl_fas2_ks23_tube_xx_12"] = {
		mods = {
			--notable things:
			Override_Ammo = "buckshot"
		}
	},
	["eap_aek_mag_762_40"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky762x39"
		}
	},
	["eap_aek_mag_762_40_poly"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky762x39"
		}
	},
	["eap_aek_mag_762_30"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky762x39"
		}
	},
	["eap_aek_mag_762_30_poly"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky762x39"
		}
	},
	["eap_aek_mag_762_pmag30"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky762x39"
		}
	},
	["eap_aek_mag_60"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky545"
		}
	},
	["eap_aek_mag_545_45"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky545"
		}
	},
	["eap_aek_mag_9mm"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x19"
		}
	},
	["eap_aek_mag_556"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky556"
		}
	},
	["eap_groza_mag_40"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky762x39"
		}
	},
	["eap_groza_mag_pmag30"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky762x39"
		}
	},
	["eap_groza_mag_545_60"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky545"
		}
	},
	["eap_groza_mag_556"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky556"
		}
	},
	["eap_groza_mag_545_45"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky545"
		}
	},
	["eap_groza_mag_545"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x39"
		}
	},
	["eap_groza_mag_939_20"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x39"
		}
	},
	["eap_groza_mag_939_30"] = {
		mods = {
			--notable things:
			Override_Ammo = "sky9x39"
		}
	},
	["bo1_dbs_barrel_sawnoff"] = {
		mods = {
			Override_AmmoPerShot = 1
		}
	},
	["go_ammo_tmj"] = {
		mods = {
			SpecAmmo = "ap"
		}
	},
	["go_ammo_jhp"] = {
		mods = {
			SpecAmmo = "jhp"
		}
	},
	["go_ammo_sg_slug"] = {
		mods = {
			SpecAmmo = "slug"
		}
	},
	["go_ammo_sg_flechette"] = {
		mods = {
			SpecAmmo = "flechette"
		}
	},
	["eap_ammo_dragon"] = {
		mods = {
			SpecAmmo = "dragonsbreath"
		}
	},
	["go_ammo_sg_sabot"] = {
		mods = {
			SpecAmmo = "sabot"
		}
	},
}

local function PatchWeapon(weapon, name)
	//weapon.Base = "sky_mag_base_ins2" --hopefully this works?
	local tochange = weaponEdits[name] --easier
	for k,v in pairs(tochange.mods or {}) do
		weapon[k] = v
	end
	for k,v in pairs(tochange.primarymods or {}) do
		weapon.Primary[k] = v
	end
	for k,v in pairs(tochange.wmmods or {}) do
		weapon.WorldModelOffset[k] = v
	end
	if(!tochange.modatts) then return end --small opt
	local slotids = {}
	for key, value in ipairs(weapon.Attachments) do
		if(istable(value.Slot)) then
			for _, s in ipairs(value.Slot) do
				slotids[s] = key
			end
		else
			slotids[value.Slot] = key
		end
	end
	for k,v in pairs(tochange.modatts or {}) do
		local num = slotids[k]
		if(!num) then continue end
		for l,m in pairs(v) do
			weapon.Attachments[num][l] = m
		end
	end
end
local function PatchAttachment(att, name)
	local tochange = attEdits[name]
	for k,v in pairs(tochange.mods or {}) do
		att[k] = v
	end
end

hook.Add("InitPostEntity", "arcweps_patch", function()
    local wepTable = weapons.GetList()
    for k,v in pairs(wepTable) do
        if(weaponEdits[v.ClassName]) then
			local wep = weapons.GetStored(v.ClassName or "")
			if(wep) then
				PatchWeapon(wep, v.ClassName)
			end
        end
    end
end)
hook.Add("ArcCW_OnAttLoad", "arcatts_patch", function(v)
	--for k,v in pairs(ArcCW.AttachmentTable) do
	local k = v.ShortName
	if(attEdits[k]) then
		PatchAttachment(v, k)
	end
	--end
end)