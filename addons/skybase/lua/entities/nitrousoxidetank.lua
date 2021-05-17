
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Nitrous Oxide Jet"
ENT.Author			= "PolyMorphic Purple"
ENT.Purpose			= "Used for defense in doorways."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false


local fireloop = Sound("fire_large")

if SERVER then

function ENT:Initialize()
self:SetModel("models/props_canal/mattpipe.mdl")
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
			self.tank = ents.Create("prop_physics") 
			self.tank:SetPos(self:GetPos())
			self.tank:SetModel("models/props_junk/PropaneCanister001a.mdl")
			self.tank:SetModelScale(0.5,0)
			self.tank:SetAngles(self:GetAngles())
			self.tank:SetParent(self)
			self.tank:SetLocalPos(Vector(0.5,0,-6))
			self.tank:SetSkin(1)
			self.tank.Owner = self
			self.tank:Spawn()
			constraint.Weld(self.tank,self,0,0,0,0,0)
			self.tank:SetParent(nil)
			self.stick = ents.Create("prop_physics") 
			self.stick:SetPos(self:GetPos()+Vector(0,0,30))
			self.stick:SetModel("models/props_wasteland/prison_throwswitchbase001.mdl")
			self.stick.Owner = self
			self.stick:Spawn()
			self.ropey = constraint.Rope(self,self.stick,0,0,Vector(3.5,0,-18),Vector(1.5,0,-2.8),200,0,10,0.05,"cable/cable2",false)
			self.primed = true
			self.Entity:SetTrigger( true )
			self.UseTimer = CurTime()+2
		else
			self.stick = constraint.FindConstraint(self,"Rope").Ent2
			if constraint.FindConstraint(self,"Weld").Ent2:GetModel() == "models/props_junk/PropaneCanister001a.mdl" then
			self.tank = constraint.FindConstraint(self,"Weld").Ent2
			end
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
	self:EmitSound("coast.gaspump_ignite")
	self:EmitSound(fireloop)
	
	timer.Create( "none", 0.005, 110, function()
		if IsValid(self) then
			local tracey = {}
			tracey.start = self:GetPos()	
			tracey.endpos = self:GetPos()+self:GetUp()*300
			tracey.filter =  { self, self.stick, self.tank }
			local tr = util.TraceLine(tracey)
			local length = (self:GetPos() - tr.HitPos):Length()
			local ED = EffectData()
			ED:SetOrigin(tr.HitPos)
			ED:SetScale(length+2)
			ED:SetStart(self:GetPos())
			ED:SetNormal(self:GetUp() )
			util.Effect( "NO2", ED )
			for k, v in pairs(find_in_cone(self:GetPos(),self:GetUp(),300,math.pi/9.5 )) do
				if IsValid(v) then
					if v:IsNPC() or v:IsPlayer() then
						v:Ignite(10)
						v:TakeDamage(1, self, DMG_FIRE)
					end
				end
			end
			for k, v in pairs(find_in_cone(self:GetPos(),self:GetUp(),100,math.pi/4.8 )) do
				if IsValid(v) then
					if v:IsNPC() or v:IsPlayer() then
						v:Ignite(10)
						v:TakeDamage(2, self, DMG_FIRE)
					end
				end
			end
		end
	end)
	ED = EffectData()
	ED:SetOrigin(self:GetPos())
	util.Effect("HelicopterMegaBomb  ", ED)
	
	self:Ignite(100)
	SafeRemoveEntityDelayed(self, 5) 
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
		trace.filter = { self, self.stick, self.tank }
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
					self.ropey = constraint.Rope(self,self.stick,0,0,Vector(3.5,0,-18),Vector(1.5,0,-2.8),self.ropelength,5,10,0.05,"cable/cable2",false)
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
	if IsValid( self.tank ) then
		self.tank:Remove()		
	end
	self:StopSound(fireloop)
	if self.broken then
		self:EmitSound("ambient/explosions/explode_5.wav",100,200)
		ED = EffectData()
		ED:SetOrigin(self:GetPos())
		util.Effect("HelicopterMegaBomb", ED)
		util.Effect("Sparks", ED)
		for i=1,7 do
			local fire = ents.Create( "env_fire" )
			fire:SetPos( self:GetPos() + Vector( math.random( -40, 40 ), math.random( -40, 40 ), math.random(-10,10) ) )
			fire:SetKeyValue( "health", 1 )
			fire:SetKeyValue( "firesize", "30" )
			fire:SetKeyValue( "fireattack", "0.1" )
			fire:SetKeyValue( "damagescale", "5.0" )
			fire:SetKeyValue( "StartDisabled", "0" )
			fire:SetKeyValue( "firetype", "0" )
			fire:SetKeyValue( "spawnflags", "132" )
			fire:Spawn()
			fire:Fire( "StartFire", "", 0.2 )
		end
	end
end