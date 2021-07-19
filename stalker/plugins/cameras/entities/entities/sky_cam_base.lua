AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "cam base"
ENT.Category = "STALKER"
ENT.Author = "sky"
ENT.Spawnable = false
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Base = "customhackbase"

ENT.hidepopup = true
ENT.hackname = function(self) return "camera-id"..self:GetIndex() end
ENT.hacktype = "Camera" --or ENT.hacktype = function(self) end

ENT.model = "models/props_borealis/bluebarrel001.mdl"
ENT.hackTypes = {	
	--do hacks here?
	--disable cam
	--change circuit id
	--self destruct
	["act"] = {
		onRun = function(self, ply)
			self:EmitSound("buttons/combine_button_locked.wav", 80)
		end,
		level = 1,
	}
	--contains an onRun = function(self, ply), and level = hack type level

} --table of hacks and what theyll do i guess idk, 

function ENT:CustomInit()
	self:SetHP(40) --todo config?
end

game.AddParticles("particles/fire_01.pcf")
PrecacheParticleSystem("smoke_gib_01")

ENT.Editable = true
function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Destroyed")
	self:NetworkVar("Int", 0, "HP", {KeyName = "camhp", Edit = {type = "Int", max = 40}}) --again change?
	self:NetworkVar("String", 0, "CircuitID", {KeyName = "circuitid", Edit = {type = "Generic", waitforenter = true}})
	
	--if(SERVER) then
		self:NetworkVarNotify("Destroyed", self.OnVarDestroyed)
	--end
end

--offset for viewing through cam
ENT.viewOffset = Vector(0,0,0)
ENT.anglOffset = Angle(0,0,0)

if(SERVER) then
	function ENT:OnVarDestroyed(name, old, new)
		--[[if(old == new) then return end --uh ye just in case
		if(new == true) then
			--destroy effects
			local cd = EffectData()
			cd:SetOrigin(self:GetPos()+Vector(0, -12, 4))
			cd:SetAngles(self:GetAngles())
			cd:SetMagnitude(math.random(2,3))

			util.Effect("ElectricSpark", cd)

			--todo: figure out if this loops?
			--ParticleEffect("smoke_gib_01", self:GetPos()+Vector(0, 0, 12), self:GetAngles():Up():Angle(), self)

		else
			--disable above effects
		end]]
	end

	function ENT:FixCamera(customhp)
		self:SetHP(customhp or 40)
		self:SetDestroyed(false)
	end
	function ENT:BreakCamera(dontset0)
		if(!dontset0) then self:SetHP(0) end
		self:SetDestroyed(true)
	end

	function ENT:OnTakeDamage(dmginfo)
		if(self:GetDestroyed()) then return end --ye no reason lol
		local new = self:GetHP() - dmginfo:GetDamage()
		if(new <= 0) then
			self:BreakCamera()
			return
		end
		self:SetHP(new)
	end
else--client
	ENT.relativeAtt = Vector(0, 0, 0) --vector where smoke should appear
	ENT.relativeSpark = Vector(0, 0, 0) --vector where spark should appear

	hook.Add("NetworkEntityCreated", "setdestroyed", function(ent)
		if(ent.Base != "sky_cam_base" && ent:GetClass() != "sky_cam_base") then return end
		--idk if i need to do this but eh
		if(ent:GetDestroyed()) then
			if(!IsValid(self.particle)) then
				self.particle = CreateParticleSystem(self, "smoke_gib_01", PATTACH_ABSORIGIN_FOLLOW, nil, self.relativeAtt)
			else
				return
			end
			if(self.particle) then 
				self.particle:StartEmission(true) 
			end --idk if thisll loop?
		end
	end)

	function ENT:OnVarDestroyed(name, old, new)
		if(old == new) then return end --uh ye just in case
		if(new == true) then
			--destroy effects
			local cd = EffectData()
			cd:SetOrigin(self:GetPos()+self.relativeSpark)
			cd:SetAngles(self:GetAngles())
			cd:SetMagnitude(math.random(2,3))

			util.Effect("ElectricSpark", cd)

			--todo: idk if thisll work?
			self.particle = CreateParticleSystem(self, "smoke_gib_01", PATTACH_ABSORIGIN_FOLLOW, nil, self.relativeAtt)
			if(self.particle) then 
				self.particle:StartEmission(true) 
			end --idk if thisll loop?

		else
			--disable above effects
			if(IsValid(self.particle)) then
				self.particle:StopEmissionAndDestroyImmediately()
			end
		end
	end
end