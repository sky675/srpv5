local PLUGIN = PLUGIN

local itemconfig = {
	/*
    ["torso_fem_refw"] = {
		name = "White Shirt (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A yellowed white button down shirt.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 5,
		width = 1,
		height = 1,
		flag = "0",
		scrapGive = 4,
		permit = "cloth",

		outfitCategory = "torso",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "top", bg = 0, skin = 2},
		addons = {"bag","mpvest","trenchcoat"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3}
		end,
	},
	
	--militia
    ["sep_mal_militia"] = {
		name = "Militia Armor (Male)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A set of makeshift commercial armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		skin = 1,
		price = 185,
		width = 1,
		height = 2,
		flag = "1",

		outfitCategory = "torso;legs;gloves;armor",
		gsonly = "male", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 0, model = "models/sky/seperate/male_militia.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 4, ["hands"] = 3}
		end,
		armor = {
			chest = ARMOR_II,
			larm = ARMOR_IIA,
			rarm = ARMOR_IIA,
			lleg = ARMOR_IIA,
			rleg = ARMOR_IIA,
		},
		resists = {
			[DMG_BULLET] = 0.19,
			[DMG_SLASH] = 0.19,
			[DMG_CLUB] = 0.19,
			[DMG_BURN] = 0.25,
			[DMG_BLAST] = 0.04,
			spd = 0.87,
		},
		upgradePath = "militia",
	},
    ["sep_fem_militia"] = {
		name = "Militia Armor (Female)",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "A set of makeshift commerical armor.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		skin = 1,
		price = 185,
		width = 1,
		height = 2,
		flag = "1",

		outfitCategory = "torso;legs;gloves;armor",
		gsonly = "female", --female or male (actually it doesnt matter what it is for male)
		gs = {type = "seperate", bg = 0, skin = 0, model = "models/sky/seperate/female_militia.mdl"},
		getBodyGroups = function(item, ply)
			return {["arms"] = 3, ["hands"] = 3}
		end,
		armor = {
			chest = ARMOR_II,
			larm = ARMOR_IIA,
			rarm = ARMOR_IIA,
			lleg = ARMOR_IIA,
			rleg = ARMOR_IIA,
		},
		resists = {
			[DMG_BULLET] = 0.19,
			[DMG_SLASH] = 0.19,
			[DMG_CLUB] = 0.19,
			[DMG_BURN] = 0.25,
			[DMG_BLAST] = 0.04,
			spd = 0.87,
		},
		upgradePath = "militia",
	},

	
	--prob should be deleted imo
	--kevlar vest
    ["armor_basickevlar"] = {
		name = "Kevlar Vest",
		base = "base_suit", --base_suit, base_pacoutfit, base_outfit
		desc = "THIS IS LEFT OVER AND MAY BE DELETED LOL A light kevlar vest worn underneath whatever you wear.",
		model = "models/nt/props_debris/cardboard_box_02.mdl",
		--skin = 0,
		price = 1550,
		width = 1,
		height = 1,
		flag = "1",
		noBusiness = true,

		outfitCategory = "armor",

		armor = {
			chest = ARMOR_IIA
		},
		resists = {
			[DMG_BULLET] = 0.07,
			[DMG_SLASH] = 0.07,
			[DMG_CLUB] = 0.07,
			spd = 0.97,
		},
	},
	*/
}

