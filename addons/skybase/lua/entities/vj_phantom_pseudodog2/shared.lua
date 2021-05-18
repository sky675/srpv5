ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Phantom"
ENT.Author 			= "Comrade Communist"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "S.T.A.L.K.E.R"

if CLIENT then
	function ENT:Initialize()
		timer.Simple(0.1,function()
		self.particle = CreateParticleSystem( self, "striderbuster_shotdown_explosion_trail", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,40) )
			  end)

--striderbuster_shotdown_explosion_trail
	end
	function ENT:Think()
	--[[ParticleEffect("striderbuster_shotdown_explosion_trail",self:LocalToWorld(Vector(math.random(1,1),math.random(1,1))),Angle(0,0,0),nil)
	timer.Simple(0.1,function()
		if(self) then
			self.particle = CreateParticleSystem( self, "striderbuster_shotdown_explosion_trail", PATTACH_ABSORIGIN_FOLLOW, 0, Vector(0,0,40) )
		end
end)]]
	end

	
end