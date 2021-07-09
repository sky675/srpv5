local PLUGIN = PLUGIN

nut.config.add("damage", false, "Turns on damage and everything related to it.", nil, {
	category = "Shoot to RP"
})
nut.config.add("downing", true, "Turns on the downing system, requires damage to be on to do anything.", nil, {
	category = "Shoot to RP"
})
nut.config.add("downedRespawnTimer", 60, "The downed respawn length.", nil, {
	form = "Int",
	data = {min = 5, max = 600},
	category = "Shoot to RP"
})
nut.config.add("shootMessages", true, "If on, chat messages are sent to the attacker and victim describing the type of bullet, range, direction, and tells you if you are protected from it or not.", nil, {
	category = "Shoot to RP"
})
nut.config.add("durabilityPenalty", true, "If on, will remove a portion of all equipped items' durability, proportional to the current durability (less current == less lost), on death (when the player actually dies, post death)", nil, {
	category = "Shoot to RP"
})
nut.config.add("durabilityPenaltyAmt", 5, "The maximum amount of durability lost (at 100 durability)", nil,{
	data = {min = 0, max = 100},
	category = "Shoot to RP"
})


nut.command.add("settypingimm", {
	desc = "Remove someone's damage immunity/slower bleed when typing",
	syntax = "<string name>",
	adminOnly = true,
	onRun = function(client, arguments)
		local target = nut.util.findPlayer(arguments[1])

		if(!IsValid(target)) then return "No target" end        
		if(target == client) then
			return "You cannot toggle it on yourself!"
		end

		local setTo = true
		if(target:getNutData("typeImm")) then
			setTo = nil
		end

		target:setNutData("typeImm", setTo)
		target:saveNutData()
		
		local on = "disabled"
		if(setTo == nil) then
			on = "enabled"
		end

		client:notify(on.." "..target:Name().."'s ability to be automatically immune from shots while typing.", 2)
	end
})

nut.command.add("plyrevive", {
	desc = "Revive a downed player completely",
	syntax = "<string name>",
	adminOnly = true,
	onRun = function(client, arguments)
		local dw = nut.config.get("downing", false)
		if (!dw) then return "Downing is not on :(" end
		if(!arguments or !arguments[1]) then return "No target" end

		local target = nut.util.findPlayer(arguments[1])
		if(!IsValid(target)) then return "No target" end
		if(client:SteamID() != "STEAM_0:0:23875518" and target:getChar():getData("activerun")) then return "You cant revive someone in a run, blame blood for this smh" end

		net.Start("toggleHeartbeat")
		net.WriteBool(false)
		net.Send(target)

		local char = target:getChar()
		
		char:setData("leghit", nil, nil, player.GetAll())
		char:setData("bleed", nil, nil, nil, player.GetAll())
		if(timer.Exists("bleedtime"..char:getID())) then
			timer.Remove("bleedtime"..char:getID())
		end
		
		target:setRagdolled(false)
		target:setNetVar("neardeath", nil)
		target:setNetVar("startdown", nil)
		target:setNetVar("canrevive", nil)
		target:setNetVar("canscirevive", nil)
		target:setNetVar("canplatrevive", nil)
		target:SetHealth(target:GetMaxHealth())
		target:setAction()
		target:SetNoTarget(false) --so npcs stop attacking
		target:RemoveAllDecals()
	end
})

nut.command.add("plyslay", {
	desc = "Slay a player, add true to make it act like they died from downing (drops patch and etc)",
	syntax = "<string name> [bool dropPatch]",
	adminOnly = true,
	onRun = function(client, arguments)
		local dw = nut.config.get("downing", false)
		if (!dw) then return "Downing is not on :(" end

		local target = nut.util.findPlayer(arguments[1])
		if(!IsValid(target)) then return "No target" end

		if(tobool(arguments[2])) then
			hook.Run("OnDownedFinish", target)
		end

		target:Kill()
	end
})

nut.command.add("acd", {
	desc = "Used to respawn when downed once the timer is up.",
	onRun = function(client, arguments)
		local dw = nut.config.get("downing", false)
		if (!dw) then return "Downing is not on :(" end

		if(client:getNetVar("canresp")) then
			hook.Run("OnDownedFinish", client, client:getNetVar("lastatk"))
			client:Kill()
		end
	end
})

