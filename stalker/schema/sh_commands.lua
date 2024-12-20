local attribTbl = {
	["quickness"] = "qkn",
	["endurance"] = "end",
	["stamina"] = "stm",
	["strength"] = "str"
}

nut.command.add("rollattrib", {
	desc = "Roll out of 100, and then have the specified attribute value added onto it. valid: (end, qkn, stm, str)",
	syntax = "<string attribid>",
	onRun = function(client, arguments)
		local attrib = client:getChar():getAttrib(attribTbl[arguments[1]:lower()] or arguments[1])
		if(!attrib) then return "invalid attrib id" end
		attrib = math.Round(attrib, 0)
		local max = 100
		local val = math.random(max)
		nut.log.addRaw(client:Name().." ("..client:SteamID()..") did roll attrib: "..val.." + "..attrib.." ("..arguments[1]..") = "..(val+attrib))

		nut.chat.send(client, "roll", "1d100 = "..val.." + "..attrib.." ("..arguments[1]..") = "..(val+attrib))
	end
})
nut.command.add("rollattribdis", {
	desc = "Roll disadvantage out of 100, and then have the specified attribute value added onto it. valid: (end, qkn, stm, str)",
	syntax = "<string attribid>",
	onRun = function(client, arguments)
		local attrib = client:getChar():getAttrib(attribTbl[arguments[1]:lower()] or arguments[1])
		if(!attrib) then return "invalid attrib id" end
		attrib = math.Round(attrib, 0)
		local max = 100
		local nums = {math.random(max), math.random(max)}
		local val = nums[1] > nums[2] and 2 or 1
		local other = val == 2 and 1 or 2
		nut.log.addRaw(client:Name().." ("..client:SteamID()..") did roll attrib dis: "..nums[val].." (other was "..nums[other]..") + "..attrib.." ("..arguments[1]..") = "..(nums[val]+attrib))

		nut.chat.send(client, "roll", "1d100 dis = "..nums[val].." (other was "..nums[other]..") + "..attrib.." ("..arguments[1]..") = "..(nums[val]+attrib))
	end
})
nut.command.add("rollattribadv", {
	desc = "Roll advantage out of 100, and then have the specified attribute value added onto it. valid: (end, qkn, stm, str)",
	syntax = "<string attribid>",
	onRun = function(client, arguments)
		local attrib = client:getChar():getAttrib(attribTbl[arguments[1]:lower()] or arguments[1])
		if(!attrib) then return "invalid attrib id" end
		attrib = math.Round(attrib, 0)
		local max = 100
		local nums = {math.random(max), math.random(max)}
		local val = nums[1] > nums[2] and 1 or 2
		local other = val == 2 and 1 or 2
		nut.log.addRaw(client:Name().." ("..client:SteamID()..") did roll attrib adv: "..nums[val].." (other was "..nums[other]..") + "..attrib.." ("..arguments[1]..") = "..(nums[val]+attrib))

		nut.chat.send(client, "roll", "1d100 adv = "..nums[val].." (other was "..nums[other]..") + "..attrib.." ("..arguments[1]..") = "..(nums[val]+attrib))
	end
})
local transres = {
	["rad"] = DMG_RADIATION,
	["psy"] = DMG_SONIC,
	["chem"] = DMG_ACID,
	["burn"] = DMG_BURN,
	["elec"] = DMG_SHOCK,
	["phys"] = DMG_SLASH,
	["exp"] = DMG_BLAST,
	["bullet"] = DMG_BULLET,
	["spd"] = "spd",
	["stmrec"] = "stmres",
}
nut.command.add("rollresist", {
	desc = "Roll out of 100, and then have the specified resistance multiply it. valid ids: (rad, psy, chem, burn, elec, phys, exp, bullet, spd, stmrec)",
	syntax = "<string attribid>",
	onRun = function(client, arguments)
		local attrib = transres[arguments[1]]
		if(!attrib) then return "invalid resist id" end
		local armor = client:GetArmorResists()
		local multi = armor[attrib] and armor[attrib]+1 or 1
		multi = math.Round(multi, 3)
		local max = 100
		local val = math.random(max)
		nut.log.addRaw(client:Name().." ("..client:SteamID()..") did roll resist: "..val.." * "..multi.." ("..arguments[1]..") = "..(val*multi))

		nut.chat.send(client, "roll", "1d100 = "..val.." * "..multi.." ("..arguments[1]..") = "..(val*multi))
	end
})
nut.command.add("rollresistdis", {
	desc = "Roll disadvantage out of 100, and then have the specified resistance multiply it. valid: (rad, psy, chem, burn, elec, phys, exp, bullet, spd, stmrec)",
	syntax = "<string attribid>",
	onRun = function(client, arguments)
		local attrib = transres[arguments[1]]
		if(!attrib) then return "invalid resist id" end
		local armor = client:GetArmorResists()
		local multi = armor[attrib] and armor[attrib]+1 or 1
		multi = math.Round(multi, 3)
		local max = 100
		local nums = {math.random(max), math.random(max)}
		local val = nums[1] > nums[2] and 2 or 1
		local other = val == 2 and 1 or 2
		nut.log.addRaw(client:Name().." ("..client:SteamID()..") did roll resist dis: "..nums[val].." (other was "..nums[other]..") * "..multi.." ("..arguments[1]..") = "..(nums[val]*multi))

		nut.chat.send(client, "roll", "1d100 dis = "..nums[val].." (other was "..nums[other]..") * "..multi.." ("..arguments[1]..") = "..(nums[val]*multi))
	end
})
nut.command.add("rollresistadv", {
	desc = "Roll advantage out of 100, and then have the specified resistance multiply it. valid: (rad, psy, chem, burn, elec, phys, exp, bullet, spd, stmrec)",
	syntax = "<string attribid>",
	onRun = function(client, arguments)
		local attrib = transres[arguments[1]]
		if(!attrib) then return "invalid resist id" end
		local armor = client:GetArmorResists()
		local multi = armor[attrib] and armor[attrib]+1 or 1
		multi = math.Round(multi, 3)
		local max = 100
		local nums = {math.random(max), math.random(max)}
		local val = nums[1] > nums[2] and 1 or 2
		local other = val == 2 and 1 or 2
		nut.log.addRaw(client:Name().." ("..client:SteamID()..") did roll resist adv: "..nums[val].." (other was "..nums[other]..") * "..multi.." ("..arguments[1]..") = "..(nums[val]*multi))

		nut.chat.send(client, "roll", "1d100 adv = "..nums[val].." (other was "..nums[other]..") * "..multi.." ("..arguments[1]..") = "..(nums[val]*multi))
	end
})

