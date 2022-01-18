
--why not keep the transfered function on items?
hook.Add("ItemTransfered", "transferfunction", function(context)
	if(context.item and context.item.onTransfered) then
		context.item:onTransfered()
	end
end)


local starters = {
	"cwep_makarov", 
	"pda", "ammo_9x18", "food_cantuna", 
	"drink_waterflask", "flashlight",
	"cwep_m_knife_t", "medkit", "meds_bandage"
}
local starterdata = {
	["cwep_makarov"] = {ammo = 9},
	["cwep_cz75"] = {ammo = 15},
	["cwep_browninghp"] = {ammo = 13},
	["cwep_g17"] = {ammo = 17},
}
local starterquant = {
	["ammo_9x18"] = 50,
	["ammo_9x19"] = 50,
}
local starterreplacements = {
	[FACTION_MONOLITH] = {
		["cwep_makarov"] = "cwep_cz75",
		["ammo_9x18"] = "ammo_9x19",
		["pda"] = "monopda"
	},
	[FACTION_CLEARSKY] = {
		["cwep_makarov"] = "cwep_browninghp",
		["ammo_9x18"] = "ammo_9x19"
	},
	[FACTION_DUTY] = {
		["cwep_makarov"] = "cwep_cz75",
		["ammo_9x18"] = "ammo_9x19"
	},
	[FACTION_FREEDOM] = {
		["cwep_makarov"] = "cwep_browninghp",
		["ammo_9x18"] = "ammo_9x19"
	},
	[FACTION_MERC] = {
		["cwep_makarov"] = "cwep_g17",
		["ammo_9x18"] = "ammo_9x19"
	},
	[FACTION_ECO] = {
		["cwep_makarov"] = "cwep_g17",
		["ammo_9x18"] = "ammo_9x19"
	},
}

local function modelfem(model, client)
	return hook.Run("CustomFemaleModel", model, client, nil, true) or model:find("female") or model:find("metroll/f")
end

--give starter kit
function SCHEMA:OnCharCreated(client, character)
	local inventory = character:getInv()
	local fem = modelfem(character:getModel(), client)

	if(fem) then
		character:setData("cFemale", true) 
		--autoset this so if they equip a suit theyll keep female sounds
	end

	if (inventory) then	

		if(character:getFaction() == FACTION_MUTANT) then return end --no starting items

		local rep = starterreplacements[character:getFaction()]
		for k,v in pairs(starters) do
			local ac = rep and rep[v] or v
			inventory:add(ac, starterquant[ac] or 1, starterdata[ac] or {})
		end
		
    end
end

--this should force the arms being hidden with no item equipped
hook.Add("PlayerRemoveOutfitEnd", "resetbg", function(ply, item)
	--reapplying anorak just in case it wipes submats
	timer.Simple(0, function() --i dont believe that it exists at this point
		local char = ply:getChar()
	if(char:getData("anorak")) then
		nut.newchar.setBodygroups(ply, "t", nil, {["anorak_lone"] = ANORAKTEXTURES[char:getData("anorak")]})
		--char:setData("anorak") --dont need anymore
	end
	end)
	if(ply.bm and ply.bm.t) then	
		--if(string.find(ply.bm.t:GetModel(), "citizen")) then
			local character = ply:getChar()
			local bgs = {["arms"] = 4, ["hands"] = 3}
			if(ply:isFemale()) then
				bgs.arms = 3
			end

			local groups = character:getData("groups", {})

			for k, v in pairs(bgs) do
				local index = ply:FindBodygroupByName(k)

				if (index > -1) then
					ply:SetBodygroup(index, v)


					if (groups[index]) then
						groups[index] = v
					end
				end
			end
			character:setData("groups", groups)
		--end
	end
end)

