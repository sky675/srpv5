
function SCHEMA:CanPlayerUseChar(client, char)
	if(!client) then return end
	if(client:InVehicle()) then
		return false, "You cannot switch characters while in a vehicle or sitting!"
	end
	if(client:getNetVar("restricted")) then
		return false, "You cannot switch characters while tied!"
	end
end

--hook.Add("CanProperty", "nobonemanip", function (ply, prop, ent)
function SCHEMA:CanProperty(ply, prop, ent)
	if(prop == "persist") then return false end
	if(prop == "drive") then return false end
	if(prop == "bonemanipulate") then return false end
	if(!ply:IsAdmin() && prop == "editentity") then return false end --uh prob dont let randos do that
end

function SCHEMA:InitializedPlugins()
	--nut.plugin.setUnloaded("organization") --disable organization for now lol
	
	if(SERVER) then
		if (!self.pacEx or #self.pacEx == 0) then return end
	
		for k,v in pairs(self.pacEx) do
			nut.pac.list[k] = v.pacData
		end
	end
end

--????? idk lets see i guess
function SCHEMA:CanItemBeTransfered(itemObject, curInv, inventory)
	-- what the fuck is going on
	if (!itemObject) then
		if (SERVER) then
			for k, v in ipairs(player.GetAll()) do
				curInv:sync(v, true)
				inventory:sync(v, true)
			end
		end

		if (CLIENT) then
			nut.gui.inv1:Remove()
		end
	end

	-- if item is actually transferred to player's inventory.
    if (inventory and curInv) then
		local a = curInv.owner
		local b = inventory.owner

		local owner, newowner

		for k, v in ipairs(player.GetAll()) do
			local char = v:getChar()

			if (char) then
				if (char:getID() == a) then
					owner = v
				elseif (char:getID() == b) then
					newowner = v
				end
			end
		end 
		
		if (IsValid(owner)) then
			if (IsValid(owner:getNetVar("searcher"))) then
				return false
			end
		end

		if (IsValid(newowner)) then
			if (IsValid(newowner:getNetVar("searcher"))) then
				return false
			end
		end

        if (inventory.vars) then
			if (itemObject and itemObject.isBag) then
				-- there is no point for recursive search.
				for itemID, invItem in pairs(inventory:getItems(true)) do
					if (invItem.outfitCategory == itemObject.outfitCategory) then
						return false, "sameTypeBagExists"
					end
				end
			end
        end
    end
end

--i guess a way to go around this is by using the TFA_GetStat hook, idk
--itd just be if statements for each stat, all the ones in the att
-- ply:getImplantRes() to get implant specific adds to this, but do GetArmorResists instead just in case
hook.Add("GetKickUpStat", "MainS", function(wep, stat)
	--[[local item = wep:GetOwner():getChar():getInv():hasItem("imp_main", {power = true})
	if(!item) then return stat * nut.traits.getMod(wep:GetOwner(), "wepreceff", wep.Type or "") end
	if(wep:IsAttached("sky_smartlink") and item:getData("attachedwep", "") == wep:GetClass()) then
		local res = wep:GetOwner():GetArmorResists()
		local smart = res["smartrec"] or 1

		return stat * smart * nut.traits.getMod(wep:GetOwner(), "wepreceff", wep.Type or "")
	end]]
	return stat * nut.traits.getMod(wep:GetOwner(), "wepreceff", wep.Type or "")
end)

hook.Add("GetKickDownStat", "MainS", function(wep, stat)
	--[[local item = wep:GetOwner():getChar():getInv():hasItem("imp_main", {power = true})
	if(!item) then return stat * nut.traits.getMod(wep:GetOwner(), "wepreceff", wep.Type or "") end
	if(wep:IsAttached("sky_smartlink") and item:getData("attachedwep", "") == wep:GetClass()) then
		local res = wep:GetOwner():GetArmorResists()
		local smart = res["smartrec"] or 1

		return stat * smart --* nut.traits.getMod(wep:GetOwner(), "wepreceff", wep.Type or "")
	end]]
	return stat-- * nut.traits.getMod(wep:GetOwner(), "wepreceff", wep.Type or "")
end)

hook.Add("GetKickHorizontalStat", "MainS", function(wep, stat)
	--[[local item = wep:GetOwner():getChar():getInv():hasItem("imp_main", {power = true})
	if(!item) then return stat * nut.traits.getMod(wep:GetOwner(), "wepreceff", wep.Type or "") end
	if(wep:IsAttached("sky_smartlink") and item:getData("attachedwep", "") == wep:GetClass()) then
		local res = wep:GetOwner():GetArmorResists()
		local smart = res["smartrec"] or 1

		return stat * smart * nut.traits.getMod(wep:GetOwner(), "wepreceff", wep.Type or "")
	end]]
	return stat * nut.traits.getMod(wep:GetOwner(), "wepreceff", wep.Type or "")
end)

hook.Add("GetStaticRecoilFactorStat", "MainS", function(wep, stat)

end)

hook.Add("GetDamageStat", "MainS", function(wep, stat)
	return stat * nut.traits.getMod(wep:GetOwner(), "wepdmgeff", wep.Type or "")
end)

hook.Add("GetSpreadStat", "MainS", function(wep, stat)
	--[[local item = wep:GetOwner():getChar():getInv():hasItem("imp_main", {power = true})
	if(!item) then return stat * nut.traits.getMod(wep:GetOwner(), "wepspreff", wep.Type or "") end
	if(wep:IsAttached("sky_smartlink") and item:getData("attachedwep", "") == wep:GetClass()) then
		local res = wep:GetOwner():GetArmorResists()
		local smart = res["smartspr"] or 1

		return stat * smart * nut.traits.getMod(wep:GetOwner(), "wepspreff", wep.Type or "")
	end]]
	return stat * nut.traits.getMod(wep:GetOwner(), "wepspreff", wep.Type or "")
end)

hook.Add("GetIronAccuracyStat", "MainS", function(wep, stat)
	local res = wep:GetOwner():GetArmorResists()

	return stat * (res["ironacc"] or 1)
end)

hook.Add("GetIronRecoilMultiStat", "MainS", function(wep, stat)
	local res = wep:GetOwner():GetArmorResists()
	return stat * (res["ironrecoil"] or 1) * nut.traits.getMod(wep:GetOwner(), "wepireceff", wep.Type or "")
end)

hook.Add("GetCrouchAccuracyMultiStat", "MainS", function(wep, stat)

end)

hook.Add("GetIronSightsTimeStat", "MainS", function(wep, stat)
	local res = wep:GetOwner():GetArmorResists()
	local qk = wep:GetOwner():getChar():getAttrib("qkn", 0)
	local qkn = 1+((qk/30)*0.15)

	return stat * (res["irontime"] or 1) * qkn * nut.traits.getMod(wep:GetOwner(), "wepireff", wep.Type or "")
end)

hook.Add("GetWeaponMoveSpeedMulti", "MainS", function(wep, stat)

end)

hook.Add("GetIronSightsMoveSpeedMulti", "MainS", function(wep, stat)
	local res = wep:GetOwner():GetArmorResists()
	return stat * (res["ironms"] or 1)
end)

--this should be a way to speed up reloads
hook.Add("TFA_AnimationRate", "MainS", function(wep, anim, rate)
	--i think these are all of them
	if(!IsValid(wep) or !IsValid(wep:GetOwner()) or !wep:GetOwner():getChar()) then return end

	--todo move this to a table probably
	if(anim == ACT_VM_RELOAD or anim == ACT_VM_RELOAD_EMPTY or anim == ACT_VM_RELOAD_INSERT or anim == ACT_VM_RELOAD_INSERT_PULL or anim == ACT_VM_RELOAD_END or anim == ACT_VM_RELOAD_END_EMPTY or anim == ACT_VM_RELOAD_INSERT_EMPTY or anim == ACT_SHOTGUN_RELOAD_START or anim == ACT_SHOTGUN_RELOAD_FINISH or anim == 2105 or anim == 2150 or anim == 2151 or anim == 2094 or anim == 2095) then
		--[[local item = wep:GetOwner():getChar():getInv():hasItem("imp_main", {power = true})
		local smart = 1
		if(item and wep:IsAttached("sky_smartlink") and item:getData("attachedwep", "") == wep:GetClass()) then
			local res = wep:GetOwner():GetArmorResists()
			smart = res["smartreload"]
		end]]
		local qk = wep:GetOwner():getChar():getAttrib("qkn", 0)
		local qkn = 1+((qk/30)*0.16)
		
		qkn = qkn * nut.traits.getMod(wep:GetOwner(), "wepreloadeff", wep.Type or "")


		return rate * qkn
	end
end)
