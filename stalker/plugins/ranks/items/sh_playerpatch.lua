ITEM.name = "Patch"
ITEM.desc = "A patch used to identify the faction of a Stalker and their rank."
ITEM.model = "models/kek1ch/tfw_badge_defiance.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.01
ITEM.price = 150
ITEM.flag = "m"
ITEM.noBusiness = true

local badgetypes = {
	[FACTION_LONER] = {
		name = "Loner",
		model = "models/kek1ch/tfw_badge_defiance.mdl",
	},
	[FACTION_BANDIT] = {
		name = "Bandit",
		model = "models/kek1ch/tfw_badge_bandit.mdl",
	},
	[FACTION_DUTY] = {
		name = "Duty",
		model = "models/kek1ch/tfw_badge_dolg.mdl",
	},
	[FACTION_FREEDOM] = {
		name = "Freedom",
		model = "models/kek1ch/tfw_badge_freedom.mdl",
	},
	[FACTION_MERC] = {
		name = "Mercenary",
		model = "models/kek1ch/tfw_badge_merc.mdl",
	},
	[FACTION_MILITARY] = {
		name = "Military",
		model = "models/kek1ch/tfw_badge_military.mdl",
	},
	[FACTION_MONOLITH] = {
		name = "Monolith",
		model = "models/kek1ch/tfw_badge_monolith.mdl",
	},
	[FACTION_ECO] = {
		name = "Ecologist",
		model = "models/kek1ch/tfw_scientist.mdl",
	},
}

function ITEM:getModel()
	local faction = self:getData("faction")
	local model = self.model

	if(faction and badgetypes[faction]) then
		model = badgetypes[faction].model
	end

    return model
end

function ITEM:getName()
	local name = "Patch"

	if(self:getData("faction")) then
		name = badgetypes[self:getData("faction")] and (badgetypes[self:getData("faction")].name.." Patch") or "Unknown faction Patch"
	end


	return name
end

function ITEM:calcPrice(price)
	price = RANK_PRICES[self:getData("rank", "novice")] or price

    return price
end

function ITEM:getDesc()
	local name = self.desc
	
	if(self:getData("faction")) then
		name = badgetypes[self:getData("faction")] and ("This is a "..badgetypes[self:getData("faction")].name.." Patch") or "Unknown faction Patch"
	end
	if(self:getData("rank", "novice")) then
		name = name.."\nIt belonged to a "..RANK_TRANS[self:getData("rank", "novice")].." stalker."
	end

    return name
end

function ITEM:onGetDropModel(ent)
	local faction = self:getData("faction")
	local model = self.model

	if(faction and badgetypes[faction]) then
		model = badgetypes[faction].model
	end

    return model
end

function ITEM:setupPatch(rank, faction, ent)
	self:setData("rank", rank)
	self:setData("faction", faction)
	if(faction and badgetypes[faction]) then
		ent:SetModel(badgetypes[faction].model)
	end
end