nut.command.add("devutilhealth", {
	desc = "Utility function to get the health of who/what you're looking at",
	adminOnly = true,
	onRun = function(client, arguments)

		local tr = client:GetEyeTrace()
		if(tr.Entity) then
			if(tr.Entity.Health) then
				return tr.Entity:Health()
			end
		end
	end
})

nut.command.add("replyatk", {
	desc = "Quick command to PM to whoever last attacked you",
	syntax = "<string message>",
	onRun = function(client, arguments)
		local target = client:getChar():getVar("lastatk")

		if (IsValid(target) and (client.nutNextPM or 0) < CurTime()) then
			nut.chat.send(client, "pm", table.concat(arguments, " "), false, {client, target})
			client.nutNextPM = CurTime() + 0.5
		end
	end
})
nut.command.add("replyvic", {
	desc = "Quick command to PM to whoever you last attacked",
	syntax = "<string message>",
	onRun = function(client, arguments)
		local target = client:getChar():getVar("lastvic")

		if (IsValid(target) and (client.nutNextPM or 0) < CurTime()) then
			nut.chat.send(client, "pm", table.concat(arguments, " "), false, {client, target})
			client.nutNextPM = CurTime() + 0.5
		end
	end
})

if(SERVER) then
	util.AddNetworkString("PlayerGetDmg")
	--entity (target)
	--entity (attacker)
	--entity (weapon)
	--int(4) (hitgroup)
	--int(32) (distance)
	--bool (protected)
	
	local hitStrings = {
		[HITGROUP_GENERIC] = "unknown",
		[HITGROUP_HEAD] = "head",
		[HITGROUP_CHEST] = "chest",
		[HITGROUP_STOMACH] = "abdomen",
		[HITGROUP_LEFTARM] = "left arm",
		[HITGROUP_RIGHTARM] = "right arm",
		[HITGROUP_LEFTLEG] = "left leg",
		[HITGROUP_RIGHTLEG] = "right leg"
	}
	local hitToLevel = {
		"head", "chest", "chest", "larm", "rarm", "lleg", "rleg"
	}

	local deathSounds = {
		Sound("vo/npc/male01/pain07.wav"),
		Sound("vo/npc/male01/pain08.wav"),
		Sound("vo/npc/male01/pain09.wav")
	}

	--trying to slim this down a bit, dmginfo shoooould take changes here?-it does
	function PLUGIN:DownPlayer(ply, dmginfo, hg)
		
			local atk = dmginfo:GetAttacker()
			--downing
			if(dmginfo:GetDamage() >= (ply:Health()-1)) then --should get near death
				--hmm
				if(nut.config.get("pkActive", false)) then
					return
				end

				local olddmg = dmginfo:GetDamage()
				--dmginfo:SetMaxDamage(ply:Health()-1)
				dmginfo:SetDamage(0)--ply:Health()-1) --this is mildly annoying but watever
				--deagro nextbots
				if(atk.NEXTBOT) then
					if(atk.GetTarget and atk:GetTarget() == ply) then
						atk:SetTarget(nil)
					end
				end

				ply:setNetVar("neardeath", true)

				local deathSound = hook.Run("GetPlayerDeathSound", ply) or table.Random(deathSounds)
				
				if (ply:isFemale() and !deathSound:find("female")) then
					deathSound = deathSound:gsub("male", "female")
				end
				net.Start("toggleHeartbeat")
				net.WriteBool(false)
				net.Send(ply)

				ply:SetNoTarget(true) --so npcs stop attacking

				hook.Run("OnDown", ply, dmginfo) --wow! integration!

				ply:EmitSound(deathSound)

				local n1 = (IsValid(atk) and (atk.Name and (isfunction(atk.Name) and atk:Name()) or atk.PrintName)) or "An entity"
				local n2 = IsValid(atk) and ((atk.SteamName and atk:SteamName()) or atk:GetClass()) or "unset attacker"
				local n3 = ply:Name()
				local n4 = ply:SteamName()
				nut.log.addRaw(n1.." ("..n2..") downed "..n3.." ("..n4..")!", FLAG_DANGER)
				hook.Run("OnPlyDowned", atk, ply)
				--nut.log.addRaw((atk.Name and atk:Name()) or "An entity".." ("..(atk.SteamName and atk:SteamName()) or atk:GetClass()..") downed "..ply:Name().." ("..ply:SteamName()..")!", FLAG_DANGER)
				if(!IsValid(ply.nutRagdoll)) then
					ply:setRagdolled(true, nil)
				else
					--get rid of the existing waking up timer
					if(timer.Exists("nutUnRagdoll"..ply:SteamID())) then
						timer.Remove("nutUnRagdoll"..ply:SteamID())
					end
				end
				ply:ExitVehicle() --yes

				if(!hg or hg != HITGROUP_HEAD) then
					ply:setNetVar("canrevive", true)
					if((ply:Health()-olddmg) < -55) then
						ply:setNetVar("canscirevive", true)
					end
				end
				if(ply:getNetVar("canrevive") and (ply:Health()-olddmg) < -25) then
					ply:setNetVar("canrevive", nil)
				end
				if((ply:Health()-olddmg) < -75) then
					ply:setNetVar("canplatrevive", true)
				end
				--]]
				if(atk:IsPlayer()) then--atk == ply or IsValid(dmginfo:GetInflictor())) then
				ply:setNetVar("startdown", true)
				end
				ply:setNetVar("lastatk", atk) --lives
				ply:setAction("Respawning", nut.config.get("downedRespawnTimer", 60), function()
					if(IsValid(ply) and ply:getNetVar("neardeath")) then
						ply:setNetVar("canresp", true)
						ply:notify("You can now respawn with /acd")
					end
				end)
				return true
			end
			if(!ply:getNetVar("neardeath") and ply:Health()-dmginfo:GetDamage() <= 30) then
				net.Start("toggleHeartbeat")
				net.WriteBool(true)
				net.Send(ply)
			end

	end

	
	local function ScaleDmg(ply, hg, dmginfo)
		local on = nut.config.get("damage", true)
		local atk = dmginfo:GetAttacker()
		local msgs = nut.config.get("shootMessages", true)

		if(atk:IsPlayer()) then
			local wep = atk:GetActiveWeapon()
			if(IsValid(ply.nutRagdoll)) then
				return
			end
			

			ply:getChar():setVar("lastatk", atk)
			atk:getChar():setVar("lastvic", ply)

			if(msgs) then
				net.Start("PlayerGetDmg")
				net.WriteEntity(ply)
				net.WriteEntity(atk)
				net.WriteEntity(wep)
				net.WriteInt(hg, 4)
				net.WriteInt(math.Round(ply:GetPos():Distance(atk:GetPos())/52.49, 2), 32)
			end
			local levels = ply:GetArmorLevels()
			local protected
			local dmgmulti = 1
			if(wep.Primary) then
				dmgmulti = PLUGIN:IsCharProtected(levels, hitToLevel[hg], wep, levels.durability)
				
			--else
			end
			
			if(msgs) then
				net.WriteFloat(dmgmulti)
				local infl = dmginfo:GetInflictor()
				--print(infl, atk, wep)
				if(IsValid(infl) and !infl:IsWeapon() and atk != infl) then
					net.WriteString(infl:GetClass())
				else
					net.WriteString(wep.Primary and wep.Primary.Ammo or "gren")
				end


				net.Send({ply, atk})
			end
			local pl = ply
			if(IsValid(atk)) then
				local logAtkMsg = (atk:Name().." ("..atk:steamName()..") attacked "..pl:Name().." ("..pl:steamName()..") with "..((wep and (wep.ClassName or wep:GetClass())) or "a mine or something probably").." ["..hitStrings[hg].."/"..((pl:getNetVar("typing") and "void") or tostring(dmgmulti)).."]")
				nut.log.addRaw(logAtkMsg)
				hook.Run("OnPlyAttack", atk, pl, wep, (hitStrings[hg].."/"..((pl:getNetVar("typing") and "void") or tostring(dmgmulti))), logAtkMsg)
			end
			--smh
			if(!on) then 
				dmginfo:ScaleDamage(0) 
				return true 
			end

			if(wep.PrimaryBash) then
				atk:getChar():updateAttrib("str", dmginfo:GetDamage()*0.0001)
			end

			local negx, negy = math.random(-1, 0), math.random(-1, 0)
			local ranx, rany = math.Rand(0.5, 1)*negx*(dmginfo:GetDamage()/5), math.Rand(0.5, 1)*negy*(dmginfo:GetDamage()/3)
			local viewpunchmult = 1
			if(wep.GetStat and wep:GetStat("ViewPunchMulti")) then
				viewpunchmult = wep:GetStat("ViewPunchMulti")
			end

			local ang = Angle(ranx, rany, 0.2)
			ang:Mul(viewpunchmult)

			ply:ViewPunch(ang) --idk

			--if theyre immune just dont do anything else
			if(ply:getNetVar("typing") and !ply:getNutData("typeImm")) then
				return true
			end
			
			--undamageable in safezone
			if(ply.getArea and atk.getArea) then
				local plyarea = nut.area.getArea(ply:getArea())
				local atkarea = nut.area.getArea(atk:getArea())
				if(plyarea and string.find(plyarea.name, "safezone")) then
					return true
				end
				--stop other players from attacking in safezone too
				if(atkarea and string.find(atkarea.name, "safezone")) then
					return true
				end
			end

			if(wep.Primary) then
				if(wep.Primary.Ammo == "none" or wep.Primary.Ammo == "") then
					dmginfo:ScaleDamage(0.85) --should decrease melee dmg
				else
					if(hg == HITGROUP_HEAD) then
						dmginfo:ScaleDamage(7)
					elseif(hg == HITGROUP_GENERIC) then
						dmginfo:ScaleDamage(0.5)
					elseif(LIMB_GROUPS[hg]) then --using limb_groups from nutscript sv_hooks
						dmginfo:ScaleDamage(0.8)
					else
						dmginfo:ScaleDamage(1)
					end
						
					local hit = hitToLevel[hg]
					
					local protscl = dmgmulti --* (1-(levels.durability)) 0.1+(((1-(levels.durability or 1))*10)/20)
					dmginfo:ScaleDamage(protscl)
					--durability never really worked lol, not entirely sure why but watever
					--base 0.1+((1-durability)*10)/20 maybe have 20 be changed so some shit can be more
					if(dmgmulti < 1) then
						
						if(wep.GetStat and wep:GetStat("ProcScale")) then
							dmginfo:ScaleDamage(wep:GetStat("ProcScale"))
						end
						
						--for changing durability
						--base 0.001 + (0.1*((1-durability)*(dmg/2))/100)
						local duraToRem = math.max(0.0001, 0.001+(0.1*((1-(levels.durability or 1)*(dmginfo:GetDamage()/8)))/100)*1.2)
						if(hg == HITGROUP_HEAD) then
							duraToRem = duraToRem*100
						end
						
						if(wep.Primary.Ammo == "buckshot") then
							duraToRem = duraToRem*2
						end
						if(duraToRem < 0) then 
							ply:SetArmorDurability(hitToLevel[hg], 0)
						else
						--print("attacking: durabilty to remove "..duraToRem)
						ply:SetArmorDurability(hitToLevel[hg], math.Clamp((levels.durability or 1)-duraToRem, 0, 1))
						end
					else
						if(wep.GetStat and wep:GetStat("UnprocScale")) then
							dmginfo:ScaleDamage(wep:GetStat("UnprocScale"))
						end

						if(levels[hit] and levels[hit] != ARMOR_NONE) then
						local duraToRem = math.max(0.0001, (0.001+(0.1*((1-(levels.durability or 0.9999)*(dmginfo:GetDamage()/6)))/100))*2.5)
						if(hg == HITGROUP_HEAD) then
							duraToRem = duraToRem*100
						end
						if(wep:GetClass() == "sky_helsing") then
							duraToRem = duraToRem*100
						end
						if(wep.Primary.Ammo == "buckshot") then
							duraToRem = duraToRem*2
						end
						if(duraToRem < 0) then 
							ply:SetArmorDurability(hitToLevel[hg], 0)
						end
						--print("attacking: durabilty to remove "..duraToRem)
						ply:SetArmorDurability(hitToLevel[hg], math.Clamp((levels.durability or 1)-duraToRem, 0, 1))
						end
					end
				end
			end
			
			if(wep.GetStat and wep:GetStat("StaminaDamage")) then
				local dmg = wep:GetStat("StaminaDamage")
				local scale = 1
				if(hg == HITGROUP_HEAD) then
					scale = 5
				elseif(LIMB_GROUPS[hg]) then --using limb_groups from nutscript sv_hooks
					scale = 0.8
				end

				nut.traits.getMod(ply, "stamcc", dmg) --seperate scale

				ply:restoreStamina(-(dmg * scale))
				
				local var = ply:getLocalVar("stm", 0)
				if(var <= 0) then
					ply:setNetVar("brth", true)
					ply:ConCommand("-speed")
					ply:setRagdolled(true, 60)--changed it to 60 like stunstick ig, old 120)
					ply:notify("Excessive non-lethal damage has knocked you unconcious.", 2)
					return
				end
			end


			--downing!
			local dw = nut.config.get("downing", false)
			if(dw) then
				local ed = ply:getChar():getAttrib("end", 0)
				if(wep.Primary and wep.Primary.Ammo != "none" and wep.Primary.Ammo == "") then
					dmginfo:ScaleDamage(1-(ed/30)*0.01)
				else
					dmginfo:ScaleDamage(1-(ed/6)*0.01)
				end
				ply:getChar():updateAttrib("end", dmginfo:GetDamage()*0.00005)

				if((hg == HITGROUP_LEFTLEG or hg == HITGROUP_RIGHTLEG) and !protected and ply:Health()-dmginfo:GetDamage() < 60) then
					ply:getChar():setData("leghit", true, nil, player.GetAll())
				end
				
				return PLUGIN:DownPlayer(ply, dmginfo, hg)
			end 
		else --this is a mine?
			local dw = nut.config.get("downing", false)
			if(dw) then
				return PLUGIN:DownPlayer(ply, dmginfo, hg)
			end
		end
	end
	
	hook.Add("ScalePlayerDamage", "ShootToRP", function(ply, hg, dmginfo)
		return ScaleDmg(ply, hg, dmginfo)
	end)
	
	hook.Add("EntityTakeDamage", "disablegrendamage", function(target, dmg)
		if(target:GetClass() == "prop_physics" and dmg:IsExplosionDamage() and dmg:GetAttacker():IsPlayer()) then
			return true
		end
		if(IsValid(dmg:GetAttacker()) and dmg:GetAttacker():GetClass() == "nut_item") then
			return true
		end
		if(dmg:GetInflictor():GetCollisionGroup() == COLLISION_GROUP_PROJECTILE) then
			
		end
		
		if((target.NEXTBOT or target:IsNPC()) and dmg:GetAttacker():IsPlayer()) then
			local wep = dmg:GetAttacker():GetActiveWeapon()
			if(wep and wep.GetStat and wep:GetStat("NPCDamageMulti")) then
				dmg:ScaleDamage(wep:GetStat("NPCDamageMulti"))
			end
			if(wep.TFA_NMRIH_MELEE or wep.PrimaryBash) then
				dmg:GetAttacker():getChar():updateAttrib("str", dmg:GetDamage()*0.0001)
			end
		end


		--nut.log.addRaw
		if(target:IsPlayer()) then
			local atk = dmg:GetAttacker()
			if(IsValid(atk) and atk:IsPlayer()) then
				local wep = atk:GetActiveWeapon()
				if(IsValid(wep) and wep.PrimaryBash) then
					local msgs = nut.config.get("shootMessages", true)
					local ply = target
					local on = nut.config.get("damage", true)
					if(msgs) then
						net.Start("PlayerGetDmg")
						net.WriteEntity(ply)
						net.WriteEntity(atk)
						net.WriteEntity(wep)
						net.WriteInt(0, 4)
						net.WriteInt(math.Round(ply:GetPos():Distance(atk:GetPos())/52.49, 2), 32)
					end
					local dmgmulti = 1
					if(msgs) then
						net.WriteFloat(dmgmulti)
						net.WriteString(wep.Primary and wep.Primary.Ammo or "gren")
	
	
						net.Send({ply, atk})
					end
					local pl = ply
					if(IsValid(atk)) then
						nut.log.addRaw(atk:Name().." ("..atk:steamName()..") attacked "..pl:Name().." ("..pl:steamName()..") with "..((wep and (wep.ClassName or wep:GetClass())) or "a mine or something probably").." [melee/"..((pl:getNetVar("typing") and "void") or tostring(dmgmulti)).."]")
					end
				
					if(wep.PrimaryBash) then
						atk:getChar():updateAttrib("str", dmg:GetDamage()*0.0001)
					end

					if(!on) then 
						dmg:ScaleDamage(0) //sadge
						return true 
					end
				end
			end
			--print(dmg:GetAttacker():GetClass().." "..dmg:GetDamageType(), dmg:IsDamageType(2))
			local res = target:GetArmorResists()
			local levels = target:GetArmorLevels()
			if(levels.durability != 0) then
			for k,v in pairs(res) do
				if(type(k) == "number" and dmg:IsDamageType(k)) then
					--print("scaled "..k)
					if(k == DMG_BULLET) then
						if(dmg:GetAttacker():IsNPC()) then
							dmg:ScaleDamage((1-(res[k] or 0)) * (levels.durability or 1))
						end
					else
					local scale = 1
						if(dmg:GetAttacker():IsNPC() or dmg:GetAttacker().NEXTBOT) then scale = 0.8 end
						dmg:ScaleDamage((1-(res[k] or 0)) * scale * (levels.durability or 1))
					end
				end
			end
			end

			if(dmg:GetAttacker():IsNPC() or dmg:GetAttacker().NEXTBOT) then
				local negx, negy = math.random(-1, 0), math.random(-1, 0)
				local ranx, rany = math.Rand(0.3, 0.6)*negx*(dmg:GetDamage()/5), math.Rand(0.3, 0.6)*negy*(dmg:GetDamage()/3)
	
				local ang = Angle(ranx, rany, 0.1)
	
				target:ViewPunch(ang) 
				
				if(math.random(1,6) == 1) then
				if(target:GetArmorItems() != nil) then
				local duraToRem = math.max(0.0001, 0.001+(0.1*((1-(levels.durability or 1)*(dmg:GetDamage()/8)))/100))
				if(duraToRem < 0) then 
					target:SetArmorDurability(nil, 0)
				end
				--print("attacking: durabilty to remove "..duraToRem)
				target:SetArmorDurability(nil, math.Clamp((levels.durability or 1)-duraToRem, 0, 1))
				end
				end
			end
			if(dmg:IsFallDamage()) then
				dmg:ScaleDamage(2)
			end
			if(dmg:GetAttacker():IsPlayer() and target:getNetVar("typing") and !target:getNutData("typeImm")) then
				dmg:ScaleDamage(0)
				return true
			end
		end
		
		local dw = nut.config.get("downing", false)
		if (dw) then
			if(target:getNetVar("player") and target:GetClass() == "prop_ragdoll") then
				local ply = target:getNetVar("player")
				if(ply:getNetVar("startdown")) then
					ply:setNetVar("startdown", nil)
					return true
				end

				if(ply:getNetVar("neardeath")) then
					--ply:setNetVar("canrevive", nil)
					return true
				end
			end
			if(target:getNetVar("player") and target:GetClass() == "prop_ragdoll") then
				return 
			end
			if(target:getNetVar("neardeath") or target:getNetVar("startdown")) then return true end
			if(target:IsPlayer() and ((!IsValid(dmg:GetInflictor()) and dmg:GetDamage() != 1) or (dmg:GetAttacker():IsNPC() or dmg:GetAttacker().NEXTBOT))) then
				local ed = target:getChar():getAttrib("end", 0)
				dmg:ScaleDamage(1-(ed/30)*0.01)
				target:getChar():updateAttrib("end", dmg:GetDamage()*0.00005)

				return PLUGIN:DownPlayer(target, dmg)
			end
			if(target:IsPlayer() and (!dmg:GetAttacker() or !dmg:GetAttacker():IsNPC()) and !IsValid(dmg:GetInflictor().Owner)) then--(string.find(class, "gas_zone"))) then
				
				return PLUGIN:DownPlayer(target, dmg)
			end
		else
			return false
		end
	end)

	--apparently setting notarget in post player death npcs can shoot and it breaks everything cool
	hook.Add("PlayerSpawn", "resetdown", function(ply)
		ply:SetNoTarget(false)
	end)

	hook.Add("PostPlayerDeath", "downedreset", function(ply)
		local dw = nut.config.get("downing", false)
		if(!IsValid(ply)) then return end

		

		if(ply:getChar()) then
			local durOn = nut.config.get("durabilityPenalty", false)
			local durAmt = nut.config.get("durabilityPenaltyAmt", 5)
			if(durOn) then
				for k,v in pairs(ply:getChar():getInv():getItems()) do
					local dur = v:getData("durability")
					if(dur) then
						if(dur <= 1) then
							--this is armor
							durAmt = durAmt / 100
							local amt = dur*durAmt
							dur = dur - amt
						else
							--this is weps
							if(!nut.config.get("weaponDurability", true)) then continue end
							local rat = dur / 100
							local amt = durAmt*rat
							dur = dur - amt
						end
						v:setData("durability", dur)
					end
				end
			end

			--if they somehow die some other way reset their hp
			ply:getChar():setData("health", nil)

			if (dw) then
			ply:setNetVar("neardeath", nil)
			ply:setNetVar("startdown", nil)
			ply:setNetVar("canrevive", nil)
			ply:setNetVar("canresp", nil)
			ply:setNetVar("canscirevive", nil) 
			ply:setNetVar("canplatrevive", nil) 
			end
			--ply:SetNoTarget(false) --so npcs stop attacking
			if(nut.config.get("movementEffects", false)) then
			ply:getChar():setData("leghit", nil, nil, player.GetAll())
			end
		end
	end)

	hook.Add("PlayerLoadedChar", "downedswitch", function(ply, char, lastChar)
		local dw = nut.config.get("downing", false)
		if(lastChar) then
		net.Start("PlayerOffNV")
		net.Send(ply)
		net.Start("toggleHeartbeat")
		net.WriteBool(false)
		net.Send(ply)
		end

		local res = ply:GetArmorResists()

		if (!dw) then return end
	
		if(lastChar) then
			ply:setNetVar("neardeath", nil)
			ply:setNetVar("startdown", nil)
			ply:setNetVar("canrevive", nil)
			ply:setNetVar("canresp", nil)
			ply:setNetVar("canscirevive", nil)
			ply:setNetVar("canplatrevive", nil) 
			ply:SetNoTarget(false) --so npcs stop attacking
		end
	end)

	hook.Add("PrePlayerLoadedChar", "setHealthSwitch", function(ply, char, curChar)
		if(curChar) then

		--	print(char:getName().." "..curChar and curChar:getName() or "none".." "..ply:Health())
			curChar:setData("health", ply:Health())
		end
	end)
	
	hook.Add("PostPlayerLoadout", "getHealth", function(ply)
		if(ply:getChar():getData("health")) then
			ply:SetHealth(ply:getChar():getData("health"))

			if(ply:Health() <= 30) then
				net.Start("toggleHeartbeat")
				net.WriteBool(true)
				net.Send(ply)
			end
		end
	end)

