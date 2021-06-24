local PLUGIN = PLUGIN

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
local ammoCheck = {
	["go_ammo"] = true,
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
						--prevent upgrading mags while having an ammo upgrade
						--i dont think this is actually necessary anymore but keeping for now
						--[[for k,v in pairs(ammoCheck) do
							if(atts[k]) then
								return
							end
						end]]
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
local sawnOffAtts = {
	["cwep_870"] = {
		["go_870_barrel"] = "go_870_barrel_short",
		["go_870_mag"] = "go_870_mag_4",
		["go_870_stock"] = "go_870_stock_sawnoff"
	},
	["cwep_toz34"] = {
		["mifl_fas2_toz34_bar"] = "mifl_fas2_toz_bar_2x_s",
		["mifl_fas2_ks23_stock"] = "mifl_fas2_ks23_stock_k",
	},
	["cwep_doublebarrel"] = {
		["waw_dbs_barrel"] = "bo1_dbs_barrel_sawnoff",
		["bo1_mp5stock"] = "bo1_solider_stock", --will remove it if existing
	},
	["cwep_m1014"] = {
		["go_m1014_barrel"] = "go_m1014_barrel_short",
		["go_m1014_mag"] = "go_m1014_mag_4",
		["go_stock_none"] = "go_stock_none"
	},
}
local minSawn = {
	["cwep_m1014"] = 2, --2 atts need to have been changed to be good
	["cwep_870"] = 2,
	--the 2 double barrels wont ever need this imo, even if the toz's other barrels are added
}
local function setSawnAtts(src, name)
	local at = src or {}
	local appl = 0
	for k,v in pairs(sawnOffAtts[name]) do
		--want to keep the capability for like a long barreled 870 or m1014 with a custom stock lmao
		if(at[k] == v) then atk[k] = nil continue end
		if(at[k] != nil and at[k] != "none") then continue end
		at[k] = v
		appl = appl + 1
	end
	--tripping the minimum count, if the amount applied meets or is less than whats defined
	--it will force change all of them, this is to prevent abuse (ex having a 3 width m1014 that has 7 rounds, a long barrel, and a custom stock. having one of these in the newly created sawnoff version is fine, having multiple is not imo)
	if(minSawn[name] and minSawn[name] >= appl) then
		nut.log.addRaw("whoever just used a sawnoff recipe lost existing conflicting atts becuz too few were changed initially! this is an intentional feature to prevent abuse")
		for k,v in pairs(sawnOffAtts[name]) do --fuckem, apply them all
			at[k] = v
		end
	end
	nut.traits.addXp(ply, "crafting_spec", 1)
	return at
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
		desc = [[A simple bandage.]],
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
		desc = [[Increase the quality of a bandage by using a jar of antiseptics.]],
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
		desc = [[Combine various things to make a basic medkit.]],
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
		result = "medkit", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},

	--crafting
	["comp_mech1"] = {
		name = "Craft Light Mechanisms",
		desc = [[Fashions the scrap into some various springs and mechanisms.]],
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
		desc = [[Does some stuff to make the assorted mechanisms sturdier.]],
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
		desc = [[Does some stuff to make a more thick cloth.]],
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
	["cook_blood_vodka"] = {
		name = "Bloodsucker Goulash (Vodka Quality)",
		desc = [[Use more advanced cooking knowledge to create a Bloodsucker Goulash out of Bloodsucker meat and assorted spices and other ingredients.
Add in some vodka to negate the negative effects.]],
		category = "Cooking (Vodka Quality)",
		model = "models/wick/wrbstalker/anomaly/items/wick_meat_bloodsucker.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 2,--min level needed or true for no level ones,
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
		customIng = "1x Any Vodka",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_vodka")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_blood"] = 1, --or # of needed,
		},
		result = "food_meal_a_blood", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_boar_vodka"] = {
		name = "Boar Chops (Vodka Quality)",
		desc = [[Use more advanced cooking knowledge to prepare some Boar Chops with assorted seasonings and other ingredients.
Add in some vodka to negate the negative effects.]],
		category = "Cooking (Vodka Quality)",
		model = "models/wick/wrbstalker/anomaly/items/wick_meat_boar.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 2,--min level needed or true for no level ones,
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
		customIng = "1x Any Vodka",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_vodka")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_boar"] = 1, --or # of needed,
		},
		result = "food_meal_a_boar", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_dog_vodka"] = {
		name = "Dog Chops (Vodka Quality)",
		desc = [[Use more advanced cooking knowledge to prepare some Dog meat with assorted seasonings and other ingredients.
Add in some vodka to negate the negative effects.]],
		category = "Cooking (Vodka Quality)",
		model = "models/wick/wrbstalker/anomaly/items/wick_meat_dog.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 2,--min level needed or true for no level ones,
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
		customIng = "1x Any Vodka",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_vodka")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_dog"] = 1, --or # of needed,
		},
		result = "food_meal_a_dog", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_chimera_vodka"] = {
		name = "Chimera Meat (Vodka Quality)",
		desc = [[Use more advanced cooking knowledge to prepare some Chimera meat with assorted seasonings and other ingredients.
Add in some vodka to negate the negative effects.]],
		category = "Cooking (Vodka Quality)",
		model = "models/wick/wrbstalker/anomaly/items/wick_chimera_food.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 2,--min level needed or true for no level ones,
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
		customIng = "1x Any Vodka",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_vodka")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_chimera"] = 1, --or # of needed,
		},
		result = "food_meal_a_chimera", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_flesh_vodka"] = {
		name = "Flesh Bacon (Vodka Quality)",
		desc = [[Use more advanced cooking knowledge to turn some Flesh meat into some fat and greasy bacon.
Add in some vodka to negate the negative effects.]],
		category = "Cooking (Vodka Quality)",
		model = "models/wick/wrbstalker/anomaly/items/wick_meat_flesh.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 2,--min level needed or true for no level ones,
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
		customIng = "1x Any Vodka",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_vodka")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_flesh"] = 1, --or # of needed,
		},
		result = "food_meal_a_flesh", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_pseudodog_vodka"] = {
		name = "Pseudodog Chops (Vodka Quality)",
		desc = [[Use more advanced cooking knowledge to prepare some Pseudodog Chops with assorted seasonings and other ingredients.
Add in some vodka to negate the negative effects.]],
		category = "Cooking (Vodka Quality)",
		model = "models/wick/wrbstalker/anomaly/items/wick_meat_pseudodog.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 2,--min level needed or true for no level ones,
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
		customIng = "1x Any Vodka",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_vodka")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_pseudodog"] = 1, --or # of needed,
		},
		result = "food_meal_a_pseudodog", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_rat_vodka"] = {
		name = "Rat Skewers (Vodka Quality)",
		desc = [[Use more advanced cooking knowledge to prepare some Rat Skewers with assorted seasonings and other ingredients.
Add in some vodka to negate the negative effects.]],
		category = "Cooking (Vodka Quality)",
		model = "models/wick/wrbstalker/anomaly/items/wick_meat_tushkano.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 2,--min level needed or true for no level ones,
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
		customIng = "1x Any Vodka",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_vodka")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_rat"] = 1, --or # of needed,
		},
		result = "food_meal_a_rat", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_snork_vodka"] = {
		name = "Snork Hand (Vodka Quality)",
		desc = [[Use more advanced cooking knowledge to prepare a Grilled Snork Hand.
Add in some vodka to negate the negative effects.]],
		category = "Cooking (Vodka Quality)",
		model = "models/kek1ch/snork_food.mdl",
		--skin = skin of model (not required),
		workbench = {["cooking"]=true,},
		traits = { --traits requirements
			["crafting_cook"] = 2,--min level needed or true for no level ones,
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
		customIng = "1x Any Vodka",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_vodka")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_snork"] = 1, --or # of needed,
		},
		result = "food_meal_a_snork", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_blood_water"] = {
		name = "Bloodsucker Goulash (Water Quality)",
		desc = [[Use basic cooking knowledge to create a Bloodsucker Goulash out of Bloodsucker meat and assorted spices and other ingredients.
Add in some water to reduce negative effects.]],
		category = "Cooking (Water Quality)",
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
		customIng = "1x Any Clean Water",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_water")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_blood"] = 1, --or # of needed,
		},
		result = "food_meal_b_blood", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_boar_water"] = {
		name = "Boar Chops (Water Quality)",
		desc = [[Use basic cooking knowledge to prepare some Boar Chops with assorted seasonings and other ingredients.
Add in some water to reduce negative effects.]],
		category = "Cooking (Water Quality)",
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
		customIng = "1x Any Clean Water",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_water")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_boar"] = 1, --or # of needed,
		},
		result = "food_meal_b_boar", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_dog_water"] = {
		name = "Dog Chops (Water Quality)",
		desc = [[Use basic cooking knowledge to prepare some Dog meat with assorted seasonings and other ingredients.
Add in some water to reduce negative effects.]],
		category = "Cooking (Water Quality)",
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
		customIng = "1x Any Clean Water",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_water")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_dog"] = 1, --or # of needed,
		},
		result = "food_meal_b_dog", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_chimera_water"] = {
		name = "Chimera Meat (Water Quality)",
		desc = [[Use basic cooking knowledge to prepare some Chimera meat with assorted seasonings and other ingredients.
Add in some water to reduce negative effects.]],
		category = "Cooking (Water Quality)",
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
		customIng = "1x Any Clean Water",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_water")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_chimera"] = 1, --or # of needed,
		},
		result = "food_meal_b_chimera", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_flesh_water"] = {
		name = "Flesh Bacon (Water Quality)",
		desc = [[Use basic cooking knowledge to turn some Flesh meat into some fat and greasy bacon.
Add in some water to reduce negative effects.]],
		category = "Cooking (Water Quality)",
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
		customIng = "1x Any Clean Water",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_water")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_flesh"] = 1, --or # of needed,
		},
		result = "food_meal_b_flesh", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_pseudodog_water"] = {
		name = "Pseudodog Chops (Water Quality)",
		desc = [[Use basic cooking knowledge to prepare some Pseudodog Chops with assorted seasonings and other ingredients.
Add in some water to reduce negative effects.]],
		category = "Cooking (Water Quality)",
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
		customIng = "1x Any Clean Water",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_water")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_pseudodog"] = 1, --or # of needed,
		},
		result = "food_meal_b_pseudodog", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_rat_water"] = {
		name = "Rat Skewers (Water Quality)",
		desc = [[Use basic cooking knowledge to prepare some Rat Skewers with assorted seasonings and other ingredients.
Add in some water to reduce negative effects.]],
		category = "Cooking (Water Quality)",
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
		customIng = "1x Any Clean Water",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_water")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_rat"] = 1, --or # of needed,
		},
		result = "food_meal_b_rat", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_snork_water"] = {
		name = "Snork Hand (Water Quality)",
		desc = [[Use basic cooking knowledge to prepare a Grilled Snork Hand.
Add in some water to reduce negative effects.]],
		category = "Cooking (Water Quality)",
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
		customIng = "1x Any Clean Water",
		handpick = function(items) --pick an item 
			for k,v in pairs(items) do
				if(v.uniqueID:find("_water")) then
					return k
				end
			end
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			local item = nut.item.instances[handpick]
			if(item:getData("uses", item.uses) <= 1) then --1 or less
				items[handpick] = item --add it to the list for removal
			else
				item:setData("uses", item:getData("uses", item.uses)-1)
			end
		end,
		ingredients = { --items that will be taken
			["food_meat_snork"] = 1, --or # of needed,
		},
		result = "food_meal_b_snork", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["cook_blood"] = {
		name = "Bloodsucker Goulash (Low Quality)",
		desc = [[Use basic cooking knowledge to create a Bloodsucker Goulash out of Bloodsucker meat and assorted spices and other ingredients.]],
		category = "Cooking (Low Quality)",
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
		desc = [[Use basic cooking knowledge to prepare some Boar Chops with assorted seasonings and other ingredients.]],
		category = "Cooking (Low Quality)",
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
		desc = [[Use basic cooking knowledge to prepare some Dog meat with assorted seasonings and other ingredients.]],
		category = "Cooking (Low Quality)",
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
		desc = [[Use basic cooking knowledge to prepare some Chimera meat with assorted seasonings and other ingredients.]],
		category = "Cooking (Low Quality)",
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
		desc = [[Use basic cooking knowledge to turn some Flesh meat into some fat and greasy bacon.]],
		category = "Cooking (Low Quality)",
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
		desc = [[Use basic cooking knowledge to prepare some Pseudodog Chops with assorted seasonings and other ingredients.]],
		category = "Cooking (Low Quality)",
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
		desc = [[Use basic cooking knowledge to prepare some Rat Skewers with assorted seasonings and other ingredients.]],
		category = "Cooking (Low Quality)",
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
		desc = [[Use basic cooking knowledge to prepare a Grilled Snork Hand.]],
		category = "Cooking (Low Quality)",
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
	--6x Scrap Metal, 5x Wire Spool, 6x Basic Tech, 
	--special yes
	["maki_special"] = {
		name = "Craft KAMI",
		desc = [[Creates a specialized hack tool.]],
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
			--["comp_scrap_metal"] = 6,
			--["comp_wire1"] = 5, --or # of needed,
			--["comp_tech1"] = 6,
			--["comp_duct_tape"] = 2, --removing this, replacing with higher requirements elsewhere
			["datachik1"] = 1,
			["datachik2"] = 1,
			["datachik3"] = 1,
			["junk_vpx"] = 1,
		},
		result = "hacktool_maki", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	["maki_remote"] = {
		name = "Craft Hack Remote",
		desc = [[Creates an experimental remote hack source.]],
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
			["comp_scrap_metal"] = 2,
			["comp_wire1"] = 1, --or # of needed,
			["comp_tech1"] = 3,
			--["comp_duct_tape"] = 2, --removing this, replacing with higher requirements elsewhere
			--["datachik1"] = 1,
			--["datachik2"] = 1,
			["datachik3"] = 1,
		},
		result = "hack_remote", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	/*
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
		ingredients = { --items that will be taken
			["comp_scrap_metal"] = 3, --or # of needed,
			["comp_mech1"] = 1,
			["comp_tech1"] = 2,
			["comp_duct_tape"] = 1,
			["comp_wire1"] = 1,
		},
		result = "flashlight", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},*/
	["craft_flashlight"] = {
		name = "Craft Flashlight",
		desc = [[Create a flashlight out of various bits.]],
		category = "Items",
		model = "models/props_junk/cardboard_box004a.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting"] = 1,
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
		desc = [[Create a makeshift radio out of various bits.]],
		category = "Items",
		model = "models/wick/wrbstalker/anomaly/items/wick_dev_fmradio.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting"] = 1,
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
			["comp_wire1"] = 2,
		},
		result = "radio", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	
	["craft_flashlightatt"] = {
		name = "Flashlight -> Flashlight Attachment",
		desc = [[Turn a flashlight into a kind that you can mount on a gun.]],
		category = "Items",
		model = "models/Items/BoxMRounds.mdl",
		skin = 0,
		workbench = {["basic"]=true,},
		traits = { --traits requirements
			["crafting"] = 1,
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
		desc = [[Create a remotely triggered IED.]],
		category = "Items",
		model = "models/Items/BoxMRounds.mdl",
		skin = 0,
		workbench = {["basic"]=true,["weapons"] = true},
		traits = { --traits requirements
			["crafting"] = 1,
			["crafting_tech"] = 3,--min level needed or true for no level ones,
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
			--["comp_wire1"] = 1,
			["comp_tech1"] = 3,
		},
		result = "ied", --can also be table for multiple results
		--flag = "", --optional can be left out, flag to check for
	},
	
	--craft weps

	--weapon conversions
	--passive weapon upgrades
	--generic weapon mag upgrade
	["passiveadd_magup"] = {
		name = "Magazine Upgrade",
		desc = [[temp name maybe
changes the magazine/tube you're using with your weapon. will not work with all weapons. if it does not find the weapon it has already been upgraded or cannot be upgraded
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Generic Weapon Upgrades",
		model = "models/Items/BoxMRounds.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped weapon",
		customRes = "1x that unequipped weapon with the upgrade applied",
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
	--Trait Requirements: Weapon Crafting Level 1 - just in case removing trait requirements for spec ammo is a bad idea
	--generic match ammo upgrade - not shotgun - go_ammo=go_ammo_match
	["passiveadd_ammo_match"] = {
		name = "Ammo Upgrade (Match)",
		desc = [[temp name maybe
changes the ammo type you're using with your weapon. will not work with shotguns.
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_ammo_match.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,},
		--traits = { --traits requirements
		--	["crafting_weapon"] = 1,--min level needed or true for no level ones,
		--},
		customIng = "1x any unequipped applicable weapon",
		customRes = "1x that unequipped weapon with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 1,
			--["comp_scrap_metal"] = 2,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return genericUpgradeValid(items, "go_ammo_match", true)
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			genericUpgrade(ply, handpick, "go_ammo_match")
		end,
	}, 
	--generic jhp ammo upgrade - not shotgun - go_ammo=go_ammo_jhp
	["passiveadd_ammo_jhp"] = {
		name = "Ammo Upgrade (JHP)",
		desc = [[temp name maybe
changes the ammo type you're using with your weapon. will not work with shotguns.
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory]],
		category = "Generic Weapon Upgrades",
		workbench = {["basic"]=true,["weapons"]=true,},
		render = {
			icon = "entities/acwatt_go_ammo_jhp.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		--traits = { --traits requirements
		--	["crafting_weapon"] = 1,--min level needed or true for no level ones,
		--},
		customIng = "1x any unequipped applicable weapon",
		customRes = "1x that unequipped weapon with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 1,
			--["comp_scrap_metal"] = 2,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return genericUpgradeValid(items, "go_ammo_jhp", true)
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			genericUpgrade(ply, handpick, "go_ammo_jhp")
		end,
	}, 
	--generic tmj ammo upgrade - not shotgun - go_ammo=go_ammo_tmj
	["passiveadd_ammo_ap"] = {
		name = "Ammo Upgrade (TMJ)",
		desc = [[temp name maybe
changes the ammo type you're using with your weapon. will not work with shotguns.
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory]],
		category = "Generic Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_ammo_tmj.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		--traits = { --traits requirements
		--	["crafting_weapon"] = 1,--min level needed or true for no level ones,
		--},
		customIng = "1x any unequipped applicable weapon",
		customRes = "1x that unequipped weapon with the upgrade applied",
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
	["passiveadd_ammo_remove"] = {
		name = "Ammo Upgrade (Remove)",
		desc = [[temp name maybe
removes the special ammo type you're using with your weapon.
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory]],
		category = "Generic Weapon Upgrades",
		render = {
			icon = "arccw/hud/atts/default.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		--traits = { --traits requirements
		--	["crafting_weapon"] = 1,--min level needed or true for no level ones,
		--},
		customIng = "1x any unequipped applicable weapon",
		customRes = "1x that unequipped weapon with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 1,
			--["comp_scrap_metal"] = 2,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return genericUpgradeValid(items, nil, false, false)
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			genericUpgrade(ply, handpick)
		end,
	}, 
	--generic slug ammo upgrade - shotgun - go_ammo=go_ammo_sg_slug
	--, 1x Reinforced Mechanisms, 2x Scrap Metal, 1x Roll of Duct Tape
	["passiveadd_ammo_slug"] = {
		name = "Ammo Upgrade (Slug)",
		desc = [[temp name maybe
changes the ammo type you're using with your weapon. will ONLY work with shotguns.
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory]],
		category = "Generic Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_ammo_sg_slug.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["basic"]=true,["weapons"]=true,},
		--traits = { --traits requirements
		--	["crafting_weapon"] = 1,--min level needed or true for no level ones,
		--},
		customIng = "1x any unequipped applicable weapon",
		customRes = "1x that unequipped weapon with the upgrade applied",
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
this upgrade is PERMANENT and cannot be reverted]],
		category = "Generic Weapon Upgrades",
		model = "models/Items/BoxMRounds.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped applicable weapon",
		customRes = "1x that unequipped weapon with the upgrade applied",
		ingredients = { --items that will be taken
			--["wep_glocka"] = true, --or # of needed,
			--["jar_antiseptic"] = true,
			["comp_mech2"] = 1,
			["comp_scrap_metal"] = 3,
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
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_cz75_slide_auto.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit2"] = true, },
		customIng = "1x any unequipped CZ75",
		customRes = "1x that unequipped CZ75 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			["comp_mech2"] = 2,
			["comp_scrap_metal"] = 2,
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
	["weaponmod_fiveseven_long"] = {
		name = "Five-seveN Plus Slide Upgrade",
		desc = [[temp name maybe
adds the long plus slide to a fiveseven
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_fiveseven_slide_long.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped Five-seveN",
		customRes = "1x that unequipped Five-seveN with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_fiveseven", {
				["go_fiveseven_slide"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_fiveseven_slide"] = "go_fiveseven_slide_long",
			})
		end,
	}, 
	--glock long - arccw_go_glock (in general) - go_glock_slide=go_glock_slide_long
	["weaponmod_glock_long"] = {
		name = "Glock Long Slide Upgrade",
		desc = [[temp name maybe
adds the long slide upgrade to any normal length glock (17, 21)
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_glock_slide_long.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped applicable Glock",
		customRes = "1x that unequipped applicable Glock with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_glock", {
				["go_glock_slide"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_glock_slide"] = "go_glock_slide_long"
			})
		end,
	}, 
	--m92l - arccw_go_m9 - go_m9_slide=go_m9_slide_long
	["weaponmod_m9_long"] = {
		name = "M92FS Long Slide Upgrade",
		desc = [[temp name maybe
adds the long slide upgrade to a M92FS
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_m9_slide_long.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped M92FS",
		customRes = "1x that unequipped M92FS with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_m9", {
				["go_m9_slide"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_m9_slide"] = "go_m9_slide_long"
			})
		end,
	}, 
	--p2000l - arccw_go_p2000 - go_p2000_slide=go_p2000_slide_long
	["weaponmod_p2000_long"] = {
		name = "P2000 Long Slide Upgrade",
		desc = [[temp name maybe
adds the long slide upgrade to a P2000
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_p2000_slide_long.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped P2000",
		customRes = "1x that unequipped P2000 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_p2000", {
				["go_p2000_slide"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_p2000_slide"] = "go_p2000_slide_long"
			})
		end,
	}, 
	--p250 full - arccw_go_p250 - go_p250_slide=go_p250_slide_long
	["weaponmod_p250_long"] = {
		name = "P250 Full Slide Upgrade",
		desc = [[temp name maybe
adds the full slide upgrade to a P250
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_p250_slide_long.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped P250",
		customRes = "1x that unequipped P250 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_p250", {
				["go_p250_slide"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_p250_slide"] = "go_p250_slide_long"
			})
		end,
	}, 
	--tec9 auto (could generic?) - arccw_go_tec9 - go_perk=go_homemade_auto
	["weaponmod_tec9_auto"] = {
		name = "TEC-9 Automatic Upgrade",
		desc = [[temp name maybe
makes the TEC-9 automatic, *slightly* illegal
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_homemade_auto.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit2"] = true, },
		customIng = "1x any unequipped TEC-9",
		customRes = "1x that unequipped TEC-9 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			["comp_mech2"] = 3,
			["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			--thisll fuck shit up if i decide to implement some of the perks but eh
			return specificUpgradeValid(items, "arccw_go_tec9", {
				["go_perk"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_perk"] = "go_homemade_auto"
			})
		end,
	}, 
	--usp elite - arccw_go_usp - go_usp_slide=go_usp_slide_long
	["weaponmod_usp_long"] = {
		name = "USP Elite Slide Upgrade",
		desc = [[temp name maybe
adds the full slide upgrade to any non-match USP
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_usp_slide_long.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped USP",
		customRes = "1x that unequipped USP with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_usp", {
				["go_usp_slide"] = "none",
				["go_muzzle_usp"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_usp_slide"] = "go_usp_slide_long"
			})
		end,
	}, 
	--mac10 patrol barrel - arccw_go_mac10 - go_mac10_barrel=go_mac10_barrel_med
	["weaponmod_mac10_med"] = {
		name = "MAC-10 Patrol Barrel Upgrade",
		desc = [[temp name maybe
adds the medium-length patrol barrel upgrade to a MAC-10
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_mac10_barrel_med.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped MAC-10",
		customRes = "1x that unequipped MAC-10 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 2,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_mac10", {
				["go_mac10_barrel"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_mac10_barrel"] = "go_mac10_barrel_med"
			})
		end,
	}, 
	--mac10 carbine barrel - arccw_go_mac10 - go_mac10_barrel=go_mac10_barrel_long
	["weaponmod_mac10_long"] = {
		name = "MAC-10 Carbine Barrel Upgrade",
		desc = [[temp name maybe
adds the long carbine barrel upgrade to a MAC-10
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_mac10_barrel_long.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped MAC-10",
		customRes = "1x that unequipped MAC-10 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 5,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_mac10", {
				["go_mac10_barrel"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_mac10_barrel"] = "go_mac10_barrel_long"
			})
		end,
	}, 
	--mp9 plus barrel - arccw_go_mp9 - go_mp9_barrel=go_mp9_barrel_med
	["weaponmod_mp9_med"] = {
		name = "MP9 Plus Barrel Upgrade",
		desc = [[temp name maybe
adds the plus barrel upgrade to a MP9
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_mp9_barrel_med.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped MP9",
		customRes = "1x that unequipped MP9 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 2,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_mp9", {
				["go_mp9_barrel"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_mp9_barrel"] = "go_mp9_barrel_med"
			})
		end,
	}, 
	--p90 ps90 barrel - arccw_go_p90 - go_p90_barrel=go_p90_barrel_med
	["weaponmod_p90_med"] = {
		name = "P90 PS Barrel Upgrade",
		desc = [[temp name maybe
adds the PS90 barrel upgrade to a P90
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_p90_barrel_med.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped P90",
		customRes = "1x that unequipped P90 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 2,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_p90", {
				["go_p90_barrel"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_p90_barrel"] = "go_p90_barrel_med"
			})
		end,
	}, 
	--bizon gru barrel - arccw_go_bizon - go_bizon_barrel=go_bizon_barrel_long
	["weaponmod_bizon_long"] = {
		name = "Bizon GRU Barrel Upgrade",
		desc = [[temp name maybe
adds the GRU long barrel upgrade to a Bizon
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_bizon_barrel_long.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped Bizon",
		customRes = "1x that unequipped Bizon with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 6,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_bizon", {
				["go_bizon_barrel"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_bizon_barrel"] = "go_bizon_barrel_long"
			})
		end,
	}, 
	--awm ext barrel - arccw_go_awp - go_awp_barrel=go_awp_barrel_long
	["weaponmod_awp_long"] = {
		name = "AWM Extended Barrel Upgrade",
		desc = [[temp name maybe
adds the long barrel upgrade to an AWM
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_awp_barrel_long.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit2"] = true, },
		customIng = "1x any unequipped AWM",
		customRes = "1x that unequipped AWM with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 5,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_awp", {
				["go_awp_barrel"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_awp_barrel"] = "go_awp_barrel_long"
			})
		end,
	}, 
	--awm bull barrel - arccw_go_awp - go_awp_barrel=go_awp_barrel_bull
	["weaponmod_awp_bull"] = {
		name = "AWM Bull Barrel Upgrade",
		desc = [[temp name maybe
adds a custom shorter barrel upgrade to an AWM
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_awp_barrel_bull.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit2"] = true, },
		customIng = "1x any unequipped AWM",
		customRes = "1x that unequipped AWM with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 6,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_awp", {
				["go_awp_barrel"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_awp_barrel"] = "go_awp_barrel_bull"
			})
		end,
	}, 
	--fal nightstalker barrel - arccw_go_fnfal - go_fal_barrel=go_fal_barrel_sd
	["weaponmod_fal_sd"] = {
		name = "Fal Nightstalker Barrel Upgrade",
		desc = [[temp name maybe
adds a custom made internal suppressor upgrade to a FN Fal Para
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_fal_barrel_sd.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit3"] = true, },
		customIng = "1x any unequipped Fal",
		customRes = "1x that unequipped Fal with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 12,
			["comp_pad_cloth"] = 5,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_fnfal", {
				["go_fal_barrel"] = "none",
				["muzzle"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_fal_barrel"] = "go_fal_barrel_sd"
			})
		end,
	}, 
	--fal cqc barrel - arccw_go_fnfal - go_fal_barrel=go_fal_barrel_short
	["weaponmod_fal_cqc"] = {
		name = "Fal CQC Barrel Upgrade",
		desc = [[temp name maybe
adds the CQC short barrel upgrade to a FN Fal Para
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_fal_barrel_short.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped Fal",
		customRes = "1x that unequipped Fal with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 7,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_fnfal", {
				["go_fal_barrel"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_fal_barrel"] = "go_fal_barrel_short"
			})
		end,
	}, 
	--ssg08 long barrel - arccw_go_ssg08 - go_ssg08_barrel=go_ssg08_barrel_long
	["weaponmod_ssg08_long"] = {
		name = "SSG08 Long Barrel Upgrade",
		desc = [[temp name maybe
adds the long barrel upgrade to a SSG08
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_ssg08_barrel_long.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped SSG08",
		customRes = "1x that unequipped SSG08 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 4,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_ssg08", {
				["go_ssg08_barrel"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_ssg08_barrel"] = "go_ssg08_barrel_long"
			})
		end,
	}, 
	--sawn off m1014 - arccw_go_m1014 - go_m1014_barrel=go_m1014_barrel_short,go_m1014_mag=go_m1014_mag_4
	["weaponmod_m1014_sawn"] = {
		name = "M1014 Sawn-off Conversion",
		desc = [[temp name maybe
removes the stock and saws off most of the barrel of a M1014, also reduces its tube size to 4 shells. will retain any atts and etc the source weapon has (existing atts in the same slot take priority)
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Conversions",
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["cwep_m1014"] = true,
			--["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		result = "cwep_m1014sawn",
		--flag = "", --optional can be left out, flag to check for
		beforeCraft = function(ply, items)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			local data = {}
			for k,v in pairs(items) do
				if(v.uniqueID == "cwep_m1014") then
					data = v:getData(true) --this apparently gets all data
					break
				end
			end
			if(data and table.Count(data) != 0) then
				data.atts = setSawnAtts(data.atts, "cwep_m1014")
				--data["ammo"] = nil --actually shouldnt need to worry about this tbh, it doesnt let it get over the mag size unlike a certain other base lmao
				return data
			end
		end,
		adddata = true,
	}, 
	--m1014 long barrel - arccw_go_m1014 - go_m1014_barrel=go_m1014_barrel_long
	["weaponmod_m1014_long"] = {
		name = "M1014 Long Barrel Upgrade",
		desc = [[temp name maybe
adds the long barrel upgrade to a M1014
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_m1014_barrel_long.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped M1014",
		customRes = "1x that unequipped M1014 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_m1014", {
				["go_m1014_barrel"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_m1014_barrel"] = "go_m1014_barrel_long"
			})
		end,
	}, 
	--comebackto
	--m249 9mm conv - arccw_go_m249para - go_m249_mag=go_m249_mag_9_200
	--m249 shotgun conv - arccw_go_m249para - go_m249_mag=go_m249_mag_12g_45
	--870 conversion to sawn off
	["weaponmod_870_sawn"] = {
		name = "Remington Model 870 Sawn-off Conversion",
		desc = [[temp name maybe
saws off stock and most of the barrel of a 870, also reduces its tube size to 4 shells. will retain any atts and etc the source weapon has (existing atts in the same slot take priority)
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Conversions",
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["cwep_870"] = true,
			--["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		result = "cwep_870sawn",
		--flag = "", --optional can be left out, flag to check for
		beforeCraft = function(ply, items)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			local data = {}
			for k,v in pairs(items) do
				if(v.uniqueID == "cwep_870") then
					data = v:getData(true) --this apparently gets all data
					break
				end
			end
			if(data and table.Count(data) != 0) then
				data.atts = setSawnAtts(data.atts, "cwep_870")
				return data
			end
		end,
		adddata = true,
	}, 
	--870 long barrel - arccw_go_870 - go_870_barrel=go_870_barrel_long
	["weaponmod_870_long"] = {
		name = "Remington Model 870 Long Barrel Upgrade",
		desc = [[temp name maybe
adds the long barrel upgrade to a full M870
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_870_barrel_long.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped M870",
		customRes = "1x that unequipped M870 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 4,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_870", {
				["go_870_barrel"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_870_barrel"] = "go_870_barrel_long"
			})
		end,
	}, 
	--ace carbine barrel - arccw_go_ace - go_ace_barrel=go_ace_barrel_med
	["weaponmod_ace_med"] = {
		name = "ACE Series Carbine Barrel Upgrade",
		desc = [[temp name maybe
adds the medium-length carbine barrel upgrade to an ACE
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/acwatt_go_ace_barrel_med.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped ACE",
		customRes = "1x that unequipped ACE with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 2,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_go_ace", {
				["go_ace_barrel"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["go_ace_barrel"] = "go_ace_barrel_med"
			})
		end,
	}, 
	--famas valorise - arccw_mifl_fas2_famas - mifl_fas2_famas_hg=mifl_fas2_famas_barrel_felin
	["weaponmod_famas_felin"] = {
		name = "FAMAS Valorise Frame Upgrade",
		desc = [[temp name maybe very temp
adds the custom Valorise frame upgrade to a FAMAS
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_famas_hg_felin.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit3"] = true, },
		customIng = "1x any unequipped FAMAS",
		customRes = "1x that unequipped FAMAS with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 15,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_famas", {
				["mifl_fas2_famas_hg"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_famas_hg"] = "mifl_fas2_famas_barrel_felin"
			})
		end,
	}, 
	--famas whisper - arccw_mifl_fas2_famas - mifl_fas2_famas_hg=mifl_fas2_famas_barrel_sd
	["weaponmod_famas_whisper"] = {
		name = "FAMAS Whsiper Frame Upgrade",
		desc = [[temp name maybe very temp
adds the custom internally suppressed frame upgrade to a FAMAS
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_famas_hg_sd.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit3"] = true, },
		customIng = "1x any unequipped FAMAS",
		customRes = "1x that unequipped FAMAS with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 12,
			["comp_pad_cloth"] = 5,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_famas", {
				["mifl_fas2_famas_hg"] = "none",
				["muzzle"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_famas_hg"] = "mifl_fas2_famas_barrel_sd"
			})
		end,
	}, 
	--g36c whisper - arccw_mifl_fas2_g36c - mifl_fas2_g36c_hg=mifl_fas2_g36_barrel_sd
	["weaponmod_g36c_whisper"] = {
		name = "G36C Whsiper Handguard Upgrade",
		desc = [[temp name maybe very temp
adds the custom internally suppressed handguard upgrade to a G36C
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_g36_hg_sd.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit3"] = true, },
		customIng = "1x any unequipped G36C",
		customRes = "1x that unequipped G36C with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 10,
			["comp_pad_cloth"] = 4,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_g36c", {
				["mifl_fas2_g36c_hg"] = "none",
				["muzzle"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_g36c_hg"] = "mifl_fas2_g36_barrel_sd"
			})
		end,
	}, 
	--g3 whisper - arccw_mifl_fas2_g3 - mifl_fas2_g3_hg=mifl_fas2_g3_hg_sd
	["weaponmod_g3_whisper"] = {
		name = "G3A3 Whsiper Handguard Upgrade",
		desc = [[temp name maybe very temp
adds the custom internally suppressed handguard upgrade to a G3A3
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_g3_hg_sd.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit3"] = true, },
		customIng = "1x any unequipped G3A3",
		customRes = "1x that unequipped G3A3 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 10,
			["comp_pad_cloth"] = 5,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_g3", {
				["mifl_fas2_g3_hg"] = "none",
				["muzzle"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_g3_hg"] = "mifl_fas2_g3_hg_sd"
			})
		end,
	}, 
	--ks23 colossal barrel - arccw_mifl_fas2_ks23 - mifl_fas2_ks23_barrel=mifl_fas2_ks23_barrel_b
	--m24 m82 barrel - arccw_mifl_fas2_m24 - mifl_fas2_m24_hg=mifl_fas2_m24_hg_82
	--m24 sd barrel - arccw_mifl_fas2_m24 - mifl_fas2_m24_hg=mifl_fas2_m24_hg_sd
	["weaponmod_m24_sd"] = {
		name = "M24 SD Barrel Upgrade",
		desc = [[temp name maybe very temp
adds the custom internally suppressed barrel upgrade to a M24
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_m24_br_sd.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit3"] = true, },
		customIng = "1x any unequipped M24",
		customRes = "1x that unequipped M24 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 12,
			["comp_pad_cloth"] = 5,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_m24", {
				["mifl_fas2_m24_hg"] = "none",
				["muzzle"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_m24_hg"] = "mifl_fas2_m24_hg_sd"
			})
		end,
	}, 
	--m24 jungle barrel - arccw_mifl_fas2_m24 - mifl_fas2_m24_hg=mifl_fas2_m24_hg_jungle
	["weaponmod_m24_jungle"] = {
		name = "M24 Jungle Barrel Upgrade",
		desc = [[temp name maybe very temp
adds the custom internally suppressed barrel upgrade to a M24
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_m24_br_jungle.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit3"] = true, },
		customIng = "1x any unequipped M24",
		customRes = "1x that unequipped M24 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 12,
			["comp_pad_cloth"] = 6,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_m24", {
				["mifl_fas2_m24_hg"] = "none",
				["muzzle"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_m24_hg"] = "mifl_fas2_m24_hg_jungle"
			})
		end,
	}, 
	--m4a1 jungle barrel - arccw_mifl_fas2_m4a1 - mifl_fas2_m4a1_hg=mifl_fas2_m4a1_barrel_jungle
	["weaponmod_m4a1_jungle"] = {
		name = "M4A1 Jungle Handguard Upgrade",
		desc = [[temp name maybe very temp
adds the custom internally suppressed handguard upgrade to a M4A1
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_m4a1_hg_jungle.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit3"] = true, },
		customIng = "1x any unequipped M4A1",
		customRes = "1x that unequipped M4A1 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 12,
			["comp_pad_cloth"] = 6,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_m4a1", {
				["mifl_fas2_m4a1_hg"] = "none",
				["muzzle"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_m4a1_hg"] = "mifl_fas2_m4a1_barrel_jungle"
			})
		end,
	}, 
	--m4a1 heat barrel - arccw_mifl_fas2_m4a1 - mifl_fas2_m4a1_hg=mifl_fas2_m4a1_barrel_heat
	["weaponmod_m4_heat"] = {
		name = "M4A1 HEAT Handguard Upgrade",
		desc = [[temp name maybe
adds the HEAT handguard upgrade to a M4A1
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_m4a1_hg_heat.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped M4A1",
		customRes = "1x that unequipped M4A1 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 12,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_m4a1", {
				["mifl_fas2_m4a1_hg"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_m4a1_hg"] = "mifl_fas2_m4a1_barrel_heat"
			})
		end,
	}, 
	--m4a1 whisper barrel - arccw_mifl_fas2_m4a1 - mifl_fas2_m4a1_hg=mifl_fas2_m4a1_barrel_sd
	["weaponmod_m4a1_whisper"] = {
		name = "M4A1 Whisper Handguard Upgrade",
		desc = [[temp name maybe very temp may not be supp need to check
adds the custom internally suppressed handguard upgrade to a M4A1
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_m4a1_hg_sd.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit3"] = true, },
		customIng = "1x any unequipped M4A1",
		customRes = "1x that unequipped M4A1 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 10,
			["comp_pad_cloth"] = 5,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_m4a1", {
				["mifl_fas2_m4a1_hg"] = "none",
				["muzzle"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_m4a1_hg"] = "mifl_fas2_m4a1_barrel_sd"
			})
		end,
	}, 
	--m4a1 commando barrel - arccw_mifl_fas2_m4a1 - mifl_fas2_m4a1_hg=mifl_fas2_m4a1_barrel_commando
	["weaponmod_m4_commando"] = {
		name = "M4A1 Commando Handguard Upgrade",
		desc = [[temp name maybe
adds the Commando handguard upgrade to a M4A1
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_m4a1_hg_cmd.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped M4A1",
		customRes = "1x that unequipped M4A1 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 9,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_m4a1", {
				["mifl_fas2_m4a1_hg"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_m4a1_hg"] = "mifl_fas2_m4a1_barrel_commando"
			})
		end,
	}, 
	--m4a1 9mm conv - arccw_mifl_fas2_m4a1 - mifl_fas2_m4a1_mag=mifl_fas2_m4a1_mag_9mm_32
	["weaponmod_m4a1_9mmconv"] = {
		name = "M4A1 9x19mm Conversion Upgrade",
		desc = [[temp name maybe
changes the ammo type to 9x19 with 32 round mags
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_m4a1_ammo_32.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit2"] = true, },
		customIng = "1x any unequipped M4A1",
		customRes = "1x that unequipped M4A1 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			["comp_mech2"] = 3,
			["comp_scrap_metal"] = 5,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_m4a1", {
				["mifl_fas2_m4a1_mag"] = "none",
				["go_ammo"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_m4a1_mag"] = "mifl_fas2_m4a1_mag_9mm_32"
			})
		end,
	}, 
	--p226 long barrel - arccw_mifl_fas2_p226 - mifl_fas2_p226_slide=mifl_fas2_p226_slide_long
	["weaponmod_p226_long"] = {
		name = "P226 Long Barrel Upgrade",
		desc = [[temp name maybe
adds the long barrel upgrade to a P226
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_p226_slide_x.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		customIng = "1x any unequipped P226",
		customRes = "1x that unequipped P226 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_p226", {
				["mifl_fas2_p226_slide"] = "none",
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_p226_slide"] = "mifl_fas2_p226_slide_long"
			})
		end,
	}, 
	--sg552 whisper barrel - arccw_mifl_fas2_sg55x - mifl_fas2_sg55x_hg=mifl_fas2_sg55x_barrel_sd
	["weaponmod_sg552_whisper"] = {
		name = "SG552 Whisper Handguard Upgrade",
		desc = [[temp name maybe very temp
adds the custom internally suppressed handguard upgrade to a SG552
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_sg55x_sd.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit3"] = true, },
		customIng = "1x any unequipped SG552",
		customRes = "1x that unequipped SG552 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 10,
			["comp_pad_cloth"] = 4,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_sg55x", {
				["mifl_fas2_sg55x_hg"] = "none",
				["muzzle"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_sg55x_hg"] = "mifl_fas2_sg55x_barrel_sd"
			})
		end,
	}, 
	--sr25 whisper barrel - arccw_mifl_fas2_sr25 - mifl_fas2_sr25_hg=mifl_fas2_sr25_barrel_sd
	["weaponmod_sr25_whisper"] = {
		name = "SR-25 Whisper Handguard Upgrade",
		desc = [[temp name maybe very temp
adds the custom internally suppressed handguard upgrade to a SR-25
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Upgrades",
		render = {
			icon = "entities/arccw_mifl_fas2_sr25_hg_sd.png"
		},
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 2,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit3"] = true, },
		customIng = "1x any unequipped SR-25",
		customRes = "1x that unequipped SR-25 with the upgrade applied",
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["comp_scrap_metal"] = 12,
			["comp_pad_cloth"] = 5,
			--["comp_duct_tape"] = 1,
		},
		--flag = "", --optional can be left out, flag to check for
		handpick = function(items) --pick an item 
			return specificUpgradeValid(items, "arccw_mifl_fas2_sr25", {
				["mifl_fas2_sr25_hg"] = "none",
				["muzzle"] = "none"
			})
		end,
		beforeCraft = function(ply, items, handpick)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			if(!handpick) then ply:notify("uh this should never happen") return end
			specificUpgrade(ply, handpick, {
				["mifl_fas2_sr25_hg"] = "mifl_fas2_sr25_barrel_sd"
			})
		end,
	}, 
	--db conversion to sawn off
	["weaponmod_db_sawn"] = {
		name = "Double Barrel Sawn-off Conversion",
		desc = [[temp name maybe
saws off the stock and most of the barrel of a double barrel, will retain any atts and etc the source weapon has (existing atts in the same slot take priority)
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Conversions",
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["cwep_doublebarrel"] = true,
			--["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		result = "cwep_doublebarrelsawn",
		--flag = "", --optional can be left out, flag to check for
		beforeCraft = function(ply, items)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			local data = {}
			for k,v in pairs(items) do
				if(v.uniqueID == "cwep_doublebarrel") then
					data = v:getData(true) --this apparently gets all data
					break
				end
			end
			if(data and table.Count(data) != 0) then
				data.atts = setSawnAtts(data.atts, "cwep_doublebarrel")
				return data
			end
		end,
		adddata = true,
	}, 
	--toz conversion to sawn off
	["weaponmod_toz_sawn"] = {
		name = "TOZ-34 Sawn-off Conversion",
		desc = [[temp name maybe
saws off the stock and most of the barrel of a TOZ-34, will retain any atts and etc the source weapon has (existing atts in the same slot take priority)
NOTE: for best results, have the item you want this to be applied to be the ONLY unequipped applicable weapon in your inventory
this upgrade is PERMANENT and cannot be reverted]],
		category = "Weapon Conversions",
		model = "models/fallout/components/box.mdl",--models/weapons/tfa_ins2/w_glock17.mdl",
		--skin = skin of model (not required),
		workbench = {["weapons"]=true,},
		traits = { --traits requirements
			["crafting_weapon"] = 1,--min level needed or true for no level ones,
		},
		requirements = { ["junk_toolkit1"] = true, },
		ingredients = { --items that will be taken
			--temp removed ingredients for testing
			--["comp_mech2"] = 2,
			["cwep_toz34"] = true,
			--["comp_scrap_metal"] = 3,
			--["comp_duct_tape"] = 1,
		},
		result = "cwep_toz34sawn",
		--flag = "", --optional can be left out, flag to check for
		beforeCraft = function(ply, items)
			--items are the items that will be taken, 
			--return a table and it will reappear in oncreate as data
			local data = {}
			for k,v in pairs(items) do
				if(v.uniqueID == "cwep_toz34") then
					data = v:getData(true) --this apparently gets all data
					break
				end
			end
			if(data and table.Count(data) != 0) then
				data.atts = setSawnAtts(data.atts, "cwep_toz34")
				return data
			end
		end,
		adddata = true,
	}, 
}