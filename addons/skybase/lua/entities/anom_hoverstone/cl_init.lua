
include('shared.lua')

function ENT:Initialize()

	self.Emitter = ParticleEmitter( self.Entity:GetPos() )
	self.Dist = self.Entity:OBBCenter():Distance( self.Entity:OBBMaxs() )

end

function ENT:OnRemove()

	if self.Emitter then
	
		self.Emitter:Finish()
		
	end

end

function ENT:Think()
	
	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 3000) then
		if(!IsValid(self.Emitter) or !self.Emitter) then
			self.Emitter = ParticleEmitter(self.Entity:GetPos())
		end

		local particle = self.Emitter:Add( "effects/muzzleflash"..math.random(1,4), self.Entity:LocalToWorld( self.Entity:OBBCenter() ) + VectorRand() * self.Dist )
		
		particle:SetVelocity( VectorRand() * 10 ) 
		particle:SetLifeTime( 0 )  
		particle:SetDieTime( math.Rand( 0.50, 0.75 ) ) 
		particle:SetStartAlpha( 30 ) 
		particle:SetEndAlpha( 0 ) 
		particle:SetStartSize( math.random( 15, 30 ) ) 
		particle:SetEndSize( math.random( 3, 6 ) ) 
		particle:SetColor( 100, math.random( 100, 150 ), math.random( 150, 250 ) )
		particle:SetAirResistance( 50 )
	end	
end

function ENT:Draw()
	local mypos = self:GetPos()
	local dist = LocalPlayer():GetPos():Distance(mypos)
	
	if(dist < 3000) then
		self.Entity:DrawModel()
	end
end