function PLUGIN:InitializedItems()--Plugins()
	if(table.Count(itemconfig) == 0) then return end
    --do
		for id, data in pairs(itemconfig) do
			if(data.base == "base_suit") then data.base = "base_armor" end
            local ITEM = nut.item.register(id, data.base, nil, nil, true)
            ITEM.name = data.name
			ITEM.desc = data.desc
			local mdl = data.model
			ITEM.onGetDropModel = function(item, ent)
				return mdl
			end
			ITEM.model = data.model
			ITEM.skin = data.skin or 0
			ITEM.price = data.price or 0
			ITEM.width = data.width
			ITEM.height = data.height
			ITEM.noBusiness = data.noBusiness
			if(data.flag) then
				ITEM.flag = data.flag
			end
			local other = ""
			if(data.gsonly) then
				other = " ("..data.gsonly..")"
			end
			ITEM.category = "Clothing"..other
			ITEM.permit = data.permit

			if(data.scrapGive) then
				ITEM.destroyval = {
					[data.scrapType or "comp_scrap_cloth"] = data.scrapGive
				} --for scrap clothing crafting
			end
			if(data.destroyval) then
				ITEM.destroyval = data.destroyval --in case i wanna add more
			end

			ITEM = EZADDDESTROYFUNC(ITEM) --gotta do it this way i think

			ITEM.outfitCategory = data.outfitCategory
			
			if(data.gsonly) then
				if(data.gsonly == "female") then
					ITEM.canWear = function(self, ply)
						local model = ply:GetModel()
						if(nut.newchar.isBM(model) and ply:isFemale()) then
							if(!data.addons) then return true end

							local inv = ply:getChar():getInv()
							local item
							for k,v in pairs(inv:getItems()) do
								if(string.find(v.uniqueID, "addon") and v:getData("equip")) then
									item = v
									break
								end
							end
							if(item) then
								return false, "You have an addon equipped, you must unequip it first!"
							end
							
							return true
						else
							return false, "Your model cannot wear this item!"
						end
					end
				else
					ITEM.canWear = function(self, ply)
						local model = ply:GetModel()
						if(nut.newchar.isBM(model) and !ply:isFemale()) then
							if(!data.addons) then return true end
							
							local inv = ply:getChar():getInv()
							local item
							for k,v in pairs(inv:getItems()) do
								if(string.find(v.uniqueID, "addon") and v:getData("equip")) then
									item = v
									break
								end
							end
							if(item) then
								return false, "You have an addon equipped, you must unequip it first!"
							end

							return true
						else
							return false, "Your model cannot wear this item!"
						end
					end
				end
			end
			if(data.addons) then --table to prevent unequipping with items with these names equipped
				local addonscheck = data.addons
				ITEM.canRemove = function(self, ply)
					local inv = ply:getChar():getInv()
					local item
					for k,v in pairs(inv:getItems()) do
						for k2,v2 in pairs(addonscheck) do
							if(string.find(v.uniqueID, v2) and v:getData("equip")) then
								item = v
								break
							end
						end
					end
					if(item) then
						return false, "You need to unequip an item on top of this first!"
					else
						return true
					end
				end
			end

			if(data.hooks) then
				for k,v in pairs(data.hooks) do
					ITEM:hook(k, v)
				end
			end
			if(data.posthooks) then
				for k,v in pairs(data.posthooks) do
					ITEM:postHook(k, v)
				end
			end

			if(data.base == "base_suit") then
				--i messed up the armor so instead of changing it ill fix it here
				if(data.armor) then
				local armors = {}
				for k,v in pairs(data.armor) do
					armors[k] = {level = v}
				end
				ITEM.armor = armors
				end
				ITEM.resists = data.resists

				ITEM.pacData = data.pacData or {}
				ITEM.pacF = data.pacF
				ITEM.pacM = data.pacM
				ITEM.newSkin = data.newSkin
				ITEM.bodyGroups = data.bodyGroups 
				ITEM.replacements = data.replacements
				ITEM.onGetReplacement = data.onGetReplacement
				ITEM.getBodyGroups = data.getBodyGroups
				
				ITEM.upgradePath = data.upgradePath


				if(data.gs) then
					ITEM.gs = data.gs
					--[[
					local gstype, gsbg = data.gs.type, data.gs.bg
					ITEM:postHook("Equip", function(item, result, data)
						if(result == false) then return end --just in case
						nut.newchar.setBody(item.player, gstype, gsbg)
					end)
					ITEM:postHook("EquipUn", function(item, result, data)
						if(!result) then return end --just in case
						nut.newchar.setBody(item.player, gstype, 0)
					end)
					ITEM:hook("drop", function(item)
						if(item:getData("equip")) then
							nut.newchar.setBody(item.player, gstype, 0)
						end
					end)
					function ITEM:onLoadout()
						if(self:getData("equip")) then
							nut.newchar.setBody(self.player, gstype, gsbg)
						end
					end
						]]
				end
			end
			if(data.base == "base_pacoutfit") then
				ITEM.pacData = data.pacData or {}
				ITEM.pacF = data.pacF
				ITEM.pacM = data.pacM
			end
			if(data.base == "base_outfit") then
				ITEM.newSkin = data.newSkin
				ITEM.bodyGroups = data.bodyGroups 
				ITEM.replacements = data.replacements
				ITEM.onGetReplacement = data.onGetReplacement
				ITEM.getBodyGroups = data.getBodyGroups
				if(data.gs) then
					ITEM.gs = data.gs
				end
			end

			if(data.gs) then
				local gsbg = data.gs.bg
				local gsskin = data.gs.skin or 0
				if(data.gs.type == "top" and data.gsonly == "female") then
					ITEM.model = data.gs.model or "models/sky/torsos/female_citizen1.mdl"
					ITEM.skin = data.gs.skin or 0
					ITEM.exRender = true
					ITEM.iconCam = {
						pos = Vector(33.581039428711, 0, 49.281421661377),
						ang = Angle(0, 180, 0),
						entAng = Angle(0, 0, 0),
						fov = 35.148176754126,
						
						drawHook = function(ent, w, h)
							ent:SetBodygroup(0, gsbg)
							ent:SetSkin(gsskin)
						end,
					}
				elseif(data.gs.type == "top") then
					ITEM.model = data.gs.model or "models/sky/torsos/male_citizen1.mdl"
					ITEM.skin = data.gs.skin or 0
					ITEM.exRender = true
					ITEM.iconCam = {
						pos = Vector(80.053802490234, 0, 49.822090148926),
						ang = Angle(0, 180, 0),
						entAng = Angle(0, 0, 0),
						fov = 14.763357201488,
						
						drawHook = function(ent, w, h)
							ent:SetBodygroup(0, gsbg)
							ent:SetSkin(gsskin)
						end,
					}
				elseif(data.gs.type == "bot") then
					ITEM.model = data.gs.model or (data.gsonly == "female" and "models/sky/legs/female_citizen1.mdl" or "models/sky/legs/male_citizen1.mdl")
					
					ITEM.skin = data.gs.skin or 0
					ITEM.exRender = true
					ITEM.iconCam = {
						pos = Vector(-57.587574005127, 0, 21.754777908325),
						ang = Angle(0, -0, 0),
						entAng = Angle(0, 0, 0),
						fov = 29.916595845406,

						drawHook = function(ent, w, h)
							ent:SetBodygroup(0, gsbg)
							ent:SetSkin(gsskin)
						end,
					}
				end

				if(data.gs.type == "top" and !string.find(id, "_sec")) then
					ITEM.upgradePath = "gstop"
				elseif(data.gs.type == "bot" and !string.find(id, "_sec")) then
					ITEM.upgradePath = "gsbot"
				end
			end

        end
        for id, data in pairs(self.upgradesList) do
            local ITEM = nut.item.register(id, "base_suit_up", nil, nil, true)
            ITEM.name = data.name
            ITEM.desc = data.desc
            ITEM.price = data.price or 0
			ITEM.upgrades = data.upgrades
			if(data.flag) then
				ITEM.flag = data.flag
			end
        end
    --end
end