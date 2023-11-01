local PLUGIN = PLUGIN
PLUGIN.name = "Round System"
PLUGIN.author = "sky"
PLUGIN.desc = "Implements round-based system"
PLUGIN.roundActive = PLUGIN.roundActive or false 
PLUGIN.roundFactions = PLUGIN.roundFactions or {}

local alwaysFaction = {
	[FACTION_SPEC] = true,
	[FACTION_MUTANT] = true
}

if (SERVER) then
	hook.Add("CanPlayerUseChar", "restrictchar", function(ply, char)
		if (!PLUGIN.roundActive) then return end
		if (alwaysFaction[char:getFaction()]) then return end
		if (PLUGIN.roundFactions[char:getFaction()]) then return end
		--admin can get on whatever char they want
		--however this is commented out for now for testing purposes
		--if (ply:IsAdmin()) then return end
		--check for respawn time lmao

		return false, "The character's faction isn't in this current round!"
	end)
--client
else
	
end