
function EFFECT:Render()
end

function EFFECT:Init( data )
	local Velocity = (data:GetNormal() + Vector(math.Rand(-0.04,0.04),math.Rand(-0.04,0.04),math.Rand(-0.04,0.04))) * data:GetScale()/0.5
	local DieTime = data:GetScale()/Velocity:Length()+0.01
	local emitter = ParticleEmitter(data:GetStart()+data:GetNormal() )
	for i=0, 2 do
		local flame = emitter:Add("sprites/heatwave",data:GetStart()+data:GetNormal() +  data:GetNormal() * i)
		flame:SetVelocity(Velocity)
		flame:SetDieTime(DieTime)
		flame:SetStartAlpha( 250 )
		flame:SetStartSize( 2 )
		flame:SetEndSize( 20 )
		flame:SetRoll( math.random( 0, 360 ) )
		flame:SetRollDelta( math.random( -0.5, 0.5 ) )
		flame:SetColor( 255, 255, 255 )
	end
	for i=1,40 do
		local flame = emitter:Add( "particles/flamelet"..math.random( 1, 5 ),data:GetStart()+data:GetNormal()+data:GetNormal()*i)
		flame:SetVelocity(Velocity)
		flame:SetDieTime(DieTime)
		flame:SetStartAlpha( 30 )
		flame:SetStartSize( .7 )
		flame:SetEndSize( math.random( 15, 20 ) )
		flame:SetRoll(math.random( 0, 360 ) )
		flame:SetRollDelta( math.random( -1, 1 ) )
		flame:SetColor(math.random( 160, 230 ), math.random( 120, 130 ), math.random(110,130) )
	end
	for i=0,10 do
		local flame = emitter:Add( "particles/flamelet"..math.random( 1, 5 ),data:GetStart()+data:GetNormal()+data:GetNormal()*i)
		flame:SetVelocity( data:GetNormal() *  (0.5*data:GetScale()/0.4))
		flame:SetDieTime(DieTime)
		flame:SetStartAlpha( 255 )
		flame:SetStartSize( 0.5*i )
		flame:SetEndSize( 5 )
		flame:SetRoll( 30 )
		flame:SetRollDelta( math.Rand( -0.5, 0.5 ) )
		flame:SetColor( 30, math.random(25,50), math.random( 50, 160 ) )
	end		
	emitter:Finish()
end
