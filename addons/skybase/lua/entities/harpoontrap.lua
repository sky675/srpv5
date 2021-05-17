
AddCSLuaFile()

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Harpoon Stick Trap"
ENT.Author			= "Polymorphic Turtle"
ENT.Purpose			= "Commonly used to halt enemy movement."
ENT.Category		= "PolyTraps"

ENT.Spawnable		= true
ENT.AdminOnly		= false

ENT.nonlaunch = false

if SERVER then
function ENT:Initialize()
self:SetModel("models/props_junk/harpoon002a.mdl")
self:PhysicsInit( SOLID_VPHYSICS )
self:SetMoveType( MOVETYPE_VPHYSICS )
self:SetSolid( SOLID_VPHYSICS )
self:DrawShadow( false )
self.Entity:SetTrigger( true )
self:SetColor( Color(255, 255, 255, 255) )
self.UseTimer = CurTime()
self.defused = 0
local phys = self:GetPhysicsObject()	
if (phys:IsValid()) then
	phys:Wake()
	phys:SetMaterial("metal")
end	
local self_name = "Landmine" .. self:EntIndex()
self:SetName( self_name )
self:Activate()
if !constraint.HasConstraints(self) then 
self:SetPos(self:GetPos()+self:GetUp()*10)
else
self.primed = true
end
end
end


function ENT:Think()
if self.primed and self.defused>0 then
	if (self.DefuseTimer != nil) then
		if self.DefuseTimer<CurTime() then
			self.defused = 0
			self:EmitSound("Buttons.snd16")
		end
	end
end
self:NextThink( CurTime() + 0.1 )
return true
end

function ENT:Use(user)
	if user:IsPlayer() and self.primed and self.defused>0 then
		self.DefuseTimer = CurTime()+0.1
	end
	if user:IsPlayer() and self.UseTimer<CurTime() then
		targetguy = user
		self.UseTimer = CurTime()+2.5
		if self.primed != true then
			if !constraint.HasConstraints(self) then 
				local tr = util.TraceHull({start = self:GetPos(),endpos = self:GetPos() + self:GetForward() * -120,maxs = 1,mins = 1,filter = self})
				if (tr.Hit) then
					if (tr.HitWorld) then
						user:ChatPrint("Spike Deployed.")
						self.primed = true
						self:SetPos(tr.HitPos)
						if !IsValid(self.mineweld) then
							self.mineweld = constraint.Weld(self,game.GetWorld(),0,0,0,0,0)
						end
						if IsValid(user) and user:IsPlayer() then
							self:SetOwner(user)
						end
						self:GetPhysicsObject():EnableMotion(true)
						self:GetPhysicsObject():Wake()
						self.defused = 0
						self:EmitSound("Weapon_SLAM.TripMineMode", 50, 200)
					else
						user:ChatPrint("The ground is not solid enough!")
					end
				else
				user:ChatPrint("The spike is not close enough to the ground!")
				end
			else
				self.primed = true
			end
		else
			if (self.defused==75) then
				self.primed = false
				user:ChatPrint("Stick dismantling 100%")
				user:ChatPrint("Stick dismantled.")
				self:EmitSound("Wood.Break")
				SafeRemoveEntityDelayed(self, 0.1) 
			else
				self.defused = self.defused + 25
				self:EmitSound("Wood_Solid.BulletImpact")
				user:ChatPrint("Stick dismantling " .. self.defused .. "%")
				self.UseTimer = CurTime()+.5
			end
		end
	end
end


function ENT:Touch(entity)
	if IsValid(entity) then
		if constraint.HasConstraints(self) and !self.primed then 
			self.primed = true
			self.UseTimer = CurTime()+0.05
		end
		if self.primed and self.UseTimer<CurTime() and entity:GetVelocity():Length()*0.05>2 then
			self.UseTimer = CurTime()+0.5
			if IsValid(self.Owner) then
			entity:TakeDamage(entity:GetVelocity():Length()*0.12, self.Owner, DMG_SLASH)
			else
			entity:TakeDamage(entity:GetVelocity():Length()*0.12, self, DMG_SLASH)
			end
			if entity:IsPlayer() then
				entity:ViewPunch( Angle( -10, 0, 0 ) )
				entity:EmitSound("Flesh.Break")
			elseif entity:IsNPC() then
				entity:EmitSound("Flesh.Break")
			end
			self:EmitSound("Metal.SawbladeStick")
			if IsValid(entity:GetPhysicsObject()) then
				if entity:GetPhysicsObject():GetMass()>80 and entity:GetVelocity():Length()*0.12>60 then
					self:EmitSound("Wood.Break")
					SafeRemoveEntityDelayed(self, 0.1) 
				elseif entity:GetPhysicsObject():GetMass()>400 then
					self:EmitSound("Wood.Break")
					SafeRemoveEntityDelayed(self, 0.1) 
				end
			end
		end
	end
end
