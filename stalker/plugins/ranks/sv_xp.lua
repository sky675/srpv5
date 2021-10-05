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
			local rep = math.random(-2500, 2500)
			local newrank
			local maxxp
			local newrep
			local maxrep
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
			--find rep
			for k,v in pairs(REP_TABLE) do
				if(rep >= v) then
					if(!maxrep or v > maxrep) then
						maxrep = v
					else
						continue
					end
					newrep = k
				end
			end
			RANK_TOBEADD[math.random(1, 500)] = {["name"] = "test"..math.random(1,50000), ["fac"] = math.random(1,9), ["xp"] = xp, ["rank"] = newrank, ["rep"] = newrep}
		end

		print("printing generated ranks")
		for k,v in pairs(RANK_TOBEADD) do
			print(k, v.name, v.fac, v.xp, v.rank, v.rep)
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

	--easy way to remove someone from scoreboard: 
	--add them to RANK_TOBEADD with 0 xp, 
	--so theyll get skipped and removed from the leaderboard


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
			if(!added[v.id] and !new[v.id] and min <= v.xp) then --checking again
				added[v.id] = true
				cach[#cach+1] = {
					name = v.name,
					fac = v.fac,
					id = v.id,
					xp = v.xp,
					rep = v.rep,
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
					rep = v.rep,
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
			RANK_TOBEADD[char:getID()] = {["name"] = char:getName(), ["fac"] = char:getFaction(), ["xp"] = xp, ["rank"] = newrank, ["rep"] = char:getData("rep", "neutral")}
			self.updateRank = true
		end
		--at a new rank
		if(newrank != oldrank) then
			char:setData("rank", newrank)
			return newrank --return new rank
		end
	end

	function PLUGIN:AddRep(char, amt)
		local xp = char:getData("reppoints", 0)
		local oldrank = char:getData("rep", "neutral")
		xp = xp + amt

		local newrank
		local maxxp
		--find rank
		for k,v in pairs(REP_TABLE) do
			if(xp >= v) then
				if(!maxxp or v > maxxp) then
					maxxp = v
				else
					continue
				end
				newrank = k
			end
		end

		char:setData("reppoints", xp)
		--at a new rank
		if(newrank != oldrank) then
			char:setData("rep", newrank)
			--if its possible to be on the list
			if(char:getData("rankpoints", 0) > nut.config.get("rankMinLeader", 0)) then
				for k,v in ipairs(RANK_LEADER) do
					if(v.id == char:getID()) then
						v.rep = newrank
						break
					end
				end
			end

			return newrank --return new rank
		end
	end