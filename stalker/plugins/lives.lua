local PLUGIN = PLUGIN
PLUGIN.name = "Lives"
PLUGIN.author = "sky"
PLUGIN.desc = "new auto lives system"

--[[how lives repeat protection (hopefully) works
	1. when attacking someone, 
	you get added to a table of people who recently attacked them
	2. if they die before the timer (livesRepeatAtkTime) expires, 
	you are then checked (with the actual attacker) if you were involved in
	a recent death, and if so they wont lose a life

	this makes it so if you decide to bully someone to death multiple times,
	theyll only lose a life on their first death, even if you didnt do
	the killing blow
	theyre meant to be something like assists
	ofc if someone abuses this in ways this cant rly detect or in ways id
	rather not patch in unless i have to 
	(ex switching chars to do it for the 2nd (as it checks per char), or
	not directly effecting their death for the 1st 
	(ex getting someone else to do it)),
	thered still need to be admin involvement 
	(there are commands for adding/removing lives, and 
	getting the lives of a current player)
]]

--just disable it if u dont want it :)
nut.config.add("livesStarter", 3, "Number of lives new characters start with (not retroactive)", nil, {
	form = "Int",
	data = {min = 1, max = 12},
	category = "Lives"
})
nut.config.add("livesRepeatProt", true, "Repeated deaths to (or related to) a specific player will prevent more than one life being lost for a limited amount of time", nil, {
    category = "Lives"    
})
nut.config.add("livesRepeatTime", 600, "Time (sec) until the repeat death protection against someone resets (from the last death)", nil, {
	form = "Int",
	data = {min = 10, max = 7200},
	category = "Lives"
})
nut.config.add("livesRepeatAtkTime", 90, "Time (sec) until the repeat death protection against someone resets (from the last attack, if expires they wont be checked for repeat death if u die), should be longer than the respawn timer (default 60 sec) or this wont do anything (itll expire before the timer is up and it checks)", nil, {
	form = "Int",
	data = {min = 5, max = 7200},
	category = "Lives"
})
nut.config.add("livesNpcTake", false, "NPC deaths take lives like a player (repeat death protection counts against them all together)", nil, {
    category = "Lives"    
})
nut.config.add("livesPlyTake", 1, "Number of lives that gets taken when players die to another player (or npc if NpcTake is on)", nil, {
	form = "Int",
	data = {min = 0, max = 12},
	category = "Lives"
})
nut.config.add("livesEnvTake", 2, "Number of lives that gets taken when players die to the environment or a non-npc entity (such as fall damage, trigger_hurt, anomalies, urself, etc)", nil, {
	form = "Int",
	data = {min = 0, max = 12},
	category = "Lives"
})

nut.command.add("livesmod", {
	adminOnly = true,
	syntax = "<string player> [int toadd]",
	desc = "Add (or remove) a specified number (optional, default 1) lives to the player",
	onRun = function(client, arguments)
		local ply = nut.util.findPlayer(arguments[1])
		if(!ply or !ply:getChar()) then return "no ply/char?" end
		local lives = ply:getChar():getData("lives", nut.config.get("livesStarter", 3))
		if(arguments[2] and !tonumber(arguments[2])) then return "not a number" end
		lives = lives + (arguments[2] and tonumber(arguments[2]) or 1)
		
		nut.log.addRaw(client:steamName().." ("..client:SteamID()..") just changed "..ply:Name().." ("..ply:steamName().."|"..ply:SteamID()..") lives by "..arguments[2].." to "..lives)

		ply:getChar():setData("lives", lives)
		return ply:Name().." now has "..lives.." lives."

 	end
})
nut.command.add("livesset", {
	adminOnly = true,
	syntax = "<string player> [int toset]",
	desc = "Set a players lives to a specified number (optional, default is starter)",
	onRun = function(client, arguments)
		local ply = nut.util.findPlayer(arguments[1])
		if(!ply or !ply:getChar()) then return "no ply/char?" end
		local lives = ply:getChar():getData("lives", nut.config.get("livesStarter", 3))
		if(arguments[2] and !tonumber(arguments[2])) then return "not a number" end
		local lives = (arguments[2] and tonumber(arguments[2]) or nut.config.get("livesStarter", 3))
		
		nut.log.addRaw(client:steamName().." ("..client:SteamID()..") just set "..ply:Name().." ("..ply:steamName().."|"..ply:SteamID()..") lives to "..arguments[2] or "default")

		ply:getChar():setData("lives", lives)
		return ply:Name().." now has "..lives.." lives."

 	end
})
nut.command.add("livesget", {
	adminOnly = true,
	syntax = "<string player>",
	desc = "Get the number of lives a character has.",
	onRun = function(client, arguments)
		local ply = nut.util.findPlayer(arguments[1])
		if(!ply or !ply:getChar()) then return "no ply/char?" end
		local lives = ply:getChar():getData("lives", nut.config.get("livesStarter", 3))
		
		return ply:Name().." has "..lives.." lives."

 	end
})
LIVE_RECENTS = LIVE_RECENTS or {}
local function addToRecent(id, atk, time)
	LIVE_RECENTS[id] = LIVE_RECENTS[id] or {}
	LIVE_RECENTS[id][atk] = true

	--im like 99% sure it overwrites?
	timer.Create("liveTimer"..id.."-"..atk, time, 1, function()
		LIVE_RECENTS[id][atk] = nil
	end)
