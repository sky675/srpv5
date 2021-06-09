local PLUGIN = PLUGIN


nut.command.add("togglenightvision", {
	desc = "Toggles nightvision if you have it, type specifies type if you have FLIR",
	syntax = "[number type]",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		local res = client:GetArmorResists()
		if(res["nv"] and res["nv"] != 0) then
			net.Start("PlayerSetNV")
			net.Send(client)
			if(arguments[1] and (tonumber(arguments[1]) <= res["nv"])) then
				net.Start("SetNVType")
				net.WriteInt(tonumber(arguments[1]), 3)
				net.Send(client)
			end
		end
	end
})
nut.command.add("setnightvision", {
	desc = "Set your nightvision type if you have nightvision on currently",
	syntax = "<number type>",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		local res = client:GetArmorResists()
		if(res["nv"] and res["nv"] != 0) then
			if(arguments[1] and (tonumber(arguments[1]) <= res["nv"])) then
				net.Start("SetNVType")
				net.WriteInt(tonumber(arguments[1]), 3)
				net.Send(client)
			end
		end
	end
})

nut.command.add("resetstatuses", {
	desc = "makes someone whos broken their legs be able to run again and also stop bleeding lmao",
	syntax = "<string name>",
	adminOnly = true,
	onRun = function(client, arguments)
		local dw = nut.config.get("downing", false)
		if (!dw) then return "Downing is not on :(" end

		local target 
		if(arguments[1]) then
			target = nut.util.findPlayer(arguments[1])
		else
			target = client
		end
		if(!IsValid(target)) then return "No target" end

		local char = target:getChar()
		if(!char) then return "No char" end

		char:setData("leghit", nil, nil, player.GetAll())
		char:setData("bleed", nil, nil, nil, player.GetAll())
		if(timer.Exists("bleedtime"..char:getID())) then
			timer.Remove("bleedtime"..char:getID())
		end

		return "reset statuses for "..target:Name()
	end
})


--armor enums
ARMOR_NONE = 0
ARMOR_IIA = 1
ARMOR_II = 2
ARMOR_IIIA = 3
ARMOR_III = 4
ARMOR_IV = 5
ARMOR_V = 6 --unsure if thisll be used but mebi lmao
ARMOR_I = 7 --lol

local blank = {
    ["chest"] = {level = ARMOR_NONE},
    ["head"] = {level = ARMOR_NONE},
    ["larm"] = {level = ARMOR_NONE},
    ["rarm"] = {level = ARMOR_NONE},
    ["lleg"] = {level = ARMOR_NONE},
    ["rleg"] = {level = ARMOR_NONE}
}
local blankres = {
	[DMG_BULLET] = 0, --bullet
	[DMG_SLASH] = 0, --seems to be the dmg type used by melee
	--other possible ones?
	--[DMG_CLUB] = 0, --this is for the crowbar, should be same as slash tbh
	--[DMG_BURN] = 0, --burn dmg obvi
	--[DMG_FALL] = 0, --would reduce fall damage, implants?
	--[DMG_BLAST] = 0, --blast/explosive damage obvi
	--[DMG_SHOCK] = 0, --electric
	--[DMG_POISON] = 0, --poison dmg?
	--[DMG_RADIATION] = 0, --????
	--[DMG_ACID] = 0, --????? probably better to use poison or rad
	--see https://wiki.garrysmod.com/page/Enums/DMG

	--[[other values that may be used but are not needed 
	(technically none of these are needed if you check if they exist):
	nospr = completely removes ability to sprint if it exists
	spd = movespeed multiplier (0-1)
	spr = lower == quicker stamina depletion, 1 == no effect (0-1)
	nv = 1 is normal nv, 2 is flir
	hud = existing == on
	imprat = existing == you get +0.2 movespeed ratio until you start slowing down, ex: at 0.4 u start slowing at 60%, with this its 40%
	]]
}


