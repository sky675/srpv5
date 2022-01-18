PLUGIN.name = "sky's edits"
PLUGIN.author = "sky"
PLUGIN.desc = "assorted hooks and other things"

nut.util.include("sh_commands.lua")
--[[
hook.Add("PhysgunPickup", "StopDoorMoving", function (client, entity)
	if(entity:GetClass():lower() == "func_door" or entity:GetClass():lower() == "func_door_rotating" or entity:GetClass():lower() == "prop_door_rotating") then return false end    
end)

hook.Add("GetPlayerIcon", "meeeicon", function(client)
    --todo
end)
]]

function PLUGIN:CanDrive(ply, ent)
    if(!ply:IsAdmin()) then
        return false
    end
end

function PLUGIN:StartCommand(ply, cmd)
	if(ply:GetMoveType() != MOVETYPE_NOCLIP and ply:getNetVar("brth", false) and cmd:KeyDown(IN_JUMP)) then
		cmd:RemoveKey(IN_JUMP)
	end
end

hook.Add("CanProperty", "nobonemanip", function (ply, prop, ent)
	--persist has always been wonky for me, and since even recently its caused the server to break, and i prefer permaprops instead, im just preventing anyone from doing it
	if(prop == "persist") then return false end
	if(prop == "drive") then return false end
	if(prop == "bonemanipulate") then return false end
	if(!ply:IsAdmin() && prop == "editentity") then return false end --uh prob dont let randos do that
end)

local fems = { 
	["models/sky/stalker/neo.mdl"] = true,
	["models/sky/stalker/quiet.mdl"] = true,
}

hook.Add("CustomFemaleModel", "customSrpModel", function(model, ply, char, creation)
	if(creation) then return end
	
	if(fems[model]) then return true end

	if(char and char:getData("cFemale")) then
		return char:getData("cFemale")
	end
	if(!char and IsValid(ply) and ply:getChar() and ply:getChar():getData("cFemale")) then
		return ply:getChar():getData("cFemale")
	end

	if(string.find(model,"metroll/f")) then
		return true
	end
	
	return nil
end)
	
hook.Add("PluginShouldLoad", "disablePlugins", function(id)
	--dont need these
--[[	if(id == "recognition") then
		return false
	end
	]]
end)





if(SERVER) then

    --honestly if they spam space its their fault their stamina is gone
hook.Add("KeyRelease", "JumpStam", function(client, key)
    if(key == IN_JUMP and client:GetMoveType() != MOVETYPE_NOCLIP and client:getChar()) then
		client:restoreStamina(-15)
		local stm = client:getLocalVar("stm", 0)
		if(stm == 0) then
			--client:SetRunSpeed(nut.config.get("walkSpeed"))
			client:setNetVar("brth", true)
			client:ConCommand("-speed")
		end
	end
end)

hook.Add("PlayerInitialSpawn", "fukoffmusic", function(ply)
	local annoying = ents.FindByName("music")
	if(#annoying > 0) then
		annoying[1]:SetKeyValue("RefireTime", 99999999)
		annoying[1]:Fire("Disable") --i dont know if killing it stops the timer so here
        annoying[1]:Fire("Kill")
    else
        
	end
	if(game.GetMap() == "rp_jupiter_remaster") then
		for k,v in pairs(ents.FindByClass("point_hurt")) do
			if(IsValid(v)) then
				v:Remove()
			end
		end
	end
	if(game.GetMap() == "rp_stalker_redux") then --afaik this is the only map this does it on and is why this is here
		annoying = ents.FindByClass("trigger_soundscape")
		for k,v in pairs(annoying) do
			if(IsValid(v)) then
				v:Fire("Kill")
			end
		end
		local val = ents.GetMapCreatedEntity(1733) --this should be thunder?
		if(IsValid(val)) then
			val:SetKeyValue("RefireTime", 99999999)
			val:Fire("Disable") --i dont know if killing it stops the timer so here
			val:Fire("Kill")
		end
	end
end)

hook.Add("PlayerSpray", "DisablePlayerSpray", function(ply)
	return true
end)

--add new chat types that should be autoformatted here (or copy it to the right plugin preferably)
--[[hook.Add("CanAutoFormatMessage", "newones", function(client, chatType, message)
	if(chatType == "radio" or chatType == "radiow") then
		return true
	end
end)]]

hook.Add("PlayerSpawnedNPC", "disableDrop", function(ply, ent)
	ent:SetKeyValue("spawnflags", "8192") --disable drop weapons
end)
---[[
--]]
	gameevent.Listen("player_disconnect")
	hook.Add("player_disconnect", "leavelog", function(data) --this is better
		nut.log.addRaw(data.name.." disconnected. ("..data.reason..")", FLAG_WHITE)
	end)

	hook.Add("PlayerDeath", "playerdeathlog", function(client, inf, attacker)
		nut.log.addRaw((attacker:GetName() ~= "" and attacker:GetName() or attacker:GetClass()).." ("..attacker:GetClass()..") killed "..client:Name(), FLAG_DANGER) 
	end)
elseif(CLIENT) then
    hook.Add("ShouldDrawCrosshair", "HideSomeCross", function()
        local wep = LocalPlayer():GetActiveWeapon()
    
        if(wep and wep:IsValid()) then --for whatever reason the physgun's classname is nil
            if(wep.ClassName == nil or wep.ClassName == "gmod_tool" or string.find(wep.ClassName, "nut_") or string.find(wep.ClassName, "detector_")) then
                return true
            end
        end
    
        return false
	end)
	
	NUT_CVAR_BROADCAST = CreateClientConVar("nut_broadcast", 1, true, true)

	NUT_CVAR_STORAGE = CreateClientConVar("nut_storagespawn", 1, true, true)

    function PLUGIN:SetupQuickMenu(menu)
    	if (LocalPlayer():IsAdmin() or LocalPlayer():IsUserGroup("operator")) then
            local buttonItem = menu:addCheck("Broadcast Commands", function(panel, state)
                if(state) then
                    RunConsoleCommand("nut_broadcast", "1")
                else
                    RunConsoleCommand("nut_broadcast", "0")
                end
            end, NUT_CVAR_BROADCAST:GetBool())

            menu:addSpacer()
		end
		
		local b = menu:addCheck("Spawn Storages", function(panel, state)
			if(state) then
				RunConsoleCommand("nut_storagespawn", "1")
			else
				RunConsoleCommand("nut_storagespawn", "0")
			end
		end, NUT_CVAR_STORAGE:GetBool())

		menu:addSpacer()
    end
end