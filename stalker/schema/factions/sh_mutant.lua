FACTION.name = "Mutants"
FACTION.desc = "Mutants are animals or humans who have been warped by the Zone, changing both their physical appearance and behavior, usually making them more aggressive. Some humanoid mutants are by-products of C-Consciousness experiments and they all possess psychic powers."
FACTION.color = Color(54, 44, 20)--Color(204, 204, 204)
FACTION.noflavoritem = true
FACTION.isDefault = false

FACTION.hasanorak = false

--doing this here should be fine lol
nut.anim.setModelClass("models/tnb/stalker/kontroler1.mdl", "player")

--there has to be an easier way to do this
FACTION.models = {
	"models/tnb/stalker/kontroler1.mdl", --26
}


FACTION_MUTANT = FACTION.index