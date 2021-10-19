local PLUGIN = PLUGIN

--todo:
--add sizes to armors
--implement suit durability modifier

--[[item data structure:
	ex = { extra slots to use when checking max, added when applying
		[slot] = additionalnum,
	},
	slot = {
		[slot] = curnum,
	}
	upgrades = {
		[id] = true,
	}
]]
local slotMaxes = {
	--helm, light, medium, heavy, exo, mask, vest, sci, seva
	["helm"] = {
		["mask"] = 1, --num allowed
		["core"] = 1, --3 upgrades, either allows more mask slots or an eyes slot or an armor slot
	},
	["mask"] = {
		["mask"] = 1,
		["core"] = 1, --2 upgrades, more mask slot or eyes slot
	},
	["vest"] = {
		["chest"] = 1,
		["lining"] = 1,
		["core"] = 1,--another lining, weight decrease and/or artifact max increase
	},
	["vestl"] = {
		["chest"] = 1,
		["lining"] = 1,
		["core"] = 1,--another lining, weight decrease and/or artifact max increase
	},
	["light"] = {
		["chest"] = 1,
		["lining"] = 1,
		["core"] = 2, --another lining, weight decrease (possibly artifact max increase too, or as separate?), or additional chest slot for better armor
	},
	["medium"] = {
		["chest"] = 1,
		["lining"] = 2,
		["core"] = 3,--another lining, weight decrease (possibly artifact max increase too, or as separate?), stm increase, or additional chest slot for better armor
	},
	["gorka"] = {
		["chest"] = 1,
		["lining"] = 3,
		["core"] = 4,--another lining, weight decrease (possibly artifact max increase too, or as separate?), stm increase, or additional chest slot for better armor
	},
	["heavy"] = {
		["chest"] = 3,
		["lining"] = 2,
		["core"] = 2,--same as above
	},
	["exo"] = {
		["chest"] = 3,
		["lining"] = 2,
		["core"] = 3,--same as above but also with nospr removal
	},
	["sci"] = {
		["chest"] = 1,
		["lining"] = 3,
		["core"] = 2,--another lining, weight decrease, artifact max increase, stm increase
	},
	["seva"] = {
		["chest"] = 2,
		["lining"] = 3,
		["core"] = 3,--another lining, weight decrease, artifact max increase, stm increase
	},
}
local slotShow = {
	["chest"] = "Armor",
	["lining"] = "Lining",
	["core"] = "Infrastructure",
	["helm"] = "Armor",
	["eyes"] = "Visor",
	["mask"] = "Mask",

}


