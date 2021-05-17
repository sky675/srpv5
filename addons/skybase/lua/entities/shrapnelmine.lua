
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Directed Shrapnel Mine"
ENT.Author			= "PolyMorphic Purple"
ENT.Purpose			= "Used for defense in doorways."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false



if SERVER then

function ENT:Initialize()
self:SetModel("models/props_lab/reciever01a.mdl")
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
local self_name = "Directed Mine" .. self:EntIndex()
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
			self.ropey = constraint.Rope(self,self.stick,0,0,Vector(6,-4.5,0),Vector(1.5,0,-2.8),200,0,10,0.05,"cable/cable2",false)
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

local function find_in_cone(cone_origin, cone_direction, cone_radius, cone_angle)
	local entities = ents.FindInSphere(cone_origin, cone_radius)
	local result = {}
	cone_direction:Normalize()
	local cos = math.cos(cone_angle)
	for _, entity in pairs(entities) do
		local pos = entity:GetPos()
		local dir = pos - cone_origin
		dir:Normalize()
		local dot = cone_direction:Dot(dir)
		if (dot > cos) then
			table.insert(result, entity)
		end
	end

	return result
end


function ENT:Explode()
		self:EmitSound("ambient/explosions/explode_9.wav", 100, 255)
		self:EmitSound("ambient/explosions/explode_7.wav", 100, 255)
		if IsValid(self) then
			local bullet = {}
			bullet.Num = 100
			bullet.Src = self:GetPos()	
			bullet.Dir = self:GetForward() 
			bullet.Spread = Vector( 0.15, 0.15, 0 ) 
			bullet.TracerName = "Tracer"
			bullet.Force = 5 * 0.5
			bullet.Damage = 2
			self:FireBullets(bullet)
			local ED = EffectData()
			ED:SetOrigin(self:GetPos())
			util.Effect("HelicopterMegaBomb", ED)
			util.Effect("Explosion", ED)
			util.BlastDamage(self, self, self:GetPos(), 80, 300)
		end
	SafeRemoveEntityDelayed(self, .5) 
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
					self.ropey = constraint.Rope(self,self.stick,0,0,Vector(6,-4.5,0),Vector(1.5,0,-2.8),self.ropelength,0,10,0.05,"cable/cable2",false)
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