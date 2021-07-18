AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/monsters/plot.mdl" 
ENT.StartHealth = 230
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MUTANT"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle and etc.)
ENT.BloodParticle = "blood_impact_red_01" -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = "Blood" -- (Red = Blood) (Yellow Blood = YellowBlood) | Leave blank for none
ENT.BloodDecalRate = 1000 -- The more the number is the more chance is has to spawn | 1000 is a good number for yellow blood, for red blood 500 is good | Make the number smaller if you are using big decal like Antlion Splat, Which 5 or 10 is a really good number for this stuff
ENT.ZombieFriendly = false -- Makes the SNPC friendly to the HL2 Zombies
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 1 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.8 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random( 17, 21 )
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.Immune_Physics = true
ENT.HasItemDropsOnDeath = false
ENT.CanOpenDoors = false
ENT.HasDeathRagdoll = true
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
ENT.FootStepSoundLevel = 60
	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {"npc/flesh/flesh_eat_0.ogg","npc/flesh/flesh_eat_1.ogg","npc/flesh/flesh_eat_2.ogg","npc/flesh/flesh_eat_3.ogg","npc/flesh/flesh_eat_4.ogg","npc/flesh/flesh_eat_5.ogg","npc/flesh/flesh_eat_6.ogg","npc/flesh/flesh_idle_0.ogg","npc/flesh/flesh_idle_1.ogg","npc/flesh/flesh_idle_2.ogg","npc/flesh/flesh_idle_3.ogg","npc/flesh/flesh_idle_4.ogg"}
ENT.SoundTbl_Alert = {"npc/flesh/flesh_aggressive_0.ogg","npc/flesh/flesh_aggressive_1.ogg","npc/flesh/flesh_aggressive_2.ogg"}
ENT.SoundTbl_MeleeAttack = {"npc/flesh/flesh_attack_0.ogg","npc/flesh/flesh_attack_1.ogg","npc/flesh/flesh_attack_2.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/flesh/flesh_attack_0.ogg","npc/flesh/flesh_attack_1.ogg","npc/flesh/flesh_attack_2.ogg"}
ENT.SoundTbl_MeleeAttackExtra = {"npc/pseudoplot/flesh_attack_hit_0.ogg","npc/pseudoplot/flesh_attack_hit_1.ogg"}
ENT.SoundTbl_Pain = {"npc/flesh/flesh_pain_0.ogg","npc/flesh/flesh_pain_1.ogg","npc/flesh/flesh_pain_2.ogg","npc/flesh/flesh_pain_3.ogg"}
ENT.SoundTbl_Death = {"npc/flesh/flesh_death_0.ogg","npc/flesh/flesh_death_1.ogg","npc/flesh/flesh_death_2.ogg","npc/flesh/flesh_death_3.ogg"}
ENT.SoundTbl_CombatIdle = {"npc/flesh/flesh_aggressive_0.ogg","npc/flesh/flesh_aggressive_1.ogg","npc/flesh/flesh_aggressive_2.ogg","npc/flesh/flesh_panic_0.ogg","npc/flesh/flesh_panic_1.ogg","npc/flesh/flesh_panic_2.ogg"}

ENT.SoundTbl_LeapAttackJump = {"npc/flesh/attack_hit_5.ogg"}

function ENT:CustomInitialize()
	local randomstartbg_body = math.random(0,4)
	self:SetSkin(randomstartbg_body) --why does nobody just do this?
end

--this was a fucking nightmare to unfuck

ENT.AllowPrintingInChat = false
ENT.HasEntitiesToNoCollide = false
ENT.CanOpenDoors = false
ENT.CallForHelp = false
ENT.FollowPlayer = false
ENT.HasPoseParameterLooking = false
ENT.PushProps = false
ENT.AttackProps = false
ENT.HasDamageByPlayer = false
ENT.AllowedToGib = false -- Is it allowed to gib in general? This can be on death or when shot in a certain place
ENT.HasGibOnDeath = false -- Is it allowed to gib on death?  
ENT.HasItemDropsOnDeath = false
ENT.BringFriendsOnDeath = false
ENT.HasIdleDialogueSounds = false
ENT.OnlyDoKillEnemyWhenClear = false
ENT.DisableInitializeCapabilities = true
ENT.AnimTbl_IdleStand = {"stand_idle_0","stand_idle_1","stand_idle_2","stand_check_corpse_0","stand_eat_0","stand_eat_1","stand_eat_2","stand_eat_3","stand_attack_rat_0","stand_crawl_0","stand_look_around_0","stand_scared_0","stand_to_eat_0"}

function ENT:CustomOnAlert(argent)
	--self.AnimTbl_IdleStand = {"stand_idle_0","stand_idle_1","stand_idle_2","stand_check_corpse_0","stand_eat_0","stand_eat_1","stand_eat_2","stand_eat_3","stand_attack_rat_0","stand_crawl_0","stand_look_around_0","stand_scared_0","stand_to_eat_0"}
	local dm = math.random(1,2)
	if ( dm == 1 ) then
		if self.VJ_IsBeingControlled == true then return end
		self:VJ_ACT_PLAYACTIVITY({"stand_threaten_0"},true,false,true)
	end
end
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
	if not self:IsOnFire() then
		local Rand = math.random(1,20)
		if Rand == 1 then 
			self:VJ_ACT_PLAYACTIVITY({"stand_jump_left_0"},true,false,true)
			self:SetLocalVelocity(self:GetForward()*350 + self:GetUp()*150 + self:GetRight()*-450)	
		elseif Rand == 2 then 	
			self:VJ_ACT_PLAYACTIVITY({"stand_jump_right_0"},true,false,true)
			self:SetLocalVelocity(self:GetForward()*350 + self:GetUp()*150+ self:GetRight()*450)			
		end
	end
end
function ENT:CustomOnThink()
	if self:IsOnFire() then
		self.Behavior = VJ_BEHAVIOR_PASSIVE
		self.SoundTbl_Pain = {"npc/flesh/flesh_anomaly_death_0.ogg","npc/flesh/flesh_panic_0.ogg","npc/flesh/flesh_panic_1.ogg","npc/flesh/flesh_panic_2.ogg"}

		self.NextSoundTime_Pain1 = 2
		self.NextSoundTime_Pain2 = 3
	else
		self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
		self.SoundTbl_Pain = {"npc/flesh/flesh_pain_0.ogg","npc/flesh/flesh_pain_1.ogg","npc/flesh/flesh_pain_2.ogg","npc/flesh/flesh_pain_3.ogg"}
		self.NextSoundTime_Pain1 = 2
		self.NextSoundTime_Pain2 = 2
	end
	
	--this is unreachable code it wont be 1 before this..
	--if self.damage_showsmoke == 1 then
		if (self:Health() <= 45) then 
			--self.damage_showsmoke = 1

			self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("stand_walk_fwd_dmg_0"))}
			self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("stand_run_dmg_0"))}
		end
		if self:Health() <= 25 then 
			local dm = math.random(1,100)
			if ( dm == 1 ) then
				self.Behavior = VJ_BEHAVIOR_PASSIVE
			elseif ( dm == 25 ) then	
				self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
			end
		end
	--end	
end

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,ply) 
	ply.npcClass = self:GetClass()
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/