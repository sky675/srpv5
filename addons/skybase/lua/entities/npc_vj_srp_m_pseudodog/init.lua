AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/monsters/psydog.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 140
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MUTANT"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodParticle = {"blood_impact_red_01"} -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = {"Blood"} -- Leave blank for none | Commonly used: Red = Blood, Yellow Blood = YellowBlood
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.8 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random (23, 27)
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage

ENT.FindEnemy_UseSphere = true
ENT.TurningSpeed = 50

ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.SightDistance = 6000 -- How far it can see
ENT.ShootDistance = 6000
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
ENT.LeapAttackVelocityUp = 220 -- How much upward force should it apply?
ENT.LeapAttackVelocityRight = 0 -- How much right force should it apply?
ENT.LeapAttackDamage = 25
ENT.LeapAttackDamageDistance = 90 -- How far does the damage go?
ENT.LeapAttackDamageType = DMG_SLASH -- Type of Damage
ENT.DisableLeapAttackAnimation = false -- if true, it will disable the animation code
ENT.AnimTbl_LeapAttack = {ACT_JUMP}
ENT.Immune_Physics = true

ENT.AnimTbl_RangeAttack = {ACT_DOD_PRONE_ZOOM_BAZOOKA}
ENT.NextRangeAttackTime = 15.6
ENT.NextAnyAttackTime_Range = 2
ENT.RangeUseAttachmentForPos = true -- Should the projectile spawn on a attachment?
ENT.RangeUseAttachmentForPosID = "eyes" -- The attachment used on the range attack if RangeUseAttachmentForPos is set to true
ENT.RangeAttackEntityToSpawn = "obj_psy_wave" -- The entity that is spawned when range attacking
ENT.TimeUntilRangeAttackProjectileRelease = 0.9
ENT.HasRangeAttack = false
ENT.RangeToMeleeDistance = 30
ENT.RangeDistance = 1500
ENT.RangeAttackAnimationDelay = 1

ENT.FootStepTimeRun = 0.2 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.3 -- Next foot step sound when it is walkinging
	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/dog/step_paw_earth1.ogg","npc/dog/step_paw_earth3.ogg","npc/dog/step_paw_earth4.ogg","npc/dog/step_paw_earth5.ogg"}
ENT.SoundTbl_Idle = {"npc/pseudodog/idle_0.ogg","npc/pseudodog/idle_1.ogg","npc/pseudodog/idle_2.ogg"}
ENT.SoundTbl_Alert = {"npc/pseudodog/pdog_aggression_0.ogg","npc/pseudodog/pdog_aggression_1.ogg","npc/pseudodog/pdog_aggression_2.ogg,npc/tushkan/pdog_attack_0.ogg","npc/tushkan/pdog_attack_1.ogg","npc/tushkan/pdog_attack_2.ogg"}
ENT.SoundTbl_MeleeAttack = {"npc/pseudodog/attack_hit_0.ogg","npc/pseudodog/attack_hit_1.ogg","npc/pseudodog/attack_hit_2.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/pseudodog/dog_attack_1.ogg","npc/pseudodog/dog_attack_2.ogg","npc/pseudodog/dog_attack_3.ogg","npc/pseudodog/sy_attack_1.ogg", "npc/pseudodog/sy_attack_0.ogg"}
ENT.SoundTbl_Pain = {"npc/pseudodog/pdog_hurt_0.ogg","npc/pseudodog/pdog_hurt_1.ogg"}
ENT.SoundTbl_Death = {"npc/pseudodog/pdog_death_0.ogg","npc/pseudodog/pdog_death_1.ogg"}
ENT.SoundTbl_CombatIdle = {"npc/pseudodog/pdog_aggression_0.ogg","npc/pseudodog/pdog_aggression_1.ogg","npc/pseudodog/pdog_aggression_2.ogg","npc/tushkan/pdog_attack_0.ogg","npc/tushkan/pdog_attack_1.ogg","npc/tushkan/pdog_attack_2.ogg","npc/tushkan/pdog_threaten_0.ogg","npc/tushkan/pdog_threaten_1.ogg","npc/tushkan/pdog_threaten_2.ogg"}
ENT.SoundTbl_LeapAttackJump = {"npc/pseudodog/pdog_aggression_0.ogg","npc/pseudodog/pdog_aggression_1.ogg","npc/pseudodog/pdog_aggression_2.ogg","npc/tushkan/pdog_attack_0.ogg","npc/tushkan/pdog_attack_1.ogg","npc/tushkan/pdog_attack_2.ogg","npc/tushkan/pdog_threaten_0.ogg","npc/tushkan/pdog_threaten_1.ogg","npc/tushkan/pdog_threaten_2.ogg"}
ENT.SoundTbl_RangeAttack = {"npc/pseudodog/psy_affect_0.ogg","npc/pseudodog/psy_attack_2.ogg","npc/pseudodog/psy_attack_1.ogg","npc/pseudodog/psy_attack_0.ogg"}

