local PLUGIN = PLUGIN

--list of armor levels as corresponding plates
local armor_items = {
	[ARMOR_IIA] = "up_armor_2a",
	[ARMOR_II] = "up_armor_2",
	[ARMOR_IIIA] = "up_armor_3a",
	[ARMOR_III] = "up_armor_3",
	[ARMOR_IV] = "up_armor_4",
	
}
--all have either mag in the name, or aug_9mm or go_ammo_556_60
local ammoup = {
	--[[
	["wep"] = {
		["none"] = "new",
		["old"] = "new2"
	},
	]]
	["arccw_go_cz75"] = {
		["none"] = "go_cz75_mag_30",
	},
	["arccw_go_deagle"] = {
		["none"] = "go_deagle_mag_9",
	},
	["arccw_go_fiveseven"] = {
		["none"] = "go_fiveseven_mag_30",
	},
	["arccw_go_glock"] = {
		["none"] = "go_glock_mag_28",
		["go_glock_mag_13_45acp"] = "go_glock_mag_26_45acp",
	},
	["arccw_go_m9"] = {
		["none"] = "go_m9_mag_24",
	},
	["arccw_go_p2000"] = {
		["none"] = "go_p2000_mag_24",
	},
	["arccw_go_p250"] = {
		["go_p250_mag_9_45acp"] = "go_p250_mag_15_45acp",
		["go_p250_mag_15_9mm"] = "go_p250_mag_24_9mm",
	},
	["arccw_go_tec9"] = {
		["none"] = "go_tec9_mag_32",
	},
	["arccw_go_usp"] = {
		["none"] = "go_usp_mag_20",
		["go_usp_mag_15_9"] = "go_usp_mag_25_9"
	},
	["arccw_go_mac10"] = {
		["none"] = "go_mac10_mag_48",
	},
	["arccw_go_mp5"] = {
		["none"] = "go_mp5_mag_40",
	},
	["arccw_go_mp7"] = {
		["none"] = "go_mp7_mag_40",
	},
	["arccw_go_bizon"] = {
		["none"] = "go_bizon_mag_82",
	},
	["arccw_go_aug"] = {
		["none"] = "go_556_ammo_60round",
	},
	["arccw_go_awp"] = {
		["none"] = "go_awp_mag_15",
	},
	["arccw_go_fnfal"] = {
		["none"] = "go_fal_mag_30",
	},
	["arccw_go_scar"] = {
		["none"] = "go_scar_mag_30",
		["go_scar_mag_30_556"] = "go_scar_mag_60_556",
	},
	["arccw_go_m1014"] = {
		["none"] = "go_m1014_mag_7",
	},
	["arccw_go_mag7"] = {
		["none"] = "go_mag7_mag_7",
	},
	["arccw_go_870"] = {
		["none"] = "go_870_mag_8",
	},
	["arccw_go_nova"] = {
		["none"] = "go_nova_mag_8",
	},
	["arccw_go_ace"] = {
		["none"] = "go_556_ammo_60round",
		["go_ace_mag_30_762"] = "go_ace_mag_40_762",
	},
	["arccw_mifl_fas2_ak47"] = {
		["none"] = "mifl_fas2_ak_mag_762_45",
		["mifl_fas2_ak_mag_545"] = "mifl_fas2_ak_mag_545_45",
		["mifl_fas2_ak_mag_939_20"] = "mifl_fas2_ak_mag_939_40",
		["mifl_fas2_ak_mag_919_30"] = "mifl_fas2_ak_mag_919_50",
	},
	["arccw_mifl_fas2_famas"] = {
		["none"] = "mifl_fas2_famas_mag_556_50",
	},
	["arccw_mifl_fas2_g36c"] = {
		["none"] = "mifl_fas2_m4a1_mag_556_60",
	},
	["arccw_mifl_fas2_g3"] = {
		["none"] = "mifl_fas2_g3_mag_762_30",
	},
	["arccw_mifl_fas2_ks23"] = {
		["none"] = "mifl_fas2_ks23_tube_x",
	},
	["arccw_mifl_fas2_m4a1"] = {
		["none"] = "mifl_fas2_m4a1_mag_556_60",
		["mifl_fas2_m4a1_mag_9mm_32"] = "mifl_fas2_m4a1_mag_9mm_50",
	},
	["arccw_mifl_fas2_rpk"] = {
		["none"] = "mifl_fas2_ak_mag_drum",
	},
	["arccw_mifl_fas2_sg55x"] = {
		["mifl_fas2_m4a1_mag_556_20"] = "none",
	},
	["arccw_mifl_fas2_sr25"] = {
		["none"] = "mifl_fas2_sr25_mag_762_20",
	},
	["arccw_mifl_fas2_m3"] = {
		["none"] = "mifl_fas2_m3_tube_x",
	},
}
local ammoslots ={
	["arccw_go_cz75"] = "go_cz75_mag",
	["arccw_go_deagle"] = "go_deagle_mag",
	["arccw_go_fiveseven"] = "go_fiveseven_mag",
	["arccw_go_glock"] = "go_glock_mag",
	["arccw_go_m9"] = "go_m9_mag",
	["arccw_go_p2000"] = "go_p2000_mag",
	["arccw_go_p250"] = "go_p250_mag",
	["arccw_go_tec9"] = "go_tec9_mag",
	["arccw_go_usp"] = "go_usp_mag",
	["arccw_go_mac10"] = "go_mac10_mag",
	["arccw_go_mp5"] = "go_mp5_mag",
	["arccw_go_mp7"] = "go_mp7_mag",
	["arccw_go_bizon"] = "go_bizon_mag",
	["arccw_go_aug"] = "go_ammo_556_60",
	["arccw_go_awp"] = "go_awp_mag",
	["arccw_go_fnfal"] = "go_fal_mag",
	["arccw_go_scar"] = "go_scar_mag",
	["arccw_go_m1014"] = "go_m1014_mag",
	["arccw_go_mag7"] = "go_mag7_mag",
	["arccw_go_870"] = "go_870_mag",
	["arccw_go_nova"] = "go_nova_mag",
	["arccw_go_ace"] = "go_ace_mag",
	["arccw_mifl_fas2_ak47"] = "mifl_fas2_ak_mag",
	["arccw_mifl_fas2_famas"] = "mifl_fas2_famas_mag",
	["arccw_mifl_fas2_g36c"] = "mifl_fas2_g36c_mag",
	["arccw_mifl_fas2_g3"] = "mifl_fas2_g3_mag",
	["arccw_mifl_fas2_ks23"] = "mifl_fas2_ks23_mag",
	["arccw_mifl_fas2_m4a1"] = "mifl_fas2_m4a1_mag",
	["arccw_mifl_fas2_rpk"] = "mifl_fas2_rpk_mag",
	["arccw_mifl_fas2_sg55x"] = "mifl_fas2_sg55x_mag",
	["arccw_mifl_fas2_sr25"] = "mifl_fas2_sr25_mag",
	["arccw_mifl_fas2_m3"] = "mifl_fas2_m3_mag"
}
local shotguns = {
	["arccw_go_870"] = true,
	["arccw_go_nova"] = true,
	["arccw_go_m1014"] = true,
	["arccw_go_mag7"] = true,
	["arccw_mifl_fas2_toz34"] = true,
	["arccw_mifl_fas2_ks23"] = true,
	["arccw_mifl_fas2_ak47"] = "mifl_fas2_ak_mag_20g",
	["arccw_waw_doublebarrel"] = true,
	["arccw_mifl_fas2_m3"] = true
}
//the item, the string to use to find the slot
local function genericUpgradeValid(items, slotcheck, noshotgun, onlyshotgun)
	for k,v in pairs(items) do
		--get the first item thats a weapon and isnt equipped
		if(v.base == "base_cweapon" and v:getData("equip") != true) then
			if(slotcheck == "mag") then
				if(ammoup[v.class]) then
					local selmod = ammoslots[v.class]
					if(selmod) then
						local atts = v:getData("atts", {})
						local val = (!atts[selmod] and ammoup[v.class]["none"]) or ammoup[v.class][atts[selmod]]
						if(val) then
							return {["id"] = k, ["slot"] = selmod, ["att"] = val}
						end
					end
				end
			else--go_ammo
				local isshot = false
				if(shotguns[v.class] == true) then 
					isshot = true 
				elseif(shotguns[v.class]) then
					local selmod = ammoslots[v.class]
					local atts = v:getData("atts", {})
					if(selmod) then
						if(atts[selmod] == shotguns[v.class]) then isshot = true end
					end
				end
					
				if(noshotgun and isshot) then return end
				if(onlyshotgun and !isshot) then return end

				return {["id"] = k}
			end
		end
	end
