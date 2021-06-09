AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/monsters/gigant3.mdl"--"models/tnb/stalker/pseudogiant1.mdl" 
ENT.StartHealth = 1600
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_LARGE
ENT.VJ_IsHugeMonster = true

ENT.AnimTbl_Run = {ACT_WALK}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MUTANT"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle and etc.)
ENT.BloodParticle = "blood_impact_red_01" -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = "Blood" -- (Red = Blood) (Yellow Blood = YellowBlood) | Leave blank for none
ENT.BloodDecalRate = 1000 -- The more the number is the more chance is has to spawn | 1000 is a good number for yellow blood, for red blood 500 is good | Make the number smaller if you are using big decal like Antlion Splat, Which 5 or 10 is a really good number for this stuff
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_RANGE_ATTACK_AR2} -- Melee Attack Animations
ENT.MeleeAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.MeleeAttackDistance = 164 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 500 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 1.5 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 9.9 -- Sometimes 45 is a good number but Sometimes needs a change
ENT.MeleeAttackHitTime = 1.6 -- This counted in seconds | This calculates the time until it hits something
ENT.UntilNextAttack_Melee = 9.9 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = 85
ENT.MeleeAttackDamageType = DMG_RADIATION -- Type of Damage
ENT.MeleeAttackReps = 1
ENT.HasDeathRagdoll = true
ENT.Immune_CombineBall = true
ENT.Immune_Physics = true
ENT.MeleeAttackBleedEnemy = false -- Should the enemy bleed when attacked by melee?
ENT.MeleeAttackBleedEnemyChance = 1 -- How much chance there is that the enemy will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 30 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 0.2 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 6 -- How many reps?
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.FootStepTimeRun = 0.5 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.HasWorldShakeOnMove = true -- Should the world shake when it's moving?
ENT.NextWorldShakeOnRun = 0.5 -- How much time until the world shakes while it's running
ENT.NextWorldShakeOnWalk = 0.5 -- How much time until the world shakes while it's walking
ENT.WorldShakeOnMoveRadius = 500 -- How far the screen shake goes, in world units
ENT.WorldShakeOnMoveDuration = 0.4 -- How long the screen shake will last, in seconds
ENT.WorldShakeOnMoveFrequency = 100 -- Just leave it to 100
ENT.HasMeleeAttackDSPSound = false
--ENT.MeleeAttackDSPSoundType = 134 
ENT.BrokenBloodSpawnUp = 20 -- Positive Number = Up | Negative Number = Down
ENT.HasEchoAttack = false -- Makes an echo sound to the player
ENT.KnockBackV = true -- If true, it will cause a knockback to its enemy
ENT.KnockBackVForward = 100 -- Knockback Forward number
ENT.KnockBackVUP = 200 -- Knockback Up Number
	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npcs/stalker/large_step1.ogg","npcs/stalker/large_step2.ogg"}
ENT.SoundTbl_Idle = {"npcs/stalker/giant/giant_idle_0.ogg","npcs/stalker/giant/giant_idle_1.ogg",}
ENT.SoundTbl_Alert = {"npcs/stalker/giant/giant_aggressive_0.ogg","npcs/stalker/giant/giant_aggressive_1.ogg","npcs/stalker/giant/giant_aggressive_2.ogg",}
ENT.SoundTbl_MeleeAttack = {"npcs/stalker/giant/giant_windup_0.ogg",}
ENT.SoundTbl_MeleeAttackMiss = {}
ENT.SoundTbl_Pain = {"npcs/stalker/giant/giant_hurt_0.ogg","npcs/stalker/giant/giant_hurt_1.ogg","npcs/stalker/giant/giant_hurt_2.ogg","npcs/stalker/giant/giant_hurt_3.ogg",}
ENT.SoundTbl_Death = {"npcs/stalker/giant/giant_death_0.ogg","npcs/stalker/giant/giant_death_1.ogg",}

function ENT:CustomOnThink_AIEnabled()
	if(self:Health() < 500) then
		self.AnimTbl_Run = {825} --i dont trust
		self.AnimTbl_Walk = {825}
		self.AnimationPlaybackRate = 0.8 --this might make it slower
		
	end
end

function ENT:CustomOnAlert()
	if self.VJ_IsBeingControlled == true then return end
	self:VJ_ACT_PLAYACTIVITY(ACT_IDLE_ANGRY,true,1,true)
	timer.Simple(1,function()
	if self:IsValid() then
		//self:TaskComplete()
		self.NextChaseTime = CurTime()
		self:DoChaseAnimation()
    
		end
	end)

end
function ENT:CustomInitialize()
	self:SetModelScale(1.35)
	self:Activate()
end
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,ply) 
	if(IsValid(self)) then
		self:SetModelScale(1.35)
	end
	ply:SetModelScale(1.35) --just wanna make sure
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeChecks()
	--need to look at mutants addon and take that ring code
	if(self.attacktype != "slam") then return end
	local blast = ents.Create("prop_combine_ball")
	blast:SetPos(self:GetPos())
	blast:SetParent(self)
	blast:Spawn()
	blast:Fire("explode","",0)
	//blast:Fire("disablepuntsound","1")
	
	if self.HasSounds == true && GetConVarNumber("vj_npc_sd_meleeattack") == 0 then
		self:EmitSound( "stalker/creature/giant/giant_hit.wav",100,math.random(80,100))
	end
	
	//util.BlastDamage(self, self, self:GetPos(), 400, self.MeleeAttackDamage)
	util.VJ_SphereDamage(self,self,self:GetPos(),400,25,self.MeleeAttackDamageType,true,true,{Force=80})
end

function ENT:MultipleMeleeAttacks()
	--can use this to random between normal attacks and slams
	self.attacktype = "slam"
	--normal attack: ACT_MELEE_ATTACK_SWING 
	--MeleeAttackDistance 60ish is good
	--MeleeAttackDamageDistance 80ish prob good
	--TimeUntilMeleeAttackDamage 0.6
	--MeleeAttackDamage 20
	--MeleeAttackDamageType = DMG_SLASH
end

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeStartTimer()
	--self:MeleeAttackSoundCode()
end


/*-----------------------------------------------
	*** Copyright (c) 2012-2015 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/