--new ammos =
--shotgun = flechette
local ammoProtect = {
	--if the armor level is not in this list, it means the ammo type will pen
	["sky9x18"] = {
		jhp = {[ARMOR_NONE] = 1.3, [ARMOR_I] = 0.6, [ARMOR_IIA] = 0.3,[ARMOR_II] = 0.2, [ARMOR_IIIA] = 0.15, [ARMOR_III] = 0.03, [ARMOR_IV] = 0.01},
		normal = {[ARMOR_I] = 0.75, [ARMOR_IIA] = 0.5,[ARMOR_II] = 0.35, [ARMOR_IIIA] = 0.2, [ARMOR_III] = 0.05, [ARMOR_IV] = 0.025},
		ap = {[ARMOR_II] = 0.5, [ARMOR_IIIA] = 0.35, [ARMOR_III] = 0.2, [ARMOR_IV] = 0.05},
	},
	["sky9x19"] = {
		jhp = {[ARMOR_NONE] = 1.3, [ARMOR_IIA] = 0.5,[ARMOR_II] = 0.4, [ARMOR_IIIA] = 0.3, [ARMOR_III] = 0.15, [ARMOR_IV] = 0.05},
		normal = {[ARMOR_IIA] = 0.7,[ARMOR_II] = 0.55, [ARMOR_IIIA] = 0.4, [ARMOR_III] = 0.25, [ARMOR_IV] = 0.1},
		ap = {[ARMOR_II] = 0.7, [ARMOR_IIIA] = 0.5, [ARMOR_III] = 0.3, [ARMOR_IV] = 0.15},
	},
	["sky45acp"] = {
		jhp = {[ARMOR_NONE] = 1.3, [ARMOR_IIA] = 0.5,[ARMOR_II] = 0.375, [ARMOR_IIIA] = 0.3, [ARMOR_III] = 0.2, [ARMOR_IV] = 0.075},
		normal = {[ARMOR_IIA] = 0.7,[ARMOR_II] = 0.525, [ARMOR_IIIA] = 0.375, [ARMOR_III] = 0.225, [ARMOR_IV] = 0.1},
		ap = {[ARMOR_II] = 0.7, [ARMOR_IIIA] = 0.55, [ARMOR_III] = 0.35, [ARMOR_IV] = 0.15},
	},
	["buckshot"] = {
		normal = {[ARMOR_IIIA] = 0.5, [ARMOR_III] = 0.35, [ARMOR_IV] = 0.1},
		slug = {[ARMOR_IIIA] = 0.75, [ARMOR_III] = 0.45, [ARMOR_IV] = 0.15},
		sabot = {[ARMOR_III] = 0.65, [ARMOR_IV] = 0.4},
	},
	["357"] = {
		jhp = {[ARMOR_NONE] = 1.3, [ARMOR_IIA] = 0.9,[ARMOR_II] = 0.6, [ARMOR_IIIA] = 0.35, [ARMOR_III] = 0.2, [ARMOR_IV] = 0.05},
		normal = {[ARMOR_II] = 0.65, [ARMOR_IIIA] = 0.5, [ARMOR_III] = 0.3, [ARMOR_IV] = 0.1},
		ap = {[ARMOR_IIIA] = 0.6, [ARMOR_III] = 0.4, [ARMOR_IV] = 0.15},
	},
	["sky762x39"] = {
		jhp = {[ARMOR_NONE] = 1.5, [ARMOR_IIA] = 1.3,[ARMOR_II] = 1.1, [ARMOR_IIIA] = 0.75, [ARMOR_III] = 0.4, [ARMOR_IV] = 0.2},
		normal = {[ARMOR_III] = 0.5, [ARMOR_IV] = 0.25},
		ap = { [ARMOR_IV] = 0.5},
	},
	["sky762x51"] = {
		jhp = {[ARMOR_NONE] = 1.5, [ARMOR_IIA] = 1.3,[ARMOR_II] = 1.1, [ARMOR_IIIA] = 0.75, [ARMOR_III] = 0.4, [ARMOR_IV] = 0.2},
		normal = {[ARMOR_III] = 0.5, [ARMOR_IV] = 0.25},
		ap = {[ARMOR_IV] = 0.5},
	},
	["sky556"] = {
		jhp = {[ARMOR_NONE] = 1.5, [ARMOR_IIA] = 1.3,[ARMOR_II] = 1.1, [ARMOR_IIIA] = 0.75, [ARMOR_III] = 0.4, [ARMOR_IV] = 0.2},
		normal = {[ARMOR_III] = 0.5, [ARMOR_IV] = 0.25},
		ap = {[ARMOR_IV] = 0.5},
	},
	["sky545"] = {
		jhp = {[ARMOR_NONE] = 1.5, [ARMOR_IIA] = 1.3,[ARMOR_II] = 1.1, [ARMOR_IIIA] = 0.75, [ARMOR_III] = 0.4, [ARMOR_IV] = 0.2},
		normal = {[ARMOR_III] = 0.5, [ARMOR_IV] = 0.25},
		ap = {[ARMOR_IV] = 0.5},
	},
	["sky50ae"] = {
		jhp = {[ARMOR_NONE] = 1.3, [ARMOR_IIA] = 1.2,[ARMOR_II] = 1.1, [ARMOR_IIIA] = 0.6, [ARMOR_III] = 0.3, [ARMOR_IV] = 0.1},
		normal = {[ARMOR_III] = 0.4, [ARMOR_IV] = 0.2},
		ap = {[ARMOR_IV] = 0.3},
	},
	["sky9x39"] = {
		jhp = {[ARMOR_NONE] = 1.5, [ARMOR_IIA] = 1.3,[ARMOR_II] = 1.15, [ARMOR_IIIA] = 0.75, [ARMOR_III] = 0.5, [ARMOR_IV] = 0.35},
		normal = {[ARMOR_III] = 0.65, [ARMOR_IV] = 0.3},
		ap = {[ARMOR_IV] = 0.45},
	},
	["sky762x54"] = {
		jhp = {[ARMOR_NONE] = 1.5, [ARMOR_IIA] = 1.4,[ARMOR_II] = 1.3, [ARMOR_IIIA] = 1.2, [ARMOR_III] = 0.75, [ARMOR_IV] = 0.3},
		normal = {[ARMOR_IV] = 0.4},
		ap = {[ARMOR_IV] = 0.6},
	},
	["sky762x25"] = {
		normal = {[ARMOR_IIIA] = 0.8, [ARMOR_III] = 0.6, [ARMOR_IV] = 0.4},
		ap = {[ARMOR_III] = 0.7, [ARMOR_IV] = 0.5},
	},
	["sky46"] = {
		jhp = {[ARMOR_NONE] = 1.4, [ARMOR_IIA] = 1.25,[ARMOR_II] = 1.1, [ARMOR_IIIA] = 0.8, [ARMOR_III] = 0.45, [ARMOR_IV] = 0.3},
		normal = {[ARMOR_III] = 0.6, [ARMOR_IV] = 0.4},
		ap = {[ARMOR_IV] = 0.6},
	},
	["sky57"] = {
		jhp = {[ARMOR_NONE] = 1.5, [ARMOR_IIA] = 1.4,[ARMOR_II] = 1.3, [ARMOR_IIIA] = 1.2, [ARMOR_III] = 0.75, [ARMOR_IV] = 0.3},
		normal = {[ARMOR_IV] = 0.4},
		ap = {[ARMOR_IV] = 0.6},
	}
	--23mm and 338 pens everything so not here
}