end
local function genericUpgrade(ply, handpick, slotcheck)
	local item = nut.item.instances[handpick.id]
	local data = item:getData("atts", {})
	print("upgr")
	PrintTable(handpick)
	if(slotcheck == "mag") then
		if(handpick.att == "none") then
			data[handpick.slot] = nil
		else
			data[handpick.slot] = handpick.att --apply the attachment
		end
	else--go_ammo
		data["go_ammo"] = slotcheck
	end
	item:setData("atts", data)
	nut.traits.addXp(ply, "crafting_spec", 1)
end
local function specificUpgradeValid(items, lookclass, upvalidtbl)
	for k,v in pairs(items) do
		--get the first item thats a weapon and isnt equipped
		if(v.base == "base_cweapon" and v:getData("equip") != true) then
			if(v.class == lookclass) then
				local atts = v:getData("atts", {})
				local val = true 
				for slot,mod in pairs(upvalidtbl) do
					--this is the best way i can comphrend writing this rn sry 2:13am
					if((!atts[slot] and mod == "none") or atts[slot] == mod) then
						--its good
					else
						val = false
					end
				end
				if(val) then
					return k--{["id"] = k}
				end
			end
		end
	end
end
local function specificUpgrade(ply, handpick, replacetbl)
	local item = nut.item.instances[handpick]
	local data = item:getData("atts", {})
	for slot,mod in pairs(replacetbl) do
		data[slot] = mod
	end
	item:setData("atts", data)
	nut.traits.addXp(ply, "crafting_spec", 1)