ENT.AnimTbl_IdleStand = {"stand_idle_0","stand_idle_1","stand_idle_2","stand_check_corpse_0","stand_eat_0","stand_eat_1","stand_howling_0","stand_idle_threaten_0","stand_idle_scared_0","stand_sniff_0"} -- The idle animation when AI is enabled
----------------Simplified AI---------------------
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
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo,hitgroup)
	local Rand = math.random(1,30)
	if Rand == 1 then 
		self:VJ_ACT_PLAYACTIVITY("stand_check_corpse_0",true,1.29)
		self:SetLocalVelocity(self:GetForward()*-20)
	elseif Rand == 2 then 
		self:VJ_ACT_PLAYACTIVITY("stand_howling_0",true,1.29)
		self:SetLocalVelocity(self:GetRight()*1)
	elseif Rand == 3 then

	end

 end
 
function ENT:CustomOnThink()
	if self:Health() <= 25 then 
		self.AnimTbl_Walk = {self:GetSequenceActivity(self:LookupSequence("stand_walk_dmg_0"))}
	
		self.AnimTbl_Run = {self:GetSequenceActivity(self:LookupSequence("stand_run_dmg_0"))}
		self.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
		self.FootStepTimeWalk = 0.9 -- Next foot step sound when it is walking

	end
end

function ENT:CustomInitialize()
	--why did i keep this lol
	--[[local psy = math.random(1,2)
	if ( psy == 1 ) then
		self.HasRangeAttack = true
	elseif ( psy == 2 ) then
		self.HasRangeAttack = false		
	end]]
	self:SetSkin(math.random(0,2))
	
	self:SetCollisionBounds(Vector(20, 20, 35), Vector(-10, -10, 0))
end

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,ply) 
	ply.npcClass = self:GetClass()
end
ENT.FootStepSoundLevel = 60
ENT.BreathSoundPitch1 = 100
ENT.BreathSoundPitch2 = 100
ENT.IdleSoundPitch1 = 100
ENT.IdleSoundPitch2 = 100
ENT.CombatIdleSoundPitch1 = 100
ENT.CombatIdleSoundPitch2 = 100
ENT.OnReceiveOrderSoundPitch1 = 100
ENT.OnReceiveOrderSoundPitch2 = 100
ENT.MoveOutOfPlayersWaySoundPitch1 = 100
ENT.MoveOutOfPlayersWaySoundPitch2 = 100
ENT.BeforeHealSoundPitch1 = 100
ENT.BeforeHealSoundPitch2 = 100
ENT.AfterHealSoundPitch1 = 100
ENT.AfterHealSoundPitch2 = 100
ENT.MedicReceiveHealSoundPitch1 = 100
ENT.MedicReceiveHealSoundPitch2 = 100
ENT.OnPlayerSightSoundPitch1 = 100
ENT.OnPlayerSightSoundPitch2 = 100
ENT.AlertSoundPitch1 = 100
ENT.AlertSoundPitch2 = 100
ENT.CallForHelpSoundPitch1 = 100
ENT.CallForHelpSoundPitch2 = 100
ENT.BecomeEnemyToPlayerPitch1 = 100
ENT.BecomeEnemyToPlayerPitch2 = 100
ENT.SuppressingPitch1 = 100
ENT.SuppressingPitch2 = 100
ENT.WeaponReloadSoundPitch1 = 100
ENT.WeaponReloadSoundPitch2 = 100
ENT.GrenadeAttackSoundPitch1 = 100
ENT.GrenadeAttackSoundPitch2 = 100
ENT.OnGrenadeSightSoundPitch1 = 100
ENT.OnGrenadeSightSoundPitch2 = 100
ENT.OnKilledEnemySoundPitch1 = 100
ENT.OnKilledEnemySoundPitch2 = 100
ENT.PainSoundPitch1 = 100
ENT.PainSoundPitch2 = 100
ENT.ImpactSoundPitch1 = 80
ENT.ImpactSoundPitch2 = 100
ENT.DamageByPlayerPitch1 = 100
ENT.DamageByPlayerPitch2 = 100
ENT.DeathSoundPitch1 = 100
ENT.DeathSoundPitch2 = 100