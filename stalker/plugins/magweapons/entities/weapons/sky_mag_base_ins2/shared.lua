DEFINE_BASECLASS("tfa_gun_base")--"tfa_bash_base")

SWEP.UseHands = true
SWEP.DrawCrosshair = false

SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.DrawAmmo = false
--[[ --needed
SWEP.MagType = ""
]]

--agh

SWEP.SmokeParticles = {
	pistol = "tfa_ins2_weapon_muzzle_smoke",
	smg = "tfa_ins2_weapon_muzzle_smoke",
	grenade = "tfa_ins2_weapon_muzzle_smoke",
	ar2 = "tfa_ins2_weapon_muzzle_smoke",
	shotgun = "tfa_ins2_weapon_muzzle_smoke",
	rpg = "tfa_ins2_weapon_muzzle_smoke",
	physgun = "tfa_ins2_weapon_muzzle_smoke",
	crossbow = "tfa_ins2_weapon_muzzle_smoke",
	melee = "tfa_ins2_weapon_muzzle_smoke",
	slam = "tfa_ins2_weapon_muzzle_smoke",
	normal = "tfa_ins2_weapon_muzzle_smoke",
	melee2 = "tfa_ins2_weapon_muzzle_smoke",
	knife = "tfa_ins2_weapon_muzzle_smoke",
	duel = "tfa_ins2_weapon_muzzle_smoke",
	camera = "tfa_ins2_weapon_muzzle_smoke",
	magic = "tfa_ins2_weapon_muzzle_smoke",
	revolver = "tfa_ins2_weapon_muzzle_smoke",
	silenced = "tfa_ins2_weapon_muzzle_smoke",
	pistol_2handd = "tfa_ins2_weapon_muzzle_smoke",
}
--overwrite
SWEP.IronSightHoldTypes = {
	pistol = "revolver",
	smg = "rpg",
	grenade = "melee",
	ar2 = "rpg",
	shotgun = "ar2",
	rpg = "rpg",
	physgun = "physgun",
	crossbow = "ar2",
	melee = "melee2",
	slam = "camera",
	normal = "fist",
	melee2 = "magic",
	knife = "fist",
	duel = "duel",
	camera = "camera",
	magic = "magic",
	revolver = "revolver",
	pistol_2handd = "revolver",
}

SWEP.SprintHoldTypes = {
	pistol = "normal",
	smg = "passive",
	grenade = "normal",
	ar2 = "passive",
	shotgun = "passive",
	rpg = "passive",
	physgun = "normal",
	crossbow = "passive",
	melee = "normal",
	slam = "normal",
	normal = "normal",
	melee2 = "melee",
	knife = "fist",
	duel = "normal",
	camera = "slam",
	magic = "normal",
	revolver = "normal",
	pistol_2handd = "normal",
}

SWEP.ReloadHoldTypes = {
	pistol = "pistol",
	smg = "smg",
	grenade = "melee",
	ar2 = "ar2",
	shotgun = "shotgun",
	rpg = "ar2",
	physgun = "physgun",
	crossbow = "crossbow",
	melee = "pistol",
	slam = "smg",
	normal = "pistol",
	melee2 = "pistol",
	knife = "pistol",
	duel = "duel",
	camera = "pistol",
	magic = "pistol",
	revolver = "revolver",
	pistol_2handd = "pistol_2handd",
}



SWEP.CanJam = false --i already had a jamming thing

local degradetest = function()
	print("does this even do anything")
	if(util.NetworkStringToID("srpDeg") != 0) then
		local start = net.Start("srpDeg")
		net.WriteEntity(LocalPlayer():GetActiveWeapon())
		net.SendToServer()
	end
end

SWEP.ironDown = false

local irontest = function(wep) --TFA.Enum.STATUS_SHOOTING
	timer.Simple(0.01, function()
	if(wep:GetStatus() == 11 and !wep.ironDown) then
		print("ugh")
		wep.ironDown = true
		degradetest()
	elseif(wep:GetStatus() != 11) then
		wep.ironDown = false
		print("ughhhhh")
	end
end)
end

