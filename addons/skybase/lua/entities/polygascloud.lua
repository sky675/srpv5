
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Gas Cloud"
ENT.Author			= "Polymorphic Turtle"
ENT.Purpose			= "Commonly used to block off choke points."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= false
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then
function ENT:Draw()
	return
end
function ENT:Initialize()
self:SetModel("models/Items/grenadeAmmo.mdl")
local self_name = "Landmine" .. self:EntIndex()
self:SetName( self_name )
self:SetRenderMode( RENDERMODE_NONE )
self:Activate()
self:Explode()
end

function ENT:Gasdamage(ent)
	if IsValid(ent) then
		if ent:IsPlayer() or ent:IsNPC() and self:Visible(ent) and ent:GetPos():Distance(self:GetPos()) < 200 then
		if IsValid(self.Owner) then
			ent:TakeDamage(0.5+(201-ent:GetPos():Distance(self:GetPos()))*0.005, self.Owner, DMG_NERVEGAS)
		else
			ent:TakeDamage(0.5+(201-ent:GetPos():Distance(self:GetPos()))*0.005, self, DMG_NERVEGAS)
		end
		
		end
	end
end


function ENT:Think()
	if self.Fired then
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 200)) do
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
		self:EmitSound("ambient/machines/steam_release_2.wav", 75, 150)
		self:EmitSound("ambient/machines/steam_release_2.wav", 75, 100)
		self:EmitSound("ambient/machines/steam_release_2.wav", 75, 70)
		smoke = ents.Create("env_smoketrail")
		smoke:SetKeyValue("startsize","50")
		smoke:SetKeyValue("endsize","100")
		smoke:SetKeyValue("spawnradius","100")
		smoke:SetKeyValue("minspeed","1")
		smoke:SetKeyValue("maxspeed","2")
		smoke:SetKeyValue("startcolor", "255 255 255")
		smoke:SetKeyValue("endcolor", "255 255 255")
		smoke:SetKeyValue("opacity","0.25")
		smoke:SetKeyValue("spawnrate","5")
		smoke:SetKeyValue("lifetime","2")
		smoke:SetPos(self:GetPos())
		smoke:SetParent(self)
		smoke:Spawn()
		smoke:Fire("kill","",5+self:GetSkin())
		SafeRemoveEntityDelayed(self, 6+self:GetSkin()) 
	end
end

end


