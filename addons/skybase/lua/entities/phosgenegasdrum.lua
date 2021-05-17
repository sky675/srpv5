
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Phosgene Gas"
ENT.Author			= "Polymorphic Turtle"
ENT.Purpose			= "Pacify a crowd of people, more commonly used indoors or against fortifications."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false


if SERVER then

function ENT:Initialize()
	self:SetModel("models/props_c17/oildrum001.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )
	self:SetSkin(5)
	self:SetCollisionGroup(COLLISION_GROUP_NONE )	
	self:SetColor( Color(255, 255, 255, 255) )
	self.enthealth = 70
	self.UseTimer = CurTime()+2
	local phys = self:GetPhysicsObject()	
	if (phys:IsValid()) then
		phys:Wake()
		phys:SetMaterial("metal")
	end	
	local self_name = "Phosgene Gas" .. self:EntIndex()
		self:SetName( self_name )
	end
end

function ENT:Gasdamage(ent)
	if IsValid(ent) then
		if ent:IsPlayer() or ent:IsNPC() and self:Visible(ent) and ent:GetPos():Distance(self:GetPos()) < 400 then
		ent:TakeDamage(0.5+(401-ent:GetPos():Distance(self:GetPos()))*0.005, self, DMG_NERVEGAS)
		end
	end
end


function ENT:Think()
	if self.Fired then
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 400)) do
				if IsValid(v) then
					if v:IsNPC() or v:IsPlayer() then
						self:Gasdamage(v)
					end
				end
			end
	end
end

function ENT:Explode()
if !self.Fired then
		self.Fired = true
		self:EmitSound("ambient/machines/steam_release_2.wav", 75, 100)
		self:EmitSound("ambient/machines/steam_release_2.wav", 75, 50)
		self:EmitSound("ambient/machines/steam_release_2.wav", 75, 30)
		smoke = ents.Create("env_smoketrail")
		smoke:SetKeyValue("startsize","126")
		smoke:SetKeyValue("endsize","256")
		smoke:SetKeyValue("spawnradius","200")
		smoke:SetKeyValue("minspeed","1")
		smoke:SetKeyValue("maxspeed","2")
		smoke:SetKeyValue("startcolor", "255 255 255")
		smoke:SetKeyValue("endcolor", "255 255 255")
		smoke:SetKeyValue("opacity","0.3")
		smoke:SetKeyValue("spawnrate","20")
		smoke:SetKeyValue("lifetime","5")
		smoke:SetPos(self:GetPos())
		smoke:SetParent(self)
		smoke:Spawn()
		smoke:Fire("kill","",29)
		SafeRemoveEntityDelayed(self, 30) 
	end
end

function ENT:Use(user)
	if user:IsPlayer() and self.UseTimer<CurTime() then
		self.UseTimer = CurTime()+1
		if !self.primed then
		user:ChatPrint("Valve safety removed.")
		self.primed = 1
		elseif self.primed == 1 then
		user:ChatPrint("Secondary safety removed.")
		self.primed = 2
		elseif self.primed == 2 then
		user:ChatPrint("Valve opened.")
		self:Explode()
		self.primed = 3
		end
	end
end


function ENT:OnTakeDamage(dmginfo)
		self.enthealth = self.enthealth - dmginfo:GetDamage()
		self:EmitSound("ambient/machines/steam_release_2.wav", 50, 200)
		smoke = ents.Create("env_smoketrail")
		smoke:SetKeyValue("startsize","50")
		smoke:SetKeyValue("endsize","50")
		smoke:SetKeyValue("spawnradius","30")
		smoke:SetKeyValue("minspeed","1")
		smoke:SetKeyValue("maxspeed","2")
		smoke:SetKeyValue("startcolor", "255 255 255")
		smoke:SetKeyValue("endcolor", "255 255 255")
		smoke:SetKeyValue("opacity","0.3")
		smoke:SetKeyValue("spawnrate","5")
		smoke:SetKeyValue("lifetime","1")
		smoke:SetPos(self:GetPos())
		smoke:SetParent(self)
		smoke:Spawn()
		smoke:Fire("kill","",1)
		if self.primed == 2 then
			self.primed = 3
			self:Explode()
		end
		if self.enthealth<1 and self.primed != 3 then
			self.primed = 3
			self:Explode()
		end
end