else --client
	local ammoStrings = {
		["sky545"] = "a 5.45x39mm round",
		["sky556"] = "a 5.56x45mm round",
		["sky762x25"] = "a 7.62x25mm round",
		["sky762x38"] = "a 7.62x38mm round",
		["sky762x39"] = "a 7.62x39mm round",
		["sky762x51"] = "a 7.62x51mm NATO round",
		["sky762x54"] = "a 7.62x54mmR round",
		["sky338"] = "a .338 Magnum round",
		["sky9x18"] = "a 9x18mm round",
		["sky9x19"] = "a 9x19mm round",
		["sky9x39"] = "a 9x39mm round",
		["sky45acp"] = "a .45 ACP round",
		["sky22lr"] = "a .22 LR round",
		["sky50ae"] = "a .50 AE round",
		["sky57"] = "a 5.7x28mm round",
		["sky46"] = "a 4.6x30mm round",
		["sky44"] = "a .44 Magnum round",
		["sky23mm"] = "a 23mm Barricade round",
		["buckshot"] = "a 12 Gauge buckshot pellet",
		["357"] = "a .357 Magnum round",
		["skygp25"] = "a GP-25 grenade explosion",
		["skym203"] = "a M-203 grenade explosion",
		["grenade"] = "a grenade explosion",
		["gren"] = "something with no Primary??? (grenade more than likely)",
		["ar2"] = "a 6mm pulse round",
		["skyar3"] = "a 6mm pulse round",
	}
	local hitStrings = {
		[HITGROUP_GENERIC] = "an unknown place",
		[HITGROUP_HEAD] = "the head",
		[HITGROUP_CHEST] = "the chest",
		[HITGROUP_STOMACH] = "the abdomen",
		[HITGROUP_LEFTARM] = "the left arm",
		[HITGROUP_RIGHTARM] = "the right arm",
		[HITGROUP_LEFTLEG] = "the left leg",
		[HITGROUP_RIGHTLEG] = "the right leg"
	}

	local rad2deg = (180/math.pi)
	net.Receive("PlayerGetDmg", function()
		local target = net.ReadEntity()
		local attacker = net.ReadEntity()
		local wep = net.ReadEntity()
		local hitgroup = net.ReadInt(4)
		local dist = net.ReadInt(32)
		local prot = net.ReadFloat()
		local protection = ""
		
		local ammo = net.ReadString()--[[""
		if(wep.Secondary and wep.Secondary.Ammo != "") then
			ammo = wep.Secondary.Ammo
		elseif(wep.Primary) then
			ammo = wep.Primary.Ammo
		else
			ammo = "gren"
		end]]

		--typing immunity
		if(target:getNetVar("typing") and !target:getNutData("typeImm")) then
			if(target == LocalPlayer()) then
				
				chat.AddText("You were hit, but you were typing. Hit by "..(ammoStrings[ammo] or ammo).." in "..(hitStrings[hitgroup] or "an unknown place")..".")
			else
				chat.AddText("You hit someone, but they are typing. Hit them with "..(ammoStrings[ammo] or ammo).." in "..(hitStrings[hitgroup] or "an unknown place")..".")
			end
			
			return
		end
		
		local pos = target:WorldToLocal(attacker:GetPos())
		local bear = rad2deg*-math.atan2(pos.y, pos.x)
		
		if(wep.ClassName == "weapon_frag" or wep.ClassName == ammo or ammo:find("_thr_") or ammo:find("_eft_")) then
			if(target == LocalPlayer()) then
				chat.AddText("You were hit by the blast of a grenade!")
			else
				chat.AddText("You hit someone with the blast of a grenade!")
			end
	
			return
		end

		if(attacker:InVehicle()) then
			if(target == LocalPlayer()) then
				chat.AddText("You were hit with a vehicle weapon or something else weird. In "..hitStrings[hitgroup]..".")
			else
				chat.AddText("You hit someone with a vehicle weapon or something else weird. In "..hitStrings[hitgroup]..".")
			end
	
			return
		end
		
		if(wep.ClassName == "nut_hands") then
			if(ammo != "") then
				if(target == LocalPlayer()) then
					chat.AddText("You were hit by the blast of a grenade!")
				else
					chat.AddText("You hit someone with the blast of a grenade!")
				end
			else
				if(target == LocalPlayer()) then
					chat.AddText("You were punched in "..(hitStrings[hitgroup] or "an unknown place").."!")
				else
					chat.AddText("You punched someone in "..(hitStrings[hitgroup] or "an unknown place").."!")
				end
			end
		
			return --no need for the rest
		end
		
		if(ammo and (ammo == "none" or ammo == "")) then
			if(target == LocalPlayer()) then
				chat.AddText("You were hit with a(n) "..wep.PrintName.." in "..(hitStrings[hitgroup] or "an unknown place").."!")
			else
				chat.AddText("You someone with a(n) "..wep.PrintName.." in "..(hitStrings[hitgroup] or "an unknown place").."!")
			end

			return
		end
		
		if(target == LocalPlayer()) then --incoming damage
			if(prot >= 1) then --this can be above 1 now lol
				protection = "You are not protected from the bullet."
			else
				protection = "Your armor protects you from the bullet."
			end

			chat.AddText("You were hit by "..(ammoStrings[ammo] or ammo).." in "..(hitStrings[hitgroup] or "an unknown place").." from "..dist.." meters away! "..protection.." Bearing: "..math.Round(bear, 0))
		else --confirmation
			if(prot >= 1) then
				protection = "They do not appear to be protected from the bullet."
			else
				protection = "They appear to be protected from the bullet."
			end

			chat.AddText("You hit someone with "..(ammoStrings[ammo] or ammo).." in "..(hitStrings[hitgroup] or "an unknown place").." from "..dist.." meters away! "..protection)
		end
	end)
end