local upgrades = {
	--[[
	["id"] = {
		name = "display name",
		--item variables
		desc = "desc for item",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 0, --price for item
		width = 2,
		height = 1,
		weight = 0.1,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "slotname",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["armor"] = true,
			["sizesallowed"] = true,
		},
		--extra slots add
		slotadd = { --optional slots add, comment if not adding new slots
			["slot"] = 1,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_BULLET] = 0.1,
			[DMG_BULLET.."-m"] = 1.1,
		},
		levels = { --optional overwrite an armor level
			chest = {level = ARMOR_IV},
		},
		additionalArtifact = 1, --optional adds onto artifact slot space
		itemWeightMod = 0.9, --optional multiplier to modify item weight
		maxWeightMod = 1.1, --optional multiplier to modify max weight
		duraMod = 1.1, --unused, optional multiplier to modify durability loss (more == lose more)
	},]]
	--masks, rad, chem, psy, stm, burn
	["mask_stm"] = {
		name = "Steam purification and respiration filters",
		--item variables
		desc = "A set of filters used in contaminated air or critical air temperature conditions. It increases the wearer's stamina.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 16000, --price for item
		width = 2,
		height = 1,
		weight = 0.8,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "mask",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["helm"] = true,
			["mask"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			["stmres"] = 1.4,
		},
		itemWeightMod = 1.15, --optional multiplier to modify item weight
	},
	["mask_psy"] = {
		name = "Psy-Dome band",
		--item variables
		desc = "A high-tech psy-protection that was supposedly invented by a scientist called Sakharov.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 12000, --price for item
		width = 2,
		height = 1,
		weight = 1.4,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "mask",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["helm"] = true,
			["mask"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_SONIC.."-m"] = 1.25,
			["psy-m"] = 1.25
		},
		itemWeightMod = 1.1, --optional multiplier to modify item weight
	},
	["mask_rad"] = {
		name = "Plexiglass coating",
		--item variables
		desc = "A coat of plexiglass that can provide partial protection from radiation.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 10200, --price for item
		width = 2,
		height = 1,
		weight = 0.7,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "mask",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["helm"] = true,
			["mask"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_RADIATION.."-m"] = 1.5,
		},
		itemWeightMod = 1.13, --optional multiplier to modify item weight
	},
	["mask_chem"] = {
		name = "Filter for work in contaminated areas",
		--item variables
		desc = "A filter with a reinforced anti-corrosive coating with an additional preventative layer for removal of poisons. Adds chemical resistance.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 10400, --price for item
		width = 2,
		height = 1,
		weight = 0.7,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "mask",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["helm"] = true,
			["mask"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_ACID.."-m"] = 1.3,
		},
		itemWeightMod = 1.1, --optional multiplier to modify item weight
	},
	--eyes
	["eyes_nv"] = {
		name = "Integrated nightvision",
		--item variables
		desc = "A nightvision device. Can be used via /togglenightvision.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 30000, --price for item
		width = 2,
		height = 1,
		weight = 1.4,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "eyes",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["helm"] = true,
			["mask"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			["nv"] = 1,
		},
		itemWeightMod = 1.25, --optional multiplier to modify item weight
	},
	--linings, exp
	["lining_burnexp"] = {
		name = "Fire-resistant lining with nickel inserts",
		--item variables
		desc = "Nickel is sufficiently fire-resistant to be used for body armor inserts.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 15200, --price for item
		width = 2,
		height = 1,
		weight = 2,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 3, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_BURN.."-m"] = 1.55,
		},
		itemWeightMod = 1.07, --optional multiplier to modify item weight
	},
	["lining_radexp"] = {
		name = "Plexiglass inner lining",
		--item variables
		desc = "Plexiglass absorbs two types of radiation while being a lot lighter than lead.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 13800, --price for item
		width = 2,
		height = 1,
		weight = 2,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 3, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_RADIATION.."-m"] = 1.55,
		},
		itemWeightMod = 1.07, --optional multiplier to modify item weight
	},
	["lining_chemexp"] = {
		name = "Flexible lead mesh lining",
		--item variables
		desc = "The lead mesh creates unbreachable chemical protection without sacrificing mobility.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 11400, --price for item
		width = 2,
		height = 1,
		weight = 2.2,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 3, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_ACID.."-m"] = 1.55,
		},
		itemWeightMod = 1.07, --optional multiplier to modify item weight
	},
	["lining_elecexp"] = {
		name = "An isolation bodysuit with manganin inserts",
		--item variables
		desc = "This nickel and magnesium alloy is used in armor to prevent electric shocks.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 12000, --price for item
		width = 2,
		height = 1,
		weight = 1.7,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 3, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_SHOCK.."-m"] = 1.55,
		},
		itemWeightMod = 1.07, --optional multiplier to modify item weight
	},
	--linings, advanced
	["lining_psyadv"] = {
		name = "Advanced psy-protection band",
		--item variables
		desc = "A closed band that provides partial protection against direct psy-emission.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 12000, --price for item
		width = 2,
		height = 1,
		weight = 1.1,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 2, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			--["vest"] = true,["vestl"] = true,
			--["light"] = true,
			--["medium"] = true,
			--["gorka"] = true,
			--["heavy"] = true,
			--["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_SONIC.."-m"] = 1.3,
			["psy-m"] = 1.3
		},
		itemWeightMod = 1.05, --optional multiplier to modify item weight
	},
	["lining_burnadv"] = {
		name = "Advanced magnesium plate inserts",
		--item variables
		desc = "Magnseium inserts protect the wearer from thermal dangers.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 13200, --price for item
		width = 2,
		height = 1,
		weight = 1.2,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 2, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_BURN.."-m"] = 1.3,
		},
		itemWeightMod = 1.05, --optional multiplier to modify item weight
	},
	["lining_radadv"] = {
		name = "Advanced rubberized bodysuit lining",
		--item variables
		desc = "Rubber is a simple way of protecting yourself from brief radiation exposure. This uses a somewhat better source of rubber than the basic variant.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 10800, --price for item
		width = 2,
		height = 1,
		weight = 1.1,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 2, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_RADIATION.."-m"] = 1.3,
		},
		itemWeightMod = 1.05, --optional multiplier to modify item weight
	},
	["lining_chemadv"] = {
		name = "Advanced canvas bodysuit lining",
		--item variables
		desc = "Protection against caustic substances coming into contact with the skin. Adds chemical resistance.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 8600, --price for item
		width = 2,
		height = 1,
		weight = 1.2,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 2, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_ACID.."-m"] = 1.3,
		},
		itemWeightMod = 1.05, --optional multiplier to modify item weight
	},
	["lining_elecadv"] = {
		name = "Advanced constantan-based inner lining",
		--item variables
		desc = "A thin layer of canstantan is capable of isolating against electricity.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 8000, --price for item
		width = 2,
		height = 1,
		weight = 0.9,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 2, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_SHOCK.."-m"] = 1.3,
		},
		itemWeightMod = 1.05, --optional multiplier to modify item weight
	},
	--linings, basic
	["lining_psysimple"] = {
		name = "Basic psy-protection band",
		--item variables
		desc = "A closed band made of paired steel grills that provides partial protection against direct psy-emission.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 7200, --price for item
		width = 2,
		height = 1,
		weight = 0.7,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			--["vest"] = true,["vestl"] = true,
			--["light"] = true,
			--["medium"] = true,
			--["gorka"] = true,
			--["heavy"] = true,
			--["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_SONIC.."-m"] = 1.1,
			["psy-m"] = 1.1
		},
		itemWeightMod = 1.02, --optional multiplier to modify item weight
	},
	["lining_burnsimple"] = {
		name = "Basic magnesium plate inserts",
		--item variables
		desc = "Magnseium inserts protect the wearer from thermal dangers.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 8200, --price for item
		width = 2,
		height = 1,
		weight = 1.1,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_BURN.."-m"] = 1.1,
		},
		itemWeightMod = 1.02, --optional multiplier to modify item weight
	},
	["lining_radsimple"] = {
		name = "Basic rubberized bodysuit lining",
		--item variables
		desc = "Rubber is a basic way of protecting yourself from brief radiation exposure.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 6800, --price for item
		width = 2,
		height = 1,
		weight = 1,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_RADIATION.."-m"] = 1.1,
		},
		itemWeightMod = 1.02, --optional multiplier to modify item weight
	},
	["lining_chemsimple"] = {
		name = "Basic canvas bodysuit lining",
		--item variables
		desc = "Protection against caustic substances coming into contact with the skin. Adds chemical resistance.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 5400, --price for item
		width = 2,
		height = 1,
		weight = 1.2,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_ACID.."-m"] = 1.1,
		},
		itemWeightMod = 1.02, --optional multiplier to modify item weight
	},
	["lining_elecsimple"] = {
		name = "Basic constantan-based inner lining",
		--item variables
		desc = "A thin layer of canstantan is capable of isolating against electricity.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 5000, --price for item
		width = 2,
		height = 1,
		weight = 0.8,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "lining",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_SHOCK.."-m"] = 1.1,
		},
		itemWeightMod = 1.02, --optional multiplier to modify item weight
	},
	["chest_resist"] = {
		name = "More resistant materials",
		--item variables
		desc = "Replaces materials of the suit with more durable ones to increase various physical resistances.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 9000, --price for item
		width = 2,
		height = 1,
		weight = 0.1,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "chest",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_BLAST.."-m"] = 1.1,
			--phys
			[DMG_SLASH.."-m"] = 1.3,
			[DMG_CLUB.."-m"] = 1.3,
			[DMG_CRUSH.."-m"] = 1.3,
			--bullet fire wound
			[DMG_BULLET.."-m"] = 1.15,
		},
		itemWeightMod = 1.15, --optional multiplier to modify item weight
	},
	--chest, armor
	["chest_armor4"] = {
		name = "Armor plate (IV)",
		--item variables
		desc = "A *larger* plate for a suit. Cannot downgrade to a lower armor level.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 50000, --price for item
		width = 2,
		height = 1,
		weight = 1.8,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "chest",
		slotspace = 3, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["medium"] = true,
			["gorka"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_BLAST.."-m"] = 1.2,
			--phys
			[DMG_SLASH.."-m"] = 1.35,
			[DMG_CLUB.."-m"] = 1.35,
			[DMG_CRUSH.."-m"] = 1.35,
			--bullet fire wound
			[DMG_BULLET.."-m"] = 1.3,
			["spd"] = 0.8,
		},
		levels = { --optional overwrite an armor level
			chest = {level = ARMOR_IV},
		},
		itemWeightMod = 1.4, --optional multiplier to modify item weight
	},
	["chest_armor3"] = {
		name = "Armor plate (III)",
		--item variables
		desc = "A *better* plate for a suit. Cannot downgrade to a lower armor level.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 30000, --price for item
		width = 2,
		height = 1,
		weight = 1.2,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "chest",
		slotspace = 2, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["light"] = true,
			["medium"] = true,
			["vestl"] = true,
			["gorka"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_BLAST.."-m"] = 1.2,
			--phys
			[DMG_SLASH.."-m"] = 1.2,
			[DMG_CLUB.."-m"] = 1.2,
			[DMG_CRUSH.."-m"] = 1.2,
			--bullet fire wound
			[DMG_BULLET.."-m"] = 1.2,
			["spd"] = 0.9,
		},
		levels = { --optional overwrite an armor level
			chest = {level = ARMOR_III},
		},
		itemWeightMod = 1.2, --optional multiplier to modify item weight
	},
	["chest_armor3a"] = {
		name = "Armor plate (IIIA)",
		--item variables
		desc = "A new plate for a suit. Cannot downgrade to a lower armor level.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 15000, --price for item
		width = 2,
		height = 1,
		weight = 0.75,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "chest",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["sci"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_BLAST.."-m"] = 1.1,
			--phys
			[DMG_SLASH.."-m"] = 1.1,
			[DMG_CLUB.."-m"] = 1.1,
			[DMG_CRUSH.."-m"] = 1.1,
			--bullet fire wound
			[DMG_BULLET.."-m"] = 1.1,
			["spd"] = 0.95,
		},
		levels = { --optional overwrite an armor level
			chest = {level = ARMOR_IIIA},
		},
		itemWeightMod = 1.1, --optional multiplier to modify item weight
	},
	["chest_armor2"] = {
		name = "Armor plate (II)",
		--item variables
		desc = "A new plate for a suit. Cannot downgrade to a lower armor level.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 12000, --price for item
		width = 2,
		height = 1,
		weight = 0.6,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "chest",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["light"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_BLAST.."-m"] = 1.1,
			--phys
			[DMG_SLASH.."-m"] = 1.1,
			[DMG_CLUB.."-m"] = 1.1,
			[DMG_CRUSH.."-m"] = 1.1,
			--bullet fire wound
			[DMG_BULLET.."-m"] = 1.1,
			["spd"] = 0.95,
		},
		levels = { --optional overwrite an armor level
			chest = {level = ARMOR_II},
		},
		itemWeightMod = 1.1, --optional multiplier to modify item weight
	},
	["chest_sevaarmor2"] = {
		name = "Armored visor (II)",
		--item variables
		desc = "An armored visor for a closed suit.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 11000, --price for item
		width = 2,
		height = 1,
		weight = 0.4,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "chest",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_BLAST.."-m"] = 1.04,
			--phys
			[DMG_SLASH.."-m"] = 1.04,
			[DMG_CLUB.."-m"] = 1.04,
			[DMG_CRUSH.."-m"] = 1.04,
			--bullet fire wound
			[DMG_BULLET.."-m"] = 1.04,
			["spd"] = 0.98,
		},
		levels = { --optional overwrite an armor level
			head = {level = ARMOR_II},
		},
		itemWeightMod = 1.04, --optional multiplier to modify item weight
	},
	["chest_armor2a"] = {
		name = "Armor plate for vest (IIA)",
		--item variables
		desc = "A better plate used for vests.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 9600, --price for item
		width = 2,
		height = 1,
		weight = 0.4,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "chest",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_BLAST.."-m"] = 1.1,
			--phys
			[DMG_SLASH.."-m"] = 1.1,
			[DMG_CLUB.."-m"] = 1.1,
			[DMG_CRUSH.."-m"] = 1.1,
			--bullet fire wound
			[DMG_BULLET.."-m"] = 1.1,
			["spd"] = 0.98,
		},
		levels = { --optional overwrite an armor level
			chest = {level = ARMOR_IIA},
		},
		itemWeightMod = 1.1, --optional multiplier to modify item weight
	},
	["chest_armorlimbs"] = {
		name = "Soft limb armor for Gorka (II)",
		--item variables
		desc = "Armor for the limbs for use with the Gorka suit.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 11300, --price for item
		width = 2,
		height = 1,
		weight = 0.4,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "chest",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["gorka"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			[DMG_BLAST.."-m"] = 1.25,
			--phys
			[DMG_SLASH.."-m"] = 1.2,
			[DMG_CLUB.."-m"] = 1.2,
			[DMG_CRUSH.."-m"] = 1.2,
			--bullet fire wound
			[DMG_BULLET.."-m"] = 1.3,
			["spd"] = 0.96,
		},
		levels = { --optional overwrite an armor level
			larm = {level = ARMOR_II},
			rarm = {level = ARMOR_II},
			lleg = {level = ARMOR_II},
			rleg = {level = ARMOR_II},
		},
		itemWeightMod = 1.2, --optional multiplier to modify item weight
	},
	--core, movement
	["core_exospr"] = {
		name = "Hydraulic boosters for an exoskeleton",
		--item variables
		desc = "A set of hydraulic boosters for exoskeletons. Allows sprinting while wearing one.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 42000, --price for item
		width = 2,
		height = 1,
		weight = 2.5,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["exo"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			["nospr"] = false,
		},
	},
	["core_stmfull"] = {
		name = "Internal thermal regulation system",
		--item variables
		desc = "A set of ergonomic mounts for armor that increases stamina.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 8000, --price for item
		width = 2,
		height = 1,
		weight = 2,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			--["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			--["vest"] = true,["vestl"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			["spd"] = 1.25,
			["stmres"] = 1.2
		},
	},
	["core_stmlight"] = {
		name = "Internal thermal regulation vest system",
		--item variables
		desc = "A set of ergonomic mounts for vests and light armors. Increases stamina.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 4000, --price for item
		width = 2,
		height = 1,
		weight = 1.8,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
			["light"] = true,
		},
		resist = { --optional resist table, -m functionality like artifacts, 
			--however also can be normal to be added on
			["spd"] = 1.1,
			["stmres"] = 1.4
		},
	},
	--core, space add
	["core_artifactvest"] = {
		name = "Additional Artifact Vest Slot",
		--item variables
		desc = "Adds an additional artifact attachment slot for the vest.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 4500, --price for item
		width = 2,
		height = 1,
		weight = 0.25,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
		},
		additionalArtifact = 1, --optional adds onto artifact slot space
	},
	["core_artifactfull"] = {
		name = "Additional Artifact Slots",
		--item variables
		desc = "Allows for the use of two more attached artifacts.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 10000, --price for item
		width = 2,
		height = 1,
		weight = 0.5,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			--["vest"] = true,["vestl"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		additionalArtifact = 2, --optional adds onto artifact slot space
	},
	["core_spacevest"] = {
		name = "Lightening of the vest",
		--item variables
		desc = "Exchanges some parts with lighter parts for a lighter overall weight.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 4500, --price for item
		width = 2,
		height = 1,
		weight = 0.5,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,["vestl"] = true,
		},
		--additionalArtifact = 1, --optional adds onto artifact slot space
		itemWeightMod = 0.8, --optional multiplier to modify item weight
		--maxWeightMod = 1.2, --optional multiplier to modify max weight
	},
	["core_spacefull"] = {
		name = "Lightening of the suit and new added space",
		--item variables
		desc = "An assorted set of systems and materials that allow for a higher weight capacity and a lighter suit weight overall at the same time. Also includes an additional artifact attachment slot.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 9000, --price for item
		width = 2,
		height = 1,
		weight = 1.4,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			--["vest"] = true,["vestl"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		additionalArtifact = 1, --optional adds onto artifact slot space
		itemWeightMod = 0.9, --optional multiplier to modify item weight
		maxWeightMod = 1.2, --optional multiplier to modify max weight
	},
	--core, duramods
	["core_durasoft"] = {
		name = "Enhanced durability for light suits and vests",
		--item variables
		desc = "An assorted set of materials that allow for a more durable suit. Will not modify current durability unless its full.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 9000, --price for item
		width = 2,
		height = 1,
		weight = 1.3,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["vest"] = true,
			["vestl"] = true,
			["light"] = true,
		},
		itemWeightMod = 1.1, --optional multiplier to modify item weight
		duraMod = 1.25, --optional multiplier to modify max weight
	},
	["core_durahard"] = {
		name = "Enhanced durability for medium and heavy suits",
		--item variables
		desc = "An assorted set of materials that allow for a more durable suit. Will not modify current durability unless its full.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 16000, --price for item
		width = 2,
		height = 1,
		weight = 1.6,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			--["vest"] = true,["vestl"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		itemWeightMod = 1.2, --optional multiplier to modify item weight
		duraMod = 1.15, --optional multiplier to modify max weight
	},
	--core, slot adds
	["core_lining"] = {
		name = "Additional possibility for lining",
		--item variables
		desc = "Adds the potential for another lining modification.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 2500, --price for item
		width = 2,
		height = 1,
		weight = 0.3,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["vest"] = true,["vestl"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		--extra slots add
		slotadd = { --optional slots add, comment if not adding new slots
			["lining"] = 1,
		},
	},
	["core_chest2"] = {
		name = "Possibility for a larger armor plate",
		--item variables
		desc = "Allows for a larger armor plate to be used with the suit (+ 2 slots). Use this or the other armor core, not both.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 7500, --price for item
		width = 2,
		height = 1,
		weight = 0.8,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 2, --number of space itll take up in the slot
		reqOverride = 3,
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["vest"] = true,["vestl"] = true,
		},
		--extra slots add
		slotadd = { --optional slots add, comment if not adding new slots
			["chest"] = 2,
		},
	},
	["core_chest"] = {
		name = "Possibility for a better armor plate",
		--item variables
		desc = "Allows for a better armor plate to be used with the suit (+ 1 slot). Use this or the other armor core, not both.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 4000, --price for item
		width = 2,
		height = 1,
		weight = 0.6,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["light"] = true,
			["medium"] = true,
			["gorka"] = true,
			["heavy"] = true,
			["exo"] = true,
			["vest"] = true,["vestl"] = true,
			["seva"] = true,
		},
		--extra slots add
		slotadd = { --optional slots add, comment if not adding new slots
			["chest"] = 1,
		},
	},
	--[[["core_helm"] = { --ehh
		name = "Possibility for better helmet armor",
		--item variables
		desc = "desc for item",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 0, --price for item
		width = 2,
		height = 1,
		weight = 0.1,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["helm"] = true,
		},
		--extra slots add
		slotadd = { --optional slots add, comment if not adding new slots
			["helm"] = 1,
		},
	},]]
	["core_eyes"] = {
		name = "Possibility for integrated nightvision",
		--item variables
		desc = "Adds the infrastructure for some form of integrated nightvision.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 2500, --price for item
		width = 2,
		height = 1,
		weight = 0.3,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["helm"] = true,
			["mask"] = true,
			["sci"] = true,
			["seva"] = true,
		},
		reqOverride = 2,
		--extra slots add
		slotadd = { --optional slots add, comment if not adding new slots
			["eyes"] = 1,
		},
	},
	["core_mask"] = {
		name = "Possibility for more mask modifications",
		--item variables
		desc = "Provides the capacity for one more modification in the mask slot.",
		model = "models/wick/wrbstalker/anomaly/items/dez_upgr_o_2.mdl",
		price = 5000, --price for item
		width = 2,
		height = 1,
		weight = 0.4,
		--flag = "",
		traitreq = { --optional trait requirement
			trait = "crafting_armor",
			val = 1,
		},
		--upgrade specific variables
		slot = "core",
		slotspace = 1, --number of space itll take up in the slot
		size = { --item sizes allowed
			--helm, light, medium, heavy, exo, mask, vest, sci, seva
			["helm"] = true,
			["mask"] = true,
		},
		--extra slots add
		slotadd = { --optional slots add, comment if not adding new slots
			["mask"] = 1,
		},
	},
}

