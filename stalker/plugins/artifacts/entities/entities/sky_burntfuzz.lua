AddCSLuaFile()
ENT.Base = "base_gmodentity"
ENT.Type = "anim"  
ENT.PrintName		= "Burnt Fuzz" 
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Category		= "STALKER"
ENT.Author			= "sky"
ENT.AutomaticFrameAdvance = true

if(SERVER) then
	hook.Add("PhysgunDrop", "stopburnt", function(ply, ent)
		if(ent:GetClass() == "sky_burntfuzz") then
			ent:GetPhysicsObject():EnableMotion(false) --force freeze
		end
	end)
	hook.Add("PhysgunPickup", "stopburnt", function(ply, ent)
		--only allow if in noclip
		if(ent:GetClass() == "sky_burntfuzz" and ply:GetMoveType() != MOVETYPE_NOCLIP) then
			--ent:GetPhysicsObject():EnableMotion(false) --force freeze
			return false
		end
	end)

	function ENT:Initialize()
		--self:SetMoveType(MOVETYPE_VPHYSICS)  
		--self:SetSolid(SOLID_BBOX)	
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:SetModel("models/wick/wrbstalker/shoc/items/anomaly/wick_topolinypuh.mdl")--models/anomaly/anomaly_fix.mdl")
		self:DrawShadow(false)
		--self:SetCollisionBounds(Vector(-30.94, -40.71, -252.72), Vector(30.26, 30.30, 3.56))
		--self:UseTriggerBounds(true)
		self:PhysicsInitBox(Vector(-30.94, -40.71, -252.72), Vector(30.26, 30.30, 3.56))
		self:SetTrigger(true)
		self:ResetSequence("idle")

		local physobj = self:GetPhysicsObject()
		if(IsValid(physobj)) then
			physobj:EnableCollisions(false)
			physobj:EnableGravity(false)
			physobj:EnableDrag(false)
			physobj:EnableMotion(false)
		end
	end

	local nxt = nxt or 0
	function ENT:Touch(ent)
		if(ent:IsPlayer() and ent:GetMoveType() != MOVETYPE_NOCLIP and nxt < CurTime()) then
			--burnt fuzz dont dmg ppl who are crouching
			if(ent:Crouching() or (ent.IsProne and ent:IsProne())) then return end
			nxt = CurTime() + 2
			
			self:EmitSound("geiger/bfuzz_hit.ogg")
			local info = DamageInfo()
			info:SetAttacker(ent)
			info:SetInflictor(ent)
			info:SetDamage(math.random(30,35))
			info:SetDamageType(DMG_ACID)
			info:SetReportedPosition(ent:GetPos())
			ent:TakeDamageInfo(info)
		end
	end
end