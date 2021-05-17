
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Boobytrap grenade"
ENT.Author			= "PolyMorphic Purple"
ENT.Purpose			= "Commonly used to prevent enemy movement."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then

function ENT:Initialize()
self:SetModel("models/weapons/w_eq_fraggrenade.mdl")
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self:SetCollisionGroup( COLLISION_GROUP_WEAPON )	
self:SetColor( Color(255, 255, 255, 255) )
print(constraint.HasConstraints(self.Entity))
local phys = self:GetPhysicsObject()	
self.primed = false
self.UseTimer = CurTime()+0.2
if (phys:IsValid()) then
	phys:Wake()
	phys:SetMaterial("metal")
end	
local self_name = "Tripwire Grenade" .. self:EntIndex()
self:SetName( self_name )
end
end

function ENT:SETUP()
	if SERVER then
			if !constraint.FindConstraint(self,"Rope") then
			self.stick = ents.Create("prop_physics") 
			self.stick:SetPos(self:GetPos()+Vector(0,0,10))
			self.stick:SetModel("models/props_c17/TrapPropeller_Lever.mdl")
			self.stick.Owner = self
			self.stick:Spawn()
			self.ropey = constraint.Rope(self,self.stick,0,0,Vector(0,0,6),Vector(0,6,0),200,0,10,0.05,"cable/cable2",false)
			self.primed = true
			self.Entity:SetTrigger( true )
			self.UseTimer = CurTime()+2
			if self:GetVar("Placed") then
				self.primed = false
				self.stick:SetPos(self.stickpos)
				self.stick:SetAngles(self.stickang)
				constraint.Weld(self.stick,game.GetWorld(),0,0,0,0,0) 
				self.ropelength = (self:LocalToWorld(self.ropey.LPos1) - self.stick:LocalToWorld(self.ropey.LPos2)):Length()
				if self.ropelength then
					self.ropey:Remove()
					self.ropey = constraint.Rope(self,self.stick,0,0,Vector(0,0,6),Vector(0,6,0),self.ropelength,2,10,0.05,"cable/cable2",false)
					self.primed = true
					self.primed2 = true
				end
			end
		else
			self.stick = constraint.FindConstraint(self,"Rope").Ent2
			self.ropey = constraint.Find(self,self.stick,"Rope",0,0) 
			self.primed = true
			self.primed2 = true
		end
	end
end
function ENT:Explode()
	ED = EffectData()
	ED:SetOrigin(self:GetPos())
	
	util.Effect("Explosion", ED)
	util.Effect("HelicopterMegaBomb", ED)
	util.BlastDamage(self, self, self:GetPos(), 256, 100)
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 256)) do
		if IsValid(v) then
			if v:GetClass() == "tripwiregrenade" or v:GetClass() == "tripwireincendiarygrenade" then
				timer.Simple( 0.2, function() if IsValid(v.ropey) then v.ropey:Remove() end end )
			end
		end
	end
	SafeRemoveEntityDelayed(self, 0.5) 
end
function ENT:Think()
	if self.UseTimer == nil then
		self.UseTimer = CurTime()+0.2
	end
	if !self.deployed and self.UseTimer<CurTime() then
		self.deployed = true
		self:SETUP()
	end
	if !IsValid(self.ropey) and not self.broken and self.primed then
	self.broken = true
	self:EmitSound("Padlock.Break")
	timer.Simple( 0.1, function() if IsValid(self) then self:Explode() end end )
	end
	
	if IsValid(self.ropey) and !self.broken and self.primed and self.primed2 then
	local trace = {}
		trace.start = self:LocalToWorld(self.ropey.LPos1)
		trace.endpos = self.stick:GetPos()+Vector(0,0,2)
		trace.filter = { self, self.stick }
	local tr = util.TraceLine( trace )
	if tr.Hit then 
	self.ropey:Remove() 
	end
	end
	self:NextThink(CurTime())
	return true
end


function ENT:Use(user)
	if user:IsPlayer() and self.UseTimer<CurTime() then
		self.UseTimer = CurTime()+1
		
		if !constraint.FindConstraint(self,"Rope").Ent2:GetModel() == "models/props_c17/trappropeller_lever.mdl" then
			self.stick = ents.Create("prop_physics") 
			self.stick:SetPos(self:GetPos()+Vector(0,0,10))
			self.stick:SetModel("models/props_c17/TrapPropeller_Lever.mdl")
			self.stick.Owner = self
			self.stick:Spawn()
			self.ropey = constraint.Rope(self,self.stick,0,0,Vector(0,0,6),Vector(0,6,0),200,0,10,0.05,"cable/cable2",false)
			self.primed = true
			self.Entity:SetTrigger( true )
			self.UseTimer = CurTime()+2
			if self:GetVar("Placed") then
				self.primed = false
				self.stick:SetPos(self.stickpos)
				self.stick:SetAngles(self.stickang)
				constraint.Weld(self.stick,game.GetWorld(),0,0,0,0,0) 
				self.ropelength = (self:LocalToWorld(self.ropey.LPos1) - self.stick:LocalToWorld(self.ropey.LPos2)):Length()
				if self.ropelength then
					self.ropey:Remove()
					self.ropey = constraint.Rope(self,self.stick,0,0,Vector(0,0,6),Vector(0,6,0),self.ropelength,2,10,0.05,"cable/cable2",false)
					self.primed = true
					self.primed2 = true
				end
			end
		else
			print("apply")
			self.stick = constraint.FindConstraint(self,"Rope").Ent2
			self.ropey = constraint.Find(self,self.stick,"Rope",0,0) 
			print(IsValid(self.ropey))
			self.primed = true
		end



		if self.primed2 != true and self.primed then
		user:ChatPrint("Trigger armed.")
		self.primed2 = true
		else
			if IsValid(self.ropey) then
				user:ChatPrint("Tripwire tightened.")
				self.primed2 = false 
				self.primed = false
				self.ropelength = (self:LocalToWorld(self.ropey.LPos1) - self.stick:LocalToWorld(self.ropey.LPos2)):Length()
				if self.ropelength then
					self.ropey:Remove()
					self.ropey = constraint.Rope(self,self.stick,0,0,Vector(0,0,6),Vector(0,6,0),self.ropelength,2,10,0.05,"cable/cable2",false)
					self.primed2 = true
					self.primed = true
				end
			end
		end
	end
end
function ENT:OnRemove()
	if IsValid( self.stick ) then
		self.stick:Remove()		
	end
	if IsValid( self.ropey ) then
		self.ropey:Remove()		
	end
end