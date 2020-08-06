local PLUGIN = PLUGIN

--do here batching edits to weapons
local weaponEdits = {
	--[[
	["class"] = {
		--things that arent attachment related
		straightmods = {

		},
		--above, but put into the primary table
		primarystraight = {

		},
		vele = { --velements to add

		},
		wele = { --welements to add

		},
		attmerge = { --att table to merge

		},
		--or, use this to completely override atts, 
		--above wont run if this exists
		--atts = {},
		attdep = { --att dependences to add

		},
		attrestrict = { --att restrictions to add

		}
	},
	]]
	--this is minimum
	["tfa_ins2_ak12"] = {
		--things that arent attachment related
		straightmods = {
			MagType = "mag_545ak",
		},
		primarystraight = {
			Ammo = "sky545",
			DefaultClip = 0,
		},
	},
}

local function PatchWeapon(weapon, name)
	weapon.Base = "sky_mag_base_ins2" --hopefully this works?
	local tochange = weaponEdits[name] --easier
	for k,v in pairs(tochange.straightmods or {}) do
		weapon[k] = v
	end
	for k,v in pairs(tochange.primarystraight or {}) do
		weapon.Primary[k] = v
	end
	if(tochange.vele and table.Count(tochange.vele) != 0) then table.Add(weapon.VElements, tochange.vele) end
	if(tochange.wele and table.Count(tochange.wele) != 0) then table.Add(weapon.WElements, tochange.wele) end
	
	if(tochange.atts) then
		weapon.Attachments = tochange.atts
	elseif(tochange.attmerge and table.Count(tochange.attmerge != 0)) then
		for k,v in pairs(tochange.attmerge) do
			if(weapon.Attachments[k]) then
				table.Add(weapon.Attachments[k].atts, tochange.attmerge[k])
			else					--idk if this is needed but i always see it
				weapon.Attachments[k] = {offset = {0,0}, atts = tochange.attmerge[k]}
			end
		end
	end

end

--hook.Add("TFA_PreInitialize", "magweps_patch", function(wep)
--	if(weaponEdits[wep.ClassName]) then
--		PatchWeapon(wep)
hook.Add("InitPostEntity", "magweps_patch", function()
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