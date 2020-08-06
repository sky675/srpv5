local PLUGIN = PLUGIN

--list of armor levels as corresponding plates
local armor_items = {
	[ARMOR_IIA] = "up_armor_2a",
	[ARMOR_II] = "up_armor_2",
	[ARMOR_IIIA] = "up_armor_3a",
	[ARMOR_III] = "up_armor_3",
	[ARMOR_IIIp] = "up_armor_3p",
	[ARMOR_IV] = "up_armor_4",
	
}

PLUGIN.recipeList = {
	--[[
	recipe def:
	["uniqueID"] = {
		name = the name,
		desc = the desc,
		category = the category to file it under,
		model = model to display,
		skin = skin of model (not required),
		workbench = table of workbench ids ({["basic"] = true,},)
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		ingredients = { --items that will be taken
			["ingreduniqueid"] = true, --or # of needed,
		},
		result = "result", --can also be table for multiple results
		flag = "", --optional can be left out, flag to check for
		handpick = function(items)
			--return an item id from the list of items and that id will get passed into beforeCraft
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--handpick is the item id gotten from handpick, it will be nil if this wasnt done
			--return a table and it will reappear in oncreate as data
		end,
		adddata = true, --this will set the data returned in beforeCraft on the result item
		onCreate = function(ply, item, data) 
			--to do something when created such as transfer data
		end,
		timed = {
			action = "the action to display during timed action",
			time = 0, --length of the action
		},
		--jobRequire = true, --special thing for crafting job keeping
	},
	]]
	--basic stuff
	["basic_bandage"] = {
		name = "Bandage",
		desc = [[A simple bandage.
Ingredients: 3x Patch of Cloth
Results: 1x Bandage]],
		category = "Medical",
		model = "models/sky/items/bandage.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_cloth"] = 3, --or # of needed,
			--["jar_antiseptic"] = true,
		},
		result = "meds_bandage", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["basic_upbandage"] = {
		name = "Upgrade Bandage",
		desc = [[Increase the quality of a bandage by using a jar of antiseptics.
Trait Requirements: General Crafting Level 1
Ingredients: 1x Bandage, 1x Jar of Antiseptic
Results: 1x Antiseptic Bandage]],
		category = "Medical",
		model = "models/sky/items/bandage.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting"] = 1,--min level needed or true for no level ones,
			--["tech_med"] = 1,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["meds_bandage"] = true, --or # of needed,
			["comp_jar_antiseptic"] = true,
		},
		result = "meds_bandage2", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	
	["basic_medkit"] = {
		name = "Medkit",
		desc = [[Combine various things to make a basic medkit.
Trait Requirements: General Crafting Level 1
Ingredients: 2x Bandage, 1x Jar of Antiseptic, 3x Patch of Cloth
Results: 1x Basic Medkit]],
		category = "Medical",
		model = "models/sky/items/medkit1.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
			--["tech_med"] = 1,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["meds_bandage"] = 2, --or # of needed,
			["comp_jar_antiseptic"] = 1,
			["comp_scrap_cloth"] = 3,
		},
		result = "medkit1", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},

	--crafting
	["comp_mech1"] = {
		name = "Craft Light Mechanisms",
		desc = [[Fashions the scrap into some various springs and mechanisms.
Trait Requirements: General Crafting Level 2
Ingredients: 2x Scrap Metal, 1x Wire Spool
Results: 1x Light Mechanisms]],
		category = "Components",
		model = "models/fallout/components/box.mdl",
		skin = 5,
		workbench = {["basic"]=true,["weapons"]=true,["armor"]=true},
		traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_wire1"] = 1, --or # of needed,
			["comp_scrap_metal"] = 2,
		},
		result = "comp_mech1", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["comp_mech2"] = {
		name = "Reinforce Mechanisms",
		desc = [[Does some stuff to make the assorted mechanisms sturdier.
Trait Requirements: General Crafting Level 1
Ingredients: 2x Light Mechanisms, 1x Scrap Metal
Results: 1x Reinforced Mechanisms]],
		category = "Components",
		model = "models/fallout/components/box.mdl",
		skin = 3,
		workbench = {["basic"]=true,["weapons"]=true,["armor"]=true},
		traits = { --traits requirements
			["crafting"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_mech1"] = 2, --or # of needed,
			["comp_scrap_metal"] = true,
		},
		result = "comp_mech2", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["comp_padcloth"] = {
		name = "Padded Cloth",
		desc = [[Does some stuff to make a more thick cloth.
Trait Requirements: General Crafting Level 1
Ingredients: 2x Scrap of Cloth
Results: 1x Padded Cloth]],
		category = "Components",
		model = "models/fallout/components/box.mdl",
		skin = 0,
		workbench = {["basic"]=true,["weapons"]=true,["armor"]=true},
		traits = { --traits requirements
			["crafting"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_cloth"] = 2, --or # of needed,
		},
		result = "comp_pad_cloth", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},

	--cooking
	["cook_blood"] = {
		name = "Bloodsucker Goulash (Low Quality)",
		desc = [[Use basic cooking knowledge to create a Bloodsucker Goulash out of Bloodsucker meat and assorted spices and other ingredients.
Trait Requirements: Cooking Level 1
Ingredients: 1x Bloodsucker Meat
Results: 1x Bloodsucker Goulash]],
		category = "Cooking",
		model = "models/kek1ch/meat_bloodsucker.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 1,--min level needed or true for no level ones,
			--["tech_med"] = 1,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["food_meat_blood"] = 1, --or # of needed,
		},
		result = "food_meal_blood", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_boar"] = {
		name = "Boar Chops (Low Quality)",
		desc = [[Use basic cooking knowledge to prepare some Boar Chops with assorted seasonings and other ingredients.
Trait Requirements: Cooking Level 1
Ingredients: 1x Boar Chops
Results: 1x Prepared Boar Chops]],
		category = "Cooking",
		model = "models/kek1ch/meat_boar.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 1,--min level needed or true for no level ones,
			--["tech_med"] = 1,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["food_meat_boar"] = 1, --or # of needed,
		},
		result = "food_meal_boar", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_dog"] = {
		name = "Dog Chops (Low Quality)",
		desc = [[Use basic cooking knowledge to prepare some Dog meat with assorted seasonings and other ingredients.
Trait Requirements: Cooking Level 1
Ingredients: 1x Dog Meat
Results: 1x Dog Chops]],
		category = "Cooking",
		model = "models/kek1ch/meat_dog.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 1,--min level needed or true for no level ones,
			--["tech_med"] = 1,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["food_meat_dog"] = 1, --or # of needed,
		},
		result = "food_meal_dog", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_flesh"] = {
		name = "Flesh Bacon (Low Quality)",
		desc = [[Use basic cooking knowledge to turn some Flesh meat into some fat and greasy bacon.
Trait Requirements: Cooking Level 1
Ingredients: 1x Flesh Meat
Results: 1x Flesh Bacon]],
		category = "Cooking",
		model = "models/kek1ch/raw_flesh.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 1,--min level needed or true for no level ones,
			--["tech_med"] = 1,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["food_meat_flesh"] = 1, --or # of needed,
		},
		result = "food_meal_flesh", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_rat"] = {
		name = "Rat Skewers (Low Quality)",
		desc = [[Use basic cooking knowledge to prepare some Rat Skewers with assorted seasonings and other ingredients.
Trait Requirements: Cooking Level 1
Ingredients: 1x Rat Meat
Results: 1x Rat Skewers]],
		category = "Cooking",
		model = "models/kek1ch/meat_tushkano.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 1,--min level needed or true for no level ones,
			--["tech_med"] = 1,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["food_meat_rat"] = 1, --or # of needed,
		},
		result = "food_meal_rat", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_snork"] = {
		name = "Snork Hand (Low Quality)",
		desc = [[Use basic cooking knowledge to prepare a Grilled Snork Hand.
Trait Requirements: Cooking Level 1
Ingredients: 1x Snork Hand
Results: 1x Grilled Snork Hand]],
		category = "Cooking",
		model = "models/kek1ch/snork_food.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 1,--min level needed or true for no level ones,
			--["tech_med"] = 1,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["food_meat_snork"] = 1, --or # of needed,
		},
		result = "food_meal_snork", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	
	--special yes
	["maki_special"] = {
		name = "Craft KAMI",
		desc = [[Creates a specialized hack tool.
Trait Requirements: None
Ingredients: 6x Scrap Metal, 5x Wire Spool, 6x Basic Tech, 1x Data Reader, 1x Data Recorder, 1x GPS
Results: 1x KAMI Interface]],
		category = "Special",
		model = "models/fallout/components/box.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		--[[traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
		},]]
		steamid = "STEAM_0:0:23875518", --me :)
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 6,
			["comp_wire1"] = 5, --or # of needed,
			["comp_tech1"] = 6,
			--["comp_duct_tape"] = 2, --removing this, replacing with higher requirements elsewhere
			["datachik1"] = 1,
			["datachik2"] = 1,
			["datachik3"] = 1,
		},
		result = "hacktool_maki", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["maki_remote"] = {
		name = "Craft Hack Remote",
		desc = [[Creates an experimental hack remote.
Trait Requirements: None
Ingredients: 3x Scrap Metal, 3x Wire Spool, 4x Basic Tech, 1x GPS
Results: 1x Hack Remote]],
		category = "Special",
		model = "models/fallout/components/box.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		--[[traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
		},]]
		steamid = "STEAM_0:0:23875518", --me :)
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 3,
			["comp_wire1"] = 3, --or # of needed,
			["comp_tech1"] = 4,
			--["comp_duct_tape"] = 2, --removing this, replacing with higher requirements elsewhere
			--["datachik1"] = 1,
			--["datachik2"] = 1,
			["datachik3"] = 1,
		},
		result = "hack_remote", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},

	["craft_flashlight"] = {
		name = "Craft Flashlight (Tape)",
		desc = [[Create a flashlight out of various bits. Lightbulb? Don't worry about it.
Trait Requirements: Basic Tech Crafting Level 1
Ingredients: 3x Scrap Metal, 1x Light Mechanisms, 2x Small Tech, 1x Duct Tape, 1x Wire Spool
Results: 1x Flashlight]],
		category = "Items",
		model = "models/props_junk/cardboard_box004a.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting_tech"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 3, --or # of needed,
			["comp_mech1"] = 1,
			["comp_tech1"] = 2,
			["comp_duct_tape"] = 1,
			["comp_wire1"] = 1,
		},
		result = "flashlight", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["craft_flashlight2"] = {
		name = "Craft Flashlight (Wire)",
		desc = [[Create a flashlight out of various bits. Lightbulb? Don't worry about it.
Trait Requirements: Basic Tech Crafting Level 1
Ingredients: 3x Scrap Metal, 1x Light Mechanisms, 2x Small Tech, 4x Wire Spool
Results: 1x Flashlight]],
		category = "Items",
		model = "models/props_junk/cardboard_box004a.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting_tech"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 3, --or # of needed,
			["comp_mech1"] = 1,
			["comp_tech1"] = 2,
			["comp_wire1"] = 4,
		},
		result = "flashlight", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["craft_radio"] = {
		name = "Craft Radio",
		desc = [[Create a makeshift radio out of various bits.
Trait Requirements: Basic Tech Crafting Level 2
Ingredients: 4x Scrap Metal, 1x Light Mechanisms, 3x Small Tech, 2x Wire Spool
Results: 1x Radio]],
		category = "Items",
		model = "models/stalker/item/handhelds/radio.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting_tech"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 4, --or # of needed,
			["comp_mech1"] = 1,
			["comp_tech1"] = 3,
			["comp_wire_spool"] = 2,
		},
		result = "radio", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	
	["craft_flashlightatt"] = {
		name = "Flashlight -> Flashlight Attachment",
		desc = [[Turn a flashlight into a kind that you can mount on a gun.
Trait Requirements: Basic Tech Crafting Level 1
Ingredients: 1x Flashlight, 1x Scrap Metal, 1x Duct Tape, 1x Wire Spool
Results: 1x Flashlight Attachment]],
		category = "Items",
		model = "models/Items/BoxMRounds.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting_tech"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["flashlight"] = 1,
			["comp_scrap_metal"] = 1, --or # of needed,
			["comp_duct_tape"] = 1,
			["comp_wire1"] = 1,
		},
		result = "ins2_ub_light", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	
	--todo: change model of this, ied, and comp explosive

	["craft_ied"] = {
		name = "IED",
		desc = [[Create a remotely triggered IED.
Trait Requirements: General Crafting Level 3
Ingredients: 1x Explosive Block, 2x Scrap Metal, 3x Duct Tape, 1x Wire Spool, 3x Basic Tech
Results: 1x IED]],
		category = "Items",
		model = "models/Items/BoxMRounds.mdl",
		skin = 0,
		workbench = {["basic"]=true,["weapons"] = true},
		traits = { --traits requirements
			["crafting"] = 3,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_explosive"] = 1,
			["comp_scrap_metal"] = 2, --or # of needed,
			["comp_duct_tape"] = 3,
			["comp_wire1"] = 1,
			["comp_tech1"] = 3,
		},
		result = "ied", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	
	--craft weps
	["wep_switchblade"] = {
		name = "Switchblade",
		desc = [[Assemble some scrap and assorted parts into a makeshift switchblade.
Trait Requirements: General Crafting Level 2
Ingredients: 2x Scrap Metal, 1x Light Mechanisms
Results: 1x Switchblade]],
		category = "Weapons",
		model = "models/mosi/fallout4/props/weapons/melee/switchblade.mdl",
		skin = 0,
		workbench = {["basic"]=true,["weapons"]=true},
		traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 2, --or # of needed,
			["comp_mech1"] = 1,
		},
		result = "wep_m_f4switchblade", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},

	--weapon conversions
	["wepconv_glocka"] = {
		name = "G17 -> G17 Auto Conversion",
		desc = [[Converts a Glock 17 to be automatic only.
Data such as durability and atts will transfer.
Trait Requirements: Weapon Crafting Level 2
ingredients: 1x Glock 17, 2x Reinforced Mechanisms,
results: 1x Glock 17 Auto]],
		category = "Custom Conversions",
		model = "models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["wep_glock"] = true, --or # of needed,
			["comp_mech2"] = 2,
			--["jar_antiseptic"] = true,
		},
		result = "wep_glocka", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		beforeCraft = function(ply, items)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			local data = {}
			for k,v in pairs(items) do
				if(v.uniqueID == "wep_glock") then
					data = v:getData(true) --this apparently gets all data
					break
				end
			end
			if(data and table.Count(data) != 0) then
				return data
			end
		end,
		adddata = true,
	},
	["wepconv_glock"] = {
		name = "G17 Auto -> G17 Conversion",
		desc = [[Converts a Glock 17 Auto back to the normal version.
Data such as durability and atts will transfer.
Trait Requirements: Weapon Crafting Level 2
Ingredients: 1x Glock 17,
Result: 1x Glock 17 Auto]],
		category = "Custom Reverts",
		model = "models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
		},
		result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		beforeCraft = function(ply, items)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			local data = {}
			for k,v in pairs(items) do
				if(v.uniqueID == "wep_glocka") then
					data = v:getData(true) --this apparently gets all data
					break
				end
			end
			if(data and table.Count(data) != 0) then
				return data
			end
		end,
		adddata = true,
	},
	["wepconv_izhsawn"] = {
		name = "IZH-43 Sawn-off",
		desc = [[Converts a IZH-43 to be the sawn-off version. Not reversible.
Data such as durability and atts will transfer.
Trait Requirements: Weapon Crafting Level 1
ingredients: 1x Izh-43,
results: 1x Izh-43 (Sawn-off)]],
		category = "Custom Conversions",
		model = "models/weapons/tfa_ins2/w_sawedoff.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			["wep_izh"] = true, --or # of needed,
			--["comp_mech2"] = 2,
			--["jar_antiseptic"] = true,
		},
		result = "wep_izhsawn", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		beforeCraft = function(ply, items)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			local data = {}
			for k,v in pairs(items) do
				if(v.uniqueID == "wep_izh") then
					data = v:getData(true) --this apparently gets all data
					break
				end
			end
			if(data and table.Count(data) != 0) then
				return data
			end
		end,
		adddata = true,
	},

	--passive weapon upgrades
	["passiveadd_dura"] = {
		name = "Durability Increase",
		desc = [[probably will be renamed eventually
decreases durability taken on firing,
but increases spread, recoil and decreases movespeed
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
you CANNOT remove this once you apply it

Trait Requirements: Weapon Crafting Level 1
Ingredients: 1x any unequipped weapon, 1x Reinforced Mechanisms, 2x Scrap Metal, 1x Roll of Duct Tape
Result: 1x that unequipped weapon, with the att applied]],
		category = "Custom Upgrades",
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech2"] = 1,
			["comp_scrap_metal"] = 2,
			["comp_duct_tape"] = 1,
		},
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.base == "base_mweapons" and v:getData("equip") != true) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[10] = "sky_pass_dura" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},
	["passiveadd_hvbrl"] = {
		name = "Heavy Barrel",
		desc = [[reduces the vertical recoil of weapon but also increases its weight.
needs to be a rifle (any 545, 556, 762 or 338 weapon), not usable on weapons that have a suppressor attached
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
you CANNOT remove this once you apply it

Trait Requirements: Weapon Crafting Level 1
Ingredients: 1x any unequipped applicable weapon, 1x Light Mechanisms, 3x Scrap Metal, 1x Wire Spool
Result: 1x that unequipped weapon, with the att applied]],
		category = "Custom Upgrades",
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_scrap_metal"] = 3,
			["comp_wire1"] = 1,
		},
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.base == "base_mweapons" and v:getData("equip") != true) then
					if(!(v.type == "n" or v.type =="ws") or v:getData("atts", {})[1]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[11] = "ins2_br_heavy" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},

	--melee mods
	["melee_bat_nail"] = {
		name = "Add nails to wooden baseball bat",
		desc = [[adds nails to a wooden baseball bat
needs a wooden baseball bat unequipped in the inventory
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
you CANNOT remove this once you apply it

Trait Requirements: General Crafting Level 1
Ingredients: 1x any unequipped wooden baseball bat, 2x Light Mechanisms,
Result: 1x that bat, with the att applied]],
		category = "Custom Upgrades",
		model = "models/mosi/fallout4/props/weapons/melee/baseballbat.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		traits = { --traits requirements
			["crafting"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 2,
		},
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.uniqueID == "wep_m_f4bat" and v:getData("equip") != true) then
					if(v:getData("atts", {})[4]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[4] = "sky_batnail" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},
	["melee_baton_stun"] = {
		name = "Add stunpack to plastic baton",
		desc = [[adds a makeshift stunpack to the plastic baton, causing stamina damage.
needs a plastic baton unequipped in the inventory
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
you CANNOT remove this once you apply it

Trait Requirements: Weapon Crafting Level 1, Basic Tech Crafting Level 1
Ingredients: 1x any unequipped plastic baton, 1x Light Mechanisms, 2x Small Tech, 1x Duct Tape Roll
Result: 1x that baton, with the att applied]],
		category = "Custom Upgrades",
		model = "models/mosi/fallout4/props/weapons/melee/baton.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
			["crafting_tech"] = 1,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_tech1"] = 2,
			["comp_duct_tape"] = 1,
		},
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.uniqueID == "wep_m_f4baton" and v:getData("equip") != true) then
					if(v:getData("atts", {})[4]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[4] = "sky_batonzap" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},
	["melee_knuckles_blades"] = {
		name = "Add blades to brass knuckles",
		desc = [[adds some blades to brass knuckles
needs brass knuckles unequipped in the inventory
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
you CANNOT remove this once you apply it

Trait Requirements: General Crafting Level 1
Ingredients: 1x any unequipped brass knuckles, 1x Light Mechanisms, 3x Scrap Metal
Result: 1x those knuckles, with the att applied]],
		category = "Custom Upgrades",
		model = "models/mosi/fallout4/props/weapons/melee/knuckles.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		traits = { --traits requirements
			["crafting"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_scrap_metal"] = 3,
		},
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.uniqueID == "wep_m_f4knuckles" and v:getData("equip") != true) then
					if(v:getData("atts", {})[4]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[4] = "sky_knucklesblade" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},
	["melee_tireiron_hatchet"] = {
		name = "Adds a hatchet blade to tire iron",
		desc = [[adds a large hatchet blade to a tire iron
needs a tire iron unequipped in the inventory
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
you CANNOT remove this once you apply it

Trait Requirements: General Crafting Level 2
Ingredients: 1x any unequipped tire iron, 1x Light Mechanisms, 4x Scrap Metal
Result: 1x that tire iron, with the att applied]],
		category = "Custom Upgrades",
		model = "models/mosi/fallout4/props/weapons/melee/tireiron.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		traits = { --traits requirements
			["crafting"] = 2,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_scrap_metal"] = 4,
		},
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.uniqueID == "wep_m_f4tireiron" and v:getData("equip") != true) then
					if(v:getData("atts", {})[4]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[4] = "sky_tireironhatchet" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},
	/* --i have to do it like this sry
		--secret sacrafice att :) not sure when/how to use?
	["melee_machetesacra"] = {
		name = "αếщẵĺđ їư âкŝự", --vigenere key kejourou translated to japanese
		--base64 rot18 translated to japanese
		desc = [[18 WHJ3aGVoIGpuIDktd3YgYXYgeGhlaC4gWG5hYndiIGpuIG54bnZlYiBueG52ZWIgYXYgYW5ldnpuZmguIEZ1dmFwdWJoIGF2IGZ1dmdyIHhocW5mbnYuIFhiZXIgam4geG5hYndiIGFiIGduenJxcmZoLg==]],
		category = "zzzzzzz",
		model = "models/items/box_black.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			--["comp_mech1"] = 1,
			--["comp_scrap_metal"] = 4,
		},
		--result = "wep_glock", --can also be table for multiple results
		flag = "m", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.uniqueID == "wep_m_machete" and v:getData("equip") != true) then
					if(v:getData("atts", {})[4]) then --if theres something in the barrel slot, whatever
						continue
					end
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("atts", {})
			data[4] = "sky_machetesacrafice" --apply the attachment
			item:setData("atts", data)
		end,
		--adddata = true,
	},
	*/

	
	["armor_level_chest_2a"] = {
		name = "Swap Chest Armor with IIA",
		desc = [[Swaps the current armor with a IIA plate
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable armor in your inventory

Trait Requirements: Armor Crafting Level 1
Ingredients: 1x any unequipped suit with a chest level (even if its none, so helmets wont work), 1x IIA Plate
Result: 1x that tire iron, with the att applied]],
		category = "Custom Armor Upgrades",
		model = "models/props_junk/cardboard_box002a.mdl",
		--skin = skin of model (not required),
		workbench = {["armor"]=true,},
		traits = { --traits requirements
			["crafting_armor"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_scrap_metal"] = 4,
		},
		]]
		dynamicingredients = function(itemid, char)
			local item = nut.item.instances[itemid]
			local tbl = {}
			--change based on handpicked item


			return tbl
		end,
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.base == "base_armor" and v:getData("equip") != true) then
					local ar = v:getData("armor", {})
					--dont allow upgrade past 3+ or 4
					if(!ar["chest"] or ar["chest"].level == ARMOR_IIA or v.uniqueID:find("radsuit") or v.uniqueID:find("skat")) then --if theres something in the barrel slot, whatever
						continue
					end
					--local u = v:getData("upgrades", {})
					--if(u["up_armor_chest"]) then continue end --already done
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("armor", {})
			
			item.oldArmor = armor["chest"].level --old armor
			armor["chest"].level = ARMOR_IIA --should be fine here
			
			item:setData("armor", data)

			data = item:getData("resists",{})
			--change based on difference between old armor and new? for weight too
			local multi = item.oldArmor-ARMOR_IIA
			data["spd"] = math.min(data["spd"] or 1 + (0.06 * multi), 1)
			item:setData("resists", data)

			item:setData("weight", item:getData("weight",item.weight) + (0.45*multi))

			data = item:getData("upgrades", {})

			data["up_armor_chest"] = "Swapped Chest Armor (IIA)"

			item:setData("upgrades", data)

		end,
		addbasedonpick = function(handpick)
			if(!handpick) then return end
			local item = nut.item.instances[handpick]

			if(item.oldArmor) then
				return armor_items[item.oldArmor]
			end
		end
		--adddata = true,
	},
	["armor_level_chest_2"] = {
		name = "Swap Chest Armor with II",
		desc = [[Swaps the current armor with a II plate
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable armor in your inventory

Trait Requirements: Armor Crafting Level 1
Ingredients: 1x any unequipped suit with a chest level (even if its none, so helmets wont work), 1x II Plate
Result: 1x that tire iron, with the att applied]],
		category = "Custom Armor Upgrades",
		model = "models/props_junk/cardboard_box002a.mdl",
		--skin = skin of model (not required),
		workbench = {["armor"]=true,},
		traits = { --traits requirements
			["crafting_armor"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_scrap_metal"] = 4,
		},
		]]
		dynamicingredients = function(itemid, char)
			local item = nut.item.instances[itemid]
			local tbl = {}
			--change based on handpicked item


			return tbl
		end,
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.base == "base_armor" and v:getData("equip") != true) then
					local ar = v:getData("armor", {})
					--dont allow upgrade past 3+ or 4
					if(!ar["chest"] or ar["chest"].level == ARMOR_II or v.uniqueID:find("radsuit") or v.uniqueID:find("skat")) then --if theres something in the barrel slot, whatever
						continue
					end
					--local u = v:getData("upgrades", {})
					--if(u["up_armor_chest"]) then continue end --already done
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("armor", {})
			
			item.oldArmor = armor["chest"].level --old armor
			armor["chest"].level = ARMOR_II --should be fine here
			
			item:setData("armor", data)

			data = item:getData("resists",{})
			--change based on difference between old armor and new? for weight too
			local multi = item.oldArmor-ARMOR_II
			data["spd"] = math.min(data["spd"] or 1 + (0.06 * multi), 1)
			item:setData("resists", data)

			item:setData("weight", item:getData("weight",item.weight) + (0.45*multi))

			data = item:getData("upgrades", {})

			data["up_armor_chest"] = "Swapped Chest Armor (II)"

			item:setData("upgrades", data)

		end,
		addbasedonpick = function(handpick)
			if(!handpick) then return end
			local item = nut.item.instances[handpick]

			if(item.oldArmor) then
				return armor_items[item.oldArmor]
			end
		end
		--adddata = true,
	},
	["armor_level_chest_3a"] = {
		name = "Swap Chest Armor with IIIA",
		desc = [[Swaps the current armor with a IIIA plate
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable armor in your inventory

Trait Requirements: Armor Crafting Level 1
Ingredients: 1x any unequipped suit with a chest level (even if its none, so helmets wont work), 1x IIIA Plate
Result: 1x that tire iron, with the att applied]],
		category = "Custom Armor Upgrades",
		model = "models/props_junk/cardboard_box002a.mdl",
		--skin = skin of model (not required),
		workbench = {["armor"]=true,},
		traits = { --traits requirements
			["crafting_armor"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_scrap_metal"] = 4,
		},
		]]
		dynamicingredients = function(itemid, char)
			local item = nut.item.instances[itemid]
			local tbl = {}
			--change based on handpicked item


			return tbl
		end,
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.base == "base_armor" and v:getData("equip") != true) then
					local ar = v:getData("armor", {})
					--dont allow upgrade past 3+ or 4
					if(!ar["chest"] or ar["chest"].level == ARMOR_IIIA or v.uniqueID:find("radsuit") or v.uniqueID:find("skat")) then --if theres something in the barrel slot, whatever
						continue
					end
					--local u = v:getData("upgrades", {})
					--if(u["up_armor_chest"]) then continue end --already done
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("armor", {})
			
			item.oldArmor = armor["chest"].level --old armor
			armor["chest"].level = ARMOR_IIIA --should be fine here
			
			item:setData("armor", data)

			data = item:getData("resists",{})
			--change based on difference between old armor and new? for weight too
			local multi = item.oldArmor-ARMOR_IIIA
			data["spd"] = math.min(data["spd"] or 1 + (0.06 * multi), 1)
			item:setData("resists", data)

			item:setData("weight", item:getData("weight",item.weight) + (0.45*multi))

			data = item:getData("upgrades", {})

			data["up_armor_chest"] = "Swapped Chest Armor (IIIA)"

			item:setData("upgrades", data)

		end,
		addbasedonpick = function(handpick)
			if(!handpick) then return end
			local item = nut.item.instances[handpick]

			if(item.oldArmor) then
				return armor_items[item.oldArmor]
			end
		end
		--adddata = true,
	},
	["armor_level_chest_3"] = {
		name = "Swap Chest Armor with III",
		desc = [[Swaps the current armor with a III plate
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable armor in your inventory

Trait Requirements: Armor Crafting Level 1
Ingredients: 1x any unequipped suit with a chest level (even if its none, so helmets wont work), 1x III Plate
Result: 1x that tire iron, with the att applied]],
		category = "Custom Armor Upgrades",
		model = "models/props_junk/cardboard_box002a.mdl",
		--skin = skin of model (not required),
		workbench = {["armor"]=true,},
		traits = { --traits requirements
			["crafting_armor"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_scrap_metal"] = 4,
		},
		]]
		dynamicingredients = function(itemid, char)
			local item = nut.item.instances[itemid]
			local tbl = {}
			--change based on handpicked item


			return tbl
		end,
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.base == "base_armor" and v:getData("equip") != true) then
					local ar = v:getData("armor", {})
					--dont allow upgrade past 3+ or 4
					if(!ar["chest"] or ar["chest"].level == ARMOR_III or v.uniqueID:find("radsuit") or v.uniqueID:find("skat")) then --if theres something in the barrel slot, whatever
						continue
					end
					--local u = v:getData("upgrades", {})
					--if(u["up_armor_chest"]) then continue end --already done
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("armor", {})
			
			item.oldArmor = armor["chest"].level --old armor
			armor["chest"].level = ARMOR_III --should be fine here
			
			item:setData("armor", data)

			data = item:getData("resists",{})
			--change based on difference between old armor and new? for weight too
			local multi = item.oldArmor-ARMOR_III
			data["spd"] = math.min(data["spd"] or 1 + (0.06 * multi), 1)
			item:setData("resists", data)

			item:setData("weight", item:getData("weight",item.weight) + (0.45*multi))

			data = item:getData("upgrades", {})

			data["up_armor_chest"] = "Swapped Chest Armor (III)"

			item:setData("upgrades", data)

		end,
		addbasedonpick = function(handpick)
			if(!handpick) then return end
			local item = nut.item.instances[handpick]

			if(item.oldArmor) then
				return armor_items[item.oldArmor]
			end
		end
		--adddata = true,
	},
	["armor_level_chest_3p"] = {
		name = "Swap Chest Armor with III+",
		desc = [[Swaps the current armor with a III+ plate
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable armor in your inventory

Trait Requirements: Armor Crafting Level 1
Ingredients: 1x any unequipped suit with a chest level (even if its none, so helmets wont work), 1x III+ Plate
Result: 1x that tire iron, with the att applied]],
		category = "Custom Armor Upgrades",
		model = "models/props_junk/cardboard_box002a.mdl",
		--skin = skin of model (not required),
		workbench = {["armor"]=true,},
		traits = { --traits requirements
			["crafting_armor"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_scrap_metal"] = 4,
		},
		]]
		dynamicingredients = function(itemid, char)
			local item = nut.item.instances[itemid]
			local tbl = {}
			--change based on handpicked item


			return tbl
		end,
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.base == "base_armor" and v:getData("equip") != true) then
					local ar = v:getData("armor", {})
					--dont allow upgrade past 3+ or 4
					if(!ar["chest"] or ar["chest"].level == ARMOR_IIIp or v.uniqueID:find("radsuit") or v.uniqueID:find("skat")) then --if theres something in the barrel slot, whatever
						continue
					end
					--local u = v:getData("upgrades", {})
					--if(u["up_armor_chest"]) then continue end --already done
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("armor", {})
			
			item.oldArmor = armor["chest"].level --old armor
			armor["chest"].level = ARMOR_IIIp --should be fine here
			
			item:setData("armor", data)

			data = item:getData("resists",{})
			--change based on difference between old armor and new? for weight too
			local multi = item.oldArmor-ARMOR_IIIp
			data["spd"] = math.min(data["spd"] or 1 + (0.06 * multi), 1)
			item:setData("resists", data)

			item:setData("weight", item:getData("weight",item.weight) + (0.45*multi))

			data = item:getData("upgrades", {})

			data["up_armor_chest"] = "Swapped Chest Armor (III+)"

			item:setData("upgrades", data)

		end,
		addbasedonpick = function(handpick)
			if(!handpick) then return end
			local item = nut.item.instances[handpick]

			if(item.oldArmor) then
				return armor_items[item.oldArmor]
			end
		end
		--adddata = true,
	},
	["armor_level_chest_4"] = {
		name = "Swap Chest Armor with IV",
		desc = [[Swaps the current armor with a IV plate
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable armor in your inventory

Trait Requirements: Armor Crafting Level 1
Ingredients: 1x any unequipped suit with a chest level (even if its none, so helmets wont work), 1x IV Plate
Result: 1x that tire iron, with the att applied]],
		category = "Custom Armor Upgrades",
		model = "models/props_junk/cardboard_box002a.mdl",
		--skin = skin of model (not required),
		workbench = {["armor"]=true,},
		traits = { --traits requirements
			["crafting_armor"] = 1,--min level needed or true for no level ones,
		},
		--[[
		attribs = { --attrib requirements
			["id"] = min needed,
		},
		traits = { --traits requirements
			["id"] = min level needed or true for no level ones,
		},
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech1"] = 1,
			["comp_scrap_metal"] = 4,
		},
		]]
		dynamicingredients = function(itemid, char)
			local item = nut.item.instances[itemid]
			local tbl = {}
			--change based on handpicked item


			return tbl
		end,
		--result = "wep_glock", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				--get the first item thats a weapon and isnt equipped
				if(v.base == "base_armor" and v:getData("equip") != true) then
					local ar = v:getData("armor", {})
					--dont allow upgrade past 3+ or 4
					if(!ar["chest"] or ar["chest"].level == ARMOR_IV or v.uniqueID:find("radsuit") or v.uniqueID:find("skat")) then --if theres something in the barrel slot, whatever
						continue
					end
					--local u = v:getData("upgrades", {})
					--if(u["up_armor_chest"]) then continue end --already done
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			local data = item:getData("armor", {})
			
			item.oldArmor = armor["chest"].level --old armor
			armor["chest"].level = ARMOR_IV --should be fine here
			
			item:setData("armor", data)

			data = item:getData("resists",{})
			--change based on difference between old armor and new? for weight too
			local multi = item.oldArmor-ARMOR_IV
			data["spd"] = math.min(data["spd"] or 1 + (0.06 * multi), 1)
			item:setData("resists", data)

			item:setData("weight", item:getData("weight",item.weight) + (0.45*multi))

			data = item:getData("upgrades", {})

			data["up_armor_chest"] = "Swapped Chest Armor (IV)"

			item:setData("upgrades", data)

		end,
		addbasedonpick = function(handpick)
			if(!handpick) then return end
			local item = nut.item.instances[handpick]

			if(item.oldArmor) then
				return armor_items[item.oldArmor]
			end
		end
		--adddata = true,
	},
	
	
}