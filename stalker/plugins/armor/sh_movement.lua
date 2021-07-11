local PLUGIN = PLUGIN

nut.config.add("movementEffects", false, "Enable leg breaking", nil, {
	category = "Shoot to RP"
})
nut.config.add("movespeedRatio", 0.4, "The percentage of health needed to be missing (1 == 100% of health, 0 == 0%) in order to start slowing players' speed. Requires downing to be on.", nil, {
	form = "Float",
	data = {min = 0, max = 1},
	category = "Shoot to RP"
})

hook.Add("PluginShouldLoad", "disablestamina", function(id)
	if(id == "stamina") then return false end
end)


hook.Add("StartCommand", "removespr", function(ply, cmd)
	
	if(ply:GetMoveType() != MOVETYPE_NOCLIP and (ply:getNetVar("brth") or (ply:getChar() and (ply:getChar():getData("leghit") or nut.traits.hasTrait(ply, "big_cripple"))))) then
		if(staminatest) then
			print("pls stop")
		end
		if(cmd:KeyDown(IN_SPEED)) then
			--its not like anyone used shift+alt anyway
			cmd:RemoveKey(IN_SPEED)
		end
		if(cmd:KeyDown(IN_JUMP)) then
			cmd:RemoveKey(IN_JUMP)
		end
	end
end)

if(SERVER) then
    function PLUGIN:PlayerDeath(client, inflictor, attacker)
	    --nut.log.addRaw(client:Name().." ("..client:steamName()..") was killed with "..inflictor:GetName().." by "..attacker:GetName())
	
    	local dw = nut.config.get("downing", false)
	    if (dw) then
        	if(client:getChar():getData("leghit")) then
		        client:getChar():setData("leghit", nil, nil, player.GetAll())
        	end
    	end
    end
	
	hook.Add("PlayerDisconnected", "JustWaitTheFuckingTimer", function(ply)
		local character = ply:getChar()
		if(ply:getNetVar("neardeath")) then
			if(character) then
				character:setData("pos", nil)
				character:setData("health", nil)
			end
			
			--maybe?
			ply:setNetVar("neardeath", nil) --just to be safe
			ply:Kill()

			--todo change to evolve ban
			--RunConsoleCommand("ev","ban",ply:SteamID(),"10","Just wait the respawn timer out next time okay? It's a fucking minute.")
		else
			local char = character
			if(char) then
				char:setData("health", ply:Health())

			end
		end
	end)

    --honestly if they spam space its their fault their stamina is gone
hook.Add("KeyRelease", "JumpStam", function(client, key)
    if(key == IN_JUMP and client:GetMoveType() != MOVETYPE_NOCLIP and client:getChar()) then
		client:restoreStamina(-15) --still wanna change this eventually
		local stm = client:getLocalVar("stm", 0)
		if(stm == 0) then
			--client:SetRunSpeed(nut.config.get("walkSpeed"))
			client:setNetVar("brth", true)
			client:ConCommand("-speed")
		end
	end
end)

hook.Add("GetFallDamage", "BreakLegs", function(ply, speed)
	local dw = nut.config.get("movementEffects", false)
	if (dw) then
		if(IsValid(ply) and ply:getChar()) then
			--[[if(ply:getChar().getImplants and ply:getChar():getImplants("implants", "fallprot")) then--Data("implants", {})["fallprot"]) then
				print(speed)
				if(speed > 520) then
					ply:EmitSound("player/longfall_land_01.wav", 80, math.random(97, 103))
				end
				return 
			end]]
			if(speed > 600) then --620
				ply:getChar():setData("leghit", true, nil, player.GetAll())
				ply:notify("It appears a leg broke from your fall!", 3)
			end
		end
	end
end)
end

--idea from tfa base :)
hook.Add("SetupMove", "slowhpply", function(ply, moved, commandd)
	local hp = ply:Health()
	if(!ply:getChar()) then return end --no reason then lmao

	local res = ply:GetArmorResists()
	local char = ply:getChar()

	local over = 1
	local weight, max = char:getInv():getWeight(), char:getInv():getMaxWeight()
	--overencumbered, im gonna make double the max weight the point where you cant walk anymore
	if(weight > max) then 
		local fun = 1-(((weight-max) / max)*char:getData("maxwgtbuf", 0.6))

		over = math.max(0.01, fun) --just in case, max of 0.01
	end

	if(hp >= 100) then
		local ms = res["spd"] or 1
		ms = ms*over

		if(nut.traits.hasTrait(ply, "big_cripple")) then
			ms = ms*0.75
		end

		if(ply:getNetVar("restricted")) then --slow the restricted player
			ms = ms*0.5
		end
		
		local spd = moved:GetMaxClientSpeed()
		if(prone and prone.config and ply:IsProne()) then
			spd = prone.config.MoveSpeed
		end
		
		moved:SetMaxClientSpeed(spd*ms)
		commandd:SetForwardMove(commandd:GetForwardMove()*ms)
		commandd:SetSideMove(commandd:GetSideMove()*ms)

		return 
	end

	local ratio = 1
	
					
	if(!res["norat"]) then
		local baserat = nut.config.get("movespeedRatio", 0.4)
		if(IsValid(ply) and (char:getFaction() == FACTION_MONOLITH or res["imprat"])) then baserat = baserat + 0.2 end						
		ratio = (ply:Health()/ply:GetMaxHealth()) + baserat
		if(ratio > 1) then
			ratio = 1
		end
	end
	local ms = res["spd"] or 1
	ms = ms*over
	
	if(nut.traits.hasTrait(ply, "big_cripple")) then
		ms = ms*0.75
	end

	if(ply:getNetVar("restricted")) then --slow the restricted player
		ms = ms*0.5
	end

	local spd = moved:GetMaxClientSpeed()
	if(prone and prone.config and ply:IsProne()) then
		spd = prone.config.MoveSpeed
	end

	moved:SetMaxClientSpeed(spd*ratio*ms)
	commandd:SetForwardMove(commandd:GetForwardMove()*ratio*ms)
	commandd:SetSideMove(commandd:GetSideMove()*ratio*ms)
end)