hook.Add("PlayerLoadedChar", "eyegive", function(ply, char, lastChar)
	local mats = ply:GetMaterials()
	local mat = {}
	for k,v in ipairs(mats) do
		if(string.find(v, "eyeball_l")) then
			mat[#mat+1] = {mat = k-1, type = "l"}
		end
		if(string.find(v, "eyeball_r")) then
			mat[#mat+1] = {mat = k-1, type = "r"}
		end
	end

	local eyes = char:getData("eyes")
	if(eyes) then
		if(eyes == "blue") then
			for k,v in pairs(mat) do
				ply:SetSubMaterial(v.mat, v.type == "l" and "models/bloo_ltcom_zel/citizens/eyeball_l_blue" or "models/bloo_ltcom_zel/citizens/eyeball_r_blue")
			end
		elseif(eyes == "green") then
			for k,v in pairs(mat) do
				ply:SetSubMaterial(v.mat, v.type == "l" and "models/bloo_ltcom_zel/citizens/eyeball_l_green" or "models/bloo_ltcom_zel/citizens/eyeball_r_green")
			end
		elseif(eyes == "cyber") then
			for k,v in pairs(mat) do
				ply:SetSubMaterial(v.mat, v.type == "l" and "models/sky/eyeball_cyber_l" or "models/sky/eyeball_cyber_r")
			end
		else
			for k,v in pairs(mat) do
				ply:SetSubMaterial(v.mat)
			end
		end
	else
		for k,v in pairs(mat) do
			ply:SetSubMaterial(v.mat)
		end
	end
	--reset all
	--if(!nut.newchar.isBM(ply:GetModel())) then
		ply:SetSubMaterial()
	--end

	--submaterials from items
	for k,v in pairs(char:getData("submat", {})) do
	local mat
	for k2,v2 in pairs(mats) do
		if(string.find(v2, k)) then
			mat = k2-1
		end
	end
	if(mat) then
		ply:SetSubMaterial(mat, v)
	end
	end
	
	timer.Simple(0.1, function()
	if(char:getData("gbgs", {}).t or char:getData("gsub", {}).t) then
		nut.newchar.setBodygroups(ply, "t", char:getData("gbgs", {}).t, char:getData("gsub", {}).t)
	end
	end)

	timer.Simple(0, function() --i dont believe that it exists at this point
	if(char:getData("anorak")) then
		nut.newchar.setBodygroups(ply, "t", nil, {["anorak_lone"] = ANORAKTEXTURES[char:getData("anorak")]})
		--char:setData("anorak") --dont need anymore
	end
	end)

	--set anorak texture from ANORAKTEXTURES table (number data called anorak)
	--only if model is in sky/stalker/
	if(string.find(ply:GetModel(), "sky/stalker") and char:getData("anorak")) then
		local mats = ply:GetMaterials()
		local mat
		for k,v in ipairs(mats) do
			if(string.find(v, "anorak_lone")) then
				mat = k-1
				break
			end
		end

		ply:SetSubMaterial(mat, ANORAKTEXTURES[char:getData("anorak")])
	end
end)


--just combining them both becuz default onplayerheal will just take whatever returns something first
hook.Add("OnPlayerHeal", "uhbothlmao", function(client, target, amount, seconds)
	--local amt, sec = hook.Run("healimplants", client, target, amount, seconds)

	local amtchange, secchange = nut.traits.getMod(client, "heal", target, amount, seconds)

	--local amtchange = amtchange * ((target:getChar():getData("humn", 6)/6)^0.6)

	return amtchange, secchange
end)

util.AddNetworkString("BanMeAmHack")
net.Receive("BanMeAmHack", function(len, ply)
	RunConsoleCommand("ev","ban", ply:SteamID(), "0", "you have easily detectable hacks and frankly should be ashamed. fuck off.")
end) 
---[[
hook.Add("PlayerSpawn", "WideDecals", function(ply)
	ply:RemoveAllDecals()
end)--]]


hook.Add("PlayerGetStunThreshold", "trait", function(ply, atk)
	local mod = nut.traits.getMod(ply, "cc", 3)

	return mod
end)
