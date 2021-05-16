local PLUGIN = PLUGIN
PLUGIN.name = "arccw support"
PLUGIN.author = "sky"
PLUGIN.desc = "adds support for arccw weps+atts, no mags (for now..)"

nut.util.include("sh_hooks.lua")
nut.util.include("sh_config.lua")
nut.util.include("sh_patch.lua")
nut.util.include("sv_dura.lua")


--notes:
--[[todo:
- finish weapons+atts in general
- add ammo items (put in a config?) - set up config to do items
]]


--test force show/showhealth off to make sure its good now

--convars to change:
--arccw_truenames 1
--arccw_clicktocycle 1 maybe too idk lol
--these are clientside only, so need a way to be forced serverside somehow?
--they can be changed serverside, but id rather not change players personal settings
--may have to use a special base to override the related funcs
--arccw_attinv_onlyinspect 1 -- this i think is mostly fixed below
--arccw_autosave 0 --THIS however can only be fixed by changing the var
--these i believe have been rendered useless, however will need to see:
--arccw_hud_forceshow 1 --tho this and below may need to be something else, 
--arccw_hud_showhealth 0 -- ns's hook needs to somehow be ran before theirs

--allowed weapons per supp: can be used for things as needed but ya
--this works
local suppAllow = {
	--can also be a table of slot = id to restrict to certain atts already installed
	--[[["supp"] = {
		["weapon"] = true,
		or
		["weapon"] = {
			["slot"] = "id"
		}
		or
		["weapon"] = {
			["slot"] = {["validid1"] = true, ["validid2"] = true}
		}
	},]]
	["go_supp_osprey"]= {
		--9mm
		["arccw_go_glock"] = {
			["go_glock_mag"] = { ["none"] = true, ["go_glock_mag_28"] = true, }
		},
		["arccw_go_m9"] = true,
		["arccw_go_cz75"] = true,
		["arccw_go_p2000"] = true,
		["arccw_go_p250"] = {
			["go_p250_mag"] = { ["go_p250_mag_15_9mm"] = true, ["go_p250_mag_24_9mm"] = true, }
		},
		["arccw_go_usp"] = {
			["go_usp_mag"] = { ["go_usp_mag_15_9"] = true, ["go_usp_mag_25_9"] = true }
		},
		["arccw_mifl_fas2_p226"] = true,
		["arccw_go_mp5"] = true,
		["arccw_go_ump"] = {
			["go_ump_mag"] = {["go_ump_mag_30_9mm"] = true}
		},
		["arccw_go_mp9"] = true,
		["arccw_go_m249para"] = {
			["go_m249_mag"] = {["go_m249_mag_9_200"] = true}
		},
		["arccw_go_aug"] = {
			["go_aug_9mm"] = {["go_aug_ammo_9mm"] = true}
		},
		["arccw_mifl_fas2_ak47"] = {
			["mifl_fas2_ak_mag"] = {["mifl_fas2_ak_mag_919_30"] = true, ["mifl_fas2_ak_mag_919_50"] = true,}
		},
		["arccw_bo2_browninghp"] = true,
		["arccw_bo1_uzi"] = true,
	},
	["go_supp_ssq"] = {
		--45
		["arccw_go_glock"] = {
			["go_glock_mag"] = { ["go_glock_mag_13_45acp"] = true, ["go_glock_mag_26_45acp"] = true, }
		},
		["arccw_go_usp"] = {
			["go_usp_mag"] = { ["none"] = true, ["go_usp_mag_20"] = true }
		},
		["arccw_go_p250"] = {
			["go_p250_mag"] = { ["go_p250_mag_9_45acp"] = true, ["go_p250_mag_15_45acp"] = true, }
		},
		["arccw_mifl_fas2_m1911"] = true,
		["arccw_go_ump"] = {
			["go_ump_mag"] = {["none"] = true}
		},
		["arccw_go_mac10"] = true,
		--57 (ughhhh)
		["arccw_go_fiveseven"] = true,
		["arccw_go_p90"] = true,
		--762x51
		["arccw_go_negev"] = true,
		["arccw_go_fnfal"] = true,
		["arccw_go_scar"] = {
			["go_scar_mag"] = {["none"] = true}
		},
		["arccw_go_ssg08"] = true,
		["arccw_mifl_fas2_m24"] = true,
		["arccw_mifl_fas2_sr25"] = true,
		["arccw_mifl_fas2_g3"] = true,

	},
	["go_supp_monster"] = {
		--46
		["arccw_go_mp7"] = true,
		--556
		["arccw_go_m249para"] = {
			["go_m249_mag"] = {["none"] = true}
		},
		["arccw_go_aug"] = {
			["go_aug_9mm"] = {["none"] = true}
		},
		["arccw_go_scar"] = {
			["go_scar_mag"] = {["go_scar_mag_30_556"] = true, ["go_scar_mag_60_556"] = true}
		},
		["arccw_go_ace"] = {
			["go_ace_mag"] = {["none"] = true}
		},
		["arccw_go_galil_ar"] = true,
		["arccw_mifl_fas2_famas"] = true,
		["arccw_mifl_fas2_g36c"] = true,
		["arccw_mifl_fas2_sg55x"] = true,
		["arccw_mifl_fas2_m4a1"] = true,
	},
	["go_supp_nt4"] = {
		--556
		["arccw_go_m249para"] = {
			["go_m249_mag"] = {["none"] = true}
		},
		["arccw_go_aug"] = {
			["go_aug_9mm"] = {["none"] = true}
		},
		["arccw_go_scar"] = {
			["go_scar_mag"] = {["go_scar_mag_30_556"] = true, ["go_scar_mag_60_556"] = true}
		},
		["arccw_go_ace"] = {
			["go_ace_mag"] = {["none"] = true}
		},
		["arccw_go_galil_ar"] = true,
		["arccw_mifl_fas2_famas"] = true,
		["arccw_mifl_fas2_g36c"] = true,
		["arccw_mifl_fas2_sg55x"] = true,
		["arccw_mifl_fas2_m4a1"] = true,
	},
	["go_supp_rotor43"] = {
		--556
		["arccw_go_m249para"] = {
			["go_m249_mag"] = {["none"] = true}
		},
		["arccw_go_aug"] = {
			["go_aug_9mm"] = {["none"] = true}
		},
		["arccw_go_scar"] = {
			["go_scar_mag"] = {["go_scar_mag_30_556"] = true, ["go_scar_mag_60_556"] = true}
		},
		["arccw_go_ace"] = true,
		["arccw_go_galil_ar"] = true,
		["arccw_mifl_fas2_famas"] = true,
		["arccw_mifl_fas2_g36c"] = true,
		["arccw_mifl_fas2_sg55x"] = true,
		["arccw_mifl_fas2_m4a1"] = true,
		--762x39
		["arccw_mifl_fas2_ak47"] = {
			["mifl_fas2_ak_mag"] = {["none"] = true, ["mifl_fas2_ak_mag_762_45"] = true, ["mifl_fas2_ak_mag_82"] = true}
		},
		["arccw_mifl_fas2_rpk"] = true,
	},
	["go_supp_pbs1"] = {
		--762x39
		["arccw_mifl_fas2_ak47"] = {
			["mifl_fas2_ak_mag"] = {["none"] = true, ["mifl_fas2_ak_mag_762_45"] = true,}
		},
		["arccw_mifl_fas2_rpk"] = true,
	},
	["go_supp_tgpa"] = {
		--545
		["arccw_mifl_fas2_ak47"] = {
			["mifl_fas2_ak_mag"] = {["mifl_fas2_ak_mag_545"] = true, ["mifl_fas2_ak_mag_545_45"] = true,}
		},
		["arccw_eap_aek"] =true,
		--762x54
		["arccw_temp_mosin"]=true,
	},
	["go_supp_pbs4"] = {
		--545
		["arccw_mifl_fas2_ak47"] = {
			["mifl_fas2_ak_mag"] = {["mifl_fas2_ak_mag_545"] = true, ["mifl_fas2_ak_mag_545_45"] = true,}
		},
		["arccw_eap_aek"] =true,
	},

	["go_stock_moe"] = {
		["arccw_go_bizon"] = true,
		["arccw_go_m1014"] = true,
		["arccw_go_870"] = true,
		["arccw_go_nova"] = true,
		["arccw_go_ace"] = true,
		["arccw_mifl_fas2_m4a1"] = true,
		["arccw_mifl_fas2_ak47"] = true,
		["arccw_mifl_fas2_rpk"] = true,
		["arccw_mifl_fas2_sr25"] = true,
		["arccw_eap_aek"] = true,

	},
	["go_stock_ergo"] = {
		["arccw_go_bizon"] = true,
		["arccw_go_m1014"] = true,
		["arccw_go_870"] = true,
		["arccw_go_nova"] = true,
		["arccw_go_ace"] = true,
		["arccw_mifl_fas2_m4a1"] = true,
		["arccw_mifl_fas2_ak47"] = true,
		["arccw_mifl_fas2_rpk"] = true,
		["arccw_mifl_fas2_sr25"] = true,
		["arccw_eap_aek"] = true,
		
	},
	["go_stock_contractor"] = {
		["arccw_go_bizon"] = true,
		["arccw_go_m1014"] = true,
		["arccw_go_870"] = true,
		["arccw_go_nova"] = true,
		["arccw_go_ace"] = true,
		["arccw_mifl_fas2_m4a1"] = true,
		["arccw_mifl_fas2_ak47"] = true,
		["arccw_mifl_fas2_rpk"] = true,
		["arccw_mifl_fas2_sr25"] = true,
		["arccw_eap_aek"] = true,
		
	},
	["go_stock_basilisk"] = {
		["arccw_go_bizon"] = true,
		["arccw_go_m1014"] = true,
		["arccw_go_870"] = true,
		["arccw_go_nova"] = true,
		["arccw_go_ace"] = true,
		["arccw_mifl_fas2_m4a1"] = true,
		["arccw_mifl_fas2_ak47"] = true,
		["arccw_mifl_fas2_rpk"] = true,
		["arccw_mifl_fas2_sr25"] = true,
		["arccw_eap_aek"] = true,
		
	},
}

