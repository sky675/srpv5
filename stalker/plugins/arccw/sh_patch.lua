local PLUGIN = PLUGIN

--do here batching edits to weapons
local weaponEdits = {
	--[[
	["class"] = {
		--changing values on the swep itself
		mods = {
		}, 
		--values in the primary table to change (ammo, clipsize)
		primarymods = {
		},
		modatts = {
			--[slotname] = {Slot = "tac"}
		}
	},
	]]
	["arccw_go_glock"] = {
		mods = {
		}, 
		primarymods = {
			Ammo = "sky9x19"
		}
	},
}
local attEdits = {
	--[[
	--name can be determined by looking at att ents names, acwatt_*name*
	["name"] = {
		mods = {
			--notable things:
			Override_Ammo = ""
		}
	},
	]]
}

local function PatchWeapon(weapon, name)
	//weapon.Base = "sky_mag_base_ins2" --hopefully this works?
	local tochange = weaponEdits[name] --easier
	for k,v in pairs(tochange.mods or {}) do
		weapon[k] = v
	end
	for k,v in pairs(tochange.primarymods or {}) do
		weapon.Primary[k] = v
	end
	if(!tochange.modatts) then return end --small opt
	local slotids = {}
	for key, value in ipairs(weapon.Attachments) do
		if(istable(value.Slot)) then
			for _, s in ipairs(value.Slot) do
				slotids[s] = key
			end
		else
			slotids[value.Slot] = key
		end
	end
	for k,v in pairs(tochange.modatts or {}) do
		local num = slotids[k]
		if(!num) then continue end
		for l,m in pairs(v) do
			weapon.Attachments[num][l] = m
		end
	end
end
local function PatchAttachment(att, name)
	local tochange = attEdits[name]
	for k,v in pairs(tochange.mods or {}) do
		att[k] = v
	end
end

hook.Add("InitPostEntity", "arcweps_patch", function()
    local wepTable = weapons.GetList()
    for k,v in pairs(wepTable) do
        if(weaponEdits[v.ClassName]) then
			local wep = weapons.GetStored(v.ClassName or "")
			if(wep) then
				PatchWeapon(wep, v.ClassName)
			end
        end
    end
end)
hook.Add("ArcCW_PostLoadAtts", "arcatts_patch", function()
	for k,v in pairs(ArcCW.AttachmentTable) do
		if(attEdits[k]) then
			PatchAttachment(v, k)
		end
	end
end)