local function getMaxSlot(item, slot)
	local mx = slotMaxes[item.size or "light"]
	local slotcnt = mx[slot] or 0
	slotcnt = slotcnt + (item:getData("ex", {})[slot] or 0)
	return slotcnt
end

function suit_getUpgradeReq(id)
	local up = upgrades[id]
	if(!up) then return 1 end
	return up.reqOverride or up.slotspace
end

function suit_getUpgradeMaxes(item)
	local str = ""
	local slot = item:getData("slot", {})
	local ex = item:getData("ex", {})
	local mx = slotMaxes[item.size or "light"]
	if(!mx) then return "invalid size" end
	for k,v in pairs(slotShow) do
		--moved it out becuz itd prob be faster this way than above
		if(!mx[k]) then continue end
		local slotcnt = mx[k] or 0
		slotcnt = slotcnt + (ex[k] or 0)
		str = str.."\n    •"..v..": "..(slot[k] or 0).."/"..slotcnt
	end
	return str
end

function suit_getUpgradeName(id)
	return (upgrades[id] or {}).name or "invalid"
end

local function suitUp_CheckValid(item, upitem)
	if(item.base != "base_armor" or upitem.base != "base_upgradearmor") then return false, "One of the items aren't the correct base" end

	local upgrade = upgrades[upitem.upid]
	if(!upgrade) then return false, "Upgrade table doesnt exist? "..upitem.upid end

	--check if armor is a valid size for the upgrade
	if(!upgrade.size[item.size or "light"]) then return false, "Upgrade does not fit this item." end

	--check if upgrade was already applied
	if(item:GetUpgrades()[upitem.upid]) then return false, "Upgrade already applied to item." end

	--check if have enough slot space
	local slotcnt = getMaxSlot(item, upgrade.slot)
	local curslot = (item:getData("slot", {})[k] or 0)+upgrade.slotspace
	if(curslot > slotcnt) then return false, "Not enough space in the slot." end

	--fine
	if(upgrade.levels) then
    	local armor = item:getData("armor", {})
		local fine = true
		for k,v in pairs(upgrade.levels) do
			--purposefully not checking if the new level isnt better lmao
			if(armor[k] and armor[k].level and armor[k].level != ARMOR_I and armor[k].level >= v.level) then
				fine = false
				break --dont bother with the rest
			end
		end
		if(!fine) then
			return false, "Suit has better or equal armor compared to what will be applied"
		end
	end
	--? idk what else

	return true
