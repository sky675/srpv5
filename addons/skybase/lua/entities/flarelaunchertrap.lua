
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Flare Launcher"
ENT.Author			= "PolyMorphic Purple"
ENT.Purpose			= "Used for alarm."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then

function ENT:Initialize()
self:SetModel("models/props_wasteland/prison_pipefaucet001a.mdl")
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self:SetCollisionGroup( COLLISION_GROUP_WEAPON )	
self:SetColor( Color(255, 255, 255, 255) )
self:SetPos(self:GetPos()+Vector(0,0,30))
local phys = self:GetPhysicsObject()	
if (phys:IsValid()) then
	phys:Wake()
	phys:SetMaterial("metal")
end	
local self_name = "Spring Gun" .. self:EntIndex()
self:SetName( self_name )
end


end

function ENT:SETUP()
	if SERVER then
		if !constraint.FindConstraint(self,"Rope") then
			self.stick = ents.Create("prop_physics") 
			self.stick:SetPos(self:GetPos()+Vector(0,0,30))
			self.stick:SetModel("models/props_wasteland/prison_throwswitchbase001.mdl")
			self.stick.Owner = self
			self.stick:Spawn()
			self.ropey = constraint.Rope(self,self.stick,0,0,Vector(0,4,2),Vector(1.5,0,-2.8),200,0,10,0.05,"cable/cable2",false)
			self.primed = true
			self.Entity:SetTrigger( true )
			self.UseTimer = CurTime()+2
		else
			self.stick = constraint.FindConstraint(self,"Rope").Ent2
			self.ropey = constraint.Find(self,self.stick,"Rope",0,0) 
			self.primed = true
			self.primed2 = true
		end
	end
end
function ENT:Explode()
	local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake()
		phys:EnableMotion(true)
		if phys:IsMoveable() then
			phys:SetVelocity(((self:GetForward() - self:GetUp()):GetNormal()*10) * 50)
		end
	end
	self:EmitSound("Weapon_FlareGun.Single")
	self.Flare = ents.Create("env_flare")
	self.Flare:SetPos(self:GetPos())
	self.Flare:SetAngles(self:LocalToWorldAngles(Angle(0,-90,0)))
	self.Flare:Spawn()
	self.Flare:Activate()
	self.Flare:Fire( "Launch", "5000")
	self.Flare:SetKeyValue( "Scale", "20" )
	self.Flare:SetKeyValue( "Duration", "30" )
	self.Flare:Fire( "Die", "30" )
	ED = EffectData()
	ED:SetOrigin(self:GetPos())
	ED:SetAngles(self:GetRight():Angle()) 
	util.Effect("MuzzleEffect", ED)
	SafeRemoveEntityDelayed(self, 2.5) 
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
	if IsValid(self) then self:Explode() end
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
		self.UseTimer = CurTime()+2
		if self.primed2 != true then
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
					self.ropey = constraint.Rope(self,self.stick,0,0,Vector(0,4,2),Vector(1.5,0,-2.8),self.ropelength,5,10,0.05,"cable/cable2",false)
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