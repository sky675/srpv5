AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/monsters/boar.mdl" 
ENT.StartHealth = 120
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_MEDIUM
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MUTANT"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION

ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle and etc.)
ENT.BloodParticle = "blood_impact_red_01" -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = "Blood" -- (Red = Blood) (Yellow Blood = YellowBlood) | Leave blank for none
ENT.BloodDecalRate = 1000 -- The more the number is the more chance is has to spawn | 1000 is a good number for yellow blood, for red blood 500 is good | Make the number smaller if you are using big decal like Antlion Splat, Which 5 or 10 is a really good number for this stuff
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.8 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.5 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random( 20, 23 )
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage

ENT.HasItemDropsOnDeath = false
ENT.CanOpenDoors = false

--have my own bleeding system thanks
ENT.MeleeAttackBleedEnemy = false  -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 2 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 2 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.AnimTbl_IdleStand = {"stand_idle_0","stand_idle_1","stand_idle_2","stand_check_corpse_0","stand_eat_0"} -- The idle animation when AI is enabled

ENT.SoundTbl_FootStep = {"npc/boar/landing_0.ogg"}
ENT.SoundTbl_Idle = {"npc/boar/boar_idle_0.ogg","npc/boar/boar_idle_1.ogg","npc/boar/boar_idle_2.ogg","npc/boar/boar_idle_3.ogg","npc/boar/boar_idle_4.ogg","npc/boar/boar_idle_5.ogg","npc/boar/boar_idle_6.ogg","npc/boar/boar_threaten_0.ogg","npc/boar/boar_threaten_1.ogg","npc/boar/boar_eat_0.ogg","npc/boar/boar_eat_1.ogg","npc/boar/boar_eat_2.ogg","npc/boar/boar_eat_3.ogg"}
ENT.SoundTbl_Alert = {"npc/boar/boar_aggressive_0.ogg","npc/boar/boar_aggressive_1.ogg","npc/boar/boar_aggressive_2.ogg","npc/boar/boar_aggressive_3.ogg","npc/boar/boar_aggressive_4.ogg","npc/boar/boar_aggressive_5.ogg","npc/boar/boar_aggressive_6.ogg","npc/boar/boar_aggressive_7.ogg"}
ENT.SoundTbl_MeleeAttack = {"npc/boar/boar_attack_0.ogg","npc/boar/boar_attack_1.ogg","npc/boar/boar_attack_2.ogg","npc/boar/boar_attack_3.ogg","npc/boar/boar_attack_4.ogg","npc/boar/boar_attack_5.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/boar/boar_attack_0.ogg","npc/boar/boar_attack_1.ogg","npc/boar/boar_attack_2.ogg","npc/boar/boar_attack_3.ogg","npc/boar/boar_attack_4.ogg","npc/boar/boar_attack_5.ogg"}
ENT.SoundTbl_Pain = {"npc/boar/boar_pain_0.ogg","npc/boar/boar_pain_1.ogg","npc/boar/boar_pain_2.ogg","npc/boar/boar_pain_3.ogg","npc/boar/boar_pain_4.ogg","npc/boar/boar_pain_5.ogg","npc/boar/boar_pain_6.ogg"}
ENT.SoundTbl_Death = {"npc/boar/boar_anomaly_death_0.ogg","npc/boar/boar_death_0.ogg","npc/boar/boar_death_1.ogg","npc/boar/boar_death_2.ogg","npc/boar/boar_death_3.ogg","npc/boar/boar_death_4.ogg","npc/boar/boar_death_5.ogg"}
ENT.SoundTbl_CombatIdle = {"npc/boar/boar_aggressive_0.ogg","npc/boar/boar_aggressive_1.ogg","npc/boar/boar_aggressive_2.ogg","npc/boar/boar_aggressive_3.ogg","npc/boar/boar_aggressive_4.ogg","npc/boar/boar_aggressive_5.ogg","npc/boar/boar_aggressive_6.ogg","npc/boar/boar_aggressive_7.ogg"}
ENT.Immune_Physics = true

ENT.SoundTbl_LeapAttackJump = {"npc/boar/attack_hit_5.ogg"}
ENT.SoundTbl_LeapAttackDamage = {"npc/boar/bdog_attack_1.ogg"}
ENT.SoundTbl_LeapAttackDamageMiss = {"npc/boar/bdog_attack_1.ogg","npc/boar/threaten_0.ogg","npc/boar/threaten_1.ogg"}
---------------------------------------------------------------------------------------------------------------------------------------------

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

function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
	if not self:IsOnFire() then
		local Rand = math.random(1,20)
		if Rand == 1 then 
			self:VJ_ACT_PLAYACTIVITY({"stand_attack_run_left_0"},true,false,true)
			self:SetLocalVelocity(self:GetForward()*200 + self:GetUp()*100 + self:GetRight()*-400)
		elseif Rand == 2 then 	
			self:VJ_ACT_PLAYACTIVITY({"stand_attack_run_right_0"},true,false,true)
			self:SetLocalVelocity(self:GetForward()*200 + self:GetUp()*100+ self:GetRight()*400)
		end
	end
end
function ENT:CustomOnThink()
	if self:IsOnFire() then
		self.Behavior = VJ_BEHAVIOR_PASSIVE
		self.SoundTbl_Pain = {"npc/boar/boar_panic_0.ogg","npc/boar/boar_panic_1.ogg","npc/boar/boar_panic_2.ogg","npc/boar/boar_panic_3.ogg"}
   
		self.NextSoundTime_Pain1 = 2
   		self.NextSoundTime_Pain2 = 3
	else
		self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
		self.SoundTbl_Pain = {"npc/boar/boar_pain_0.ogg","npc/boar/boar_pain_1.ogg","npc/boar/boar_pain_2.ogg","npc/boar/boar_pain_3.ogg","npc/boar/boar_pain_4.ogg","npc/boar/boar_pain_5.ogg","npc/boar/boar_pain_6.ogg"}
		self.NextSoundTime_Pain1 = 2
		self.NextSoundTime_Pain2 = 2
	end
	   
	if self:Health() <= 50 then 
	   self.AnimTbl_IdleStand = {self:GetSequenceActivity(self:LookupSequence("agressiv_idle"))}
	   self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("stand_walk_fwd_dmg_0"))}
	   self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("stand_run_dmg_0"))}   
	end      
end
   
function ENT:CustomInitialize()
	self:SetSkin(math.random(0,4))
	self:SetCollisionBounds(Vector(15, 30, 28), Vector(-13, -13, 0))
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