end

--item = suit item, upgrade = suit upgrade item, 
--return like item func, return true to say the upgrade item should be destroyed
function applySuitUpgrade(ply, item, upitem)
	local succ, msg = suitUp_CheckValid(item, upitem)
	if(!succ) then ply:notify(msg, 3) return false end
	
	local upgrade = upgrades[upitem.upid]

	--apply extra slots
	if(upgrade.slotadd) then
		local ex = item:getData("ex", {})
		for k,v in pairs(upgrade.slotadd) do
			ex[k] = (ex[k] or 0) + v
		end
		item:setData("ex", ex)
	end

	--apply resists
	if(upgrade.resist) then
    	local resists = item:getData("resists", {})
		--should be good?
		for k2,v2 in pairs(upgrade.resist) do
			if(k2 == "spd" or k2 == "stmres") then
				resists[k2] = (resists[k2] or 1)*v2
				if(k2 == "spd") then
					--dont want above 1
					resists[k2] = math.Clamp(resists[k2], 0, 1)
				end
			elseif(k2 == "nv" or k2 == "hud") then
				if(!resists[k2] or resists[k2] < v2) then --this should never be false but ya
					resists[k2] = v2
				end
			elseif(k2 == "nospr") then
				resists[k2] = v2 --overwrite no sprint
			elseif(k2:find("-m")) then
				local real = string.Split(k2, "-")[1]
				local atm = tonumber(real)
				if(atm) then
					real = atm
				end
				--this 0.01 is fine becuz for resists it does 1-num
				resists[real] = (resists[real] or 0.01) * v2
			else
				resists[k2] = math.max((resists[k2] or 0) + v2, 0)
			end
		end
		item:setData("resists", resists)
	end

	--apply levels
	if(upgrade.levels) then
    	local armor = item:getData("armor", {})
		for k,v in pairs(upgrade.levels) do
			--purposefully not checking if the new level isnt better lmao
			armor[k] = v
		end
		item:setData("armor", armor)
	end

	--modify item weight
	if(upgrade.itemWeightMod) then
		item:setData("weight", item:getData("weight",item.weight)*upgrade.itemWeightMod)
	end
	
	--modify max weight
	if(upgrade.maxWeightMod) then
		local oldmx = item:getData("addWeight", item.addWeight or 0)
		local newmx = item:getData("addWeight", item.addWeight or 0)*upgrade.maxWeightMod
		local diff = newmx - oldmx
		item:setData("addWeight", newmx)
		local char = ply:getChar() --adding the difference
		char:getInv():setData("maxWeight", char:getInv():getMaxWeight() + diff)
	end

	--modify artifact count
	if(upgrade.additionalArtifact) then
		local cur = item:getData("artcnt", item.artifactCnt or 0)
		cur = cur + upgrade.additionalArtifact
		item:setData("artcnt", cur)
	end

	--modify suit durability multiplier
	--not losing/gaining durability is fine, 
	--theyll get at most 1 free hit if it gets lowered and its already inited
	if(upgrade.duraMod) then
		--resetting if its max so its still max next time
		if(item:getData("durability", 0) == item:getMaxDura()) then
			item:setData("durability")
		end

		item:setData("duram", item:getData("duram", 1)*upgrade.duraMod)
	end

	--add to slot count
	local slottbl = item:getData("slot", {})
	--local slot = slottbl[upgrade.slot] or 0
	--slot = slot + upgrade.slotspace
	slottbl[upgrade.slot] = (slottbl[upgrade.slot] or 0) + upgrade.slotspace
	item:setData("slot", slottbl)

	--add to upgrades table on item
	local uptbl = item:getData("upgrades", {})
	uptbl[upitem.upid] = true 
	item:setData("upgrades", uptbl)
	--i kinda dont like individually setting a bunch of data but eh should be fine
	return true