nut.command.add("chardie", {
	desc = "Used to kill yourself if you die in RP",
	onRun = function(client, arguments)
		client:Kill()
	end
})

nut.command.add("chargetmoney", {
	syntax = "<string target>",
	adminOnly = true,
	onRun = function(client, arguments) 
        local target = nut.util.findPlayer(arguments[1])
		if(!target) then return "invalid player" end
		
		return target:getChar():getName().." "..target:getChar():getMoney()
	end
})

nut.command.add("charsetanorakskin", {
	syntax = "<string target> <int skin>",
    adminOnly = true,
	desc = "Set the skin of the person's anorak (these are not found on the model)",
	onRun = function(client, arguments)
        local target = nut.util.findPlayer(arguments[1])
		if(!target) then return "invalid player" end

		if(!target.bm or !IsValid(target.bm.t)) then return end
		if(!target.bm.t:GetModel():find("_anorak")) then return "model not compatible with this command" end

		if(!ANORAKTEXTURES[tonumber(arguments[2])]) then return "no texture for that number" end

		nut.newchar.setBodygroups(target, "t", nil, {["anorak_lone"] = ANORAKTEXTURES[tonumber(arguments[2])]})
		target:getChar():setData("anorak", tonumber(arguments[2]))
		--should be it
		return "should be changed"
	end,
})

