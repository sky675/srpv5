if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
include('shared.lua')
/*--------------------------------------------------
	=============== Spawner Base ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to make spawners
--------------------------------------------------*/

function ENT:Think()
	local Emitter = ParticleEmitter(self:GetPos(), false)
	if(IsValid(Emitter)) then
		local Particles = Emitter:Add( "sprites/heatwave", self:GetPos() + Vector(math.Rand(-0,0),math.Rand(-0,0),math.Rand(25,25)))
		Particles:SetDieTime( 0.7 )
		Particles:SetStartAlpha( 0 )
		Particles:SetEndAlpha( 10 )
		Particles:SetStartSize( 10 )
		Particles:SetEndSize( 0.1 )
		Particles:SetColor( 0,0,0 )
		Particles:SetGravity(Vector(0,0,0))
		Particles:SetVelocity((-self:GetVelocity():GetNormalized()*math.random(20,30)) + Vector(math.random(-14,14),math.random(-14,14),math.random(54,54)))
		Particles:SetCollide(false)	
		Emitter:Finish()
	end
end
