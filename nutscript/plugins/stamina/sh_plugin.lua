PLUGIN.name = "Stamina"
PLUGIN.author = "Chessnut"
PLUGIN.desc = "Adds a stamina system to limit running."

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
						if(IsValid(ply) and ply:getChar() and (ply:getChar():getFaction() == FACTION_MONO or res["imprat"])) then baserat = baserat + 0.2 end						
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
					if (!ply:getNetVar("brth") and (((length2D >= (runSpeed - 20)) or (length2D >= (client:GetRunSpeed() - 20))) or (client:KeyDown(IN_SPEED) and length2D > 10))) then
						offset = -2 + ((character:getAttrib("stm", 0)*(client:GetArmorResists()["spr"] or 1)) / 60) --* character:getStmAdd()) / 60)
					elseif (offset > 0.5) then
						offset = 1
					else
						offset = 1.75
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
						--client:SetRunSpeed(runSpeed)

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