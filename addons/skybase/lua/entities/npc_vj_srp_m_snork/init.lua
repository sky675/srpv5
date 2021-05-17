AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/wick/snork/wick_snork.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 80 --500 hp??????????
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN

ENT.SightDistance = 1600 -- How far it can see

---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MUTANT"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodParticle = {"blood_impact_red_01"} -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = {"Blood"} -- Leave blank for none | Commonly used: Red = Blood, Yellow Blood = YellowBlood
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK_SWING} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.4 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.6 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random (30, 35)
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.SlowPlayerOnMeleeAttack = false -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = false -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 3 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {ACT_SPECIAL_ATTACK1} -- Melee Attack Animations
ENT.LeapDistance = 500 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapAttackAnimationDelay = 0 -- It will wait certain amount of time before playing the animation
ENT.LeapToMeleeDistance = 150 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0.2 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = 5 -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 6 -- How much time until it can use a attack again? | Counted in Seconds
ENT.LeapAttackExtraTimers = {0.4,0.6,0.8,1} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.LeapAttackVelocityForward = 300 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 250 -- How much upward force should it apply?
ENT.LeapAttackDamage = 40
ENT.LeapAttackDamageDistance = 100 -- How far does the damage go?

ENT.AnimTbl_CallForHelp = {ACT_SIGNAL_GROUP}

ENT.CallForBackUpOnDamageAnimationTime = 15 -- How much time until it can use activities
ENT.NextCallForBackUpOnDamageTime1 = 9 -- Next time it use the CallForBackUpOnDamage function | The first # in math.random
ENT.NextCallForBackUpOnDamageTime2 = 11 -- Next time it use the CallForBackUpOnDamage function | The second # in math.random
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {""}
ENT.SoundTbl_Idle = {"wick/snork/snork_idle_0.ogg","wick/snork/snork_idle_1.ogg","wick/snork/snork_idle_2.ogg"}
ENT.SoundTbl_Alert = {"wick/snork/snork_attack_0.ogg", "wick/snork/snork_attack_1.ogg"}
ENT.SoundTbl_MeleeAttack = {"wick/snork/snork_attack_hit_0.ogg", "wick/snork/snork_attack_hit_1.ogg"}
ENT.SoundTbl_BeforeLeapAttack = {"wick/snork/snork_attack_0.ogg", "wick/snork/snork_attack_1.ogg"}
ENT.SoundTbl_LeapAttackJump = {"wick/snork/snork_attack_hit_0.ogg", "wick/snork/snork_attack_hit_1.ogg"}
ENT.SoundTbl_Pain = {"wick/snork/snork_idle_0.ogg","wick/snork/snork_idle_1.ogg","wick/snork/snork_idle_2.ogg"}
ENT.SoundTbl_Death = {"wick/snork/snork_idle_0.ogg"}
ENT.SoundTbl_CombatIdle = {"wick/snork/snork_attack_0.ogg", "wick/snork/snork_attack_1.ogg"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:CapabilitiesAdd(CAP_MOVE_CLIMB)
	self:CapabilitiesAdd(CAP_MOVE_JUMP)
end

function ENT:CustomInitialize()
	local randomstartbg_body = math.random(0,6)
	if randomstartbg_body  == 0 then self:SetSkin( 0 )
	elseif randomstartbg_body  == 1 then self:SetSkin( 1 )
	elseif randomstartbg_body  == 2 then self:SetSkin( 2 )
	elseif randomstartbg_body  == 3 then self:SetSkin( 3 )
	elseif randomstartbg_body  == 4 then self:SetSkin( 4 )
	elseif randomstartbg_body  == 5 then self:SetSkin( 5 ) 
	end
end
--are u fucking insane