
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Quick Deployment Landmine"
ENT.Author			= "Polymorphic Turtle"
ENT.Purpose			= "Commonly used to block off choke points."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then

function ENT:Initialize()
self:SetModel("models/props_wasteland/prison_lamp001a.mdl")
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self.Entity:SetTrigger( true )
self:SetCollisionGroup( COLLISION_GROUP_WEAPON )	
self:SetColor( Color(255, 255, 255, 255) )
self:SetSkin(1)
self.UseTimer = CurTime()
self.defused = 0
self.SearchTimer = CurTime()+0.2
local phys = self:GetPhysicsObject()	
if (phys:IsValid()) then
	phys:Wake()
	phys:SetMaterial("metal")
end	
local self_name = "Landmine" .. self:EntIndex()
self:SetName( self_name )
self:Activate()
self:SetPos(self:GetPos()+self:GetUp()*10)
end


end
function ENT:Explode()
	if self.primed and !self.exploded then
	self.exploded = true
	self.primed = false
	self:GetPhysicsObject():EnableMotion(true)
	self:GetPhysicsObject():Wake()
	if IsValid(self.Owner) then
	util.BlastDamage(self, self.Owner, self:GetPos()+self:GetUp()*3, 100+self.defused, 200+(self.defused*2))
	else
	util.BlastDamage(self, self, self:GetPos()+self:GetUp()*3, 100+self.defused, 200+(self.defused*2))
	end
	local ED = EffectData()
	ED:SetOrigin(self:GetPos())
	ED:SetScale(1)
	ED:SetRadius(3)
	ED:SetNormal(self:GetUp())
	ED:SetStart(self:GetPos())
	ED:SetMagnitude(1)
	util.Effect("polybewm", ED) 
	SafeRemoveEntityDelayed(self, 0.1) 
	end
end
function ENT:Think()
if self.primed and self.defused>0 then
	if (self.DefuseTimer != nil) then
		if self.DefuseTimer<CurTime() then
			if self.defused>29 then
				self:Explode()
			else
				self.defused = 0
				self:EmitSound("Buttons.snd16")
			end
		end
	end
end
end

function ENT:AutoAtt(user)
	local tr = util.TraceHull({start = self:GetPos(),endpos = self:GetPos() + self:GetUp() * -20,maxs = 1,mins = 1,filter = self})
	if (tr.Hit) then
		if (tr.HitWorld) then
			if self:GetAngles().r < 10 and self:GetAngles().r > -10 then
				user:ChatPrint("Trigger armed.")
				self.primed = true
				self:SetPos(tr.HitPos )
				self:GetPhysicsObject():EnableMotion(false)
				if IsValid(user) and user:IsPlayer() then
					self:SetOwner(user)
				end
				if !constraint.FindConstraint(self,"Weld") then
				self.mineweld = constraint.Weld(self,game.GetWorld(),0,0,0,0,0)
				end
				self.defused = 0
				self:EmitSound("Weapon_SLAM.TripMineMode", 50, 200)
				return true
			else
				user:ChatPrint("The mine is at too steep of an angle!")
				return false
			end
		else
			user:ChatPrint("The ground is not solid enough!")
			return false
		end
	else
	user:ChatPrint("The mine is not close enough to the ground!")
	return false
	end
end

function ENT:Use(user)
	if user:IsPlayer() and self.primed and self.defused>0 then
		self.DefuseTimer = CurTime()+0.1
	end
	if user:IsPlayer() and self.UseTimer<CurTime() then
		targetguy = user
		self.UseTimer = CurTime()+2.5
		if self.primed != true then
			if !constraint.FindConstraint(self,"Weld") then
				local tr = util.TraceHull({start = self:GetPos(),endpos = self:GetPos() + self:GetUp() * -20,maxs = 1,mins = 1,filter = self})
				if (tr.Hit) then
					if (tr.HitWorld) then
						if self:GetAngles().r < 10 and self:GetAngles().r > -10 then
							user:ChatPrint("Trigger armed.")
							self.primed = true
							self:SetPos(tr.HitPos )
							self:GetPhysicsObject():EnableMotion(false)
							if IsValid(user) and user:IsPlayer() then
								self:SetOwner(user)
							end
							if !constraint.FindConstraint(self,"Weld") then
							self.mineweld = constraint.Weld(self,game.GetWorld(),0,0,0,0,0)
							end
							self.defused = 0
							self:EmitSound("Weapon_SLAM.TripMineMode", 50, 200)
						else
							user:ChatPrint("The mine is at too steep of an angle!")
						end
					else
						user:ChatPrint("The ground is not solid enough!")
					end
				else
				user:ChatPrint("The mine is not close enough to the ground!")
				end
			else
				self.primed = true
			end
		else
			if (self.defused == 95) then
				self.UseTimer = CurTime()+4.5
				self.primed = false
				self:GetPhysicsObject():EnableMotion(true)
				if constraint.FindConstraint(self,"Weld") then constraint.RemoveConstraints(self,"Weld") end
				self:SetPos(self:GetPos()+self:GetUp()*18)
				user:ChatPrint("Trigger disarmed.")
				self:EmitSound("Buttons.snd28", 50, 200)
				self:GetPhysicsObject():EnableMotion(true)
				self:GetPhysicsObject():Wake()
				self:SetPos(self:GetPos()+self:GetUp()*18)
				self.defused = 0
				self.UseTimer = CurTime()+2.5
			else
				self.defused = self.defused + 5
				self:EmitSound("Buttons.snd27")
				user:ChatPrint("Trigger disarnament " .. self.defused .. "%")
				self.UseTimer = CurTime()+.5
				if self.defused == 30 then
					user:ChatPrint("WARNING! Do not let go! Fuse live!")
				end
			end
		end
	end
end


function ENT:Touch(entity)
	if !constraint.FindConstraint(self,"Weld") then
		self.primed = false
	else
		self.primed = true
	end
	self:Explode()
end
