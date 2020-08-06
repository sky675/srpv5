local PLUGIN = PLUGIN
PLUGIN.name = "STALKER Ranks"
PLUGIN.author = "sky"
PLUGIN.desc = "adds a ranking system"

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
--adding ways to gain xp

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


if(SERVER) then
	function PLUGIN:AddXp(char, amt)
		local xp = char:getData("rankpoints", 0)
		local oldrank = char:getData("rank", "novice")
		xp = xp + amt

		local newrank
		local maxxp
		--find rank
		for k,v in pairs(RANK_TABLE) do
			if(xp >= v) then
				if(!maxxp or v > maxxp) then
					maxxp = v
				else
					continue
				end
				newrank = k
			end
		end

		char:setData("rankpoints", xp)
		--at a new rank
		if(newrank != oldrank) then
			char:setData("rank", newrank)
			return newrank --return new rank
		end
	end
	
	hook.Add("OnPlayerInteractItem", "takeitem", function(ply, action, item)
		if(action == "take") then
			if(item.entity and item.entity.temp) then
				PLUGIN:AddXp(ply:getChar(), 1)
			end
		end
	end)

	hook.Add("OnNPCKilled", "xpcredit", function(npc, atk)
		if(atk:IsPlayer()) then
			PLUGIN:AddXp(atk:getChar(), 2)
		end
	end)
	--[[hook.Add("PlayerDeath", "xpcredit", function(npc, inf, atk)
		if(atk:IsPlayer() and atk != npc) then
			PLUGIN:AddXp(atk:getChar(), 5)
		end
	end)]]

	hook.Add("OnCharCreated", "expboost", function(client, char)
		local fac = char:getFaction()
		if(fac == FACTION_MONOLITH or fac == FACTION_MERC) then
			PLUGIN:AddXp(char, RANK_TABLE["experienced"])
		end
	end)

	hook.Add("OnDownedFinish", "spawnbadge", function(ply, atk)
		if(atk and atk:IsPlayer() and atk != ply) then
			PLUGIN:AddXp(atk:getChar(), 5)
		end
		if(ply:getChar()) then
			local rank = ply:getChar():getData("rank", "novice")
			--spawn patch and remove xp
			nut.item.spawn("playerpatch", ply:GetPos()+Vector(0,0,2.5), function(item, ent)
				item:setupPatch(rank, ply:getChar():getFaction(), ent)
				ent.temp = true
				local e = ent
				timer.Simple(1800, function()
					if(IsValid(e)) then
						e:Remove()
					end
				end)
			end)

			local torem = RANK_TABLE[rank] * 0.2
			local pts = ply:getChar():getData("rankpoints", 0)
			torem = math.max((pts-RANK_TABLE[rank])-torem, 0)

			PLUGIN:AddXp(ply:getChar(), -torem)

			ply:getChar():takeMoney(RANK_PRICES[rank])
		end
	end)

else--client
	--hope thisis above traits lol
	hook.Add("CreateCharInfoText", "aarank", function(self)
		self.rank = self.info:Add("DLabel")
		self.rank:Dock(TOP)
		self.rank:SetFont("nutMediumFont")
		self.rank:SetTextColor(color_white)
		self.rank:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		self.rank:DockMargin(0, 10, 0, 0)
		

	end)

	hook.Add("OnCharInfoSetup", "rank", function(self)
		if (self.rank) then
			self.rank:SetText("Your current rank is "..(RANK_TRANS[LocalPlayer():getChar():getData("rank", "novice")] or "???")..".")
		end
	end)

end