
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Kerosene Tank"
ENT.Author			= "PolyMorphic Purple"
ENT.Purpose			= "Easily flammable tank of kerosene."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then

function ENT:Initialize()
self:SetModel("models/props_junk/PropaneCanister001a.mdl")
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self:SetCollisionGroup( COLLISION_GROUP_WEAPON )	
self:SetColor( Color(255, 255, 255, 255) )
self:SetPos(self:GetPos()+Vector(0,0,30))
self.FireHealth = 105
self.FireCurTime = CurTime()+2
self.FireSound = CreateSound(self, "ambient/fire/fire_big_loop1.wav")
local phys = self:GetPhysicsObject()	
if (phys:IsValid()) then
	phys:Wake()
	phys:SetMaterial("metal")
end	
local self_name = "Kerosene Tank" .. self:EntIndex()
self:SetName( self_name )
end


end
function ENT:Explode()
	ED = EffectData()
	ED:SetOrigin(self:GetPos())
	
	util.Effect("HelicopterMegaBomb", ED)
	util.BlastDamage(self, self, self:GetPos(), 126, 30)
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 256)) do
		if IsValid(v) then
			if v:GetClass() == "tripwiregrenade" then
				timer.Simple( 0.2, function() if IsValid(v.ropey) then v.ropey:Remove() end end )
			end
		end
	end
	for i=1, 12 do
	local fire = ents.Create( "env_fire" )
	fire:SetPos( self:GetPos() + Vector( math.random( -70, 70 ), math.random( -70, 70 ), math.random(-10,10) ) )
	fire:SetKeyValue( "health", math.random( 5, 10 ) )
	fire:SetKeyValue( "firesize", "100" )
	fire:SetKeyValue( "fireattack", "0.1" )
	fire:SetKeyValue( "damagescale", "5.0" )
	fire:SetKeyValue( "StartDisabled", "0" )
	fire:SetKeyValue( "firetype", "0" )
	fire:SetKeyValue( "spawnflags", "132" )
	fire:Spawn()
	fire:Fire( "StartFire", "", 0.2 )
	self:EmitSound("d1_town.FlameTrapIgnite")
	end
	self.FireSound:Play()
	self.FireSound:FadeOut(20)
	self:Ignite(100)
	SafeRemoveEntityDelayed(self, 20) 
	
	
end
function ENT:Think()

end


function ENT:OnTakeDamage(dmginfo)
	self.FireHealth = self.FireHealth - dmginfo:GetDamage()
	if self.FireHealth<100 and self.FireHealth>50 then
		self:Ignite()
	elseif self.FireHealth<50 and self.FireCurTime<CurTime()and self.FireHealth>1 then
		self:Ignite(30)
		self.FireCurTime = CurTime()+2
		
		for i=1, 3 do
		local fire = ents.Create( "env_fire" )
		fire:SetPos( self:GetPos() + Vector( math.random( -30, 30 ), math.random( -30, 30 ), math.random(-10,10) ) )
		fire:SetKeyValue( "health", math.random( 2, 5 ) )
		fire:SetKeyValue( "firesize", "3" )
		fire:SetKeyValue( "fireattack", "0.1" )
		fire:SetKeyValue( "damagescale", "1.0" )
		fire:SetKeyValue( "StartDisabled", "0" )
		fire:SetKeyValue( "firetype", "0" )
		fire:SetKeyValue( "spawnflags", "132" )
		fire:Spawn()
		fire:Fire( "StartFire", "", 0.2 )
		end
		
	end
	if self.FireHealth<1 and self.FireCurTime<CurTime() then
		if !self.Exploded then
			self.Exploded = true
			self:Explode()
		else
			self.FireCurTime = CurTime()+0.2
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

