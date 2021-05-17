if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "P90"
SWEP.Author 					= "DrVrej"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "VJ CSS"
if (CLIENT) then
SWEP.Slot						= 2 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
SWEP.SlotPos					= 4 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
SWEP.SwayScale 					= 1 -- Default is 1, The scale of the viewmodel sway
SWEP.UseHands					= true
end
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/weapons/cstrike/c_smg_p90.mdl" -- The view model (First person)
SWEP.WorldModel					= "models/weapons/w_smg_p90.mdl" -- The world model (Third person, when a NPC is holding it, on ground, etc.)
SWEP.HoldType 					= "smg" -- List of holdtypes are in the GMod wiki
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_EnableDontUseRegulate 	= true -- Used for VJ Base SNPCs, if enabled the SNPC will remove use regulate
SWEP.NPC_NextPrimaryFire 		= 0.1 -- Next time it can use primary fire
SWEP.NPC_UsePistolBehavior 		= false -- Should it check the pistol activities when the NPC is firing the weapon?
-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 6 -- Damage
SWEP.Secondary.PlayerDamage		= 2 -- Put 1 to make it the same as above
SWEP.Primary.Force				= 5 -- Force applied on the object the bullet hits
SWEP.Primary.NumberOfShots		= 1 -- How many shots per attack?
SWEP.Primary.ClipSize			= 35 -- Max amount of bullets per clip
SWEP.Primary.DefaultClip		= 300 -- How much ammo do you get when you first pick up the weapon?
SWEP.Primary.Recoil				= 0.3 -- How much recoil does the player get?
SWEP.Primary.Cone				= 7 -- How accurate is the bullet? (Players)
SWEP.Primary.Delay				= 0.1 -- Time until it can shoot again
SWEP.Primary.Tracer				= 1
SWEP.Primary.TakeAmmo			= 1 -- How much ammo should it take on each shot?
SWEP.Primary.Automatic			= true -- Is it automatic?
SWEP.Primary.Ammo				= "SMG1" -- Ammo type
SWEP.Primary.Sound				= "weapons/p90/p90-1.wav"
-- Remember to add rest of the weapon by decompiling VJ Base.
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects()
-- Put the effects, shell spawning, realistic flash, etc.
-- EXAMPLES:
 -- Full list of effects are in VJ Base, when you decompile it, go to lua/effects/
 -- There is also the effects that come with GMod, they are placed in the GMod wiki.
	local vjeffectmuz = EffectData()
	vjeffectmuz:SetOrigin(self.Owner:GetShootPos())
	vjeffectmuz:SetEntity(self.Weapon)
	vjeffectmuz:SetStart(self.Owner:GetShootPos())
	vjeffectmuz:SetNormal(self.Owner:GetAimVector())
	vjeffectmuz:SetAttachment(1)
	vjeffectmuz:SetMagnitude(0)
	util.Effect("VJ_Weapon_RifleMuzzle1",vjeffectmuz)
	
	if GetConVarNumber("vj_wep_nobulletshells") == 0 then
	if !self.Owner:IsPlayer() then
	local vjeffect = EffectData()
	vjeffect:SetEntity(self.Weapon)
	vjeffect:SetOrigin(self.Owner:GetShootPos())
	vjeffect:SetNormal(self.Owner:GetAimVector())
	vjeffect:SetAttachment(1)
	util.Effect("VJ_Weapon_RifleShell1",vjeffect) end
	end

	if (SERVER) then
	if GetConVarNumber("vj_wep_nomuszzleflash") == 0 then
	local FireLight1 = ents.Create("light_dynamic")
	FireLight1:SetKeyValue("brightness", "2")
	if self.Owner:IsPlayer() then
	FireLight1:SetKeyValue("distance", "200") else FireLight1:SetKeyValue("distance", "150") end
	FireLight1:SetLocalPos(self.Owner:GetShootPos() +self:GetForward()*40 + self:GetUp()*-40)
	FireLight1:SetLocalAngles(self:GetAngles())
	FireLight1:Fire("Color", "255 150 60")
	FireLight1:SetParent(self)
	FireLight1:Spawn()
	FireLight1:Activate()
	FireLight1:Fire("TurnOn", "", 0)
	self:DeleteOnRemove(FireLight1)
	timer.Simple(0.07,function() if self:IsValid() then FireLight1:Remove() end end)
	end
 end
end