end

local upkits = {
	[1] = "Basic Toolkit",
	[2] = "Advanced Toolkit",
	[3] = "Expert Toolkit"
}

--todo create items for upgrades in upgrades table, like arccw config
function PLUGIN:InitializedItems()
	for id, data in pairs(upgrades) do
		local ITEM = nut.item.register("sup_"..id, "base_upgradearmor", nil, nil, true)
		ITEM.name = data.name
		local ex = "Armor Sizes: "
		for k,v in pairs(upgrades[id].size) do
			ex = ex..k..", "
		end
		local up = suit_getUpgradeReq(id)
        ex = ex:sub(1, -3).."\nSlot Used: "..slotShow[upgrades[id].slot].."\nSpace Used: "..upgrades[id].slotspace.."\nToolkit Needed: "..(upkits[up] or "invalid toolkit? "..tostring(up))

		ITEM.desc = ex.."\n"..data.desc.."\nPlease note that suit upgrades are *PERMANENT* and *IRREVERSIBLE*. Make sure you want this upgrade on the suit before applying it."
		ITEM.price = data.price or 0
		ITEM.model = data.model
		ITEM.groups = data.groups
		ITEM.width = data.width
		ITEM.height = data.height
		ITEM.weight = data.weight
		ITEM.flag = data.flag or "N"
		ITEM.traitreq = data.traitreq
		ITEM.upid = id
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
		ITEM.transferSound = data.transferSound or "interface/inv_items_cloth_2.ogg"
		
		if(data.destroyval) then
			ITEM.destroyval = data.destroyval --in case i wanna add more
			ITEM = EZADDDESTROYFUNC(ITEM)
		end
	end
end