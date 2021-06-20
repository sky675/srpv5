AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/monsters/zombie.mdl","models/monsters/zombie2.mdl","models/monsters/zombie4.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want

ENT.StartHealth = 200
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MONO"} 
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle and etc.)
ENT.BloodParticle = "blood_impact_red_01" -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = "Blood" -- (Red = Blood) (Yellow Blood = YellowBlood) | Leave blank for none
ENT.BloodDecalRate = 1000 -- The more the number is the more chance is has to spawn | 1000 is a good number for yellow blood, for red blood 500 is good | Make the number smaller if you are using big decal like Antlion Splat, Which 5 or 10 is a really good number for this stuff
ENT.ZombieFriendly = true -- Makes the SNPC friendly to the HL2 Zombies
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.HasRangeAttack = false --i dont know what the fuck was going on with that ranged attack in the original npc, but i dont want anything to do with it
ENT.NextAnyAttackTime_Melee = 1 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random (29, 34)
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.HasItemDropsOnDeath = false
ENT.CanOpenDoors = false

ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.SightDistance = 7500 -- How far it can see
ENT.ShootDistance = 8000
ENT.LeapAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.LeapAttackAnimationFaceEnemy = false -- Should it face the enemy while playing the leap attack animation?
ENT.LeapAttackAnimationDecreaseLengthAmount = 0 -- This will decrease the time until starts chasing again. Use it to fix animation pauses until it chases the enemy.
ENT.LeapDistance = 180 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 0 -- How close does it have to be until it uses melee?
	-- To use event-based attacks, set this to false:
ENT.TimeUntilLeapAttackDamage = 0.5 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 17.6 -- How much time until it can use a leap attack?
ENT.NextLeapAttackTime_DoRand = false -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.NextAnyAttackTime_Leap = 1 -- How much time until it can use any attack again? | Counted in Seconds
ENT.NextAnyAttackTime_Leap_DoRand = false -- False = Don't use random time | Number = Picks a random number between the regular timer and this timer
ENT.LeapAttackReps = 1 -- How many times does it run the leap attack code?
ENT.StopLeapAttackAfterFirstHit = true -- Should it stop the leap attack from running rest of timers when it hits an enemy?
ENT.TimeUntilLeapAttackVelocity = 0.1 -- How much time until it runs the velocity code?
ENT.LeapAttackUseCustomVelocity = false -- Should it disable the default velocity system?
ENT.LeapAttackVelocityForward = 100 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 35 -- How much upward force should it apply?
ENT.LeapAttackVelocityRight = 0 -- How much right force should it apply?
ENT.LeapAttackDamage = 15
ENT.LeapAttackDamageDistance = 120 -- How far does the damage go?
ENT.LeapAttackDamageType = DMG_SLASH -- Type of Damage
ENT.DisableLeapAttackAnimation = false -- if true, it will disable the animation code
ENT.AnimTbl_LeapAttack = {ACT_IDLE_AR2}
ENT.Immune_Physics = true
ENT.AnimTbl_Walk = {ACT_WALK} -- Set the walking animations | Put multiple to let the base pick a random animation when it moves
ENT.AnimTbl_Run = {ACT_WALK}

ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
ENT.AllowPrintingInChat = false
ENT.HasEntitiesToNoCollide = false
ENT.CanOpenDoors = false

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
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Alert = {"npc/zombie/zombie_attack_1.ogg","npc/zombie/zombie_attack_2.ogg","npc/zombie/zombie_attack_3.ogg","npc/zombie/zombie_attack_4.ogg","npc/zombie/zombie_attack_5.ogg","npc/zombie/zombie_attack_6.ogg","npc/zombie/zombie_attack_7.ogg","npc/zombie/zombie_attack_8.ogg","npc/zombie/zombie_attack_9.ogg","npc/zombie/zombie_attack_10.ogg"}
ENT.SoundTbl_Idle = {"npc/zombie/zombie_idle_1.ogg","npc/zombie/zombie_idle_2.ogg","npc/zombie/zombie_idle_3.ogg","npc/zombie/zombie_idle_4.ogg","npc/zombie/zombie_idle_5.ogg","npc/zombie/zombie_idle_6.ogg","npc/zombie/zombie_idle_7.ogg","npc/zombie/zombie_idle_8.ogg","npc/zombie/zombie_idle_9.ogg","npc/zombie/zombie_idle_10.ogg","npc/zombie/zombie_idle_11.ogg","npc/zombie/zombie_idle_12.ogg","npc/zombie/zombie_idle_13.ogg","npc/zombie/zombie_idle_14.ogg","npc/zombie/zombie_idle_15.ogg","npc/zombie/zombie_idle_16.ogg","npc/zombie/zombie_idle_17.ogg"}
ENT.SoundTbl_MeleeAttack = {"npc/zombie/zombie_attack_hit_0.ogg"}
ENT.SoundTbl_Pain = {"npc/zombie/zombie_take_damage_1.ogg","npc/zombie/zombie_take_damage_2.ogg","npc/zombie/zombie_take_damage_3.ogg","npc/zombie/zombie_take_damage_4.ogg","npc/zombie/zombie_take_damage_5.ogg","npc/zombie/zombie_take_damage_6.ogg"}
ENT.SoundTbl_Death = {"npc/zombie/zombie_die_0.ogg","npc/zombie/zombie_die_1.ogg","npc/zombie/zombie_die_2.ogg","npc/zombie/zombie_die_3.ogg","npc/zombie/zombie_die_4.ogg","npc/zombie/zombie_die_5.ogg","npc/zombie/zombie_die_6.ogg","npc/zombie/zombie_die_7.ogg","npc/zombie/zombie_die_8.ogg","npc/zombie/zombie_die_9.ogg"}
ENT.SoundTbl_CombatIdle = {"npc/zombie/zombie_attack_1.ogg","npc/zombie/zombie_attack_2.ogg","npc/zombie/zombie_attack_3.ogg","npc/zombie/zombie_attack_4.ogg","npc/zombie/zombie_attack_5.ogg","npc/zombie/zombie_attack_6.ogg","npc/zombie/zombie_attack_7.ogg","npc/zombie/zombie_attack_8.ogg","npc/zombie/zombie_attack_9.ogg","npc/zombie/zombie_attack_10.ogg"}
ENT.kukla = false	
ENT.sidit = false	
ENT.est = false	
ENT.spit = false	
ENT.AnimTbl_IdleStand = {"check_corpse_on_0","check_corpse_on_1","stand_idle_0","stand_idle_1","stand_idle_2","stand_look_around_0"} -- The idle animation when AI is enabled
function ENT:CustomOnAlert(argent)
	if self.VJ_IsBeingControlled == true then return end
	if self.sidit == false and self.est == false and self.spit == false then
		self:VJ_ACT_PLAYACTIVITY({"stand_idle_attack_0"},true,false,true)
	end
