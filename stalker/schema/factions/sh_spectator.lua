FACTION.name = "Spectator"
FACTION.desc = "Spectator faction for spectating mid round"
FACTION.color = Color(234, 234, 234)
FACTION.noflavoritem = true
--false for now, will need to be default later
FACTION.isDefault = false

FACTION.hasanorak = false

--there has to be an easier way to do this
FACTION.models = {
	--change this to whatever
	"models/tnb/stalker/kontroler1.mdl", --26
}

--need a forced observer mode or something for this


FACTION_SPEC = FACTION.index