local PLUGIN = PLUGIN
PLUGIN.name = "STALKER Ranks"
PLUGIN.author = "sky"
PLUGIN.desc = "adds a ranking system"

nut.config.add("rankMinLeader", 15000, "The minimum rank points required to be visible on the scoreboard (default is 15000, the amount for expert).", nil, {
	data = {min = 1, max = 30000},
	category = "Rankings"
})
nut.config.add("rankLeaderCount",  20, "The amount of people to keep in the cached sorted leaderboard.", nil, {
	data = {min = 3, max = 100},
	category = "Rankings"
})

nut.config.add("rankXpItem", 1, "The XP given when picking up a naturally spawned (from loot) item. 0 disables", nil, {
	data = {min = 0, max = 100},
	category = "Rankings"
})
nut.config.add("rankXpNpc", 2, "The XP given when killing an npc. 0 disables", nil, {
	data = {min = 0, max = 100},
	category = "Rankings"
})
nut.config.add("rankXpPly", 5, "The XP given to a player after a player they downed acds (will only work with damage on). 0 disables", nil, {
	data = {min = 0, max = 100},
	category = "Rankings"
})

RANK_TABLE = {
	--min value for the rank
	["novice"] = 0,
	["trainee"] = 2000,
	["experienced"] = 4000,
	["professional"] = 7000, 
	["veteran"] = 10000,
	["expert"] = 15000,
	["master"] = 21000,
	["legend"] = 28000,
}
RANK_TRANS = {
	["novice"] = "Novice",
	["trainee"] = "Trainee",
	["experienced"] = "Experienced",
	["professional"] = "Professional",
	["veteran"] = "Veteran",
	["expert"] = "Expert",
	["master"] = "Master",
	["legend"] = "Legend"
}
REP_TABLE = {
	--min value for rep
	["terrible"] = -9999,
	["realbad"] = -2000,
	["verybad"] = -1500,
	["bad"] = -1000,
	["neutral"] = -500,
	["good"] = 500,
	["verygood"] = 1000,
	["realgood"] = 1500,
	["excellent"] = 2000
}
REP_TRANS = {
	["terrible"] = "Terrible",
	["realbad"] = "Dreary",
	["verybad"] = "Awful",
	["bad"] = "Bad",
	["neutral"] = "Neutral",
	["good"] = "Good",
	["verygood"] = "Great",
	["realgood"] = "Brilliant",
	["excellent"] = "Excellent"
}
RANK_PRICES = {
	["novice"] = 250,
	["trainee"] = 500,
	["experienced"] = 1000,
	["professional"] = 2000, 
	["veteran"] = 4000,
	["expert"] = 5000,
	["master"] = 7500,
	["legend"] = 10000,
}

nut.util.include("sh_commands.lua")
nut.util.include("sv_integration.lua")
nut.util.include("sv_xp.lua")

if(SERVER) then
	--tbh, with multiple servers, having this hosted elsewhere would be better
	RANK_LEADER = RANK_LEADER or {} --this is the cached already sorted leaderboard table
	RANK_TOBEADD = RANK_TOBEADD or {} --this is a list of characters to be considered to add to it

	function PLUGIN:SaveData()
		self:setData(RANK_LEADER, nil, true)
	end
	function PLUGIN:LoadData()
		RANK_LEADER = self:getData({}, nil, true)
	end

	netstream.Hook("getleaderboard", function(ply)
		netstream.Start(ply, "sendleaderboard", RANK_LEADER)
	end)

else
	
end