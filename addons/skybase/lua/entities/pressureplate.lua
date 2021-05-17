
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Pressure Plate"
ENT.Author			= "PolyMorphic Purple"
ENT.Purpose			= "Extend the trigger length of a boobytrap"
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then

function ENT:Initialize()
self:SetModel("models/props_c17/streetsign004e.mdl")
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self:SetCollisionGroup( COLLISION_GROUP_WEAPON )	
self:SetColor( Color(255, 255, 255, 255) )
self:SetPos(self:GetPos()+Vector(0,0,30))
self.FireHealth = 200
self.TriggerForce = 85
self.Entity:SetTrigger( true )
self.target = nil
self.UseTimer = CurTime()+2
local phys = self:GetPhysicsObject()	
if (phys:IsValid()) then
	phys:Wake()
	phys:SetMaterial("metal")
end	
local self_name = "Pressure Plate" .. self:EntIndex()
self:SetName( self_name )
end


end


function ENT:CutWire()
	if !self.target.broken then
	self.target.ropey:Remove()
	end
	SafeRemoveEntityDelayed(self, 0.5) 
end

function ENT:Think()
	if !IsValid(self.ropey) and not self.broken and self.target then
	self.broken = true
	
	ED = EffectData()
	ED:SetOrigin(self:GetPos())
	
	util.Effect("StunstickImpact", ED)
	self:EmitSound("Padlock.Break")
	if IsValid(self) then self:CutWire() end
	end

	
	self:NextThink(CurTime())
	return true
end

function ENT:Touch(entity)
	if !IsValid(self.ropey) then
		if IsValid(entity.Owner) then
			if entity:GetModel() == "models/props_c17/trappropeller_lever.mdl" then
				self.ropey = constraint.Rope(self,entity,0,0,Vector(0,0,0),Vector(0,6,0),200,0,10,0.05,"cable/cable2",false)
				self.target = entity.Owner
			elseif entity:GetModel() == "models/props_wasteland/prison_throwswitchbase001.mdl" then
				self.ropey = constraint.Rope(self,entity,0,0,Vector(0,0,0),Vector(1,0,2.9),200,0,10,0.05,"cable/cable2",false)
				self.target = entity.Owner
			end
		else
			if entity:GetClass() == "tripwireextender" and IsValid(entity.ropey) then
			self.ropey = constraint.Rope(self,entity,0,0,Vector(0,0,0),Vector(1,0,2.9),200,0,10,0.05,"cable/cable2",false)
			self.target = entity
			end
		end
	else
		if entity:GetPhysicsObject():GetMass() >= self.TriggerForce then
		self.ropey:Remove()
		end
	end
end

function ENT:Use(user)
if self.UseTimer<CurTime() then
self.UseTimer = CurTime()+2
if user:IsPlayer() then
self.TriggerForce = self.TriggerForce + 15
if self.TriggerForce>130 then
self.TriggerForce = 15
end
user:ChatPrint("Pressure set to " .. self.TriggerForce .. "kg")
self:EmitSound("ambient/misc/clank1.wav")
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

