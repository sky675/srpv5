AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/tnb/stalker/chimera2.mdl" 
ENT.StartHealth = 400
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_LARGE
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MUTANT"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle and etc.)
ENT.BloodParticle = "blood_impact_red_01" -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = "Blood" -- (Red = Blood) (Yellow Blood = YellowBlood) | Leave blank for none
ENT.BloodDecalRate = 1000 -- The more the number is the more chance is has to spawn | 1000 is a good number for yellow blood, for red blood 500 is good | Make the number smaller if you are using big decal like Antlion Splat, Which 5 or 10 is a really good number for this stuff

ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.MeleeAttackDistance = 50 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 95 -- How far the damage goes
ENT.MeleeDistanceB = 55 -- Sometimes 45 is a good number but Sometimes needs a change
ENT.MeleeAttackHitTime = 1 -- This counted in seconds | This calculates the time until it hits something
ENT.UntilNextAttack_Melee = 0.8 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = 55
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.HasLeapAttack = true
ENT.Immune_CombineBall = true
ENT.AnimTbl_LeapAttack = {ACT_RANGE_ATTACK1} -- Melee Attack Animations
ENT.LeapDistance = 500 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 140 
ENT.NextAnyAttackTime_Leap = 0.3 
ENT.TimeUntilLeapAttackDamage = 0.8
ENT.NextLeapAttackTime = 15
ENT.AfterLeap = 0.6 -- How much time until it runs the leap damage code?
ENT.UntilNextAttack_Leap = 0.3 -- How much time until it can use a attack again? | Counted in Seconds
ENT.LeapAttackDamage = 85

ENT.LeapAttackVelocityForward = 5000
ENT.LeapAttackDamageDistance = 140 
ENT.LeapDamageType = DMG_SLASH -- Type of Damage
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking

	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {""}
ENT.SoundTbl_Idle = {"npcs/stalker/chimera/chimera_idle_1.ogg","npcs/stalker/chimera/chimera_idle_2.ogg",}
ENT.SoundTbl_Alert = {}
ENT.SoundTbl_LeapAttack = {"npcs/stalker/chimera/chimera_attack_1.ogg","npcs/stalker/chimera/chimera_attack_2.ogg",}
ENT.SoundTbl_MeleeAttack = {"npcs/stalker/chimera/chimera_attack_hit_1.ogg","npcs/stalker/chimera/chimera_attack_hit_2.ogg","npcs/stalker/chimera/chimera_attack_hit_3.ogg","npcs/stalker/chimera/chimera_attack_hit_4.ogg",}
ENT.SoundTbl_MeleeAttackMiss = {"misses/miss1.wav","misses/miss2.wav","misses/miss3.wav","misses/miss4.wav"}
ENT.SoundTbl_Pain = {"npcs/stalker/chimera/chimera_pain_1.ogg","npcs/stalker/chimera/chimera_pain_2.ogg","npcs/stalker/chimera/chimera_pain_3.ogg","npcs/stalker/chimera/chimera_pain_4.ogg"}
ENT.SoundTbl_Death = {"npcs/stalker/chimera/chimera_die_1.ogg","npcs/stalker/chimera/chimera_die_2.ogg"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:LeapForceCode()
	local jumpyaw
	local jumpcode = (self:GetEnemy():GetPos() -self:GetPos()):GetNormal() *1000 +self:GetUp() *180 +self:GetForward() *2000
	jumpyaw = jumpcode:Angle().y
	self:SetLocalVelocity(jumpcode)
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/