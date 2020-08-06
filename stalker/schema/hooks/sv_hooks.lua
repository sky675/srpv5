
--why not keep the transfered function on items?
hook.Add("ItemTransfered", "transferfunction", function(context)
	if(context.item and context.item.onTransfered) then
		context.item:onTransfered()
	end
end)

hook.Add("OnJammed", "main", function(ent)
	print("jammed", ent)
	if(ent:IsPlayer()) then
		print("player")
		if(ent:FlashlightIsOn()) then
		ent:Flashlight(false)
		end
	end
end)
hook.Add("OnUnjammed", "main", function(ent)
	
end)

local top_trans = {
	--[1] = "default",
	--[id in config] = {male id, female id}
	--default models not included
	--[1] = --black tshirt
	--im so fucking stupid this is +1 higher than it should be

	[2] = {"torso_fem_btshirt","torso_mal_btshirt"},
	[3] = {"torso_fem_blwcoat","torso_mal_blwcoat"},
	[4] = {"torso_fem_bcoat","torso_mal_bcoat"},
	[5] = {"torso_fem_bwcoat","torso_mal_bwcoat"},
	[6] = {"torso_fem_gbcoat","torso_mal_gbcoat"},
	[7] = {"torso_fem_brcoat","torso_mal_brcoat"},
	[8] = {"torso_fem_ghcoat","torso_mal_ghcoat"},
	[9] = {"torso_fem_bhcoat","torso_mal_bhcoat"},
	[10] = {"torso_fem_bwhcoat","torso_mal_bwhcoat"},
	[11] = {"torso_fem_brhcoat","torso_mal_brhcoat"},
	[12] = {"torso_fem_bthcoat","torso_mal_bthcoat"},
	[13] = {"torso_fem_wblsshirt","torso_mal_bbzipvest"},
	[14] = {"torso_fem_clsshirt","torso_mal_cbzipvest"},
	[15] = {"torso_fem_tatjack","torso_mal_lsvest"},
	[16] = {"torso_fem_ctatjacket","torso_mal_clsvest"},
	[17] = {"torso_fem_fleece","torso_mal_fleece"},
	[18] = {"torso_fem_pshirt","torso_mal_pshirt"},
	[19] = {"torso_fem_wactjacket","torso_mal_rhoodie"},
	[20] = {"torso_fem_bactjacket","torso_mal_bhoodie"},
	[21] = {"torso_fem_bpuffer","torso_mal_bpuffer"},
	[22] = {"torso_fem_cpuffer","torso_mal_cpuffer"},
	[23] = {"torso_fem_brscrjack","torso_mal_brscrjack"},
	[24] = {"torso_fem_blscrjack","torso_mal_blscrjack"},
	[25] = {"torso_fem_blwscrjack","torso_mal_blwscrjack"},
	[26] = {"torso_fem_brbscrjack","torso_mal_brbscrjack"},
	[27] = {"torso_fem_braincoat","torso_mal_braincoat"},
	[28] = {"torso_fem_wraincoat","torso_mal_wraincoat"},
	[29] = {"torso_fem_bwintercoat","torso_mal_bwintercoat"},
	[30] = {"torso_fem_dwintercoat","torso_mal_dwintercoat"},
	[31] = {"torso_fem_wjack","torso_mal_sweater"},
	[32] = {"torso_fem_wshirt","torso_mal_tatjack"},
	[33] = {"torso_fem_bleatjack","torso_mal_bleatjack"},
	[34] = {"torso_fem_wleatjack","torso_mal_wleatjack"},
	[35] = {"torso_fem_suit","torso_mal_suit"},
	[36] = {"torso_fem_bover","torso_mal_bover"},
	[37] = {"torso_fem_gover","torso_mal_gover"},
}
local bot_trans = { --remember with the female trackpants, it starts going down as theres 1 less male one (so black would be the first suit pants for male)
	--[1] = "default",
	[2] = {"legs_fem_dbjeans","legs_mal_dbjeans"},
	[3] = {"legs_fem_brjeans","legs_mal_brjeans"},
	[4] = {"legs_fem_blcargo","legs_mal_blcargo"},
	[5] = {"legs_fem_brcargo","legs_mal_brcargo"},
	[6] = {"legs_fem_ccargo","legs_mal_ccargo"},
	[7] = {"legs_fem_tcargo","legs_mal_tcargo"},
	[8] = {"legs_fem_tpants","legs_mal_tpants"},
	[9] = {"legs_fem_cpants","legs_mal_cpants"},
	[10] = {"legs_fem_dspants","legs_mal_dspants"},
	[11] = {"legs_fem_cspants","legs_mal_cspants"},
	[12] = {"legs_fem_gcpants","legs_mal_gcpants"},
	[13] = {"legs_fem_bcpants","legs_mal_bcpants"},
	[14] = {"legs_fem_bapants","legs_mal_bapants"},
	[15] = {"legs_fem_wtrpants","legs_mal_tatpants"},
	[16] = {"legs_fem_btrpants","legs_mal_gdpants"},
	[17] = {"legs_fem_gdpants","legs_mal_bdpants"},
	[18] = {"legs_fem_bdpants",""},
}
local starters = {
	"wep_pm", "mag_pm", "mag_pm", 
	"pda", "ammo_9x18", "food_cantuna", 
	"drink_waterbottle", "flashlight",
	"wep_m_f4knife", "medkit", "meds_bandage"
}
local starterdata = {
	["wep_pm"] = {ammo = 9},
	["mag_pm"] = {mag = 8}
}

