AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/wick/krovo/wick_krovosos.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 110
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN

ENT.SightDistance = 1600 -- How far it can see

ENT.TurningSpeed = 50

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MUTANT"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION

ENT.Immune_AcidPoisonRadiation = true -- Immune to Acid, Poison and Radiation

ENT.BloodColor = "Yellow"

ENT.BloodParticle = {"blood_impact_red_01"} -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = {"Blood"} -- Leave blank for none | Commonly used: Red = Blood, Yellow Blood = YellowBlood
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.6 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.5 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random (10, 15)
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.AllowIgnition = true -- Can this SNPC be set on fire?
ENT.SlowPlayerOnMeleeAttack = false -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 3 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking


ENT.CallForBackUpOnDamage = false -- Should the SNPC call for help when damaged? (Only happens if the SNPC hasn't seen a enemy)
ENT.CallForBackUpOnDamageDistance = 800 -- How far away the SNPC's call for help goes | Counted in World Units
ENT.CallForBackUpOnDamageUseCertainAmount = true -- Should the SNPC only call certain amount of people?
ENT.CallForBackUpOnDamageUseCertainAmountNumber = 3 -- How many people should it call if certain amount is enabled?
ENT.DisableCallForBackUpOnDamageAnimation = false -- Disables the animation when the CallForBackUpOnDamage function is called

ENT.BringFriendsOnDeath = true -- Should the SNPC's friends come to its position before it dies?
ENT.BringFriendsOnDeathDistance = 2600 -- How far away does the signal go? | Counted in World Units
ENT.BringFriendsOnDeathUseCertainAmount = true -- Should the SNPC only call certain amount of people?
ENT.BringFriendsOnDeathUseCertainAmountNumber = 3 -- How many people should it call if certain amount is enabled?

ENT.AnimTbl_CallForHelp = {ACT_SIGNAL_GROUP}

ENT.CallForBackUpOnDamageAnimationTime = 2 -- How much time until it can use activities
ENT.NextCallForBackUpOnDamageTime1 = 9 -- Next time it use the CallForBackUpOnDamage function | The first # in math.random
ENT.NextCallForBackUpOnDamageTime2 = 11 -- Next time it use the CallForBackUpOnDamage function | The second # in math.random

	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_CallForHelp = {"wick/bloodsucker/distant_growl_1.ogg"}
ENT.SoundTbl_Idle = {"wick/bloodsucker/idle_0.ogg","wick/bloodsucker/idle_1.ogg","wick/bloodsucker/idle_2.ogg","wick/bloodsucker/idle_3.ogg"}
ENT.SoundTbl_Alert = {"wick/bloodsucker/builds/attack_0.ogg", "wick/bloodsucker/builds/attack_1.ogg", "wick/bloodsucker/builds/attack_2.ogg", "wick/bloodsucker/builds/attack_3.ogg"}
ENT.SoundTbl_MeleeAttack = {"wick/bloodsucker/builds/attack_hit_2.ogg", "wick/bloodsucker/builds/attack_hit_3.ogg", "wick/bloodsucker/heavy_hit_1.ogg"}
ENT.SoundTbl_Pain = {"wick/bloodsucker/hit_0.ogg","wick/bloodsucker/hit_1.ogg","wick/bloodsucker/hit_3.ogg"}
ENT.SoundTbl_Death = {"wick/bloodsucker/die_0.ogg", "wick/bloodsucker/die_1.ogg", "wick/bloodsucker/die_2.ogg", "wick/bloodsucker/die_3.ogg"}
ENT.SoundTbl_CombatIdle = {"wick/bloodsucker/builds/attack_0.ogg", "wick/bloodsucker/builds/attack_1.ogg", "wick/bloodsucker/builds/attack_2.ogg", "wick/bloodsucker/builds/attack_3.ogg"}

ENT.SoundTbl_Breath = {}


ENT.MeleeAttackSoundPitch1 = 100
ENT.MeleeAttackSoundPitch2 = 100

ENT.AlertSoundPitch1 = 100
ENT.AlertSoundPitch2 = 100

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,ply) 
	ply.npcClass = self:GetClass()
end

function ENT:CustomInitialize()
	self:SetSkin(math.random(0,1))
end

function ENT:CustomOnThink_AIEnabled()
	--u dont need to check it twice ur literally doing the same thing twice
	--here
	--also i feel like bloodsuckers are always invisible unless attacking
if (self:GetEnemy() and self:GetEnemy() != nil) then
    if (self:GetPos( ):Distance( self:GetEnemy():GetPos( ) ) > 350 ) then
		self:SetRenderMode(RENDERMODE_TRANSCOLOR)
		self:SetColor(Color(255,255,255,20))
		if (!self.ininvis or self.ininvis < CurTime()) then
		self:EmitSound("wick/bloodsucker/builds/invisible_0.ogg")
		self.ininvis = CurTime() + 20
		end
    elseif (self:GetPos( ):Distance( self:GetEnemy():GetPos( ) ) < 100 ) then
		self:SetRenderMode(RENDERMODE_TRANSCOLOR)
		self:SetColor(Color(255,255,255,255))
		if (!self.outinvis or self.outinvis < CurTime()) then
		self:EmitSound("wick/bloodsucker/builds/invisible_0.ogg")
		self.outinvis = CurTime() + 20
		end
	end
 end
 
 end