--can use this to prevent attaching specific atts onto guns (ex 1 type of supp per wep)
hook.Add("ArcCW_PlayerCanAttach", "pickyatts", function(ply, wep, attname, slot, detach)
	if(suppAllow[attname]) then
		local cl = wep:GetClass()
		if(!suppAllow[attname][cl]) then
			return false
		end
		if(istable(suppAllow[attname][cl])) then
			local slotids = {}
			for key, value in ipairs(wep.Attachments) do
				if(istable(value.Slot)) then
					for _, s in ipairs(table) do
						slotids[s] = key
					end
				else
					slotids[value.Slot] = key
				end
			end
			
			for k,v in pairs(suppAllow[attname][cl]) do
				if(!slotids[k]) then return false end --uhhh
				if(istable(v)) then
					--if none exists, check for if its nil first, then stop this if it is
					if(v["none"] and wep.Attachments[slotids[k]].Installed == nil) then break end
					if(!v[wep.Attachments[slotids[k]].Installed]) then return false end
				else
					if(v != "none") then
						if(wep.Attachments[slotids[k]].Installed != v) then return false end
					else
						if(wep.Attachments[slotids[k]].Installed != nil) then return false end
					end
				end
			end
		end
	end
	if(!SERVER) then return end --just being sure
	if(!ply.isattaching) then 
		return false 
	end
	ply.isattaching = nil
end)