local function modelfem(model, client)
	return hook.Run("CustomFemaleModel", model, client) or model:find("female") or model:find("metroll/f")
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
		local gs = character:getData("gs", {})
		if(gs and !gs.assign) then --give starting items from char creation
			PrintTable(gs)
			if(gs.top and top_trans[gs.top+1]) then
				print("top is", top_trans[gs.top+1][1])
				--[[nut.item.instance(inventory:getID(), top_trans[gs.top+1][modelfem(character:getModel(), client) and 1 or 2], {equip = true}, 3, 1,
				function(item)
					inventory:add(item.id, nil, nil, 3, 1)
				end)]]
				inventory:add(top_trans[gs.top+1][fem and 1 or 2], 1, {equip = true})--, 3, 1)
			end
			if(gs.bot and bot_trans[gs.bot+1]) then
				print("bot is", bot_trans[gs.bot+1][1])
				--[[nut.item.instance(inventory:getID(), bot_trans[gs.bot+1][modelfem(character:getModel(), client) and 1 or 2], {equip = true}, 4, 1,
				function(item)
					inventory:add(item.id, nil, nil, 4, 1)
				end)]]
				inventory:add(bot_trans[gs.bot+1][fem and 1 or 2], 1, {equip = true})--, 4, 1)
			end
		elseif(gs) then
			if(gs.top) then
				local eq = gs.topequip
				if(eq == nil) then eq = true end
				inventory:add(gs.top[fem and 1 or 2], 1, {equip = eq})
			end
			if(gs.bot) then
				local eq = gs.botequip
				if(eq == nil) then eq = true end
				inventory:add(gs.bot[fem and 1 or 2], 1, {equip = eq})
			end
		end


		--[[if(client:isCombine()) then
			local id = client:getDigits() --this is nil?
			local valid = CMBD:addIntoDB(id, {
				["status"] = (client:Team() == FACTION_CP and "metropolice" or "overwatch"),
				["charid"] = character:getID()
			})
			
			timer.Simple(0, function() --aghhhhhhhhhhhhhhh
			character:setMoney(150)
			end)

			inventory:add("cppda", 1, {pdahandle = id})

			inventory:add("radio")
		end]]

		for k,v in pairs(starters) do
			inventory:add(v, 1, starterdata[v] or {})
		end
		--[[
		if(character:getFaction() == FACTION_OW) then
			inventory:add("armor_ota", 1, {equip = true})
		end

		if(character:getFaction() == FACTION_CITIZEN) then
			local id = math.random(10000,99999)
			if(CMBD:existInDB(id)) then --just to make sure
				while (CMBD:existInDB(id)) do --just repeat until its good
					id = math.random(10000,99999) --should only be 1-2 tries right?
				end
			end

			inventory:add("cid", 1, {
				name = character:getName(),
				id = id,
				status = "citizen"
			})
			CMBD:addIntoDB(id, {
				name = character:getName(),
				status = "citizen",
				charid = character:getID()
			})
		end
		]]


		--inventory:add("cred_n5k", 1, {money = 1000})
		
		--[[if(character:isSectcom()) then
			inventory:add(modelfem(character:getModel(), client) and "secrookkit_fem" or "secrookkit_male")
		end]]
		--inventory:add("cred_n5k", 1, {money = 1000}, 2, 1)
		--	inventory:add("can_tuna", 1)
		--	inventory:add("water", 1)
		--	inventory:add("flashlight", 1)
        
    end