hook.Add("TFA_GetStat", "overridesight", function(self, stat)
	if(type(self) == "string") then return end --like why?
	
	if(stat == "VElements.sight.active") then
		return (self.IronSightsProgress or 0) > 0.6
	end
end)

--[[
local oldthink = SWEP.Think
function SWEP:Think()
	if(oldthink) then
	oldthink(self)
	end

	if(CLIENT) then
		--print("uh ", self:GetStat("VElements.sight.active"), self.IronSightsProgress)
		if(self.VElements and self.VElements.sight and self.IronSightsProgress) then
			if(self.IronSightsProgress > 0.5 and !self.VElements.sight.active) then
				self.VElements.sight.active = true
			elseif(self.IronSightsProgress < 0.5 and self.VElements.sight.active) then
				self.VElements.sight.active = false
			end
		end
	end
end]]
--[[ --this is so annoying
SWEP.EventTable = {
	--[[[ACT_VM_PRIMARYATTACK] = {
		{['time'] = 0.01, ['type'] = "lua", ['value'] = degradetest, ['client'] = true, ['server'] = false}
	},]]
	--[[[174] = {
		{['time'] = 0.01, ['type'] = "lua", ['value'] = irontest, ['client'] = true, ['server'] = false}
	}]]
	--[[[ACT_VM_IRON_FIRE] = {
		{['time'] = 0.01, ['type'] = "lua", ['value'] = degradetest, ['client'] = true, ['server'] = false}
	},
	[ACT_VM_IRON_FIRE_LAST] = {
		{['time'] = 0.01, ['type'] = "lua", ['value'] = degradetest, ['client'] = true, ['server'] = false}
	},
	[ACT_VM_PRIMARYATTACK_EMPTY] = {
		{['time'] = 0.01, ['type'] = "lua", ['value'] = degradetest, ['client'] = true, ['server'] = false}
	},]]
--}


--forgot about the loud is sounds
SWEP.IronInSound = "SKY_TFAQuietIronIn"
SWEP.IronOutSound = "SKY_TFAQuietIronOut"

SWEP.Secondary.BashEnd = 0.9
SWEP.Secondary.BashDelay = 0.05

local dryfire_cvar = GetConVar("sv_tfa_allow_dryfire")
local l_CT = CurTime

--fuck you
hook.Add("TFA_PreDeploy", "givemeammo", function(self)
	if(!nut) then return end
	if(self.Base != "sky_mag_base_ins2") then return end
	if(self.gaveammo) then return end --only do once

	if(self:Clip1() == 0 and self:Ammo1() != 0) then --it does this every time
		local ammo = self:Ammo1()
		self:SetClip1(self:Ammo1())
		
		self:TakePrimaryAmmo(ammo, true)
		self.gaveammo = true
	end
	local oldpen = self.MainBullet.Ricochet
	function self.MainBullet:Ricochet(ply, tr, dmginfo, wep)
		if(tr.Entity and tr.Entity:IsPlayer()) then
			return true
		end
		oldpen(self, ply, tr, dmginfo, wep)
	end
end)

hook.Add("TFA_Deploy", "setatts", function(self)
	if(nut and self.toadd) then
		timer.Simple(0.1, function()
		for k,v in pairs(self.toadd) do
			if(v == nil) then continue end --just realized this is useless but watever
			local vl = self:Attach(v)
			--print(vl)
		end
		self.toadd = nil
		end)
	end
	--get mag count
	if(self.DoMagCount) then
		self:DoMagCount()
	end
end)

if(netstream and CLIENT) then
	netstream.Hook("DoMagCount", function()
		--print("hi hello?")
		timer.Simple(0, function()
		local client = LocalPlayer()
		if(client:getChar()) then
			local wep = client:GetActiveWeapon()
			if(wep.IsTFAWeapon and wep.DoMagCount) then --if the weapon whos mag they dropped isnt the active weapon, it will be gotten when its deployed again
				wep:DoMagCount()
			end
		end
		end)
	end)
	netstream.Hook("GiveMagCount", function(c)
		LocalPlayer():GetActiveWeapon().magCache = c
	end)
end


function SWEP:DoMagCount()
	if(!nut) then return end
	if(!self:GetOwner() or !self:GetOwner():getChar()) then return end
	local inv = self:GetOwner():getChar():getInv()
	local count = 0
	local rnds = 0
	for k,v in pairs(inv:getItems()) do
		if(v.uniqueID == self:GetStat("MagType") and v:getData("type") == self:GetStat("SpecAmmo")) then
			if(v:getData("mag", 0) > 0) then
				count = count + 1
				rnds = rnds + v:getData("mag", 0)
			end
		end
	end
	--print("uhhhhh"..self.magCache,rnds)

	self.magCache = string.find(self:GetStat("MagType"), "ammo_") and rnds or count

	if(SERVER and netstream) then
		netstream.Start(self:GetOwner(), "GiveMagCount", self.magCache)
	end
end

function SWEP:GetMagCount()
	if(!nut) then return self:Ammo1() end

	return (string.find(self:GetStat("MagType"), "ammo_") and "AMMO: " or "MAG COUNT: ")..tostring(self.magCache or 0)
end

hook.Add("TFA_DrawHUDAmmo", "ammoismags", function(self, xx, yy, myalpha)
	if(!nut) then return end
	if(self.Base != "sky_mag_base_ins2") then return end
	--this will need to be changed whenever they change the base code
	if self.InspectingProgress < 0.01 and self:GetStat("Primary.Ammo") ~= "" and self:GetStat("Primary.Ammo") ~= 0 then
		local str

		if self:GetStat("Primary.ClipSize") and self:GetStat("Primary.ClipSize") ~= -1 then
			if self:GetStat("Akimbo") then
				str = string.upper("MAG: " .. math.ceil(self:Clip1() / 2))

				if (self:Clip1() > self:GetStat("Primary.ClipSize")) then
					str = string.upper("MAG: " .. math.ceil(self:Clip1() / 2) - 1 .. " + " .. (math.ceil(self:Clip1() / 2) - math.ceil(self:GetStat("Primary.ClipSize") / 2)))
				end
			else
				str = string.upper("MAG: " .. self:Clip1())

				if (self:Clip1() > self:GetStat("Primary.ClipSize")) then
					str = string.upper("MAG: " .. self:GetStat("Primary.ClipSize") .. " + " .. (self:Clip1() - self:GetStat("Primary.ClipSize")))
				end
			end

			draw.DrawText(str, "TFASleek", xx + 1, yy + 1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
			draw.DrawText(str, "TFASleek", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT)
			str = self:GetMagCount() --string.upper("RESERVE: " .. self:GetMagCount())
			yy = yy + TFA.Fonts.SleekHeight
			xx = xx - TFA.Fonts.SleekHeight / 3
			draw.DrawText(str, "TFASleekMedium", xx + 1, yy + 1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
			draw.DrawText(str, "TFASleekMedium", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT)
			yy = yy + TFA.Fonts.SleekHeightMedium
			xx = xx - TFA.Fonts.SleekHeightMedium / 3
		else
			str = string.upper("AMMO: " .. self:Ammo1())
			draw.DrawText(str, "TFASleek", xx + 1, yy + 1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
			draw.DrawText(str, "TFASleek", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT)
			yy = yy + TFA.Fonts.SleekHeightMedium
			xx = xx - TFA.Fonts.SleekHeightMedium / 3
		end

		str = string.upper(self:GetFireModeName() .. (#self:GetStat("FireModes") > 2 and " | +" or ""))

		if self:IsJammed() then
			str = str .. '\nWeapon is jammed!'
		end

		draw.DrawText(str, "TFASleekSmall", xx + 1, yy + 1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
		draw.DrawText(str, "TFASleekSmall", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT)
		yy = yy + TFA.Fonts.SleekHeightSmall
		xx = xx - TFA.Fonts.SleekHeightSmall / 3
		local angpos2

		if self:GetStat("Akimbo") then
			angpos2 = self:GetOwner():ShouldDrawLocalPlayer() and self:GetAttachment(2) or self.OwnerViewModel:GetAttachment(2)
		else
			angpos2 = self:GetOwner():ShouldDrawLocalPlayer() and self:GetAttachment(self.MuzzleAttachmentRaw or self:LookupAttachment(self.MuzzleAttachment)) or self:GetOwner():GetViewModel():GetAttachment(self.MuzzleAttachmentRaw or self:GetOwner():GetViewModel():LookupAttachment(self.MuzzleAttachment))
		end

		if angpos2 then
			local pos2 = angpos2.Pos
			local ts2 = pos2:ToScreen()

			if self:GetStat("Akimbo") then
				xx, yy = ts2.x, ts2.y

				if self:GetStat("Primary.ClipSize") and self:GetStat("Primary.ClipSize") ~= -1 then
					str = string.upper("MAG: " .. math.floor(self:Clip1() / 2))

					if (math.floor(self:Clip1() / 2) > math.floor(self:GetStat("Primary.ClipSize") / 2)) then
						str = string.upper("MAG: " .. math.floor(self:Clip1() / 2) - 1 .. " + " .. (math.floor(self:Clip1() / 2) - math.floor(self:GetStat("Primary.ClipSize") / 2)))
					end

					draw.DrawText(str, "TFASleek", xx + 1, yy + 1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
					draw.DrawText(str, "TFASleek", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT)
					str = string.upper("RESERVE: " .. self:Ammo1())
					yy = yy + TFA.Fonts.SleekHeight
					xx = xx - TFA.Fonts.SleekHeight / 3
					draw.DrawText(str, "TFASleekMedium", xx + 1, yy + 1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
					draw.DrawText(str, "TFASleekMedium", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT)
					yy = yy + TFA.Fonts.SleekHeightMedium
					xx = xx - TFA.Fonts.SleekHeightMedium / 3
				else
					str = string.upper("AMMO: " .. self:Ammo1())
					draw.DrawText(str, "TFASleek", xx + 1, yy + 1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
					draw.DrawText(str, "TFASleek", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT)
					yy = yy + TFA.Fonts.SleekHeightMedium
					xx = xx - TFA.Fonts.SleekHeightMedium / 3
				end

				str = string.upper(self:GetFireModeName() .. (#self.FireModes > 2 and " | +" or ""))
				draw.DrawText(str, "TFASleekSmall", xx + 1, yy + 1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
				draw.DrawText(str, "TFASleekSmall", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT)
			end
		end

		if self:GetStat("Secondary.Ammo") and self:GetStat("Secondary.Ammo") ~= "" and self:GetStat("Secondary.Ammo") ~= "none" and self:GetStat("Secondary.Ammo") ~= 0 and not self:GetStat("Akimbo") then
			if self:GetStat("Secondary.ClipSize") and self:GetStat("Secondary.ClipSize") ~= -1 then
				str = (self:Clip2() > self:GetStat("Secondary.ClipSize")) and string.upper("ALT-MAG: " .. self:GetStat("Secondary.ClipSize") .. " + " .. (self:Clip2() - self:GetStat("Primary.ClipSize"))) or string.upper("ALT-MAG: " .. self:Clip2())
				draw.DrawText(str, "TFASleekSmall", xx + 1, yy + 1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
				draw.DrawText(str, "TFASleekSmall", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT)
				str = string.upper("ALT-RESERVE: " .. self:Ammo2())
				yy = yy + TFA.Fonts.SleekHeightSmall
				xx = xx - TFA.Fonts.SleekHeightSmall / 3
				draw.DrawText(str, "TFASleekSmall", xx + 1, yy + 1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
				draw.DrawText(str, "TFASleekSmall", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT)
			else
				str = string.upper("ALT-AMMO: " .. self:Ammo2())
				draw.DrawText(str, "TFASleekSmall", xx + 1, yy + 1, ColorAlpha(self.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
				draw.DrawText(str, "TFASleekSmall", xx, yy, ColorAlpha(self.TextCol, myalpha), TEXT_ALIGN_RIGHT)
			end
		end
	end

	return false
end)

function SWEP:Reload(released)
	if self.Owner:IsNPC() then
		return
	end
	if not self:VMIV() then return end

	if self:GetStat("Primary.ClipSize") < 0 then return end
	if ( not released ) and ( not self:GetLegacyReloads() ) then return end
	if self:GetLegacyReloads() and not  dryfire_cvar:GetBool() and not self:GetOwner():KeyDown(IN_RELOAD) then return end
	if self:GetOwner():KeyDown(IN_USE) then return end

	local mag
	local inv
	local count = 0
	local mags = {}

	if(!nut) then
		if self:Ammo1() <= 0 then return end
	else
		if(self.Owner:getChar()) then
			inv = self.Owner:getChar():getInv()

			if(!inv:hasItem( self:GetStat("MagType"))) then 
				self.magCache = 0
				return 
			end--, {type = self:GetStat("SpecAmmo")})) then return end
			if(self:getNetVar("magid")) then
				mag = nut.item.instances[self:getNetVar("magid")]
				--if the mag has nothing left or doesnt exist anymore
				if(!mag or mag:getData("type") != self:GetStat("SpecAmmo") or mag:getData("mag", 0) == 0) then --nvm
					mag = nil
				end

			end
			
			--moved this out becuz its now needed even when were not getting these mags
			--mags = {}
			--count = 0
			for k,v in pairs(inv:getItems()) do
				if(v.uniqueID == self:GetStat("MagType") and v:getData("type") == self:GetStat("SpecAmmo")) then
					if(!self.Owner:getNutData("normalreload")) then
						local cnt = v:getData("mag")
						--just skip if this mag is full
						if(cnt == self.Primary.ClipSize) then mag = v break end
						local needed = self.Primary.ClipSize
						--i dont like doing this here but fuck it lmao
						for k2,v2 in pairs(inv:getItems()) do
							--looking for magazines that are ammoboxes, have the same ammo type and special ammo type as the weapon, and arent empty
							if(v2.base == "base_magazines" and v2.ammoBox and v2.ammoType == self.Primary.Ammo and v2:getData("type") == self:GetStat("SpecAmmo") and v2:getData("mag") > 0) then
								--less ammo than required (or exact)
								if(v2:getData("mag") <= needed) then
									cnt = cnt + v2:getData("mag")
									needed = needed - v2:getData("mag")
									v2:remove() --remove as normally it would do this otherwise
								else --else is fine
									cnt = self.Primary.ClipSize
									v2:setData("mag", v2:getData("mag")-needed)
									break
								end
							end
						end
						if(cnt == 0) then return end --no ammo
						v:setData("mag", cnt)
						mag = v
						break
					end
					if(v:getData("mag", 0) > 0) then
						table.insert(mags, v)
						count = count + v:getData("mag", 0)
						--if no valid mags left and this one is empty
					end
				end
			end



			if(!mag) then
			table.sort(mags, function(a, b) return a:getData("mag", 0) > b:getData("mag", 0) end)
			mag = mags[1] --get first one
			end
			
			if(!mag) then return end
		else
			return
		end
	end


	ct = l_CT()
	stat = self:GetStatus()

	if self.PumpAction and self:GetShotgunCancel() then
		if stat == TFA.Enum.STATUS_IDLE then
			self:DoPump()
		end
	elseif TFA.Enum.ReadyStatus[stat] or ( stat == TFA.Enum.STATUS_SHOOTING and self:CanInterruptShooting() ) then
		if(self.EmptyReloadOnly and self:Clip1() != 0) then return end
		
		if self:Clip1() < self:GetPrimaryClipSize() then
			if self.Shotgun then
				success, tanim = self:ChooseShotgunReloadAnim()
				if(mag) then
					local ammo = mag:getData("mag", 0)
					if(SERVER) then
						self.Owner:GiveAmmo(1, mag.ammoType)

					mag:setData("mag", ammo-1)

					self:setNetVar("magid", mag.id, self.Owner)
					end
				end
				if(self.nutItem and self.nutItem:getData("unloaded")) then
					self.nutItem:setData("unloaded")
				end
				--self.Jammed = false
				self.magCache = string.find(self:GetStat("MagType"), "ammo_") and count-1 or table.Count(mags)

				
				if(SERVER and netstream) then
					netstream.Start(self:GetOwner(), "GiveMagCount", self.magCache)
				end
				
				if self.ShotgunEmptyAnim  then
					local _, tg = self:ChooseAnimation( "reload_empty" )
					if tanim == tg and self.ShotgunEmptyAnim_Shell then
						self:SetStatus(TFA.Enum.STATUS_RELOADING_SHOTGUN_START_SHELL)
					else
						self:SetStatus(TFA.Enum.STATUS_RELOADING_SHOTGUN_START)
					end
				else
					self:SetStatus(TFA.Enum.STATUS_RELOADING_SHOTGUN_START)
				end
				if(self:GetStat("ProceduralReloadEnabled")) then
					self:SetStatusEnd(ct + self:GetStat("ProceduralReloadTime"))
				else
					self:SetStatusEnd(ct + self:GetActivityLength( tanim, true ))
				end
				--self:SetNextPrimaryFire(ct + self:GetActivityLength( tanim, false ) )
			else
				success, tanim = self:ChooseReloadAnim()
				if(mag && self.DoubleB) then
					local ammoNum = mag:getData("mag", 0)
					--self.Jammed = false
					if(self:Clip1() == 0 and ammoNum >= 2) then
						if(SERVER) then
						self.Owner:GiveAmmo(2, mag.ammoType)

						mag:setData("mag", ammoNum - 2)
						end
						
						self.magCache = string.find(self:GetStat("MagType"), "ammo_") and count-2 or (table.Count(mags)-remthis)
		
					elseif(self:Clip1() == 1 and ammoNum >= 1) then
						if(SERVER) then
						self.Owner:GiveAmmo(1, mag.ammoType)

						mag:setData("mag", ammoNum - 1)
						end
						
						self.magCache = string.find(self:GetStat("MagType"), "ammo_") and count-1 or (table.Count(mags)-remthis)
		
					end
					if(self.nutItem and self.nutItem:getData("unloaded")) then
						self.nutItem:setData("unloaded")
					end
				elseif(mag && self:GetStat("OneShot")) then
					local ammo = mag:getData("mag", 0)
					if(SERVER) then
						self.Owner:GiveAmmo(1, mag.ammoType)

		  				mag:setData("mag", ammo-1)
					end
				elseif(mag && self:GetStat("QuadB")) then --ohjeez
					local ammoNum = mag:getData("mag", 0)
					--self.Jammed = false
					if(self:Clip1() == 0 and ammoNum >= 4) then
						if(SERVER) then
						self.Owner:GiveAmmo(4, mag.ammoType)

						mag:setData("mag", ammoNum - 4)
						end
					elseif(self:Clip1() == 1 and ammoNum >= 3) then
						if(SERVER) then
						self.Owner:GiveAmmo(3, mag.ammoType)

						mag:setData("mag", ammoNum - 3)
						end
					elseif(self:Clip1() == 2 and ammoNum >= 2) then
						if(SERVER) then
						self.Owner:GiveAmmo(2, mag.ammoType)

						mag:setData("mag", ammoNum - 2)
						end
					elseif(self:Clip1() == 3 and ammoNum >= 1) then
						if(SERVER) then
						self.Owner:GiveAmmo(1, mag.ammoType)

						mag:setData("mag", ammoNum - 1)
						end
					end
				elseif(mag) then
					local ammoNum = mag:getData("mag", 0)
					local oldclip = self:Clip1()
					if(SERVER) then --lol
					self.Owner:GiveAmmo(ammoNum, mag.ammoType) --todo load mag?
					end
					local magw, magh = mag.width, mag.height
					if(!CLIENT) then
					mag:remove()

					local givemag = self:Clip1()
					if(self:CanChamber() and self:Clip1() != 0) then
						givemag = givemag - 1
					end

					local give = true
					if(self.nutItem and self.nutItem:getData("unloaded")) then
						give = false
						self.nutItem:setData("unloaded")
					end
						

					if(give) then
					--if(inv:findEmptySlot(magw, magh)) then
					if(!inv:add( self:GetStat("MagType"), 1, {mag = math.Clamp(givemag, 0, self:GetMaxClip1()), type = self:GetStat("SpecAmmo")})) then
					--else
						nut.item.spawn( self:GetStat("MagType"), self.Owner:GetPos(), nil, self.Owner:GetAngles() {mag = math.Clamp(givemag, 0, self:GetMaxClip1()), type = self:GetStat("SpecAmmo")})
					end
					end
					end
					--self.Jammed = false

					if(self:Clip1() != 0) then
						self:SetClip1(1)
					end

					if(!self:CanChamber()) then
						self:SetClip1(0)
					end
					
				local remthis = 0
				if(oldclip == 0) then
					remthis = 1
				end
				self.magCache = string.find(self:GetStat("MagType"), "ammo_") and count-1 or (table.Count(mags)-remthis)

				end

				self:SetStatus(TFA.Enum.STATUS_RELOADING)
				if self:GetStat("ProceduralReloadEnabled") then
					self:SetStatusEnd(ct + self:GetStat("ProceduralReloadTime"))
				else
					self:SetStatusEnd(ct + self:GetActivityLength( tanim, true ) )
					self:SetNextPrimaryFire(ct + self:GetActivityLength( tanim, false ) )
				end
			end
			if ( not game.SinglePlayer() ) or ( not self:IsFirstPerson() ) then
				self:GetOwner():SetAnimation(PLAYER_RELOAD)
			end
			if self:GetStat("Primary.ReloadSound") and IsFirstTimePredicted() then
				self:EmitSound(self:GetStat("Primary.ReloadSound"))
			end
			self:SetNextPrimaryFire( -1 )
		elseif released or self:GetOwner():KeyPressed(IN_RELOAD) then--if self:GetOwner():KeyPressed(IN_RELOAD) or not self:GetLegacyReloads() then
			self:CheckAmmo()
		end
	end
end

--figure out what this does?????????
function SWEP:CompleteReload()
	if self.Owner:IsNPC() then
		return
	end
	local maxclip = self:GetPrimaryClipSizeForReload( true ) --they added on forreload
	local curclip = self:Clip1()
	local amounttoreplace = math.min(maxclip - curclip, self:Ammo1())
	self:TakePrimaryAmmo(amounttoreplace * -1) --dont understand
	self:TakePrimaryAmmo(amounttoreplace, true) --and this, esp the true part??
	self:SetJammed(false)
end

function SWEP:LoadShell( )
	if self.Owner:IsNPC() then
		return
	end
	--success, tanim = self:ChooseReloadAnim()
	
	if(nut) then
		if(SERVER) then
		local mag = nut.item.instances[self:getNetVar("magid")]
		local inv = self.Owner:getChar():getInv()
		if(!inv:hasItem( self:GetStat("MagType"), {type = self:GetStat("SpecAmmo")})) then return end
				
		if(!mag) then return end

		
		if(self:GetShotgunCancel() or self:Clip1() >= self:GetPrimaryClipSize()-1) then
			--return TFA.Enum.STATUS_RELOADING_SHOTGUN_END
		else        --mebi???
			if(mag and self:Ammo1() < 1) then
				local ammo = mag:getData("mag", 0)
					self.Owner:GiveAmmo(1, mag.ammoType)
					mag:setData("mag", ammo-1)
					--self.Jammed = false
					self:SetShotgunCancel(true)
					
					--this is janky as fuck but until they add a think hook theres nothing better, i REALLY dont wanna override the think
	local _, tanim = self:ChooseReloadAnim()
	if self:GetActivityLength(tanim,true) < self:GetActivityLength(tanim,false) then
		self:SetStatusEnd(ct + self:GetActivityLength( tanim, true ) )
	else
		sht = self:GetStat("ShellTime")
		if sht then sht = sht / self:GetAnimationRate(ACT_VM_RELOAD) end
		self:SetStatusEnd(ct + ( sht or self:GetActivityLength( tanim, true ) ) )
	end
	return TFA.Enum.STATUS_RELOADING_SHOTGUN_END
				end
			end
		end
	end

	return BaseClass.LoadShell(self)	
end

function SWEP:IsJammed() --lmao fuck you not adding a way to do it ourselves
	return self:GetJammed()
end

function SWEP:CanPrimaryAttack()
	--[[if(self:GetNWBool("nutJammed")) then--self.Jammed) then --if already jammed
		if self:GetOwner():KeyPressed(IN_ATTACK) then
			self:ChooseDryFireAnim()
		end
		if not self.HasPlayedEmptyClick then
			self:EmitSound("Weapon_Pistol.Empty2")
			self.HasPlayedEmptyClick = true
		end
	
		return false
	end]]
	

	--self.HasPlayedEmptyClick = false

	local ranJam = false
	--here random value based on durability
	if(nut) then
		local dura
		if(self.nutItem and self:Clip1() != (self:GetMaxClip1()+1)) then
			local itm = self.nutItem

			if(itm) then
				dura = itm:getData("durability")
			end

			if(dura and dura < 90) then 
				if(math.random(0, dura*4) == 0) then
					ranJam = true
				end
			end
		end
	end

	if(ranJam) then
		print("jammed")
		self:SetJammed(true)
		--self.Jammed = true
		--[[if self:GetOwner():KeyPressed(IN_ATTACK) then
			self:ChooseDryFireAnim()
		end
		if not self.HasPlayedEmptyClick then
			self:EmitSound("Weapon_Pistol.Empty2")
			self.HasPlayedEmptyClick = true
		end
		return false]]
	end

	return BaseClass.CanPrimaryAttack(self)
end
--[[
if(SERVER) then
	function SWEP:CustomBulletCallback(tr, dmg, ent)
	if(tr.Hit and !tr.HitWorld and tr.HitBox != nil and tr.Entity:IsPlayer()) then
		--print("hit"..tr.PhysicsBone..type(tr.Entity))--tr.Entity:GetHitBoxBone(tr.Hitbox))
		if(nut and nut.newchar.isBM(tr.Entity:GetModel()) and !string.find(tr.Entity:GetModel(), "heads/")) then
			hook.Run("GSDamage", tr.Entity, tr.PhysicsBone, dmg)
		end
	end			
	end
end
]]

if(SERVER) then
	
end

--overriding this because by now the player is actually firing
function SWEP:ShootBulletInformation()
	if(SERVER and IsFirstTimePredicted()) then
		--durability removal
		hook.Run("OnFireBullet", self:GetOwner(), self)

		if(self.nutItem and nut.config.get("durability", false)) then
			local item = self.nutItem
			local dura = item:getData("durability")
			local newDura = dura or 100

			if(dura) then
				--remove here
				--the 22 is kinda arbitrary tbh, increase = degrades slower
				local torem = math.max(0.0001, (((((self:GetStat("Primary.RPM")/60)/100)+self:GetStat("Primary.Damage"))/newDura)/(22*item:getData("incD",1))))
			--	print(self:GetStat("Primary.ClipSize"), self:GetStat("Primary.Damage"), newDura)
			--	print("cur dura: "..tostring(newDura).."to remove: "..tostring(torem))
				torem = torem * (self:GetStat("DuraMulti") or 1)

				newDura = newDura-torem

				item:setData("durability", newDura)

				if(newDura <= 0) then
					item:setData("broken", true)
					self:GetOwner():notify("Your "..self.PrintName.." has broken!")
					item:Unequip(self:GetOwner())
					return
				end
			end
		end
	end
	

	BaseClass.ShootBulletInformation(self)
end

