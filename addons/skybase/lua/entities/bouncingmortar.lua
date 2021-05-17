
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Bouncing Mortar Mine"
ENT.Author			= "Polymorphic Turtle"
ENT.Purpose			= "Commonly used to halt enemy movement."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then
function ENT:Initialize()
self:SetModel("models/Items/grenadeAmmo.mdl")
self:DrawShadow(false) 
self:SetMaterial("models/props_vents/borealis_vent001c")
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self.Entity:SetTrigger( true )
self.UseTimer = CurTime()
self.defused = 0
self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
self.fuse = ents.Create("prop_physics")
self.fuse:SetModel("models/props_canal/mattpipe.mdl")
self.fuse:SetMaterial("models/props_vents/borealis_vent001c")
local pos, ang = self:GetPos(), self:GetAngles()
pos = pos + ang:Up() * 6
pos = pos + ang:Right() * 0
pos = pos + ang:Forward() * -3
self.fuse:SetPos(pos)
self.fuse:SetAngles(ang)
self.fuse:SetSolid(0)
self.fuse:SetParent(self)
self.fuse:Spawn()
self.fuse:DrawShadow(false) 
self.fuse:SetModelScale(0.5,0)
self.fuse:ManipulateBoneScale(0, Vector(1, 1, 1)*.4)
self.fuse:PhysicsInitBox( Vector(-1,-1,-1), Vector(1,1,1) )
self.fuse:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
self.fuse:SetCollisionBounds(Vector( -.01 -.01, -.01 ), Vector( .01, .01, .01 ))
self:SetDTEntity(0, self.fuse)
self.fuse:PhysicsDestroy()
self:DeleteOnRemove(self.fuse)
if self:GetSkin() != 0 then
self:SetRenderMode( RENDERMODE_NONE )
end
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
	if self.primed and !self.Exploding then
	self.primed = false
	self:GetPhysicsObject():EnableMotion(true)
	constraint.RemoveConstraints(self,"Weld")
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	self:EmitSound("Weapon_AR2.Double")
	self.Exploding = true
	self:SetCollisionGroup(10) 
	self:GetPhysicsObject():SetVelocityInstantaneous(self:GetUp()*500)
	self:SetColor( Color(255, 255, 255, 255) )
	timer.Simple(0.15, function()
		if IsValid(self) then
			if IsValid(self.Owner) then
			util.BlastDamage(self, self.Owner, self:GetPos(), 30+self.defused, 120+(self.defused*2))
			else
			util.BlastDamage(self, self, self:GetPos(), 30+self.defused, 120+(self.defused*2))
			end
			local ED = EffectData()
			ED:SetOrigin(self:GetPos())
			ED:SetScale(0.3)
			ED:SetRadius(3)
			ED:SetNormal(self:GetUp()*-1)
			ED:SetStart(self:GetPos())
			ED:SetMagnitude(1)
			util.Effect("polybewm", ED)
			util.Effect("Explosion", ED)
			timer.Simple(0.05, function() 
				for i=0,15 do
					for k, v in pairs(ents.FindInSphere(self:GetPos(), 500)) do
						if IsValid(v) then
							self:Pellets(v)
						end
					end 
				end
			end)
		--[[self.Flare = ents.Create("env_flare")
			self.Flare:SetPos(self:GetPos())
			self.Flare:SetAngles(self:GetUp():Angle())
			self.Flare:Spawn()
			self.Flare:Activate()
			self.Flare:Fire( "Launch", "5000")
			self.Flare:SetKeyValue( "Scale", "20" )
			self.Flare:SetKeyValue( "Duration", "30" )
			self.Flare:Fire( "Die", "30" )]]
			SafeRemoveEntityDelayed(self, 0.3) 
		end
	end)
	end
end

function ENT:Pellets(ent)
	if IsValid(ent) then
			if ent:IsPlayer() or ent:IsNPC() then
				if self:Visible(ent) then
					if IsValid(self.Owner) then
					ent:TakeDamage(0.5+(500-ent:GetPos():Distance(self:GetPos()))*0.0085, self.Owner, DMG_BUCKSHOT)
					else
					ent:TakeDamage(0.5+(500-ent:GetPos():Distance(self:GetPos()))*0.0085, self, DMG_BUCKSHOT)
					end
				end
			end
	end
end

function ENT:Think()
if self.Exploding then
self:GetPhysicsObject():SetVelocityInstantaneous(self:GetUp()*500)
end
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

function ENT:AutoAtt(user)
	local tr = util.TraceHull({start = self:GetPos(),endpos = self:GetPos() + self:GetUp() * -20,maxs = 1,mins = 1,filter = self})
	if (tr.Hit) then
		if (tr.HitWorld) then
				user:ChatPrint("Trigger armed.")
				self.primed = true
				self:SetSkin(1) 
				self:SetPos(tr.HitPos)
				if IsValid(user) and user:IsPlayer() then
					self:SetOwner(user)
				end
				self:GetPhysicsObject():EnableMotion(false)
				if !constraint.FindConstraint(self,"Weld") then
				self.mineweld = constraint.Weld(self,game.GetWorld(),0,0,0,0,0)
				end
				self:SetRenderMode( RENDERMODE_NONE )
				self.defused = 0
				self:EmitSound("Weapon_SLAM.TripMineMode", 50, 200)
				return true
		else
			user:ChatPrint("The ground is not solid enough!")
		end
	else
	user:ChatPrint("The mine is not close enough to the ground!")
	end
	return false
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
							if IsValid(user) and user:IsPlayer() then
								self:SetOwner(user)
							end
							self:GetPhysicsObject():EnableMotion(false)
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
				self:SetPos(self:GetPos()+self:GetUp()*18)
				user:ChatPrint("Trigger disarnament 100%")
				user:ChatPrint("Trigger disarmed.")
				self:EmitSound("Buttons.snd28", 50, 200)
				self:SetColor( Color(255, 255, 255, 255) )
				if self:GetSkin() != 2 then
				self:GetPhysicsObject():EnableMotion(true)
				if constraint.FindConstraint(self,"Weld") then constraint.RemoveConstraints(self,"Weld") end
				self:SetRenderMode( RENDERMODE_TRANSALPHA )
				self:GetPhysicsObject():EnableMotion(true)
				self:GetPhysicsObject():Wake()
				self:SetPos(self:GetPos()+self:GetUp()*18)
				self.defused = 0
				self:SetSkin(0)
				self.UseTimer = CurTime()+2.5
				else
				SafeRemoveEntityDelayed(self, 0) 
				end
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
	if entity and IsValid(entity:GetPhysicsObject()) then
		if entity:GetPhysicsObject():GetMass() >= 30 then
			if !constraint.FindConstraint(self,"Weld") then
				self.primed = false
			else
				self.primed = true
			end
			self:Explode()
		end
	end
end