if(CLIENT) then
	--support for variable zoom lol
	hook.Add("CanPlayerChooseWeapon", "zoomsupp", function()
		local ply = LocalPlayer()
		if (!ply:IsValid()) then return end
		
		local wep = ply:GetActiveWeapon()
	
		if (!wep or !wep.ArcCW) then return end

		if wep:GetState() == ArcCW.STATE_SIGHTS then
			return false
		end
	end)
	--leaving this here, but i fixed it by stopping ns hud from appearing directly in it if the wep is arccw
	hook.Add("CanDrawAmmoHUD", "arcno", function(weapon)
		--this doesnt work..
		if(weapon.ArcCW) then return false end --maybe pls?
	end)
	--let it go through without forceshow
	hook.Add("HUDShouldDraw", "overrideforce", function(ele)
		if(ArcCW and ele == "CHudAmmo" and ArcCW.PollingDefaultHUDElements) then return true end
		if(ArcCW and ele == "CHudHealth" and ArcCW.PollingDefaultHUDElements) then return false end
		if(ArcCW and ele == "CHudBattery" and ArcCW.PollingDefaultHUDElements) then return false end
	end)
end

if(SERVER) then
	hook.Add("Hook_PostFireRocket", "nutgren", function(weapon, grenade)
		--this will only be used with grenades
		if(weapon.nutItem) then
			weapon.nutItem:remove()
		end
	end)

	hook.Add("InitPostEntity", "DisableArcStuff", function()
		timer.Simple(2, function()
		local cmenu = GetConVar("arccw_truenames")
		cmenu:SetInt(1) --lets try this instead?
		GetConVar("arccw_mult_defaultammo"):SetInt(0)
		end)
	end)
	--unfortunately i have to do this
	hook.Add("PlayerInitialSpawn", "sryautosave", function(ply)
		ply:ConCommand("arccw_autosave 0")
	end)
	
	--putting this here too becuz after this works,
	--ill prob copy magweps somewhere else and delete it
	--overriding
	local playerMeta = FindMetaTable("Player")

	function playerMeta:setRagdolled(state, time, getUpGrace)
		getUpGrace = getUpGrace or time or 5
	
		if (state) then
			if (IsValid(self.nutRagdoll)) then
				self.nutRagdoll:Remove()
			end
	
			local entity = self:createRagdoll()
			entity:setNetVar("player", self)
			entity:CallOnRemove("fixer", function()
				if (IsValid(self)) then
					self:setLocalVar("blur", nil)
					self:setLocalVar("ragdoll", nil)
	
					if (!entity.nutNoReset) then
						self:SetPos(entity:GetPos())
					end
	
					self:SetNoDraw(false)
					self:SetNotSolid(false)
					self:Freeze(false)
					self:SetMoveType(MOVETYPE_WALK)
					self:SetLocalVelocity(
						IsValid(entity)
						and entity.nutLastVelocity
						or vector_origin
					)
				end
	
				if (IsValid(self) and !entity.nutIgnoreDelete) then
					if (entity.nutWeapons) then
						for k, v in ipairs(entity.nutWeapons) do
							--replacing here becuz its easier this way
							local wep = self:Give(v.class, true)
							if(v.item) then
								wep.nutItem = nut.item.instances[v.item]
								--because oncharfallover doesnt call if it gets up normally
								if(wep.nutItem and wep.nutItem.doAttach) then
									wep.nutItem:doAttach(wep)
								end
							end
							if(v.ammo) then
								wep:SetClip1(v.ammo)
							end
							--[[ --old code
							self:Give(v)
							if (entity.nutAmmo) then
								for k2, v2 in ipairs(entity.nutAmmo) do
									if v == v2[1] then
										self:SetAmmo(v2[2], tostring(k2))
									end
								end
							end]]
						end
						--[[for k, v in ipairs(self:GetWeapons()) do
							v:SetClip1(0)
						end]]
					end
	
					if (self:isStuck()) then
						entity:DropToFloor()
						self:SetPos(entity:GetPos() + Vector(0, 0, 16))
	
						local positions = nut.util.findEmptySpace(
							self,
							{entity, self}
						)
						for k, v in ipairs(positions) do
							self:SetPos(v)
	
							if (!self:isStuck()) then
								return
							end
						end
					end
				end
			end)
	
			self:setLocalVar("blur", 25)
			self.nutRagdoll = entity
	
			entity.nutWeapons = {}
			entity.nutAmmo = {}
			entity.nutPlayer = self
	
			if (getUpGrace) then
				entity.nutGrace = CurTime() + getUpGrace
			end
	
			if (time and time > 0) then
				entity.nutStart = CurTime()
				entity.nutFinish = entity.nutStart + time
	
				self:setAction(
					"@wakingUp",
					nil, nil,
					entity.nutStart, entity.nutFinish
				)
			end
	
			for k, v in ipairs(self:GetWeapons()) do
				--i finally got it fixed i like mine better ok
				local clip = v:Clip1()
				--print(tostring(v), clip)
				entity.nutWeapons[#entity.nutWeapons + 1] = {class = v:GetClass(), item = ((v.nutItem and v.nutItem:getID()) or nil), ammo = clip}
				--[[entity.nutWeapons[#entity.nutWeapons + 1] = v:GetClass()
				local clip = v:Clip1()
				local reserve = self:GetAmmoCount(v:GetPrimaryAmmoType())
				local ammo = clip + reserve
				entity.nutAmmo[v:GetPrimaryAmmoType()] = {v:GetClass(), ammo}]]
			end
	
			self:GodDisable()
			self:StripWeapons()
			self:Freeze(true)
			self:SetNoDraw(true)
			self:SetNotSolid(true)
			self:SetMoveType(MOVETYPE_NONE)
	
			if (time) then
				local time2 = time
				local uniqueID = "nutUnRagdoll"..self:SteamID()
	
				timer.Create(uniqueID, 0.33, 0, function()
					if (IsValid(entity) and IsValid(self)) then
						local velocity = entity:GetVelocity()
						entity.nutLastVelocity = velocity
	
						self:SetPos(entity:GetPos())
	
						if (velocity:Length2D() >= 8) then
							if (!entity.nutPausing) then
								self:setAction()
								entity.nutPausing = true
							end
	
							return
						elseif (entity.nutPausing) then
							self:setAction("@wakingUp", time)
							entity.nutPausing = false
						end
	
						time = time - 0.33
	
						if (time <= 0) then
							entity:Remove()
						end
					else
						timer.Remove(uniqueID)
					end
				end)
			end
	
			self:setLocalVar("ragdoll", entity:EntIndex())
			hook.Run("OnCharFallover", self, entity, true)
		elseif (IsValid(self.nutRagdoll)) then
			self.nutRagdoll:Remove()
	
			hook.Run("OnCharFallover", self, entity, false)
		end
	end
end