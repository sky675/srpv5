
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Dedicated Anti Personel Landmine"
ENT.Author			= "Polymorphic Turtle"
ENT.Purpose			= "Commonly used to halt enemy movement."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then

function ENT:Initialize()
self:SetModel("models/props_wasteland/prison_lamp001c.mdl")
self:SetModelScale(1,0)
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self.Entity:SetTrigger( true )
self:SetCollisionGroup( COLLISION_GROUP_WEAPON )	
self:SetColor( Color(255, 255, 255, 255) )
self.UseTimer = CurTime()
self.defused = 0
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
	self.Exploding = true
	self:SetCollisionGroup(10) 
	self:GetPhysicsObject():SetVelocityInstantaneous( Vector( 0, 0, 1000 ) )

	timer.Simple(0.2, function()
		if IsValid(self) then
			if IsValid(self.Owner) then
			util.BlastDamage(self, self.Owner, self:GetPos(), 30+self.defused, 200+(self.defused*2))
			else
			util.BlastDamage(self, self, self:GetPos(), 30+self.defused, 200+(self.defused*2))
			end
			local ED = EffectData()
			ED:SetOrigin(self:GetPos())
			ED:SetScale(0.5)
			ED:SetRadius(3)
			ED:SetNormal(self:GetUp()*-1)
			ED:SetStart(self:GetPos())
			ED:SetMagnitude(1)
			util.Effect("polybewm", ED)
			util.Effect("Explosion", ED)
			timer.Simple(0.05, function() 
				for i=0,15 do
					for k, v in pairs(ents.FindInSphere(self:GetPos(), 800)) do
						if IsValid(v) then
							self:Pellets(v)
						end
					end 
				end
			end)
			SafeRemoveEntityDelayed(self, 0.3) 
		end
	end)
	end
end

function ENT:Pellets(ent)
	if IsValid(ent) then
			local bullet = {}
			bullet.Num = 1
			bullet.Src = self:GetPos()	
			bullet.Dir =  ent:LocalToWorld(ent:OBBCenter()) - ent:GetPos() 
			bullet.Spread = Vector( 1, 1, 1 ) 
			bullet.TracerName = "Tracer"
			bullet.Force = 5 * 0.5
			bullet.Damage = 2
			self:FireBullets(bullet)
			if ent:IsPlayer() or ent:IsNPC() then
				if self:Visible(ent) then
					if IsValid(self.Owner) then
					ent:TakeDamage(0.5+(801-ent:GetPos():Distance(self:GetPos()))*0.0085, self.Owner, DMG_BUCKSHOT)
					else
					ent:TakeDamage(0.5+(801-ent:GetPos():Distance(self:GetPos()))*0.0085, self, DMG_BUCKSHOT)
					end
				end
			end
	end
end

function ENT:Think()
if self.Exploding then
self:GetPhysicsObject():SetVelocityInstantaneous(Vector( 0, 0, 800))
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
							self:SetPos(tr.HitPos)
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
			if (self.defused==75) then
				self.primed = false
				self:GetPhysicsObject():EnableMotion(true)
				if constraint.FindConstraint(self,"Weld") then constraint.RemoveConstraints(self,"Weld") end
				self:SetPos(self:GetPos()+self:GetUp()*18)
				user:ChatPrint("Trigger disarnament 100%")
				user:ChatPrint("Trigger disarmed.")
				self:EmitSound("Buttons.snd28", 50, 200)
				self:GetPhysicsObject():EnableMotion(true)
				self:GetPhysicsObject():Wake()
				self:SetPos(self:GetPos()+self:GetUp()*18)
				self.defused = 0
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
	if !constraint.FindConstraint(self,"Weld") then
		self.primed = false
	else
		self.primed = true
	end
	self:Explode()
end