--[[ --old one
--i added in 23mm at 5 becuz idk what else lol
	--this is the old srp 2.0 protection table, some of these ammo types dont exist rn
local ammoProtect = { [ARMOR_NONE] = {[""]=true},
[ARMOR_IIA] = {["sky9x18"]=true,["sky9x19"]=true,["sky45acp"]=true,["sky22lr"]=true,},
[ARMOR_II] = {["sky9x18"]=true,["sky9x19"]=true,["sky45acp"]=true,["357"]=true,
	["sky22lr"]=true,},
[ARMOR_IIIA] = {["sky9x18"]=true,["sky9x19"]=true,["sky45acp"]=true,["357"]=true,
    ["buckshot"]=true,["sky22lr"]=true,},
[ARMOR_III] = {["sky9x18"]=true,["sky9x19"]=true,["sky45acp"]=true,["357"]=true,
    ["buckshot"]=true,["sky762x25"]=true,["sky762x38"]=true,["sky762x39"]=true,
    ["sky762x51"]=true,["sky556"]=true,["sky46"]=true,["sky545"]=true,
    ["sky50ae"]=true,["sky9x39"]=true,["sky22lr"]=true,},
[ARMOR_IV] = {["sky9x18"]=true,["sky9x19"]=true,["sky9x39"]=true,["sky45acp"]=true,
    ["357"]=true,["buckshot"]=true,["sky762x25"]=true,["sky762x38"]=true,
    ["sky762x39"]=true,["sky762x51"]=true,["sky556"]=true,["sky46"]=true,
	["sky545"]=true,["sky50ae"]=true,["sky57"]=true,["sky762x54"]=true,
	["sky22lr"]=true,},
[ARMOR_V] = {["sky9x18"]=true,["sky9x19"]=true,["sky9x39"]=true,["sky45acp"]=true,
    ["357"]=true,["buckshot"]=true,["sky762x25"]=true,["sky762x38"]=true,
    ["sky762x39"]=true,["sky762x51"]=true,["sky556"]=true,["sky46"]=true,
    ["sky545"]=true,["sky50ae"]=true,["sky57"]=true,["sky762x54"]=true,
	["sky338"]=true,["sky23mm"]=true,["sky22lr"]=true,}
}]]


