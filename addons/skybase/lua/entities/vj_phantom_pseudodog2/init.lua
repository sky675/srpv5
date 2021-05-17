AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.Model = {"models/monsters/fantom_pseudodog.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 1
ENT.MoveType = MOVETYPE_NOCLIP
ENT.HullType = HULL_TINY
ENT.MovementType = VJ_MOVETYPE_AERIAL
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MUTANT"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodParticle = {"blood_impact_red_01"} -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = {""} -- Leave blank for none | Commonly used: Red = Blood, Yellow Blood = YellowBlood
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_JUMP} -- Melee Attack Animations
ENT.MeleeAttackDistance = 45 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 1 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.8 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = 1
ENT.HullSizeNormal = false
ENT.Aerial_AnimTbl_Alerted = {ACT_RUN}
ENT.FindEnemy_UseSphere = true -- Should the SNPC be able to see all around him? (360) | Objects and walls can still block its sight!
ENT.FindEnemy_CanSeeThroughWalls = true
ENT.LastSeenEnemyTimeUntilReset = 150000
ENT.SightDistance = 600000 -- How far it can see
ENT.ShootDistance = 600000
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.SlowPlayerOnMeleeAttack = false -- If true, then the player will slow down
ENT.SlowPlayerOnMeleeAttack_WalkSpeed = 100 -- Walking Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttack_RunSpeed = 100 -- Running Speed when Slow Player is on
ENT.SlowPlayerOnMeleeAttackTime = 5 -- How much time until player's Speed resets
ENT.MeleeAttackBleedEnemy = true -- Should the player bleed when attacked by melee
ENT.MeleeAttackBleedEnemyChance = 3 -- How chance there is that the play will bleed? | 1 = always
ENT.MeleeAttackBleedEnemyDamage = 1 -- How much damage will the enemy get on every rep?
ENT.MeleeAttackBleedEnemyTime = 1 -- How much time until the next rep?
ENT.MeleeAttackBleedEnemyReps = 4 -- How many reps?
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_Idle = {"npc/poltergeist/die_0.ogg","npc/poltergeist/idle_0.ogg","npc/poltergeist/idle_1.ogg","npc/poltergeist/idle_2.ogg","npc/poltergeist/idle_3.ogg"}
ENT.SoundTbl_Alert = {"npc/poltergeist/die_0.ogg"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/attack_0.ogg","npc/poltergeist/attack_1.ogg","npc/poltergeist/attack_2.ogg","npc/poltergeist/attack_hit_0.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_1.ogg"}
ENT.SoundTbl_MeleeAttack = {"npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/attack_0.ogg","npc/poltergeist/attack_1.ogg","npc/poltergeist/attack_2.ogg","npc/poltergeist/attack_hit_0.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_1.ogg"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/attack_0.ogg","npc/poltergeist/attack_1.ogg","npc/poltergeist/attack_2.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_1.ogg"}
ENT.SoundTbl_Pain = {"npc/poltergeist/attack_hit_0.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_1.ogg"}
ENT.SoundTbl_Death = {"npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/attack_hit_0.ogg","npc/poltergeist/die_0.ogg","npc/poltergeist/die_1.ogg","npc/poltergeist/die_2.ogg","npc/poltergeist/die_3.ogg","npc/poltergeist/hit_0.ogg","npc/poltergeist/hit_1.ogg"}
ENT.SoundTbl_CombatIdle = {"npc/poltergeist/die_0.ogg","npc/poltergeist/die_0.ogg","npc/poltergeist/die_0.ogg","npc/poltergeist/die_0.ogg","npc/poltergeist/die_0.ogg","npc/poltergeist/idle_0.ogg","npc/poltergeist/idle_1.ogg","npc/poltergeist/idle_2.ogg","npc/poltergeist/idle_3.ogg"}
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
ENT.Aerial_FlyingSpeed_Calm = 0 -- The speed it should fly with, when it's wandering, moving slowly, etc. | Basically walking campared to ground SNPCs
ENT.Aerial_FlyingSpeed_Alerted = 100
function ENT:OnTakeDamage(dmg)
	local attacker = dmg:GetAttacker()
	if ( attacker:IsPlayer() or attacker:IsNPC()) then
		self:SetHealth( self:Health() - dmg:GetDamage() )
		if (self:Health() <= 0) then
		self:Remove()
	
		end
	end
end

function ENT:CustomOnThink()

					local lamp2 = ents.Create("env_sprite")
					lamp2:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
					lamp2:SetKeyValue("scale","0.1")
					lamp2:SetKeyValue("rendermode","5")
					lamp2:SetKeyValue("rendercolor","10 10 10")
					lamp2:SetKeyValue("spawnflags","1") -- If animated
					lamp2:SetParent(self)
					lamp2:Fire("SetParentAttachment","duh",0)
					lamp2:Spawn()
					lamp2:Activate()
					lamp2:Fire("Kill","",0.8)
					self:DeleteOnRemove(lamp2)	

										local lamp3 = ents.Create("env_sprite")
					lamp3:SetKeyValue("model","sprites/physcannon_bluecore2b.vmt")
					lamp3:SetKeyValue("scale","0.8")
					lamp3:SetKeyValue("rendermode","5")
					lamp3:SetKeyValue("rendercolor","7 12 11")
					lamp3:SetKeyValue("spawnflags","1") -- If animated
					lamp3:SetParent(self)
					lamp3:Fire("SetParentAttachment","duh",0)
					lamp3:Spawn()
					lamp3:Activate()
					lamp3:Fire("Kill","",0.1)
					self:DeleteOnRemove(lamp3)	
										local lamp4 = ents.Create("env_sprite")
					lamp4:SetKeyValue("model","sprites/plasmahalo.vmt")
					lamp4:SetKeyValue("scale","0.4")
					lamp4:SetKeyValue("rendermode","5")
					lamp4:SetKeyValue("rendercolor","1 1 1")
					lamp4:SetKeyValue("spawnflags","1") -- If animated
					lamp4:SetParent(self)
					lamp4:Fire("SetParentAttachment","duh",0)
					lamp4:Spawn()
					lamp4:Activate()
					lamp4:Fire("Kill","",0.1)
					self:DeleteOnRemove(lamp4)	
end
function ENT:CustomInitialize()
self:SetMaterial("models/monsters/act_pseudodog228")
	self:SetCollisionBounds(Vector(20, 20, 35), Vector(-10, -10, 0))
self:DrawShadow(false)
self:SetMoveType(MOVETYPE_NOCLIP )


			self.calleffect = EffectData()
	self.calleffect:SetStart( self:GetPos() )
	self.calleffect:SetOrigin( self:GetPos() )
	self.calleffect:SetMagnitude(0)
	self.calleffect:SetEntity( self )
	util.Effect( "propspawn", self.calleffect )
		
	self.lighteffect = ents.Create("light_dynamic")
	self.lighteffect:SetPos( self:GetPos() )
	self.lighteffect:SetOwner( self:GetOwner() )
	self.lighteffect:SetParent(self)
	self.lighteffect:Spawn()
	self.lighteffect:SetKeyValue( "_light", "180 100 40 10" )
	self.lighteffect:SetKeyValue("brightness", "5" )
	self.lighteffect:SetKeyValue("distance", "50" )
	self.lighteffect:Fire( "Kill", 1, 0.5 )
		self.allyeffect = EffectData()
	self.allyeffect:SetStart( self:GetPos() )
	self.allyeffect:SetOrigin( self:GetPos() )
	self.allyeffect:SetMagnitude(0)
	self.allyeffect:SetEntity( self )

	util.Effect( "camera_flash", self.allyeffect )
end

function ENT:CustomOnMeleeAttack_Miss()
		self:Remove()

 end
 
 function ENT:CustomOnMeleeAttack_AfterChecks(TheHitEntity) 
 		self:Remove()

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

