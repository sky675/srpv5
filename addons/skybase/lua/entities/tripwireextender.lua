
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Tripwire Extender"
ENT.Author			= "PolyMorphic Purple"
ENT.Purpose			= "Extend the trigger length of a boobytrap"
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then

function ENT:Initialize()
self:SetModel("models/props_wasteland/prison_throwswitchbase001.mdl")
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self:SetCollisionGroup( COLLISION_GROUP_WEAPON )	
self:SetColor( Color(255, 255, 255, 255) )
self:SetPos(self:GetPos()+Vector(0,0,30))
self.FireHealth = 20
self.Entity:SetTrigger( true )
self.target = nil
local phys = self:GetPhysicsObject()	
if (phys:IsValid()) then
	phys:Wake()
	phys:SetMaterial("metal")
end	
local self_name = "Tripwire Extender" .. self:EntIndex()
self:SetName( self_name )
end


end


function ENT:SETUP()
	if SERVER then
		if constraint.FindConstraint(self,"Rope") != nil then
			if constraint.FindConstraint(self,"Rope").Ent2:GetClass() == "tripwireextender" then
				self.target = constraint.FindConstraint(self,"Rope").Ent2
				self.ropey = constraint.Find(self,target,"Rope",0,0) 
			else
				self.target = constraint.FindConstraint(self,"Rope").Ent2.Owner
				self.ropey = constraint.Find(self,constraint.FindConstraint(self,"Rope").Ent2,"Rope",0,0) 
			end
		end
	end
end

function ENT:CutWire()
	if !self.target.broken and IsValid(self.target.ropey) then
	self.target.ropey:Remove()
	end
	SafeRemoveEntityDelayed(self, 0.5) 
end

function ENT:Think()
	if self.UseTimer == nil then
		self.UseTimer = CurTime()+0.01
	end
	if !self.deployed and self.UseTimer<CurTime() then
		self.deployed = true
		self:SETUP()
	end
	if !IsValid(self.ropey) and not self.broken and self.target then
	self.broken = true
	self:EmitSound("Padlock.Break")
	ED = EffectData()
	ED:SetOrigin(self:GetPos())
	
	util.Effect("StunstickImpact", ED)
	timer.Simple( 0.05, function() if IsValid(self) then self:CutWire() end end )
	end

	if IsValid(self.ropey) then
	local trace = {}
		trace.start = self:LocalToWorld(self.ropey.LPos1)
		trace.endpos = self.ropey.Ent2:LocalToWorld(self.ropey.LPos2)
		trace.filter = { self, self.ropey.Ent2}
	local tr = util.TraceLine( trace )
	if tr.Hit then 
	self.ropey:Remove()
	end
	end
	
	self:NextThink(CurTime())
	return true
end

function ENT:Touch(entity)
	if !IsValid(self.ropey) then
		if IsValid(entity.Owner) then
			if entity:GetModel() == "models/props_c17/trappropeller_lever.mdl" then
				self.ropey = constraint.Rope(self,entity,0,0,Vector(1.5,0,-2.818),Vector(0,6,0),200,0,10,0.05,"cable/cable2",false)
				self.target = entity.Owner
			elseif entity:GetModel() == "models/props_wasteland/prison_throwswitchbase001.mdl" then
				self.ropey = constraint.Rope(self,entity,0,0,Vector(1.5,0,-2.818),Vector(1,0,2.9),200,0,10,0.05,"cable/cable2",false)
				self.target = entity.Owner
			end
		else
			if entity:GetClass() == "tripwireextender" and IsValid(entity.ropey) then
			self.ropey = constraint.Rope(self,entity,0,0,Vector(1.5,0,-2.818),Vector(1,0,2.9),200,0,10,0.05,"cable/cable2",false)
			self.target = entity
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

