AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/monsters/tushkan.mdl"
ENT.StartHealth = 25
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MUTANT"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION

ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle and etc.)
ENT.BloodParticle = "blood_impact_red_01" -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = "Blood" -- (Red = Blood) (Yellow Blood = YellowBlood) | Leave blank for none
ENT.BloodDecalRate = 1000 -- The more the number is the more chance is has to spawn | 1000 is a good number for yellow blood, for red blood 500 is good | Make the number smaller if you are using big decal like Antlion Splat, Which 5 or 10 is a really good number for this stuff
ENT.ZombieFriendly = true -- Makes the SNPC friendly to the HL2 Zombies
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 15 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.7 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.2 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random( 7, 9 ) --this isnt how that works but ok
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.ShootDistance = 2500
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.SightDistance = 7000 -- How far it can see
ENT.LeapAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.LeapAttackAnimationFaceEnemy = false -- Should it face the enemy while playing the leap attack animation?
ENT.LeapAttackAnimationDecreaseLengthAmount = 0 -- This will decrease the time until starts chasing again. Use it to fix animation pauses until it chases the enemy.
ENT.LeapDistance = 180 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
	-- To use event-based attacks, set this to false:
ENT.TimeUntilLeapAttackDamage = 0.70 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 2.6 -- How much time until it can use a leap attack?
ENT.NextLeapAttackTime_DoRand = false -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.NextAnyAttackTime_Leap = 1 -- How much time until it can use any attack again? | Counted in Seconds
ENT.NextAnyAttackTime_Leap_DoRand = false -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.LeapAttackReps = 1 -- How many times does it run the leap attack code?
ENT.StopLeapAttackAfterFirstHit = true -- Should it stop the leap attack from running rest of timers when it hits an enemy?
ENT.TimeUntilLeapAttackVelocity = 0.1 -- How much time until it runs the velocity code?
ENT.LeapAttackUseCustomVelocity = false -- Should it disable the default velocity system?
ENT.LeapAttackVelocityForward = 70 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 100 -- How much upward force should it apply?
ENT.LeapAttackVelocityRight = 0 -- How much right force should it apply?
ENT.LeapAttackDamage = 15
ENT.LeapAttackDamageDistance = 90 -- How far does the damage go?
ENT.LeapAttackDamageType = DMG_SLASH -- Type of Damage
ENT.DisableLeapAttackAnimation = false -- if true, it will disable the animation code
ENT.AnimTbl_LeapAttack = {ACT_JUMP}
ENT.Immune_Physics = true
ENT.AnimTbl_IdleStand = {"stand_look_around_0","stand_check_corpse_0","stand_eat_0","stand_eat_1","stand_idle_0","stand_idle_1","stand_idle_2","stand_scared_0"} -- The idle animation when AI is enabled

ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/dog/step_paw_earth1.ogg","npc/dog/step_paw_earth3.ogg","npc/dog/step_paw_earth4.ogg","npc/dog/step_paw_earth5.ogg"}
ENT.SoundTbl_Idle = {"npc/tushkan/tushkano_idle_0.ogg","npc/tushkan/tushkano_idle_1.ogg","npc/tushkan/tushkano_idle_2.ogg","npc/tushkan/tushkano_idle_3.ogg","npc/tushkan/tushkano_eat_0.ogg"}
ENT.SoundTbl_Alert = {"npc/tushkan/tushkano_threaten_0.ogg","npc/tushkan/tushkano_threaten_1.ogg","npc/tushkan/tushkano_threaten_2.ogg","npc/tushkan/tushkano_threaten_3.ogg"}
ENT.SoundTbl_MeleeAttack = {"npc/tushkan/tushkano_attack_0.ogg","npc/tushkan/tushkano_attack_1.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/tushkan/tushkano_attack_0.ogg","npc/tushkan/tushkano_attack_1.ogg"}
ENT.SoundTbl_Pain = {"npc/tushkan/tushkano_pain_0.ogg","npc/tushkan/tushkano_pain_1.ogg","npc/tushkan/tushkano_pain_2.ogg","npc/tushkan/tushkano_pain_3.ogg","npc/tushkan/tushkano_pain_4.ogg","npc/tushkan/tushkano_pain_5.ogg"}
ENT.SoundTbl_Death = {"npc/tushkan/tushkano_death_0.ogg","npc/tushkan/tushkano_death_1.ogg","npc/tushkan/tushkano_death_2.ogg"}
ENT.SoundTbl_CombatIdle = {"npc/tushkan/tushkano_aggressive_0.ogg","npc/tushkan/tushkano_aggressive_1.ogg","npc/tushkan/tushkano_aggressive_2.ogg","npc/tushkan/tushkano_aggressive_3.ogg","npc/tushkan/tushkano_attack_0.ogg","npc/tushkan/tushkano_attack_1.ogg"}

ENT.SoundTbl_OnKilledEnemy = {"npc/tushkan/tushkano_threaten_0.ogg","npc/tushkan/tushkano_threaten_1.ogg","npc/tushkan/tushkano_threaten_2.ogg","npc/tushkan/tushkano_threaten_3.ogg"}
ENT.SoundTbl_LostEnemy = {"npc/tushkan/btushkan_die_0.ogg","npc/tushkan/threaten_0.ogg","npc/tushkan/threaten_1.ogg"}
ENT.SoundTbl_LeapAttackJump = {"npc/tushkan/tushkano_attack_0.ogg","npc/tushkan/tushkano_attack_1.ogg"}
ENT.SoundTbl_LeapAttackDamage = {"npc/tushkan/tushkano_attack_0.ogg","npc/tushkan/tushkano_attack_1.ogg"}
ENT.SoundTbl_LeapAttackDamageMiss = {"npc/tushkan/tushkano_threaten_0.ogg","npc/tushkan/tushkano_threaten_1.ogg","npc/tushkan/tushkano_threaten_2.ogg","npc/tushkan/tushkano_threaten_3.ogg"}
		
ENT.AnimTbl_Run = {ACT_RUN, ACT_RUN_PISTOL}		

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
--------------------------------------------------
function ENT:CustomOnThink()
	if self:IsOnFire() then
		self.Behavior = VJ_BEHAVIOR_PASSIVE
		self.NextSoundTime_Pain1 = 14
		self.NextSoundTime_Pain2 = 14
	else
		self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
		self.NextSoundTime_Pain1 = 2
		self.NextSoundTime_Pain2 = 2
	end
	
	--if self.damage_showsmoke == 1 then
		if self:Health() <= 15 then 
			--self.damage_showsmoke = 1

			self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("stand_idle_dmg_0"))}
			self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("stand_walk_fwd_dmg_0"))}
			self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("stand_ran_dmg_0"))}
			self.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
			self.FootStepTimeWalk = 0.9 -- Next foot step sound when it is walking
		end

		if self:Health() <= 5 then 
			local dm = math.random(1,200)
			if ( dm == 1 ) then
				self.Behavior = VJ_BEHAVIOR_PASSIVE
				self.SoundTbl_Idle = {"npc/tushkan/tushkano_panic_0.ogg","npc/tushkan/tushkano_panic_1.ogg"}
				self.SoundTbl_CombatIdle = {"npc/tushkan/tushkano_panic_0.ogg","npc/tushkan/tushkano_panic_1.ogg"}
			elseif ( dm == 25 ) then	
				self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
			end
		end
	--end	
end

function ENT:CustomInitialize()
	self:SetCollisionBounds(Vector(8, 8, 18), Vector(-8, -8, 0))
end

ENT.FootStepSoundLevel = 55



function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,ply) 
	ply.npcClass = self:GetClass()
end



/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/