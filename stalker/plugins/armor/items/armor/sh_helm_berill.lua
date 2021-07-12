ITEM.name = "Sphere 08 Helmet"
ITEM.desc = "A helmet typically worn with a Berill-5M suit. Appearance is based on worn suit."
--ITEM.icon = Material("sky/itemicons/mpmask1.png")
ITEM.icon = Material("sky/itemicons/helm_berill.png")
ITEM.model = "models/kek1ch/helm_tactic.mdl"
ITEM.category = "Clothing"
ITEM.skin = 0
ITEM.weight = 4.18
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "head;mask;eyes"
ITEM.price = 22440--25440
ITEM.flag = "3"
ITEM.size = "helm" --helm, light, medium, heavy, exo, mask, vest, sci, seva

--interface/inv_items_cloth_2.ogg masks
--interface/inv_items_cloth_3.ogg helms works i guess?
ITEM.equipSound = "interface/inv_items_cloth_3.ogg"
ITEM.unequipSound = "interface/inv_items_cloth_3.ogg"

--ITEM.upgradePath = "eyes"

ITEM.canWear = function(self, ply)
	local model = ply:GetModel()
	if(nut.newchar.isBM(model)) then
		local model = self.player.bm.t:GetModel()
		if(model:find("cs3")) then return false, "Helmets can not be worn with the CS3!" end
		if(model:find("gorka")) then return false, "Stalker helmets cannot be worn with a gorka!" end
		return true
	else
		return false, "Your model cannot wear this item!"
	end
	--[[
	local inv = ply:getChar():getInv()
	local item = inv:getFirstItemOfType("metropolice_suit_fem") or inv:getFirstItemOfType("metropolice_suit")
	if(item and item:getData("equip")) then
		return true
	else
		return false, "Your model cannot wear this item!"
	end]]
end
function ITEM:onGetReplacement()
	local model = self.player.bm.t:GetModel()
	self.player:getChar():setData("oldgst", model)
	model = string.Split(model, ".")[1].."_mask.mdl"

	return model
end