end

function ENT:CustomOnThink_AIEnabled()
	if (self:GetEnemy() and self:GetEnemy() != nil) then
		self.FindEnemy_UseSphere = true
	else
		self.FindEnemy_UseSphere = false
	end
end

function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
	local dms2 = math.random(1,30)
	if ( dms2 == 1 ) then
		self.AnimTbl_Run = {ACT_RUN}
	elseif ( dms2 == 2 ) then
		self.AnimTbl_Run = {ACT_IDLE_ANGRY_SMG1}		
	elseif ( dms2 == 3 ) then
		self.AnimTbl_Run = {ACT_IDLE_AIM_RIFLE_STIMULATED}
	end			
	local dms = math.random(1,30)
	if ( dms == 1 ) then
		--this is fine i guess?
		local Rand = math.random(1,4)
		if Rand == 1 and self.kukla==false then 
			self.kukla = true				
			self:VJ_ACT_PLAYACTIVITY("fake_death_3_0",true,1,false,0,{SequenceDuration=self.DeathFlinchTime})
			self:VJ_ACT_PLAYACTIVITY("fake_death_3_1",true,7,false,1,{SequenceDuration=self.DeathFlinchTime})	
			timer.Create("timer5",7,1,function()
				if(!IsValid(self)) then return end --it erroring here isnt harmful but fuck it
				self.kukla = false	
				self:VJ_ACT_PLAYACTIVITY("fake_death_3_2",true,4,false,0,{SequenceDuration=self.DeathFlinchTime})
			end)
		elseif Rand == 2 and self.kukla==false then 
			self.kukla = true				
			self:VJ_ACT_PLAYACTIVITY("fake_death_1_0",true,0.8,false,0,{SequenceDuration=self.DeathFlinchTime})
			self:VJ_ACT_PLAYACTIVITY("fake_death_1_1",true,7,false,0.8,{SequenceDuration=self.DeathFlinchTime})	
			timer.Create("timer5",7,1,function()
				if(!IsValid(self)) then return end --it erroring here isnt harmful but fuck it
				self.kukla = false	
				self:VJ_ACT_PLAYACTIVITY("fake_death_1_2",true,5,false,0,{SequenceDuration=self.DeathFlinchTime})
			end)
		elseif Rand == 3 and self.kukla==false then
			self.kukla = true				
			self:VJ_ACT_PLAYACTIVITY("fake_death_0_0",true,1.5,false,0,{SequenceDuration=self.DeathFlinchTime})
			self:VJ_ACT_PLAYACTIVITY("fake_death_0_1",true,7,false,1.5,{SequenceDuration=self.DeathFlinchTime})	
			timer.Create("timer5",7,1,function()
				if(!IsValid(self)) then return end --it erroring here isnt harmful but fuck it
				self.kukla = false	
				self:VJ_ACT_PLAYACTIVITY("fake_death_0_2",true,3.5,false,0,{SequenceDuration=self.DeathFlinchTime})
			end)
		elseif Rand == 4 and self.kukla==false then
			self.kukla = true			
			self:VJ_ACT_PLAYACTIVITY("fake_death_2_0",true,1.2,false,0,{SequenceDuration=self.DeathFlinchTime})
			self:VJ_ACT_PLAYACTIVITY("fake_death_2_1",true,7,false,1.2,{SequenceDuration=self.DeathFlinchTime})	
			timer.Create("timer5",7,1,function()
				if(!IsValid(self)) then return end --it erroring here isnt harmful but fuck it
				self.kukla = false	
				self:VJ_ACT_PLAYACTIVITY("fake_death_2_2",true,3,false,0,{SequenceDuration=self.DeathFlinchTime})
			end)	
		end
	end
end
function ENT:CustomOnLeapAttack_BeforeStartTimer() 
	--or does not work for this lmao
	self:VJ_ACT_PLAYACTIVITY({"stand_run_attack_0","stand_run_attack_1"},true,false,true)
	self:SetLocalVelocity(self:GetForward()*1000)
end
function ENT:CustomOnThink()


end
function ENT:CustomInitialize()
	self.kukla = false	
	self.sidit = false	
	self.est = false	
	self.spit = false	
	
	self:SetSkin(math.random(0,18))


end

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,ply) 
	ply.npcClass = self:GetClass()
end

ENT.FootStepSoundLevel = 60

/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/