end

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
		model = "models/wick/wrbstalker/anomaly/items/wick_meat_bloodsucker.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/wick_meat_boar.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/wick_meat_dog.mdl",
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
	["cook_chimera"] = {
		name = "Chimera Meat (Low Quality)",
		desc = [[Use basic cooking knowledge to prepare some Chimera meat with assorted seasonings and other ingredients.
Trait Requirements: Cooking Level 1
Ingredients: 1x Chimera Meat
Results: 1x Chimera Meal]],
		category = "Cooking",
		model = "models/wick/wrbstalker/anomaly/items/wick_chimera_food.mdl",
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
			["food_meat_chimera"] = 1, --or # of needed,
		},
		result = "food_meal_chimera", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_flesh"] = {
		name = "Flesh Bacon (Low Quality)",
		desc = [[Use basic cooking knowledge to turn some Flesh meat into some fat and greasy bacon.
Trait Requirements: Cooking Level 1
Ingredients: 1x Flesh Meat
Results: 1x Flesh Bacon]],
		category = "Cooking",
		model = "models/wick/wrbstalker/anomaly/items/wick_meat_flesh.mdl",
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
	["cook_pseudodog"] = {
		name = "Pseudodog Chops (Low Quality)",
		desc = [[Use basic cooking knowledge to prepare some Pseudodog Chops with assorted seasonings and other ingredients.
Trait Requirements: Cooking Level 1
Ingredients: 1x Pseudodog Meat
Results: 1x Pseudodog Chops]],
		category = "Cooking",
		model = "models/wick/wrbstalker/anomaly/items/wick_meat_pseudodog.mdl",
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
			["food_meat_pseudodog"] = 1, --or # of needed,
		},
		result = "food_meal_pseudodog", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_rat"] = {
		name = "Rat Skewers (Low Quality)",
		desc = [[Use basic cooking knowledge to prepare some Rat Skewers with assorted seasonings and other ingredients.
Trait Requirements: Cooking Level 1
Ingredients: 1x Rat Meat
Results: 1x Rat Skewers]],
		category = "Cooking",
		model = "models/wick/wrbstalker/anomaly/items/wick_meat_tushkano.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/wick_dev_fmradio.mdl",
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
		result = "go_flashlight", --can also be table for multiple results
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
	--passive weapon upgrades
	--generic weapon mag upgrade
	["passiveadd_magup"] = {
		name = "Magazine Upgrade",
		desc = [[temp name maybe
changes the magazine/tube you're using with your weapon. will not work with all weapons
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted

Trait Requirements: Weapon Crafting Level 1
Ingredients: 1x any unequipped weapon, 1x Reinforced Mechanisms, 2x Scrap Metal, 1x Roll of Duct Tape
Result: 1x that unequipped weapon, with the att applied]],
		category = "Weapon Upgrades",
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		--[[
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 1,
			--["comp_scrap_metal"] = 2,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return genericUpgradeValid(items, "mag")
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			genericUpgrade(ply, handpick, "mag")
		end,
	}, 
	--generic match ammo upgrade - not shotgun - go_ammo=go_ammo_match
	--generic jhp ammo upgrade - not shotgun - go_ammo=go_ammo_jhp

	--generic tmj ammo upgrade - not shotgun - go_ammo=go_ammo_tmj
	["passiveadd_ammo_ap"] = {
		name = "Ammo Upgrade (TMJ)",
		desc = [[temp name maybe
changes the ammo type you're using with your weapon. will not work with shotguns.
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted

Trait Requirements: Weapon Crafting Level 1
Ingredients: 1x any unequipped weapon, 1x Reinforced Mechanisms, 2x Scrap Metal, 1x Roll of Duct Tape
Result: 1x that unequipped weapon, with the att applied]],
		category = "Weapon Upgrades",
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		--[[
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 1,
			--["comp_scrap_metal"] = 2,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return genericUpgradeValid(items, "go_ammo_tmj", true)
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			genericUpgrade(ply, handpick, "go_ammo_tmj")
		end,
	}, 
	--generic slug ammo upgrade - shotgun - go_ammo=go_ammo_sg_slug
	["passiveadd_ammo_slug"] = {
		name = "Ammo Upgrade (Slug)",
		desc = [[temp name maybe
changes the ammo type you're using with your weapon. will ONLY work with shotguns.
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted

Trait Requirements: Weapon Crafting Level 1
Ingredients: 1x any unequipped weapon, 1x Reinforced Mechanisms, 2x Scrap Metal, 1x Roll of Duct Tape
Result: 1x that unequipped weapon, with the att applied]],
		category = "Weapon Upgrades",
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		--[[
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 1,
			--["comp_scrap_metal"] = 2,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return genericUpgradeValid(items, "go_ammo_sg_slug", false, true)
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			genericUpgrade(ply, handpick, "go_ammo_sg_slug")
		end,
	}, 
	--generic scatter ammo upgrade - shotgun - go_ammo=go_ammo_sg_scatter
	--generic sabot ammo upgrade - shotgun - go_ammo=go_ammo_sg_sabot
	--generic magnum ammo upgrade - shotgun - go_ammo=go_ammo_sg_magnum
	--generic flechette ammo upgrade - shotgun - go_ammo=go_ammo_sg_flechette
	--generic dragons breath ammo upgrade - shotgun - go_ammo=eap_ammo_dragon
	--todo id like to make this possible somehow but idk, maybe data on item
	["passiveadd_dura"] = {
		name = "Durability Increase",
		desc = [[probably will be renamed eventually
decreases durability taken on firing
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted

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
				if(v.base == "base_cweapon" and v:getData("equip") != true and !v:getData("duraMod")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			item:setData("duraMulti", true) --bool so it can be adjustable
		end,
		--adddata = true,
	},
	--specific weapon upgrades
	--cz75 auto - arccw_go_cz75 - go_cz75_slide=go_cz75_slide_auto
	["weaponmod_cz75_auto"] = {
		name = "CZ-75 Auto Slide Upgrade",
		desc = [[temp name maybe
adds the auto slide upgrade to a cz75
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted

Trait Requirements: Weapon Crafting Level 1
Ingredients: 1x any unequipped weapon, 1x Reinforced Mechanisms, 2x Scrap Metal, 1x Roll of Duct Tape
Result: 1x that unequipped weapon, with the att applied]],
		category = "Weapon Upgrades",
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		--[[
		requirements = { --require for items that will not be taken
			["requireuniqueid"] = true, --or # of needed,
		},
		]]
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 1,
			--["comp_scrap_metal"] = 2,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_cz75", {
				["go_cz75_slide"] = "none",
				["muzzle"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_cz75_slide"] = "go_cz75_slide_auto"
			})
		end,
	}, 
	--fiveseven plus - arccw_go_fiveseven - go_fiveseven_slide=go_fiveseven_slide_long
	--glock long - arccw_go_glock (in general) - go_glock_slide=go_glock_slide_long
	--m92l - arccw_go_m9 - go_m9_slide=go_glock_slide_long
	--p2000l - arccw_go_p2000 - go_p2000_slide=go_p2000_slide_long
	--p250 full - arccw_go_p250 - go_p250_slide=go_p250_slide_long
	--tec9 auto (could generic?) - arccw_go_tec9 - go_perk=go_homemade_auto
	--usp elite - arccw_go_usp - go_usp_slide=go_usp_slide_long
	--mac10 patrol barrel - arccw_go_mac10 - go_mac10_barrel=go_mac10_barrel_med
	--mac10 carbine barrel - arccw_go_mac10 - go_mac10_barrel=go_mac10_barrel_long
	--mp9 plus barrel - arccw_go_mp9 - go_mp9_barrel=go_mp9_barrel_med
	--p90 ps90 barrel - arccw_go_p90 - go_p90_barrel=go_p90_barrel_med
	--bizon gru barrel - arccw_go_bizon - go_bizon_barrel=go_bizon_barrel_long
	--awm ext barrel - arccw_go_awp - go_awp_barrel=go_awp_barrel_long
	--awm bull barrel - arccw_go_awp - go_awp_barrel=go_awp_barrel_bull
	--fal nightstalker barrel - arccw_go_fnfal - go_fal_barrel=go_fal_barrel_sd
	--fal cqc barrel - arccw_go_fnfal - go_fal_barrel=go_fal_barrel_short
	--ssg08 long barrel - arccw_go_ssg08 - go_ssg08_barrel=go_ssg08_barrel_long
	--sawn off m1014 - arccw_go_m1014 - go_m1014_barrel=go_m1014_barrel_short,go_m1014_mag=go_m1014_mag_4
	--m1014 long barrel - arccw_go_m1014 - go_m1014_barrel=go_m1014_barrel_long
	--m249 9mm conv - arccw_go_m249para - go_m249_mag=go_m249_mag_9_200
	--m249 shotgun conv - arccw_go_m249para - go_m249_mag=go_m249_mag_12g_45
	--870 long barrel - arccw_go_870 - go_870_barrel=go_870_barrel_long
	--ace carbine barrel - arccw_go_ace - go_ace_barrel=go_ace_barrel_med
	--famas valorise - arccw_mifl_fas2_famas - mifl_fas2_famas_hg=mifl_fas2_famas_barrel_felin
	--famas whisper - arccw_mifl_fas2_famas - mifl_fas2_famas_hg=mifl_fas2_famas_barrel_sd
	--g36c whisper - arccw_mifl_fas2_g36c - mifl_fas2_g36c_hg=mifl_fas2_g36_barrel_sd
	--g3 whisper - arccw_mifl_fas2_g3 - mifl_fas2_g3_hg=mifl_fas2_g3_hg_sd
	--ks23 colossal barrel - arccw_mifl_fas2_ks23 - mifl_fas2_ks23_barrel=mifl_fas2_ks23_barrel_b
	--m24 m82 barrel - arccw_mifl_fas2_m24 - mifl_fas2_m24_hg=mifl_fas2_m24_hg_82
	--m24 sd barrel - arccw_mifl_fas2_m24 - mifl_fas2_m24_hg=mifl_fas2_m24_hg_sd
	--m24 jungle barrel - arccw_mifl_fas2_m24 - mifl_fas2_m24_hg=mifl_fas2_m24_hg_jungle
	--m4a1 jungle barrel - arccw_mifl_fas2_m4a1 - mifl_fas2_m4a1_hg=mifl_fas2_m4a1_barrel_jungle
	--m4a1 heat barrel - arccw_mifl_fas2_m4a1 - mifl_fas2_m4a1_hg=mifl_fas2_m4a1_barrel_heat
	--m4a1 whisper barrel - arccw_mifl_fas2_m4a1 - mifl_fas2_m4a1_hg=mifl_fas2_m4a1_barrel_sd
	--m4a1 commando barrel - arccw_mifl_fas2_m4a1 - mifl_fas2_m4a1_hg=mifl_fas2_m4a1_barrel_commando
	--m4a1 9mm conv - arccw_mifl_fas2_m4a1 - mifl_fas2_m4a1_mag=mifl_fas2_m4a1_mag_9mm_32
	--p226 long barrel - arccw_mifl_fas2_p226 - mifl_fas2_p226_slide=mifl_fas2_p226_slide_long
	--sg552 whisper barrel - arccw_mifl_fas2_sg55x - mifl_fas2_sg55x_hg=mifl_fas2_sg55x_barrel_sd
	--sr25 whisper barrel - arccw_mifl_fas2_sr25 - mifl_fas2_sr25_hg=mifl_fas2_sr25_barrel_sd


	--melee mods
	["melee_bat_nail"] = {
		name = "Add nails to wooden baseball bat",
		desc = [[adds nails to a wooden baseball bat
needs a wooden baseball bat unequipped in the inventory
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted

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
this upgrade is PERMANENT and cannot be reverted

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
this upgrade is PERMANENT and cannot be reverted

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
this upgrade is PERMANENT and cannot be reverted

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
			data["chest"].level = ARMOR_IIA --should be fine here
			
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
			data["chest"].level = ARMOR_II --should be fine here
			
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
			data["chest"].level = ARMOR_IIIA --should be fine here
			
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
			data["chest"].level = ARMOR_III --should be fine here
			
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
			data["chest"].level = ARMOR_IV --should be fine here
			
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