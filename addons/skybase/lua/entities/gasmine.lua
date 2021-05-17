
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Cheap Gas Mine"
ENT.Author			= "Polymorphic Turtle"
ENT.Purpose			= "Commonly used to halt enemy movement."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then
function ENT:Initialize()
self:SetModel("models/props_interiors/pot01a.mdl")
self:DrawShadow(false) 
self:SetMaterial("models/props_vents/borealis_vent001c")
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self.Entity:SetTrigger( true )
self.UseTimer = CurTime()
self.defused = 0
self.fuse = ents.Create("prop_physics")
self.fuse:SetModel("models/props_trainstation/TrackSign01.mdl")
self.fuse:SetMaterial("models/props_vents/borealis_vent001c")
local pos, ang = self:GetPos(), self:GetAngles()
pos = pos + ang:Up() * 6
pos = pos + ang:Right() * 0
pos = pos + ang:Forward() * 0
self.fuse:SetPos(pos)
self.fuse:SetAngles(ang)
self.fuse:SetSolid(0)
self.fuse:SetParent(self)
self.fuse:Spawn()
self.fuse:DrawShadow(false) 
self.fuse:SetModelScale(0.45,0)
self.fuse:ManipulateBoneScale(0, Vector(1, 1, 1)*.4)
self.fuse:PhysicsInitBox( Vector(-1,-1,-1), Vector(1,1,1) )
self.fuse:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
self.fuse:SetCollisionBounds(Vector( -.01 -.01, -.01 ), Vector( .01, .01, .01 ))
self:SetDTEntity(0, self.fuse)
self.fuse:PhysicsDestroy()
self:DeleteOnRemove(self.fuse)
if self:GetSkin() == 1 then
self:SetRenderMode( RENDERMODE_NONE )
end
local phys = self:GetPhysicsObject()	
if (phys:IsValid()) then
	phys:Wake()
	phys:SetMaterial("metal")
	phys:SetMass(20)
end	
local self_name = "Landmine" .. self:EntIndex()
self:SetName( self_name )
self:Activate()
self:SetPos(self:GetPos()+self:GetUp()*10)
end


end
function ENT:Explode()
	if self.primed and !self.Exploding then
	self.primed = false
	self:GetPhysicsObject():EnableMotion(true)
	self:EmitSound("Buttons.snd27")
	self.Exploding = true
	self:SetCollisionGroup(10) 
	self:SetColor( Color(255, 255, 255, 255) )
	timer.Simple(0.15, function()
		if IsValid(self) then
			if IsValid(self.Owner) then
			util.BlastDamage(self.Owner, self, self:GetPos(), 30+self.defused, 40+(self.defused*2))
			else
			util.BlastDamage(self, self, self:GetPos(), 30+self.defused, 40+(self.defused*2))
			end
			local ED = EffectData()
			ED:SetOrigin(self:GetPos())
			ED:SetScale(0.8)
			ED:SetRadius(3)
			ED:SetNormal(self:GetUp())
			ED:SetStart(self:GetPos()+self:GetUp()*2)
			ED:SetMagnitude(1)
			util.Effect("polybewm", ED)
			self.gas = ents.Create("polygascloud")
			self.gas:SetPos(self:GetPos())
			self.gas:SetSkin(5)
			if IsValid(self.Owner) then
			self.gas:SetOwner(self.Owner)
			end
			self.gas:Spawn()
			self.gas:Activate()
			SafeRemoveEntityDelayed(self, 0) 
		end
	end)
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
self:NextThink( CurTime() + 0.1 )
return true
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
							user:ChatPrint("Trigger armed.")
							self.primed = true
							self:SetSkin(1)
							self:SetPos(tr.HitPos)
							self:GetPhysicsObject():EnableMotion(false)
							if IsValid(user) and user:IsPlayer() then
								self:SetOwner(user)
							end
							if !constraint.FindConstraint(self,"Weld") then
							self.mineweld = constraint.Weld(self,game.GetWorld(),0,0,0,0,0)
							end
							self:SetRenderMode( RENDERMODE_NONE )
							self.defused = 0
							self:EmitSound("Weapon_SLAM.TripMineMode", 50, 200)
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
			if (self.defused==75) then
				self.primed = false
				self:GetPhysicsObject():EnableMotion(true)
				if constraint.FindConstraint(self,"Weld") then constraint.RemoveConstraints(self,"Weld") end
				self:SetPos(self:GetPos()+self:GetUp()*18)
				user:ChatPrint("Trigger disarnament 100%")
				user:ChatPrint("Trigger disarmed.")
				self:EmitSound("Buttons.snd28", 50, 200)
				self:SetColor( Color(255, 255, 255, 255) )
				self:SetRenderMode( RENDERMODE_TRANSALPHA )
				self:GetPhysicsObject():EnableMotion(true)
				self:GetPhysicsObject():Wake()
				self:SetPos(self:GetPos()+self:GetUp()*18)
				self.defused = 0
				self:SetSkin(0)
				self.UseTimer = CurTime()+2.5
			else
				self.defused = self.defused + 25
				self:EmitSound("Buttons.snd27")
				user:ChatPrint("Trigger disarnament " .. self.defused .. "%")
				self.UseTimer = CurTime()+.5
				if self.defused == 50 then
					user:ChatPrint("WARNING! Do not let go! Fuse live!")
				end
			end
		end
	end
end


function ENT:Touch(entity)
	if entity then
			if !constraint.FindConstraint(self,"Weld") then
				self.primed = false
			else
				self.primed = true
			end
			self:Explode()
	end
end
