CLASS.name = "Bandit"
CLASS.desc = ""
CLASS.faction = FACTION_LONER

function CLASS:onCanBe(client)
	--might prevent joining?
	if(CLIENT) then return false end
	return client:getChar():getData("customclass", "") == "bandit"
end

CLASS_BANDIT = CLASS.index