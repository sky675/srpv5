
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Mercury Switch"
ENT.Author			= "PolyMorphic Purple"
ENT.Purpose			= "Mercury switches are used to trigger a trap when the switch moves."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then

function ENT:Initialize()
self:SetModel("models/props_junk/PopCan01a.mdl")
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self:SetCollisionGroup( COLLISION_GROUP_WEAPON )	
self:SetColor( Color(255, 255, 255, 255) )
self:SetPos(self:GetPos()+Vector(0,0,30))
self.FireHealth = 20
self.TriggerForce = 85
self.Entity:SetTrigger( true )
self.target = nil
self.UseTimer = CurTime()+2
local phys = self:GetPhysicsObject()	
if (phys:IsValid()) then
	phys:Wake()
	phys:SetMaterial("metal")
end	
local self_name = "Mercury Switch" .. self:EntIndex()
self:SetName( self_name )
end


end


function ENT:CutWire()
	if !self.target.broken and self.Primed == 2 then
	self.target.ropey:Remove()
	end
	SafeRemoveEntityDelayed(self, 0.5) 
end

function ENT:Think()
	if !IsValid(self.ropey) and not self.broken and self.target and self.Primed == 2 then
	self.broken = true
	
	ED = EffectData()
	ED:SetOrigin(self:GetPos())
	
	util.Effect("StunstickImpact", ED)
	self:EmitSound("Padlock.Break")
	if IsValid(self) then self:CutWire() end
	end
	if self:GetVelocity():Length()>30 and self.Primed == 2 and IsValid(self.ropey) then 
	self.ropey:Remove()
	end
	self:NextThink(CurTime())
	return true
end

function ENT:Touch(entity)
if !IsValid(self.ropey) then
if IsValid(entity.Owner) then
if entity.Owner:GetClass() == "springgun" or entity.Owner:GetClass() == "nitrousoxidetank" then
self.ropey = constraint.Rope(self,entity,0,0,Vector(0,0,0),Vector(1,0,2.9),200,0,10,0.05,"cable/cable2",false)
self.target = entity.Owner
elseif entity.Owner:GetClass() == "tripwiregrenade" or entity.Owner:GetClass() == "tripwireincendiarygrenade" then
self.ropey = constraint.Rope(self,entity,0,0,Vector(0,0,0),Vector(0,6,0),200,0,10,0.05,"cable/cable2",false)
self.target = entity.Owner
end
elseif entity:GetClass() == "tripwireextender" and IsValid(entity.ropey) then
self.ropey = constraint.Rope(self,entity,0,0,Vector(0,0,0),Vector(1,0,2.9),200,0,10,0.05,"cable/cable2",false)
self.target = entity
end
end
end

function ENT:Use(user)
if self.UseTimer<CurTime() then
self.UseTimer = CurTime()+2
if user:IsPlayer() and IsValid(self.ropey) then
if self.Primed != 2 then
self:EmitSound("ambient/misc/clank1.wav")
if !self.Primed then
user:ChatPrint("Trigger Exposed")
self.Primed = 1
else
user:ChatPrint("Trigger will active within 5 seconds.")
self:EmitSound("buttons/weapon_confirm.wav")
timer.Create( "MercurySwitchTimer", 1, 4, function() if IsValid(self) then self.Primed = self.Primed + 0.25 end end)
end
end
end
end
end
function ENT:OnTakeDamage(dmginfo)

	self.FireHealth = self.FireHealth - dmginfo:GetDamage()
	if self.FireHealth<1 then
	if !IsValid(self.ropey) then
	SafeRemoveEntityDelayed(self, 0.5)
	else
	self:CutWire()
	end
	end
end

