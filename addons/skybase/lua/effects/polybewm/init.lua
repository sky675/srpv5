

function EFFECT:Init(data)
self.Entity 		= data:GetEntity()
self.Pos 		= data:GetOrigin()
self.Scale 		= data:GetScale()
self.Radius 		= data:GetRadius() or 1
self.DirVec 		= data:GetNormal()
self.PenVec 		= data:GetStart()
self.Particles 		= data:GetMagnitude()
self.Angle 		= self.DirVec:Angle()
self.Size 		= 5
self.Emitter 		= ParticleEmitter( self.Pos )
sound.Play( "Explo.ww2bomb", self.Pos)
sound.Play( "ambient/explosions/explode_3.wav", self.Pos, 100, math.random(150,220) )
for i=1,10 do
		local EF = self.Emitter:Add( "effects/muzzleflash"..math.random(1,4), self.Pos )
		if (EF) then
		EF:SetVelocity( self.DirVec*100 )
		EF:SetAirResistance( 200 )
		EF:SetDieTime( 0.3 )
		EF:SetStartAlpha( 255 )
		EF:SetEndAlpha( 0 )
		EF:SetStartSize( 100*self.Scale*0.9)
		EF:SetEndSize( 0 )
		EF:SetRoll(800)
		EF:SetRollDelta( math.random(-1,1) )
		EF:SetColor(255,255,255)	
		end
		end
		for i=0, 45*self.Scale do
		local EF = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (EF) then
		EF:SetVelocity( self.DirVec * math.random( 0,600) + VectorRand():GetNormalized()*100*self.Scale )
		EF:SetDieTime(4)
		EF:SetStartAlpha( 30)
		EF:SetEndAlpha( 0 )
		EF:SetStartSize( 20*self.Scale )
		EF:SetEndSize( 30*self.Scale )
		EF:SetRoll( 37 )
		EF:SetRollDelta( math.random(-1, 1) )			
		EF:SetAirResistance( 200 ) 			 
		EF:SetGravity( Vector( 0, 0, math.random(-50, -200) ) ) 			
		EF:SetColor( 138,138,108 )
		end
		end
		local Angle = self.DirVec:Angle()
		for i=0, 80		do	
		Angle:RotateAroundAxis(Angle:Forward(), (360/30))
		local EF = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (EF) then
		EF:SetVelocity( Angle:Up() * 300 )
		EF:SetDieTime(5)
		EF:SetStartAlpha( 15)
		EF:SetEndAlpha( 0 )
		EF:SetStartSize( 30*self.Scale )
		EF:SetEndSize( 10*self.Scale )
		EF:SetRoll( math.random(0, 360) )
		EF:SetRollDelta( math.random(-1, 1) )			
		EF:SetAirResistance( 200 ) 			 
		EF:SetGravity( Vector( math.random( -50 , 50 ), math.random( -50 , 50 ), math.random( 10 , 50 ) ) )			
		EF:SetColor( 138,138,108 )
		end	
		end
		for i=0, 10*self.Scale do
		local EF = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self.Pos )
		if (EF) then
		EF:SetVelocity(VectorRand():GetNormalized() * 50 )
		EF:SetDieTime(2)
		EF:SetStartAlpha(20)
		EF:SetEndAlpha( 0 )
		EF:SetStartSize( 70*self.Scale )
		EF:SetEndSize( 100*self.Scale )
		EF:SetRoll( math.random(150, 360) )
		EF:SetRollDelta( math.random(-2, 2) )			
		EF:SetAirResistance( 300 ) 			 
		EF:SetGravity( Vector( math.random(-40,40)*self.Scale, math.random(-40,40)*self.Scale, 0 ) ) 			
		EF:SetColor( 138,138,108 )
		end
		end	
		self.Emitter:Finish()
end
 

function EFFECT:Think( )
return false
end

function EFFECT:Render()
end