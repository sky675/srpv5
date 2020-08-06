AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "crafting base"
ENT.Category = "OASIS"
ENT.Author = "sky"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.PhysgunDisable = true
ENT.RenderGroup = RENDERGROUP_OPAQUE

ENT.name = ""
ENT.desc = ""
ENT.type = ""


function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 6

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()

	return ent

end

if(SERVER) then

function ENT:Initialize()
 
	self:SetModel( self.model or "models/props_interiors/BathTub01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
    self:SetUseType( SIMPLE_USE )

        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end
 
function ENT:Use( activator, caller )

	net.Start("OpenCraft")
	net.WriteString(self.type)
	net.WriteString(self.name)
	net.WriteEntity(self)
	net.Send(caller)

end

else --client

function ENT:Draw()
    self:DrawModel()

    --draw 3d ui mebi idk
end

	ENT.DrawEntityInfo = true

	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	function ENT:onDrawEntityInfo(alpha)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y


		drawText(self.name or self.PrintName, x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
        y = y+16
        drawText((self.desc or "??"), x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
        y = y+16
        
	end

end