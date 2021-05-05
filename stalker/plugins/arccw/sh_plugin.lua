local PLUGIN = PLUGIN
PLUGIN.name = "arccw support"
PLUGIN.author = "sky"
PLUGIN.desc = "adds support for arccw weps+atts, no mags (for now..)"

nut.util.include("sh_config.lua")
nut.util.include("sh_patch.lua")
nut.util.include("sv_dura.lua")

--notes:
--weapon seems to ignore noammo bool but i think theres a convar for it?
--didnt test falling over, should be good tho

--no weapons like tt33, ppsh or just realized, mosin, but tbh ehhhhhh
--tbh tho, not having those guns for stalker aesthetics wise is kinda bad
--so maybe hold off until then? 
--idea on this: some of these guns are/will be in different packs, however,
--only like a max of 4 guns will be used out of those packs, so might as well
--rip them and put them in seperate content, also at that point could edit them
--such as the 1 handed makarov lmao, thinking of makarov could do the same thing
--with the ins makarov too, if that idea doesnt work out
--so update on this: looked at black ops pack: - frankly tho these are awful weapons
--db - ehh works? needs definite mods tho, (sawn off fires both barrels with huge dropoff???)
--ppsh - only has drum mag unfortunately
--mw pack: - these are even worse
--f2000 - eh its ok actually, sight isnt very attached tho
--pp2000 - sucks that only the small mag is available, and cant unfold the stock (which i dont think is actually foldable?), and is 1 handed
--tar21 -ehhhhhhh
--vector - ehhhh is ok i guess? short range

--another idea for above: see if can adapt the tfa ins2 pmhands and use them
--on arccw? it may work?
--notes for that tho: vmiv just returns getowner():getviewmodel()
--and this should prob be done in the patching process, or since this would need
--to be their own weps, can just put the code in the swep itself, maybe as a base

--need to change ammo types of all the guns and relevant atts
--and the aug mag size
--also the ammo types to saveammo

--convars to change:
--arccw_truenames 1
--arccw_clicktocycle 1 maybe too idk lol
--these are clientside only, so need a way to be forced serverside somehow?
--they can be changed serverside, but id rather not change players personal settings
--may have to use a special base to override the related funcs
--arccw_attinv_onlyinspect 1
--arccw_autosave 0
--arccw_hud_forceshow 1 --tho this and below may need to be something else, 
--arccw_hud_showhealth 0 -- ns's hook needs to somehow be ran before theirs

--allowed weapons per supp: can be used for things as needed but ya
--this works
local suppAllow = {
	--can also be a table of slot = id to restrict to certain atts already installed
	--[[["supp"] = {
		["weapon"] = true,
	},]]
	["go_supp_ssq"]= {
		["arccw_go_glock"] = true,--{
			--["go_glock_mag"]
--		}
		["arccw_go_m9"] = true
	}
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
				if(wep.Attachments[slotids[k]].Installed != v) then return false end
			end
		end
	end
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
	hook.Add("CanDrawAmmoHUD", "arcno", function(weapon)
		--this doesnt work..
		if(weapon.ArcCW) then return false end --maybe pls?
	end)
end

if(SERVER) then
	hook.Add("Hook_PostFireBullets", "nutgren", function(weapon)
		--print("hook works, can use this to destroy grenades")
	end)
	
	--putting this here too becuz after this works,
	--ill prob copy magweps somewhere else and delete it
	--TODO ACTUALLY TEST THIS LOL
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