--the players levels table, the part hit, the actual wep, and the dura of armor
function PLUGIN:IsCharProtected(levels, part, wep, durability)
    if(levels) then
		if(levels[part] and (durability or 1) != 0) then
			if(ammoProtect[wep.Primary.Ammo]) then			--uh just in case
				local spec = (wep.GetStat and wep:GetStat("SpecAmmo")) or (wep.GetBuff and wep:GetBuff("SpecAmmo")) or wep.SpecAmmo
				if(spec and ammoProtect[wep.Primary.Ammo][spec]) then
					return ammoProtect[wep.Primary.Ammo][spec][levels[part].level] or 1
				else
					return ammoProtect[wep.Primary.Ammo]["normal"][levels[part].level] or 1
				end
			else
				return 1 --just do no mod if its not in the table
			end
        end
    end
    return 1            
end


local stringtoenum = {
	none = ARMOR_NONE,
	I = ARMOR_I,
	IIA = ARMOR_IIA,
	II = ARMOR_II,
	IIIA = ARMOR_IIIA,
	III = ARMOR_III,
	IV = ARMOR_IV,
	V = ARMOR_V,
}

function PLUGIN:StringToArmorEnum(string)
	if(stringtoenum[string]) then
		return stringtoenum[string]
	end
	return ARMOR_NONE
end


do
	local playerMeta = FindMetaTable("Player")
	
	function playerMeta:GetArmorItems()
		local items = {}
        if(self:getChar()) then
			local inv = self:getChar():getInv()
			if(inv) then
				for k,item in pairs(inv:getItems()) do
        	        if(item.base == "base_armor" and item:getData("equip")) then
        	            items[item.id] = item
        	        end
				end
			end
        end
        return (table.Count(items) != 0 and items) or nil
    end

    function playerMeta:GetArmorLevels()
        local suit = self:GetArmorItems()
		if(suit) then
			local levels = {}
			for k,v in pairs(suit) do
				levels.durability = v:getData("durability")
				local armor = v:GetArmor()
				for k2,v2 in pairs(armor) do
					local r
					if(type(v2.level) == "string") then --backwards compatibility!
						r = PLUGIN:StringToArmorEnum(v2.level)
					else
						r = v2.level
					end
					if(!levels[k2] or levels[k2].level < r) then
						local ee = v2
						ee["orig"] = v.id
						levels[k2] = ee
					end
				end
			end

            return levels
        end
        return blank
    end
    
    function playerMeta:GetArmorResists()
		local suit = self:GetArmorItems()
		local def --no reason to copy it needlessly
		--local impres = self:getImplantRes() or {}
		if(suit) then
			local levels = {}
			for k,v in pairs(suit) do
				local armor = v.GetResists and v:GetResists() --???
				if(!armor) then print("wtf is this "..k.." "..tostring(v)) continue end

				for k2,v2 in pairs(armor) do --might need special ones?
					if(k2 == "spd" or k2 == "stmres") then
						levels[k2] = (levels[k2] or 1)*v2
					elseif(k2 == "nv" or k2 == "hud") then
						if(!levels[k2] or levels[k2] < v2) then --this should never be false but ya
							levels[k2] = v2
						end
					elseif(k2 == "nospr" or k2 == "nodrn") then
						--this should be correct?
						if(levels[k2] == nil or (levels[k2] == true and v2 == true)) then
							levels[k2] = v2
						end
					else
						levels[k2] = (levels[k2] or 0) + v2
					end
				end
			end
			
			--this should let me be able to modify the table? idk
			--so just do that, dont return a value
			hook.Run("CustomArmorResists", self, levels)

			--doing implants
			--[[for k2,v2 in pairs(impres) do --might need special ones?
				if(k2 == "spd") then
					levels[k2] = (levels[k2] or 1)*v2
				elseif(k2 == "nv" or k2 == "hud") then
					if(!levels[k2] or levels[k2] < v2) then --this should never be false but ya
						levels[k2] = v2
					end
				elseif(!istable(v2)) then
					levels[k2] = (levels[k2] or 0) + v2
				end
			end]]
				
			return levels
		else
			--this should let me be able to modify the table? idk
			--so just do that, dont return a value
			def = table.Copy(blankres)
			hook.Run("CustomArmorResists", self, def)
		end
		--if(impres) then return impres end
        return def
    end
    
    function playerMeta:GetArmorUpgrades()
        local suit = self:GetArmorItems()
		if(suit) then
			local var = {}
			for k,v in pairs(suit) do
				var[v.uniqueID] = v:GetUpgrades()
			end
			
            return var
        end
        return {}
    end

	function playerMeta:SetArmorDurability(part, newdur)
		local suit = self:GetArmorLevels()

		local duradead = false
		if(type(part) == "table") then
			local items = self:getChar():getInv():getItems()

			for k,v in pairs(part) do --this is probably kinda bad but watever
				if(v == 0) then
					duradead = true
				end
				
				local item = items[suit[k].orig]
				if(item) then
					--[[local armor = item:GetArmor()
					if(armor[k]) then
						armor[k].durability = v
					end]]
				
					item:setData("durability", v)
				end
			end
		elseif(part) then
			local orig = suit[part].orig
			if(orig) then 
			local item = self:getChar():getInv():getItems()[orig]

			if(item) then
				--[[local armor = item:GetArmor()
				if(armor[part]) then
					armor[part].durability = newdur
				end]]
			
				item:setData("durability", newdur)
			end
			end

		else --ugh
			local items = self:GetArmorItems()
			if(items) then
				for k,v in pairs(items) do --ughhhhhhhhhhh
					v:setData("durability", newdur)
					break
				end
			end
		end

        if((duradead or newdur == 0) and SERVER) then
            self:notify("At least one of your armor parts broke!", 3)
        end
    end
