local PLUGIN = PLUGIN


hook.Add("OnCharCreated", "expboost", function(client, char)
	local fac = char:getFaction()
	if(fac == FACTION_MONOLITH or fac == FACTION_MERC) then
		PLUGIN:AddXp(char, RANK_TABLE["experienced"])
	end
end)

hook.Add("OnPlayerInteractItem", "takeitem", function(ply, action, item)
	if(action == "take") then
		if(item.entity and item.entity.temp) then
			local xpItem = nut.config.get("rankXpItem", 0)
			if(xpItem != 0) then
				PLUGIN:AddXp(ply:getChar(), xpItem)
			end
		end
	end
end)

hook.Add("OnNPCKilled", "xpcredit", function(npc, atk)
	if(atk:IsPlayer()) then
		local xpNpc = nut.config.get("rankXpNpc", 0)
		if(xpNpc != 0) then
			PLUGIN:AddXp(atk:getChar(), xpNpc)
		end
	end
end)

hook.Add("OnDownedFinish", "spawnbadge", function(ply, atk)
	--again thisll never be applied unless damage is enabled
	if(atk and atk:IsPlayer() and atk != ply) then
		local xpPly = nut.config.get("rankXpPly", 0)
		if(xpPly != 0) then
			PLUGIN:AddXp(atk:getChar(), xpPly)
		end
	end
	--custom patch dropping (didnt readd them) and rank-based money taking and rank removal that ill leave commented for now
	--[[if(ply:getChar()) then
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
	end]]
end)