end
local function isInRecent(id, atk)
	return LIVE_RECENTS[id] and LIVE_RECENTS[id][atk]
end

LIVE_TEMP = LIVE_TEMP or {}
local function addToTemp(id, atk, time)
	LIVE_TEMP[id] = LIVE_TEMP[id] or {}
	LIVE_TEMP[id][atk] = true

	--im like 99% sure it overwrites?
	timer.Create("liveTimer"..id.."-"..atk, time, 1, function()
		if(LIVE_TEMP[id] and LIVE_TEMP[id][atk]) then
			LIVE_TEMP[id][atk] = nil
		end
	end)
end
local function isInTemp(id, atk)
	return LIVE_TEMP[id] and LIVE_TEMP[id][atk]
end

if(SERVER) then
	--this is for shoottorp, to use without shoottorp just change it to the comment
	function PLUGIN:OnDownedFinish(ply, atk)--DoPlayerDeath(ply, atk, dmginfo)
		if(!ply:getChar()) then return end --just in case
		local lives = ply:getChar():getData("lives", nut.config.get("livesStarter", 3))
		local id = ply:getChar():getID()
		local pk = false

		if(IsValid(atk) and (atk:IsNPC() or atk.NEXTBOT)) then
			if(!nut.config.get("livesNpcTake", false)) then return end
			local take = nut.config.get("livesPlyTake", 1)

			--already died to npc recently
			if(isInRecent(id, "npc")) then return end
			for k,v in pairs(LIVE_TEMP[id] or {}) do
				if(!LIVE_RECENTS[id]) then break end --uh
				if(LIVE_RECENTS[id][k]) then return end 
				--no lives lost if someone who recently attacked them is in temp
				addToRecent(id, k, nut.config.get("livesRepeatTime", 600))
			end
			LIVE_TEMP[id] = nil

			addToRecent(id, "npc", nut.config.get("livesRepeatTime", 600))

			local rem = lives-take
			ply:getChar():setData("lives", rem)
			--ply:notify("You have "..rem.." lives remaining.")

			if(rem <= 0) then
				pk = true
			end
		elseif(IsValid(atk) and (atk:IsPlayer() and atk != ply)) then
			local take = nut.config.get("livesPlyTake", 1)
			local enmid = atk:getChar():getID()

			if(isInRecent(id, enmid)) then return end
			for k,v in pairs(LIVE_TEMP[id] or {}) do
				if(!LIVE_RECENTS[id]) then break end --uh
				if(LIVE_RECENTS[id][k]) then return end 
				--no lives lost if someone who recently attacked them is in temp
				addToRecent(id, k, nut.config.get("livesRepeatTime", 600))
			end
			LIVE_TEMP[id] = nil

			addToRecent(id, enmid, nut.config.get("livesRepeatTime", 600))

			local rem = lives-take
			ply:getChar():setData("lives", rem)
			--ply:notify("You have "..rem.." lives remaining.")

			if(rem <= 0) then
				pk = true
			end
		else--enviro?
			local take = nut.config.get("livesEnvTake", 1)
			
			--no recent for enviro death
			for k,v in pairs(LIVE_TEMP[id] or {}) do
				if(!LIVE_RECENTS[id]) then break end --uh
				if(LIVE_RECENTS[id][k]) then return end 
				--no lives lost if someone who recently attacked them is in temp
				addToRecent(id, k, nut.config.get("livesRepeatTime", 600))
			end
			LIVE_TEMP[id] = nil

			local rem = lives-take
			ply:getChar():setData("lives", rem)
			--ply:notify("You have "..rem.." lives remaining.")

			if(rem <= 0) then
				pk = true
			end
		end

		if(pk) then
			nut.log.addRaw(ply:Name().." ("..ply:steamName().."|"..ply:SteamID()..") was just pked automatically!")
			ply:notify("You have ran out of lives.", 3)
			--ply:getChar():setData("loseitems", true)
			ply:getChar():setData("pkdeath", true)
		end
	end
	
	function PLUGIN:PlayerSpawn(client)
		local character = client:getChar()
		if (character and character:getData("pkdeath")) then
			character:ban()
			--reset lives
			character:setData("lives")
			return
		end
		
		if(character and character:getData("lives")) then
			client:notify("You have "..character:getData("lives").." lives remaining.")
		end
	end

	--plytakedamage for repeat prot
	hook.Add("ScalePlayerDamage", "livesTemp", function(ply, hg, dmginfo)
		local atk = dmginfo:GetAttacker()
		if(atk:IsPlayer() and atk:getChar() and ply != atk) then
			addToTemp(ply:getChar():getID(), atk:getChar():getID(), nut.config.get("livesRepeatAtkTime", 30))
		end
	end)
else

end