local PLUGIN = PLUGIN
	--auto update
	function PLUGIN:OnLoaded()
		timer.Create("rankupdate", 600, 0, function()
			if(self.updateRank) then
				self:ResortRankList()
				self.updateRank = nil
			end
		end)
	end
	
	function rankingTest() 
		for i = 1, 40 do
			local xp = math.random(1000, 30000)
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
			RANK_TOBEADD[math.random(1, 500)] = {["name"] = "test"..math.random(1,50000), ["fac"] = math.random(1,9), ["xp"] = xp, ["rank"] = newrank}
		end

		print("printing generated ranks")
		for k,v in pairs(RANK_TOBEADD) do
			print(k, v.name, v.fac, v.xp, v.rank)
		end
		PLUGIN:ResortRankList()
	end

	function rankingResort()
		print("current toadd cnt ", table.Count(RANK_TOBEADD))
		print("current cache cnt ", table.Count(RANK_LEADER))
		PLUGIN:ResortRankList()
		print("printing sorted ranks")
		for k,v in pairs(RANK_LEADER) do
			print(k, v.id, v.name, v.fac, v.xp, v.rank)
		end
		RANK_LEADER = {}
	end

	function PLUGIN:ResortRankList()
		--loop through the current one sorted by xp, making a new one
		--skip any that dont meet the current min
		local cach = {}
		local added = {}
		local old = RANK_LEADER
		local new = RANK_TOBEADD
		local min = nut.config.get("rankMinLeader", 0)
		local cutoff = nut.config.get("rankLeaderCount", 5)
		for k,v in ipairs(old) do
			if(!added[v.id] and min <= v.xp) then --checking again
				added[v.id] = true
				cach[#cach+1] = {
					name = v.name,
					fac = v.fac,
					id = v.id,
					xp = v.xp,
					rank = v.rank
				}
			end
		end
		for k,v in pairs(new) do
			if(!added[k] and min <= v.xp) then --checking again
				added[k] = true
				cach[#cach+1] = {
					name = v.name,
					fac = v.fac,
					id = k,
					xp = v.xp,
					rank = v.rank
				}
			end
		end

		table.SortByMember(cach, "xp")

		if(#cach > cutoff) then
			for i = cutoff+1, #cach do
				cach[i] = nil --this should remove excess members
			end
		end

		--finally apply it
		RANK_LEADER = cach
		RANK_TOBEADD = {}
	end
	
	hook.Add("OnCharCreated", "expboost", function(client, char)
		local fac = char:getFaction()
		if(fac == FACTION_MONOLITH or fac == FACTION_MERC) then
			PLUGIN:AddXp(char, RANK_TABLE["experienced"])
		end
	end)

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
		--if the xp is higher than the min get it to update the list next cycle
		if(nut.config.get("rankMinLeader", 0) <= xp) then
			--including the name and faction just in case they arent loaded (which tbh theres a large chance they wont) when the ranks are updated
			RANK_TOBEADD[char:getID()] = {["name"] = char:getName(), ["fac"] = char:getFaction(), ["xp"] = xp, ["rank"] = newrank}
			self.updateRank = true
		end
		--at a new rank
		if(newrank != oldrank) then
			char:setData("rank", newrank)
			return newrank --return new rank
		end
	end