--my modified stamina plugin
if (SERVER) then
	--whatever this is easier i guess
	function PLUGIN:PlayerSpawn(client)
		--if(!timer.Exists("nutStam"..client:SteamID())) then --if it was removed for some reason
			self:InitStam(client)
		--end 	
	end

	function PLUGIN:PostPlayerLoadout(client)
		--if(!timer.Exists("nutStam"..client:SteamID())) then --if it was removed for some reason			
		self:InitStam(client)
		--end 	

	end

	function PLUGIN:InitStam(client, noreset)
		if(!noreset) then
		client:setLocalVar("stm", 100)
		client:setNetVar("brth", nil)
		end

		local uniqueID = "nutStam"..client:SteamID()
		local offset = 0
		local velocity
		local length2D = 0
		local runSpeed = client:GetRunSpeed() - 5

		timer.Create(uniqueID, 0.25, 0, function()
			if (IsValid(client)) then
				if(IsValid(client.nutRagdoll)) then return end --idk

				local character = client:getChar()
																			--harmless but eh
				if (client:GetMoveType() != MOVETYPE_NOCLIP and character and !client:getNetVar("neardeath")) then
					velocity = client:GetVelocity()
					length2D = velocity:Length2D()
					local dw = nut.config.get("downing", false)

					local ratio = 1
					local ply = client
					
					local res = ply:GetArmorResists()
					
					if(!res["norat"]) then
						local baserat = nut.config.get("movespeedRatio", 0.4)
						if(IsValid(ply) and ply:getChar() and (ply:getChar():getFaction() == FACTION_MONOLITH or res["imprat"])) then baserat = baserat + 0.2 end						
						ratio = (ply:Health()/ply:GetMaxHealth()) + baserat
						if(ratio > 1) then
							ratio = 1
						end
					end
					local ms = res["spd"] or 1

					--tfa speed
					local sumwep = ply:GetActiveWeapon()
					local speedmult = 1
					if(IsValid(sumwep) and sumwep.IsTFAWeapon) then
						sumwep.IronSightsProgress = sumwep.IronSightsProgress or 0
						speedmult = Lerp(sumwep.IronSightsProgress, sumwep:GetStat("MoveSpeed"), sumwep:GetStat("IronSightsMoveSpeed"))
					end

					--it doesnt matter which way this is done in right?
					runSpeed = (nut.config.get("runSpeed") + (character:getAttrib("qkn", 0)))*ratio*ms*speedmult--*character:getSpdAdd())

					if (client:WaterLevel() > 1) then
						runSpeed = runSpeed * 0.775
					end


					if(staminatest) then
						print("test", tostring(client:IsSprinting()), tostring(client:KeyDown(IN_SPEED) and length2D >= (runSpeed - 20)), tostring(length2D), tostring(runSpeed-20), client:GetRunSpeed(), "<- is -5 = runspeed")
					end
					if (!ply:getNetVar("brth") and client:IsSprinting()) then--(((length2D >= (runSpeed - 10)) or (length2D >= (client:GetRunSpeed() - 10))) or (client:KeyDown(IN_SPEED) and length2D > 10))) then
						offset = -2 + ((character:getAttrib("stm", 0)*(res["spr"] or 1)) / 60) --* character:getStmAdd()) / 60)
					elseif (offset > 0.5) then
						offset = math.max(0, 1 * (res["stmres"] or 1))
					else
						offset = math.max(0, 1.75 * (res["stmres"] or 1))
					end

					--if crouching and not moving
					if (client:Crouching() and length2D == 0) then
						offset = offset + 1
					end

					--high needs bonus
					if(HIGH_THIRST_THRESHOLD and offset > 0 and character:GetThirst() >= HIGH_THIRST_THRESHOLD) then
						offset = offset*1.1 --slight boost
					end

					local current = client:getLocalVar("stm", 0)
					local value = math.Clamp(current + offset, 0, 100)

					if (current != value) then
						client:setLocalVar("stm", value)
						client:SetRunSpeed(runSpeed)

						if (value == 0 and !client:getNetVar("brth", false)) then
							--client:SetRunSpeed(nut.config.get("walkSpeed"))
							client:setNetVar("brth", true)
							client:ConCommand("-speed")

							character:updateAttrib("stm", 0.04)
							character:updateAttrib("qkn", 0.01)

							hook.Run("PlayerStaminaLost", client)
						elseif (value >= 50 and client:getNetVar("brth", false)) then
							--client:SetRunSpeed(runSpeed)
							client:setNetVar("brth", nil)
						end
					end
				end
			else
				timer.Remove(uniqueID)
			end
		end)
	end

	local playerMeta = FindMetaTable("Player")

	function playerMeta:restoreStamina(amount)
		local current = self:getLocalVar("stm", 0)
		local value = math.Clamp(current + amount, 0, 100)

		self:setLocalVar("stm", value)
	end
elseif(nut.bar) then
	nut.bar.add(function()
		return LocalPlayer():getLocalVar("stm", 0) / 100
	end, Color(200, 200, 40), nil, "stm")
end