nut.command.add("charclearsubmats", {
	syntax = "<string target>",
    adminOnly = true,
	desc = "Using this will completely REMOVE the submaterials of the target, make sure they have all clothing items unequipped when using this command.",
	onRun = function(client, arguments)
        local ply = nut.util.findPlayer(arguments[1])
		if(!ply) then return "invalid player" end
		local char = ply:getChar()
		if(!char) then return "no char" end
		
		ply:SetSubMaterial()
		if(ply.bm and ply.bm.t) then
			ply.bm.t:SetSubMaterial()
		end
		char:setData("submat")
		char:setData("gsub")
	
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
		
		--should be it
		return "should reset"
	end,
})

nut.command.add("charseteyecolor", {
	syntax = "<string target> <string color>",
    adminOnly = true,
	desc = "Set the eye color of the person (blue, green, or anything else/nothing for hazel)",
	onRun = function(client, arguments)
        local target = nut.util.findPlayer(arguments[1])
		if(!target) then return "invalid player" end
		local color = arguments[2]
		local char = target:getChar()
		if(!char) then return "no char" end
		
		local mats = target:GetMaterials()
		local mat = {}
		for k,v in ipairs(mats) do
			if(string.find(v, "eyeball_l")) then
				mat[#mat+1] = {mat = k-1, type = "l"}
			end
			if(string.find(v, "eyeball_r")) then
				mat[#mat+1] = {mat = k-1, type = "r"}
			end
		end

		char:setData("eyes", color)
		if(color == "blue") then
			for k,v in pairs(mat) do
				target:SetSubMaterial(v.mat, v.type == "l" and "models/bloo_ltcom_zel/citizens/eyeball_l_blue" or "models/bloo_ltcom_zel/citizens/eyeball_r_blue")
			end
		elseif(color == "green") then
			for k,v in pairs(mat) do
				target:SetSubMaterial(v.mat, v.type == "l" and "models/bloo_ltcom_zel/citizens/eyeball_l_green" or "models/bloo_ltcom_zel/citizens/eyeball_r_green")
			end
		elseif(color == "cyber") then
			for k,v in pairs(mat) do
				target:SetSubMaterial(v.mat, v.type == "l" and "models/sky/eyeball_cyber_l" or "models/sky/eyeball_cyber_r")
			end
		else
			for k,v in pairs(mat) do
				target:SetSubMaterial(v.mat)
			end
		end

		
		--should be it
		return "should be changed"
	end,
})


local whitelistArmors = {
	"_sunrise", "_io7a", "_eco", "_trenchcoat"
}
--todo need to prevent/reset this depending on headgear
nut.command.add("togglehood", {
	desc = "Take the hood on/off if you're wearing a model with a hood. Probably will have clipping issues with headgear.",
	onRun = function(client, arguments)
		if(!client.bm or !IsValid(client.bm.t)) then return end
		if(client:GetModel():find("_mask")) then return "You cannot toggle hood while wearing a helmet!" end

		local anorak = false
		if(client.bm.t:GetModel():find("_anorak")) then 
			anorak = true
		else
			local white = false
			--whitelists
			for k,v in pairs(whitelistArmors) do
				if(client.bm.t:GetModel():find(v)) then
					white = true
					break
				end
			end
			if(!white) then return "Your outfit does not have a toggleable hood!" end
		end

		local index = client.bm.t:FindBodygroupByName(anorak and "anorak" or "hood")
		if(index > -1) then --double checking
			if(client.bm.t:GetBodygroup(index) == 0) then --its off
				local hood = math.Clamp(ANORAKHOODGROUP[client:GetModel()] or 1, 0, client.bm.t:GetBodygroupCount(index)-1)
				--client:SetBodygroup(index, )

				nut.newchar.setBodygroups(client, "t", {[index] = hood})
				if(index == 0) then
					client:getChar():setData("gtop", hood)
				end

				--so it should save
				local grps = client:getChar():getData("groups", {})
				--grps[index] = 1
				
				local groups = {}
				for k, value in pairs(ANORAKBODYGROUPS[client:GetModel()] or {}) do
					local index = client:FindBodygroupByName(k)

					if (index > -1) then
						groups[index] = value
					end
				end

				for index, value in pairs(groups) do
					grps[index] = value
					client:SetBodygroup(index, value)
				end

				client:getChar():setData("groups", grps)
			else --its on
				local hood = 0
				--client:SetBodygroup(index, 0)
				nut.newchar.setBodygroups(client, "t", {[index] = 0})
				if(index == 0) then
					client:getChar():setData("gtop", 0)
				end

				--so it should save
				local grps = client:getChar():getData("groups", {})
				--grps[index] = nil
				
				local groups = {}
				for k, value in pairs(ANORAKBODYGROUPS[client:GetModel()] or {}) do
					local index = client:FindBodygroupByName(k)

					if (index > -1) then
						groups[index] = 0
					end
				end

				for index, value in pairs(groups) do
					grps[index] = nil
					client:SetBodygroup(index, 0)
				end

				client:getChar():setData("groups", grps)
			end
		end
	end
})
--[[
nut.command.add("apply", {
	--desc = "",
	onRun = function(client, arguments)
		
	end
})
]]

nut.command.add("toggleprone", {
	desc = "Use to toggle prone status if the hotkeys dont work like when im making this rn",
	onRun = function(client, arguments)
		if(!prone or !prone.Handle) then return end
		
		prone.Handle(client)
	end
})

nut.command.add("devutildistance", {
	adminOnly = true,
	desc = "Utility function to get the distance to where you're pointing",
    onRun = function(client, arguments)
        local tr = client:GetEyeTrace()
        local dis = tr.StartPos:Distance(tr.HitPos)

        return "Distance between you and the point you hit: "..math.Round(dis, 3)
	end
})
nut.command.add("devutilposition", {
	adminOnly = true,
	desc = "Utility function to get your current position",
    onRun = function(client, arguments)

        return "Position: "..client:GetPos()
	end
})
nut.command.add("forceresetpac", {
    syntax = "<string name>",
	desc = "*should* clear target's pac",
    adminOnly = true,
    onRun = function(client, arguments)
        local target = nut.util.findPlayer(arguments[1])
		if(!target) then return "invalid player" end

		target:ConCommand("pac_clear_parts")
		return "ran"
	end
})

local vendorTbls = {
	["main"] = {
		"ammo_9x19",
		"ammo_9x18",
		"ammo_45acp",
		"ammo_762x25",
		"ammo_buckshot",
		"ammo_buckshot_slug",
		"rep_glue_b",
		"drink_waterflask",
		"food_bread",
		"food_cantuna",
		"meds_bandage",
		"medkit",
		"meds_antirad",
		"binoculars"
	}
}

nut.command.add("setvendor", {
    syntax = "<string tableid>",
	desc = "dont use this command",
    adminOnly = true,
    onRun = function(client, arguments)
        local tr = client:GetEyeTrace()
		if(tr.Entity and tr.Entity:GetClass() == "nut_vendor") then
			local vend = tr.Entity
			if(arguments[1] == "all") then
				for k,v in pairs(nut.item.list) do vend.items[k] = {[3] = 3} end
				nut.plugin.list.vendor:saveVendors()
				return "ran all"
			end
			if(vendorTbls[arguments[1]] != nil) then
				vend.items = vend.items or {}
				for k, v in ipairs(vendorTbls[arguments[1]]) do
					vend.items[v] = vend.items[v] or {}
					vend.items[v][VENDOR_MODE] = VENDOR_SELLONLY
				end
				nut.plugin.list.vendor:saveVendors()

				return "ran"
			end
			return "no tbl"
		end

		return "no entity"
	end
})
nut.command.add("vendormulti", {
    syntax = "<number multi>",
	desc = "multiplies every items price by a set amount, put 0 to reset, dont use this command",
    adminOnly = true,
    onRun = function(client, arguments)
		local num = tonumber(arguments[1])
        local tr = client:GetEyeTrace()
		if(tr.Entity and tr.Entity:GetClass() == "nut_vendor") then
			local vend = tr.Entity
			for k, v in pairs(vend.items) do
				if(v[VENDOR_PRICE]) then
					if(num == 0) then
						v[VENDOR_PRICE] = nil
					else
						v[VENDOR_PRICE] = v[VENDOR_PRICE] * num
					end
				elseif(num != 0) then
					v[VENDOR_PRICE] = nut.item.list[k].price * num
				end
			end
			nut.plugin.list.vendor:saveVendors()

			return "no tbl"
		end

		return "no entity"
	end
})

nut.command.add("resetstorage", {
	desc = "If you ever can't use storages, use this command, should work",
	onRun = function(client, arguments)
		local storage = client.nutStorageEntity
		if (IsValid(storage)) then
			storage.receivers[client] = nil
		end
		client.nutStorageEntity = nil
		
	end
})


if(CLIENT) then
	net.Receive("gestureSet", function()
		local target = net.ReadEntity()
		--local slot = net.ReadInt(4)
		local val = net.ReadInt(18)

		target:AnimRestartGesture(GESTURE_SLOT_CUSTOM, val, true)
	end)
	net.Receive("gestureSetstr", function()
		local target = net.ReadEntity()
		--local slot = net.ReadInt(4)
		local v = net.ReadString()
		local val = target:LookupSequence(v)
		if(val == -1) then return end

		target:AnimRestartGesture(GESTURE_SLOT_CUSTOM, val, true)
	end)
else
	util.AddNetworkString("gestureSet")
	util.AddNetworkString("gestureSetstr")

end
local function setGesture(ply, val)
	net.Start("gestureSet")
	net.WriteEntity(ply)
	net.WriteInt(val, 18)
	net.SendPVS(ply:GetPos())
end
local function setGestureStr(ply, val)
	net.Start("gestureSetStr")
	net.WriteEntity(ply)
	net.WriteString(val)
	net.SendPVS(ply:GetPos())
end
	--[[ --no worky :(
nut.command.add("gestureheadshake", {
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		local str = "male_hg_headshake"
		if(client:isFemale()) then
			str = "female_hg_headshake"
		end

		setGestureStr(client, str)
	end
})
nut.command.add("gesturenodleft", {
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		local str = "male_hg_nod_left"
		if(client:isFemale()) then
			str = "female_hg_nod_left"
		end

		setGestureStr(client, str)
	end
})
nut.command.add("gesturenodright", {
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		local str = "male_hg_nod_right"
		if(client:isFemale()) then
			str = "female_hg_nod_right"
		end

		setGestureStr(client, str)
	end
})
]]
nut.command.add("gesturehalt", {
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		setGesture(client, ACT_SIGNAL_HALT)
	end
})
nut.command.add("gesturegroup", {
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		setGesture(client, ACT_SIGNAL_GROUP)
	end
})
nut.command.add("gestureforward", {
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		setGesture(client, ACT_SIGNAL_FORWARD)
	end
})
nut.command.add("gesturebecon", {
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		setGesture(client, ACT_GMOD_GESTURE_BECON)
	end
})
nut.command.add("gesturebow", {
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		setGesture(client, ACT_GMOD_GESTURE_BOW)
	end
})
nut.command.add("gesturewave", {
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		setGesture(client, ACT_GMOD_GESTURE_WAVE)
	end
})
