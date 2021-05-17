
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Automatic Directed Mine"
ENT.Author			= "Polymorphic Turtle"
ENT.Purpose			= "Commonly used to block off choke points."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then

function ENT:Initialize()
self.SearchTimer = CurTime()+5
self:SetModel("models/props_c17/consolebox05a.mdl")
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self.Entity:SetTrigger( true )
self:SetCollisionGroup( COLLISION_GROUP_WEAPON )	
self:SetColor( Color(255, 255, 255, 255) )
self:SetMaterial("models/props_vents/borealis_vent001c")
self.UseTimer = CurTime()
self.defused = 0
if self:GetSkin() == 1 then
	self.primed = true
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

function ENT:Draw()
		self:DrawModel()
		if self:GetSkin() == 1 then
		local ent = self
		local tr = util.TraceHull({start = self:GetPos(),endpos = self:GetPos() + self:GetUp() * 3000,maxs = 1,mins = 1,filter = self})
		render.SetMaterial(Material( "tripmine_laser" ))
		local TexOffset = CurTime() * 3
		local Distance = self:GetPos():Distance(tr.HitPos)
		render.DrawBeam(self:GetPos(), tr.HitPos, 4, TexOffset, TexOffset+Distance/8, Color(0,255,255,10))
		render.DrawBeam(self:GetPos(), tr.HitPos, 2, TexOffset, TexOffset+Distance/8, Color(0,255,255,50))
		end
end
function ENT:Explode(hitty)
	if self.primed and !self.exploded then
	self.exploded = true
	self.primed = false
	self:SetSkin(0)
	self:GetPhysicsObject():EnableMotion(true)
	self:GetPhysicsObject():Wake()
	local eff = EffectData()
	eff:SetOrigin(self:GetPos()+self:GetUp()*5)
	eff:SetScale(0.5)
	eff:SetRadius(3)
	eff:SetNormal(self:GetUp())
	eff:SetStart(self:GetPos()+self:GetUp()*5)
	eff:SetMagnitude(1)
	util.Effect("polybewm", eff) 
	if IsValid(self.Owner) then
	util.BlastDamage(self, self.Owner, self:GetPos(), 50+self.defused, 200+(self.defused*2))
	else
	util.BlastDamage(self, self, self:GetPos(), 50+self.defused, 200+(self.defused*2))
	end
	local bullet = {}
	if IsValid(self.Owner) then
	bullet.Attacker = self.Owner
	else
	bullet.Attacker = self
	end
	bullet.Num = 60
	bullet.Src = self:GetPos()
	bullet.Dir = self:GetUp() 
	bullet.Spread = Vector( 0.15, 0.15, 0 ) 
	bullet.TracerName = "Tracer"
	bullet.Force = 5 * 0.5
	bullet.Damage = 10
	self:FireBullets(bullet)
	if IsValid(self.Owner) then
	bullet.Attacker = self.Owner
	else
	bullet.Attacker = self
	end
	bullet.Num = 20
	bullet.Src = self:GetPos()
	bullet.Dir = self:GetUp() 
	bullet.Spread = Vector( 0.03, 0.03, 0 ) 
	bullet.TracerName = "Tracer"
	bullet.Force = 5 * 0.5
	bullet.Damage = 10
	self:FireBullets(bullet)
	if IsValid(hitty) then
		if self:Visible(hitty) then
			hitty:TakeDamage(0.5+(2000-hitty:GetPos():Distance(self:GetPos()))*0.015, self, DMG_BUCKSHOT)
		end
	end
	SafeRemoveEntityDelayed(self, 0.4) 
	end
end

function ENT:Think()
	if self.primed or self:GetVar("Primed") then
		local tr = util.TraceHull({start = self:GetPos(),endpos = self:GetPos() + self:GetUp() * 3000,maxs = 3,mins = 3,filter = self})
		if tr.Hit and !tr.HitWorld then
			self:Explode(tr.Entity)
		end
		if self.SearchTimer<CurTime() then
			self.SearchTimer = CurTime()+5
			self:EmitSound("ambient/tones/equip2.wav", 60, 150)
		end
		if self.defused>0 then
			if (self.DefuseTimer != nil) then
				if self.DefuseTimer<CurTime() then
					if self.defused>24 then
						self:Explode()
					else
						self.defused = 0
						self:EmitSound("Buttons.snd16")
					end
				end
			end
		end
		self:NextThink(CurTime()+0.02)
		return true
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
				local tr = util.TraceHull({start = self:GetPos(),endpos = self:GetPos() + self:GetUp() * -20,maxs = 2,mins = 2,filter = self})
				if (tr.Hit) then
					if (tr.HitWorld) then
							user:ChatPrint("Trigger armed.")
							self.beamcolor = 1
							self.primed = true
							self:SetSkin(1)
							self:SetPos(tr.HitPos )
							if IsValid(user) and user:IsPlayer() then
								self:SetOwner(user)
							end
							self:GetPhysicsObject():EnableMotion(false)
							if !constraint.FindConstraint(self,"Weld") then
							self.mineweld = constraint.Weld(self,game.GetWorld(),0,0,0,0,0)
							end
							self.defused = 0
							self:EmitSound("Weapon_SLAM.TripMineMode", 50, 200)
					else
						user:ChatPrint("The ground is not solid enough!")
					end
				else
				user:ChatPrint("The mine is not close enough to the ground!")
				end
			else
				self:EmitSound("Weapon_SLAM.TripMineMode", 50, 200)
				user:ChatPrint("Reactivated!")
				self.primed = true
				self:SetSkin(1)
			end
		else
			if (self.defused == 75) then
				self.UseTimer = CurTime()+4.5
				self.primed = false
				self:SetSkin(0)
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
				self.defused = self.defused + 25
				self:EmitSound("Buttons.snd27")
				user:ChatPrint("Trigger disarnament " .. self.defused .. "%")
				self.UseTimer = CurTime()+1
				if self.defused == 25 then
					user:ChatPrint("WARNING! Do not let go! Fuse live!")
				end
			end
		end
	end
end


function ENT:Touch(entity)
	if !constraint.FindConstraint(self,"Weld") then
		self.primed = false
		self:SetSkin(0)
	else
		self.primed = true
		self:SetSkin(1)
	end
	self:Explode()
end
