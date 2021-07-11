local PLUGIN = PLUGIN

nut.command.add("xpadd", {
	adminOnly = true,
	syntax = "<string player> <int toadd>",
	desc = "Add (or remove) a specified number from a player's rank points.",
	onRun = function(client, arguments)
		local ply = nut.util.findPlayer(arguments[1])
		if(!ply or !ply:getChar()) then return "no ply/char?" end
		if(arguments[2] and !tonumber(arguments[2])) then return "not a number" end
		
		local newrank = PLUGIN:AddXp(ply:getChar(), tonumber(arguments[2]))

		nut.log.addRaw(client:steamName().." ("..client:SteamID()..") just changed "..ply:Name().." ("..ply:steamName().."|"..ply:SteamID()..") rank points by "..arguments[2]..". They are now "..(newrank or "same rank"))

		return ply:Name().." had "..arguments[2].." xp added. "..(newrank != nil and ("New rank is "..newrank) or "Same rank")

 	end
})
nut.command.add("xpget", {
	adminOnly = true,
	syntax = "<string player>",
	desc = "Get a player's rank and points.",
	onRun = function(client, arguments)
		local ply = nut.util.findPlayer(arguments[1])
		if(!ply or !ply:getChar()) then return "no ply/char?" end
		local rank = ply:getChar():getData("rank", "novice")
		return ply:Name().." rank is "..RANK_TRANS[rank]..". points: "..ply:getChar():getData("rankpoints", 0)

 	end
})
nut.command.add("repadd", {
	adminOnly = true,
	syntax = "<string player> <int toadd>",
	desc = "Add (or remove) a specified number from a player's rep points.",
	onRun = function(client, arguments)
		local ply = nut.util.findPlayer(arguments[1])
		if(!ply or !ply:getChar()) then return "no ply/char?" end
		if(arguments[2] and !tonumber(arguments[2])) then return "not a number" end
		
		local newrank = PLUGIN:AddRep(ply:getChar(), tonumber(arguments[2]))

		nut.log.addRaw(client:steamName().." ("..client:SteamID()..") just changed "..ply:Name().." ("..ply:steamName().."|"..ply:SteamID()..") rep points by "..arguments[2]..". They are now "..(newrank or "same rank"))

		return ply:Name().." had "..arguments[2].." rep xp added. "..(newrank != nil and ("New rep rank is "..newrank) or "Same rep rank")

 	end
})
nut.command.add("repget", {
	adminOnly = true,
	syntax = "<string player>",
	desc = "Get a player's reputation and points.",
	onRun = function(client, arguments)
		local ply = nut.util.findPlayer(arguments[1])
		if(!ply or !ply:getChar()) then return "no ply/char?" end
		local rank = ply:getChar():getData("rep", "neutral")
		return ply:Name().." rep is "..REP_TRANS[rank]..". points: "..ply:getChar():getData("reppoints", 0)

 	end
})