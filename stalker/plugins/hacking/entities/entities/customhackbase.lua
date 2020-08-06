AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "hacking base"
ENT.Category = "OASIS"
ENT.Author = "sky"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.PhysgunDisable = true
ENT.RenderGroup = RENDERGROUP_OPAQUE

ENT.name = ""
ENT.desc = ""
ENT.hackname = "" --or ENT.hackname = function(self) end
ENT.hacktype = "" --or ENT.hacktype = function(self) end
--[[
ENT.model = ""
ENT.hackTypes = {	
	--contains an onRun = function(self, ply), and level = hack type level

} --table of hacks and what theyll do i guess idk, 

]]


function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 6

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()

	
	if(self.story and ply.notify) then
		ply:notify("hey this is something thats story-related and may contain spoilers, remove it and let it spawn when it needs to be spawned!")
	end


	return ent

end

if(SERVER) then

function ENT:Initialize()
	self:SetModel( self.model or "models/props_interiors/BathTub01a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType( SIMPLE_USE )
	
	if(self.CustomInit) then
		self:CustomInit()
	end

        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end
 
function ENT:Use( activator, caller )

	--?

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
		if(self.hidepopup) then return end --disable
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y


		drawText(self.name or self.PrintName, x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
        y = y+16
        drawText((self.desc or "??"), x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
        y = y+16
        
	end

end