end

hook.Add("OnHealPlayer", "stopheart", function(ply, heal)
	if(SERVER) then
	if(ply:Health() > 30) then
		net.Start("toggleHeartbeat")
		net.WriteBool(false)
		net.Send(ply)
	end
	end
end)

if(SERVER) then
	
	util.AddNetworkString("UpdateNVType")
	util.AddNetworkString("SetNVType")
    util.AddNetworkString("PlayerSetNV")
	util.AddNetworkString("PlayerOffNV")
	
	util.AddNetworkString("toggleHeartbeat")

	hook.Add("ShouldPlayerDrown", "res", function(ply)
		local res = ply:GetArmorResists()

		if(res["nodrn"]) then
			return false
		end
	end)

else

	zHeartBeatPatch = zHeartBeatPatch or nil
	
	net.Receive("toggleHeartbeat", function()
		local bool = net.ReadBool()
		--print("helllooo hb "..tostring(bool))
		if(!bool) then
			if(zHeartBeatPatch) then
				--print("ok")
				zHeartBeatPatch:Stop()
			end
		else
			if(zHeartBeatPatch) then --kill it and make a new one
				zHeartBeatPatch:Stop()
			end
			zHeartBeatPatch = CreateSound(game.GetWorld(), "player/heartbeatloop.wav")
			if(zHeartBeatPatch) then
				zHeartBeatPatch:SetSoundLevel(0)
				zHeartBeatPatch:Play()
			else
				ErrorNoHalt("could not create soundpatch for heartbeat sound!")
			end
		end
	end)

	hook.Add("Tick", "heartbeatcheck", function()
		if(!IsValid(LocalPlayer())) then return end --loading errors

		local hp = LocalPlayer():Health()
		if(LocalPlayer():getChar() and zHeartBeatPatch and zHeartBeatPatch:IsPlaying()) then
			if(hp > 25) then
				zHeartBeatPatch:Stop()
			end
		end
	end)
	

	net.Receive("UpdateNVType", function() --add function on things that would support this?
		NV_NIGHTTYPE = res["nv"]
	end)
	net.Receive("SetNVType", function() --add function on things that would support this?
		local type = net.ReadInt(3)
		NV_NIGHTTYPE = type
	end)
    net.Receive("PlayerSetNV", function()
		local res = LocalPlayer():GetArmorResists()
        if(res["nv"] != 0) then
            if(!NV_Status) then
                NV_Status = true
                --if(NV_NIGHTTYPE != 1) then
                    NV_NIGHTTYPE = 1--res["nv"]
                --end
                hook.Add("RenderScreenspaceEffects", "NV_FX", NV_FX)
                surface.PlaySound(Sound("items/nvg_on.wav"))
            else
                NV_Status = false
                NV_NIGHTTYPE = 0
                hook.Remove("RenderScreenspaceEffects", "NV_FX")
                surface.PlaySound(Sound("items/nvg_off.wav"))
            end
        end
    end)
    net.Receive("PlayerOffNV", function()
            if(NV_Status) then
                NV_Status = false
                NV_NIGHTTYPE = 0
                hook.Remove("RenderScreenspaceEffects", "NV_FX")
            end
	end)
	
    hook.Add("PlayerBindPress", "DisableRun", function(ply, bind, pressed)
	    if(string.find(bind, "+speed") and ply:GetMoveType() != MOVETYPE_NOCLIP and ply:getChar()) then

			local res = ply:GetArmorResists()
			if(res["nospr"]) then
				return true
			end
        
        end
    end)
end