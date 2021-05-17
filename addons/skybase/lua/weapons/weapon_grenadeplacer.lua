if SERVER then
	AddCSLuaFile( "weapon_grenadeplacer.lua" )
end
     
   
     
if CLIENT then
	SWEP.PrintName    = "Tripwire Grenade"
	SWEP.Slot         = 2
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV                    = 70
	SWEP.Spawnable = true
end

SWEP.ViewModel	= "models/weapons/cstrike/c_eq_fraggrenade.mdl"
SWEP.WorldModel	= "models/weapons/w_eq_fraggrenade.mdl"
SWEP.FiresUnderwater = false
SWEP.UseHands = true
SWEP.Primary.ClipSize	= 0 
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic	= false  
SWEP.HoldType	= "grenade"
SWEP.Ammo = "slam"

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	return true
end
     
function SWEP:SecondaryAttack()
	return false
end    
     

     
function SWEP:PrimaryAttack()
	self:Grenade(self.Owner)
	self.Weapon:SetNextPrimaryFire(CurTime())
end
     
function SWEP:Grenade(ply)
	if SERVER then
		if !IsValid(self.Owner) then return end
			if !IsValid(self.c_Model2) then
				local trace = {}
				trace.start = self.Owner:GetShootPos()
				trace.endpos = trace.start + self.Owner:GetAimVector() * 60
				trace.filter = { self.Owner, self.Weapon }
				trace.mask = MASK_SOLID
			local tr = util.TraceLine( trace )
			if tr.HitWorld then
				if !IsValid(self.c_Model) then
					self.c_Model = ents.Create("prop_physics")
					local tr_ent = util.TraceEntity(trace, self.c_Model)
					if tr_ent.HitWorld then
						grenadeang = tr_ent.HitNormal:Angle()
						grenadeang.p = grenadeang.p + 90
						grenadepos = tr_ent.HitPos + (tr_ent.HitNormal * -0.2)
						self.c_Model = ents.Create("prop_physics") 
						self.c_Model:SetPos(grenadepos)
						self.c_Model:SetAngles(grenadeang)
						self.c_Model:SetModel("models/weapons/w_eq_fraggrenade.mdl")
						self.c_Model:PhysicsInit(SOLID_NONE) 
						self.c_Model:SetMoveType(MOVETYPE_NONE)
						self.c_Model:SetCollisionGroup( COLLISION_GROUP_WEAPON )	
						self.c_Model:Spawn()
						self.c_Model:GetPhysicsObject():EnableMotion(false)
						self.c_Model:SetRenderMode( RENDERMODE_TRANSALPHA )
						self.c_Model:SetColor(Color(255,255,255,100 ))
						self.cmodeltimer=CurTime()+5
						self.Owner:ChatPrint("Grenade placed.")
					end
				elseif IsValid(self.c_Model) and !IsValid(self.c_Model2)then
					self.c_Model2 = ents.Create("prop_physics")
					local tr_ent = util.TraceEntity(trace, self.c_Model2)
					if tr_ent.HitWorld then
						if grenadepos:Distance(tr.HitPos)<190 then
							stickang = tr_ent.HitNormal:Angle()
							stickang.r = stickang.r + 90
							stickang.p = stickang.p + 90
							stickpos = tr_ent.HitPos + (tr_ent.HitNormal*3)
							self.c_Model2:SetPos(stickpos)
							self.c_Model2:SetAngles(stickang)
							self.c_Model2:SetModel("models/props_c17/TrapPropeller_Lever.mdl")
							self.c_Model2:PhysicsInit(SOLID_NONE) 
							self.c_Model2:SetMoveType(MOVETYPE_NONE)
							self.c_Model2:SetCollisionGroup( COLLISION_GROUP_WEAPON )	
							self.c_Model2:Spawn()
							self.c_Model2:GetPhysicsObject():EnableMotion(false)
							self.c_Model2:SetRenderMode( RENDERMODE_TRANSALPHA )
							self.c_Model2:SetColor(Color(255,255,255,100 ))
							self.Owner:ChatPrint("Tripwire Placed.")
						else
							self.c_Model2:Remove()
							self.Owner:ChatPrint("Too far from grenade!")
						end
					end
				end
			end
		else
			local grenade = ents.Create("tripwiregrenade")
			grenade:SetPos(grenadepos)
			grenade:SetVar("Placed", 1)
			grenade.stickpos = stickpos
			grenade.stickang = stickang
			grenade:SetAngles(grenadeang)
			grenade:Spawn()
			constraint.Weld(grenade,game.GetWorld(),0,0,0,0,0)
			self:EmitSound("buttons/lever8.wav")
			if IsValid(self.c_Model) then
				self.c_Model:Remove() 
			end
			if IsValid(self.c_Model2) then
				self.c_Model2:Remove() 
			end
			self:SendWeaponAnim(ACT_VM_THROW)
			SafeRemoveEntityDelayed(self, 0.5) 
		end
	end
end

function SWEP:Think()
	if IsValid(self.c_Model) and (self.c_Model:GetPos():Distance(self.Owner:GetPos())>220 or self.cmodeltimer<CurTime())then
		if IsValid(self.c_Model) then
			self.c_Model:Remove() 
		end
		if IsValid(self.c_Model2) then
			self.c_Model2:Remove() 
		end
	end
end


function SWEP:Reload()
	if IsValid(self.c_Model) then
		self.c_Model:Remove() 
	end
    if IsValid(self.c_Model2) then
		self.c_Model2:Remove() 
	end
end

function SWEP:OnRemove()
	if IsValid(self.c_Model) then
		self.c_Model:Remove() 
	end
    if IsValid(self.c_Model2) then
		self.c_Model2:Remove() 
	end
end

function SWEP:Holster()
	if IsValid(self.c_Model) then
		self.c_Model:Remove() 
	end
    if IsValid(self.c_Model2) then
		self.c_Model2:Remove() 
	end
	return true
end
