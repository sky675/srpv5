AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {
	"models/wick/dog/wick_blind_dog.mdl"
} 
ENT.StartHealth = 80
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
--ENT.HullSizeNormal = false 
ENT.SightDistance = 1900
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MUTANT"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle and etc.)
ENT.BloodParticle = "blood_impact_red_01" -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = "Blood" -- (Red = Blood) (Yellow Blood = YellowBlood) | Leave blank for none
ENT.BloodDecalRate = 1000 -- The more the number is the more chance is has to spawn | 1000 is a good number for yellow blood, for red blood 500 is good | Make the number smaller if you are using big decal like Antlion Splat, Which 5 or 10 is a really good number for this stuff
ENT.ZombieFriendly = true -- Makes the SNPC friendly to the HL2 Zombies
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.8 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.5 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random( 13, 16 )
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.HasItemDropsOnDeath = false
ENT.CanOpenDoors = false
ENT.SlowPlyOnMelee = false -- If true, then the player will slow down
ENT.SlowPlyWalkS = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlyRunS = 100 -- Running Speed when Slow Player is on
ENT.SlowPlyTime = 5 -- How much time until player's Speed resets
ENT.BleedEnemyOnMelee = false -- Should the player bleed when attacked by melee
ENT.BleedEnemyChance = 3 -- How chance there is that the play will bleed? | 1 = always
ENT.BleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.BleedEnemyTime = 1 -- How much time until the next rep?
ENT.BleedEnemyReps = 4 -- How many reps?
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {""}
ENT.SoundTbl_Idle = {"wick/dog/bdog_idle_0.ogg","hgn/stalker/creature/dog/bdog_idle_2.wav","hgn/stalker/creature/dog/bdog_idle_3.wav","hgn/stalker/creature/dog/bdog_idle_4.wav"}
ENT.SoundTbl_Alert = {"wick/dog/bdog_groan_0.ogg","wick/dog/bdog_groan_1.ogg","wick/dog/bdog_groan_2.ogg","wick/dog/bdog_groan_1.ogg"}
ENT.SoundTbl_MeleeAttack = {"wick/dog/attack_hit_0.ogg","wick/dog/attack_hit_1.ogg","wick/dog/attack_hit_2.ogg","wick/dog/attack_hit_3.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"wick/dog/attack_hit_0.ogg","wick/dog/attack_hit_1.ogg","wick/dog/attack_hit_2.ogg","wick/dog/attack_hit_3.ogg"}
ENT.SoundTbl_Pain = {"wick/dog/bdog_hurt_0.ogg","wick/dog/bdog_hurt_1.ogg","wick/dog/bdog_hurt_2.ogg", "wick/dog/bdog_hurt_3.ogg"}
ENT.SoundTbl_Death = {"wick/dog/bdog_die_0.ogg","wick/dog/bdog_die_1.ogg", "wick/dog/bdog_die_2.ogg"}
ENT.SoundTbl_CallForHelp = {"wick/dog/builds/bdog_groan_0.ogg", "wick/dog/builds/bdog_groan_1.ogg", "wick/dog/builds/bdog_groan_2.ogg", "wick/dog/builds/bdog_groan_3.ogg"}
ENT.SoundTbl_CombatIdle = {"wick/dog/bdog_attack_0.ogg", "wick/dog/bdog_attack_1.ogg", "wick/dog/bdog_attack_2.ogg", "wick/dog/bdog_attack_3.ogg"}
ENT.SoundTbl_OnKilledEnemy = {"wick/dog/bdog_panic_0.ogg", "wick/dog/bdog_panic_1.ogg", "wick/dog/bdog_panic_2.ogg", "wick/dog/bdog_panic_3.ogg", "wick/dog/bdog_panic_4.ogg"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomInitialize()
	--actual max is 4 tho
	self:SetSkin(math.random(0,6)) --if it goes over itll be 0 anyway
	
end

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,ply) 
	ply.npcClass = self:GetClass()
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/