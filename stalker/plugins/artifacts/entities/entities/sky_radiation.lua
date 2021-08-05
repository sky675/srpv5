AddCSLuaFile()
ENT.Base = "base_gmodentity"
ENT.Type = "anim"  
ENT.PrintName		= "Radiation Field" 
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Category		= "STALKER"
ENT.Author			= "sky"
ENT.AutomaticFrameAdvance = true
ENT.Editable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Damage", {
		KeyName = "raddmg", 
		Edit = {
			type = "Int",
			min = 0, max = 10
		}
	})
	self:NetworkVar("Int", 1, "Radius", {
		KeyName = "radrad", 
		Edit = {
			type = "Int",
			min = 0, max = 1000
		}
	})
end

if(SERVER) then
	util.AddNetworkString("doradsnd")
	
	function ENT:Initialize()
		self:SetMoveType(MOVETYPE_NONE)  
		self:SetSolid(SOLID_BBOX)	
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		self:SetModel("models/props_c17/oildrum001.mdl")--models/anomaly/anomaly_fix.mdl")
		self:SetRenderMode(RENDERMODE_ENVIROMENTAL)
		self:DrawShadow(false)
		--defaults
		self:SetRadius(250)
		self:SetDamage(3)
	end

	function ENT:Think()
		if(!self.actualradius) then
			self.actualradius = self:GetRadius()*self:GetRadius()
		end

		for k,v in ipairs(player.GetAll()) do
			if(v:GetMoveType() == MOVETYPE_NOCLIP) then continue end
			local dist = v:GetPos():DistToSqr(self:GetPos())
			if(dist <= self.actualradius) then
				local radres = v:GetArmorResists()[DMG_RADIATION] or 0
				--33% less
				local baseline = -0.2-(radres*0.8) --old full force base: 0.2-(radres*1.2)
				local mult = baseline+(1-dist/self.actualradius)
				--print("within 250 ", mult)
				if(mult <= 0) then continue end
				local realdmg = self:GetDamage()*mult
				v:getChar():addRad(realdmg)--TakeDamage(realdmg)
				net.Start("doradsnd")
				net.WriteFloat(mult) --3 base, todo scale
				net.Send(v)
			end
		end
		
		self:NextThink(CurTime()+1)
		return true
	end

	if(PermaProps) then
		local function save(ent)
			local content = {}
			content.Other = {rad = ent:GetRadius(), dmg = ent:GetDamage()}
	
			return content
		end
		local function spawn(ent, data)
			if !data or !istable( data ) then 
				//print("uh load no data")
				ent:Spawn()
				return 
			end
	
			ent:Spawn()
	
			if(data.rad) then
				ent:SetRadius(data.rad)
			end
			if(data.dmg) then
				ent:SetDamage(data.dmg)
			end
		end
	
		PermaProps.SpecialENTSSave["sky_radiation"] = save
		PermaProps.SpecialENTSSpawn["sky_radiation"] = spawn
	end
else
	language.Add ("sky_radiation", "Radiation")

	local sndmax = {
		"geiger/geiger_6.ogg",
		"geiger/geiger_7.ogg",
	}
	local sndhigh = {
		"geiger/geiger_5.ogg",
		"geiger/geiger_4.ogg",
	}
	local sndmed = {
		"geiger/geiger_4.ogg",
		"geiger/geiger_3.ogg",
	}
	local sndlow = {
		"geiger/geiger_1.ogg",
		"geiger/geiger_2.ogg",
		"geiger/geiger_8.ogg",
	}

	net.Receive("doradsnd", function()
		local dmg = net.ReadFloat()
		if(dmg > 1) then
			surface.PlaySound(sndmax[math.random(#sndmax)])
		elseif(dmg > 0.7) then --high
			surface.PlaySound(sndhigh[math.random(#sndhigh)])
		elseif(dmg > 0.4) then --med
			surface.PlaySound(sndmed[math.random(#sndmed)])
		else
			surface.PlaySound(sndlow[math.random(#sndlow)])
		end
		--surface.PlaySound(snds[math.random(#snds)])
	end)	
end