end

function SCHEMA:PostPlayerLoadout(ply)
	local fac = ply:getChar():getFaction()
	if(fac == FACTION_LONER) then
		for k, v in ipairs(nut.class.list) do
			if (ply:getChar():joinClass(k)) then
				break
			end
		end
	end
end

--this should force the arms being hidden with no item equipped
hook.Add("PlayerRemoveOutfitEnd", "resetbg", function(ply, item)
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
	for k,v in pairs(mats) do
		if(string.find(v, "eyeball_l")) then
			mat[#mat+1] = {mat = k-1, type = "l"}
		end
		if(string.find(v, "eyeball_r")) then
			mat[#mat+1] = {mat = k-1, type = "r"}
		end
	end

	if(char:getData("eyes")) then
		if(char:getData("eyes") == "blue") then
			for k,v in pairs(mat) do
				ply:SetSubMaterial(v.mat, v.type == "l" and "models/bloo_ltcom_zel/citizens/eyeball_l_blue" or "models/bloo_ltcom_zel/citizens/eyeball_r_blue")
			end
		elseif(char:getData("eyes") == "green") then
			for k,v in pairs(mat) do
				ply:SetSubMaterial(v.mat, v.type == "l" and "models/bloo_ltcom_zel/citizens/eyeball_l_green" or "models/bloo_ltcom_zel/citizens/eyeball_r_green")
			end
		elseif(char:getData("eyes") == "cyber") then
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
		nut.log.addRaw("applying")
		nut.newchar.setBodygroups(ply, "t", char:getData("gbgs", {}).t, char:getData("gsub", {}).t)
	end
	end)

	timer.Simple(0, function() --i dont believe that it exists at this point
	if(char:getData("anorak")) then
		nut.newchar.setBodygroups(ply, "t", nil, {["anorak_lone"] = ANORAKTEXTURES[char:getData("anorak")]})
		char:setData("anorak") --dont need anymore
	end
	end)

	--set anorak texture from ANORAKTEXTURES table (number data called anorak)
	--only if model is in sky/stalker/
	if(string.find(ply:GetModel(), "sky/stalker") and char:getData("anorak")) then
		local mats = ply:GetMaterials()
		local mat
		for k,v in pairs(mats) do
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
--[[
function SCHEMA:InitializedPlugins()
	if (!self.pacEx or #self.pacEx == 0) then return end

	for k,v in pairs(self.pacEx) do
		nut.pac.list[k] = v.pacData
	end
end
]]
util.AddNetworkString("BanMeAmHack")
net.Receive("BanMeAmHack", function(len, ply)
	RunConsoleCommand("ev","ban", ply:SteamID(), "0", "you have easily detectable hacks and frankly should be ashamed. fuck off.")
end) 
---[[
hook.Add("PlayerSpawn", "WideDecals", function(ply)
	ply:RemoveAllDecals()
end)--]]

--[[
function SCHEMA:PostPlayerLoadout(ply)
	local faction = ply:getChar():getFaction()

--this should work just change it based on watever u set the class names
	timer.Simple(0, function() 
	if(faction == FACTION_MONO or faction == FACTION_MUTANTS) then
		ply.VJ_NPC_Class = {"CLASS_MONOLITH"}
	elseif(faction == FACTION_FREEDOM and faction == FACTION_MERCS) then
		ply.VJ_NPC_Class = {"CLASS_FREEBAN"}
	elseif(faction == FACTION_DUTY and faction == FACTION_ECOLOGISTS) then
		ply.VJ_NPC_Class = {"CLASS_DOLG"}
	elseif(faction == FACTION_MILITARY) then
		ply.VJ_NPC_Class = {"CLASS_UKM"}
	else
		ply.VJ_NPC_Class = nil
	end
	end)
end
--]]

hook.Add("PlayerGetStunThreshold", "trait", function(ply, atk)
	local mod = nut.traits.getMod(ply, "cc", 3)

	return mod
end)
