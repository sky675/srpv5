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
		local Particles = Emitter:Add( "sprites/heatwave", self:GetPos() + Vector(math.random(-15,15),math.random(-15,15),math.random(-15,15)))
		Particles:SetDieTime( 0.7 )
		Particles:SetStartAlpha( 255 )
		Particles:SetEndAlpha( 10 )
		Particles:SetStartSize( 10 )
		Particles:SetEndSize( 0.1 )
		Particles:SetColor( 255,255,255 )
		Particles:SetGravity(Vector(0,0,0))
		Particles:SetVelocity((-self:GetVelocity():GetNormalized()*math.random(30,40)) + Vector(math.random(-24,24),math.random(-24,24),math.random(-24,24)))
		Particles:SetCollide(false)	
		Emitter:Finish()
	end
end

function ENT:Draw()
	cam.Start3D()
		render.SetMaterial( Material("sprites/heatwave") )
		render.DrawSprite( self:GetPos(), 70, 70, Color(255,175,25,155) ) -- Draw the sprite in the middle of the map, at 16x16 in it's original colour with full alpha.
	cam.End3D()
end