--[[ --this is how you apply submats, change values and stuff]]
ITEM:postHook("Equip", function(item, result, data)
	--hoping this works xd should get submats on the bonemerged model and
	--replicate them onto the replacement model
	--and there are opposites in the other posthooks to undo it
	local mats = item.player:GetMaterials()
	local repl = item.player:getChar():getData("gsub", {["t"] = {}})["t"]
	if(!repl) then return end --just in case for some reason gsub is valid but doesnt have a t table
	--you could technically butt in here and override values
	--ex like repl["sourcemat"] = "newmat"
	--like for changing a mat for a specific obj (ex a special eo-20 mask)


	local sub = item.player:getChar():getData("submat", {})
	for k2,v2 in pairs(repl) do
		local mat
		for k,v in ipairs(mats) do
			if(string.find(v, k2)) then
				mat = k-1
			end
		end
		if(mat) then
			item.player:SetSubMaterial(mat, v2)
			sub[k2] = v2
		end
	end
	item.player:getChar():setData("submat", sub)
end)--]]
ITEM:postHook("EquipUn", function(item, result, data)
	local client = item.player
	local bgs = {hands = 3, head = 0, beanie = 0, beanies = 0}
	bgs["arms"] = client:isFemale() and 3 or 4
	print("model", client:GetModel())

	if(client:getChar():getData("oldgst")) then
		nut.newchar.setBody(client, "seperate", 0, client:getChar():getData("oldgst"), nil, nil, client:getChar():getData("gsub", {})["t"])
	end

	local groups = client:getChar():getData("groups", {})
	if(client:getChar():getData("oldhood")) then
		nut.newchar.setBodygroups(client, "t", client:getChar():getData("oldhood"))
	end
	for k, v in pairs(bgs) do
		local index = client:FindBodygroupByName(k)

		if (index > -1) then
			client:SetBodygroup(index, v)

			--if (groups[index]) then
				groups[index] = v
			--end
		else
			print("index for ", k, "-1")
		end
	end
	PrintTable(groups)
	--this does this
	groups[1] = nil
	groups[2] = nil
	client:getChar():setData("groups", groups)
	
	local mats = item.player:GetMaterials()
	local repl = item.player:getChar():getData("gsub", {["t"] = {}})["t"]
	if(!repl) then return end

	local sub = item.player:getChar():getData("submat", {})
	for k2,v2 in pairs(repl) do
		local mat
		for k,v in ipairs(mats) do
			if(string.find(v, k2)) then
				mat = k-1
				break
			end
		end
		if(mat) then
			item.player:SetSubMaterial(mat)
		end
		sub[k2] = nil
	end
	item.player:getChar():setData("submat", sub)

end)
ITEM:postHook("deathun", function(item, result, data)
	local client = item.player
	local bgs = {hands = 3, head = 0, beanie = 0, beanies = 0}
	bgs["arms"] = client:isFemale() and 3 or 4

	if(client:getChar():getData("oldgst")) then
		nut.newchar.setBody(client, "seperate", 0, client:getChar():getData("oldgst"), nil, nil, client:getChar():getData("gsub", {})["t"])
	end

	local groups = client:getChar():getData("groups", {})
	if(client:getChar():getData("oldhood")) then
		nut.newchar.setBodygroups(client, "t", client:getChar():getData("oldhood"))
	end
	for k, v in pairs(bgs) do
		local index = client:FindBodygroupByName(k)

		if (index > -1) then
			client:SetBodygroup(index, v)

			--if (groups[index]) then
				groups[index] = v
			--end
		end
	end
	--this does this
	groups[1] = nil
	groups[2] = nil
	client:getChar():setData("groups", groups)
	
	local mats = item.player:GetMaterials()
	local repl = item.player:getChar():getData("gsub", {["t"] = {}})["t"]
	if(!repl) then return end

	local sub = item.player:getChar():getData("submat", {})
	for k2,v2 in pairs(repl) do
		local mat
		for k,v in ipairs(mats) do
			if(string.find(v, k2)) then
				mat = k-1
				break
			end
		end
		if(mat) then
			item.player:SetSubMaterial(mat)
		end
		sub[k2] = nil
	end
	item.player:getChar():setData("submat", sub)
end)
ITEM:postHook("drop", function(item, result, data)
	if(!item:getData("wasequipped")) then return end
	item:setData("wasequipped")

	local client = item.player
	local bgs = {hands = 3, head = 0, beanie = 0, beanies = 0}
	bgs["arms"] = client:isFemale() and 3 or 4

	if(client:getChar():getData("oldgst")) then
		nut.newchar.setBody(client, "seperate", 0, client:getChar():getData("oldgst"), nil, nil, client:getChar():getData("gsub", {})["t"])
	end

	local groups = client:getChar():getData("groups", {})
	if(client:getChar():getData("oldhood")) then
		nut.newchar.setBodygroups(client, "t", client:getChar():getData("oldhood"))
	end
	for k, v in pairs(bgs) do
		local index = client:FindBodygroupByName(k)

		if (index > -1) then
			client:SetBodygroup(index, v)

			--if (groups[index]) then
				groups[index] = v
			--end
		end
	end
	--this does this
	groups[1] = nil
	groups[2] = nil
	client:getChar():setData("groups", groups)

	local mats = item.player:GetMaterials()
	local repl = item.player:getChar():getData("gsub", {["t"] = {}})["t"]
	if(!repl) then return end

	local sub = item.player:getChar():getData("submat", {})
	for k2,v2 in pairs(repl) do
		local mat
		for k,v in ipairs(mats) do
			if(string.find(v, k2)) then
				mat = k-1
				break
			end
		end
		if(mat) then
			item.player:SetSubMaterial(mat)
		end
		sub[k2] = nil
	end
	item.player:getChar():setData("submat", sub)
end)
--]]

