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

RANK_TABLE = {
	--min value for the rank
	["novice"] = 0,
	["trainee"] = 2000,
	["experienced"] = 4000,
	["professional"] = 70000, 
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
else
	
end