--[[
--todo need a way to change forms, set rank to something at some point?
function ITEM:getCustomGS()
	local tbl = {}

	local dataRank = self:getData("rank", "default")

	--tbl.custombg = self.player:getChar():getData("gbgs", {t={}}).t --hopefully?
	tbl.type = "t"
	tbl.bgs = self.player:getChar():getData("gbgs", {t={}}).t --hopefully?

	local ind = self.player.bm.t:FindBodygroupByName("hood")
	if(ind != -1) then
		tbl.bgs[ind] = 
	end
	--i have no idea if this will work lol
	--if it doesnt since its serverside now i guess i could just manually edit them
	tbl.bgs[9] = 0
	tbl.bgs[10] = 0
	tbl.rem = {
		[9] = 1,
		[10] = 8
	}
	
	return tbl, true
end
]]
--ITEM.wipebgs = true
ITEM.getBodyGroups = function(item, ply)
	local bg = {}

	if(!ply.bm) then
		nut.newchar.resetModels(ply)
	end

	--this should get all the ones rn
	if(ply.bm and IsValid(ply.bm.t)) then
		local old = ply.bm.t:GetBodyGroups()
		local olbg = {}
		for k,v in pairs(old) do
			local b = ply.bm.t:GetBodygroup(v.id)
			--												i think this bit is redundant here, but idk
			if((v.name != "anorak" and v.name != "hood") and ply.bm.t:FindBodygroupByName(v.name) != -1) then
				bg[v.name] = b
			end
			--if(v.name == "anorak" or v.name == "hood") then
			olbg[v.id] = b
			--end
		end
		ply:getChar():setData("oldhood", olbg)--{[v.id] = ply.bm.t:GetBodygroup(v.id)})

	end

	--[[
	local hair = ply:FindBodygroupByName("hair")
	if(hair != -1 and ply:GetBodygroupCount(hair) == 3) then --hide hair too
		--if(modelsgoodfor1[ply:GetModel()]) then 
			bg["hair"] = 2
		
	elseif(hair != -1) then
		bg["hair"] = 1
	end
	local head = ply:FindBodygroupByName("head")
	if(head != -1 and ply:GetBodygroupCount(head) == 3) then --hide hair too
		--if(modelsgoodfor1[ply:GetModel()]) then 
			bg["head"] = 2
		
	elseif(head != -1) then
		bg["head"] = ply:GetBodygroupCount(head)-1
	end]]

	--if(ply:GetModel():find("_mask")) then
		bg["hood"] = 5
		if(ply.bm.t:GetModel():find("anorak")) then
			bg["anorak"] = 1
		end
		if(ply.bm.t:GetModel():find("io7a")) then --im fucking dumb
			bg["torso"] = 1
		end
	--else --have to redo the default bgs
		--bg["hands"] = 3
		--bg["arms"] = ply:isFemale() and 3 or 4
	--end

	print("hi hello?")
	return bg
end

ITEM.overlaytype = "tact"

ITEM.upgradePath = "helmberill"
ITEM.armor = {
	head = {level = ARMOR_III},
}
ITEM.resists = {
	--burn
	[DMG_BURN] = 0.011,
	--electric --less
	[DMG_SHOCK] = 0.055,
	--ext rad
	[DMG_RADIATION] = 0.463,
	--chem
	[DMG_ACID] = 0.216,
	--psy
	[DMG_SONIC] = 0.192,
	["psy"] = 0.192,
	--explosion
	[DMG_BLAST] = 0.25,
	--phys
	[DMG_SLASH] = 0.022,
	[DMG_CLUB] = 0.022,
	[DMG_CRUSH] = 0.022,
	--bullet fire wound
	[DMG_BULLET] = 0.022,

	spd = 0.95,
}