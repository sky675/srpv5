local PLUGIN = PLUGIN

local function shuffle(tbl)
	local size = #tbl
	for i = size, 1, -1 do
	  local rand = math.random(size)
	  tbl[i], tbl[rand] = tbl[rand], tbl[i]
	end
	return tbl
end

--enmlist - the list of enemy spawn types
--spawntable - the spawn table to take spawns from
--run - the curused table, it puts it in a table called enemies in that table
--amt - the max enemies to spawn
--minamt - the min enemies to spawn
--callback - called on each spawned enemy, just in case need to do stuff to it
local function SpawnEnemies(enmlist, spawntable, run, amt, minamt, callback)
	local tmpspawns = shuffle(table.Copy(spawntable))

	local enm = 0 --cur item number
	local breakk = false
	for k,v in pairs(tmpspawns) do

		--spawn random from enmlist
		if(type(v[1]) == "table") then
			for k2, v2 in pairs(v) do
				if(enm == amt) then
					breakk = true --to quit the entire thing
					break --quit spawning if at max
				end
				--if item count equals or is higher than min
				if(enm >= minamt) then 
					--random number if itll continue spawning
					--opposite of items
					if(math.Rand(0,1) >= (enm/amt)) then
						break
					end
				end
				
		
				--spawn at pos
				enm = enm+1
				local np = ents.Create(enmlist[math.random(#enmlist)])
				if(np) then
					np:SetPos(v2[1])--+Vector(0,0,16))
					np:SetAngles(v2[2]) --mebi this will work idk
					if(!np.NEXTBOT and np:IsNPC()) then
						local SpawnFlags = bit.bor( SF_NPC_FADE_CORPSE, SF_NPC_ALWAYSTHINK, SF_NPC_NO_WEAPON_DROP )
						np:SetKeyValue( "spawnflags", SpawnFlags )
					end
					np:Spawn()
					if(np.NEXTBOT) then
						np.areaid = run.area
					else
						np:Activate() --just in case
						if(np.ComeonSound) then np:ComeonSound() end
						if(list.Get("NPC")[np:GetClass()]) then
							local lis = list.Get("NPC")[np:GetClass()].Weapons
							if(lis) then
								np:Give(lis[math.random(#lis)])
							end
						end
					end
					--[[ --no diffs
					local scale = 1 
					if(diff == RUN_DIFF_NORMAL) then
					elseif(diff == RUN_DIFF_HARD) then
						scale = 1.5
					elseif(diff == RUN_DIFF_EXPERT) then
						scale = 2.5
					end
					timer.Simple(0, function() --just to be safe
					np:SetHealth(np:Health()*scale)
					end)]]
					if(callback) then
						callback(np)
					end

					if(!run.enemies) then
						run.enemies = {}
					end
					table.insert(run.enemies, np)
				end
			end
		else
			if(enm == amt) then
				break --quit spawning if at max
			end
			--if item count equals or is higher than min
			if(enm >= minamt) then 
				--random number if itll continue spawning
				--opposite of items
				if(math.Rand(0,1) >= (enm/amt)) then
					break
				end
			end
		
			--spawn at pos
			enm = enm+1
			local np = ents.Create(enmlist[math.random(#enmlist)])
			if(IsValid(np)) then
				np:SetPos(v[1])
				np:SetAngles(v[2])
				if(!np.NEXTBOT and np:IsNPC()) then
					local SpawnFlags = bit.bor( SF_NPC_FADE_CORPSE, SF_NPC_ALWAYSTHINK, SF_NPC_NO_WEAPON_DROP )
					np:SetKeyValue( "spawnflags", SpawnFlags )
				end
				np:Spawn()
				if(np.NEXTBOT) then
					np.areaid = run.area
				else
					np:Activate() --just in case
					if(np.ComeonSound) then np:ComeonSound() end
					if(list.Get("NPC")[np:GetClass()]) then
						local lis = list.Get("NPC")[np:GetClass()].Weapons
						if(lis) then
							np:Give(lis[math.random(#lis)])
						end
					end
				end
				--[[ --no diffs
				local scale = 1 
				if(diff == RUN_DIFF_NORMAL) then
				elseif(diff == RUN_DIFF_HARD) then
					scale = 1.5
				elseif(diff == RUN_DIFF_EXPERT) then
					scale = 2.5
				end
				timer.Simple(0, function() --just to be safe
				np:SetHealth(np:Health()*scale)
				end)]]
				if(callback) then
					callback(np)
				end

				if(!run.enemies) then
					run.enemies = {}
				end
				table.insert(run.enemies, np)
			end
		end
		--to break if the table loop broke
		if(breakk) then break end
	end
end

--proptable - random prop table to spawn from
--addtotable - it puts the prop into this table
local function SpawnRandomProps(proptable, addtotable)
	local enm = 0 --cur item number
	if(#proptable == 0) then return end
	local rand = shuffle(table.Copy(proptable))
	
	for k,v in pairs(rand) do
		if(!v.always and (string.find(v.class, "hack_") and enm == 2) or math.random(1, 10) > 3) then
			continue
		end

		local b = ents.Create(v.class)
		if(b) then
			if(string.find(v.class, "hack_")) then
			enm = enm + 1
			end
			if(v.model) then
				b:SetModel(v.model)
			end
			if(v.skin) then
				b:SetSkin(v.skin)
			end
			if(v.randomskin) then
				b:SetSkin(math.random(b:SkinCount()))
			end
			b:SetPos(v.pos)
			b:SetAngles(v.angle)
			b:Spawn()
			b:Activate()
			if(!v.motion and IsValid(b:GetPhysicsObject())) then
				b:GetPhysicsObject():EnableMotion(false)
			end

			if(v.sound) then
				b:EmitSound(v.sound)
				b:CallOnRemove("removesound", function(ent)
					ent:StopSound(v.sound)
				end)
			end
			if(v.color) then
				b:SetRenderMode(RENDERMODE_TRANSALPHA)
				b:SetColor(v.color)
			end
			if(v.other) then
				for k2,v2 in pairs(v.other) do
					addEnt(v2, addtotable)
				end
			end
			table.insert(addtotable, b)
		end
	end
end
--utility function used in above ^
local function addEnt(v, tbl)
	
	local b = ents.Create(v.class)
	if(b) then
		if(v.model) then
			b:SetModel(v.model)
		end
		if(v.skin) then
			b:SetSkin(v.skin)
		end
		if(v.randomskin) then
			b:SetSkin(math.random(b:SkinCount()))
		end
		b:SetPos(v.pos)
		b:SetAngles(v.angle)
		b:Spawn()
		b:Activate()
		--[[if(!run.other) then
			run.other = {}
		end]]
		if(!v.motion and b:GetPhysicsObject()) then
			b:GetPhysicsObject():EnableMotion(false)
		end

		if(v.sound) then
			b:EmitSound(v.sound)
			b:CallOnRemove("removesound", function(ent)
				ent:StopSound(v.sound)
			end)
		end
		if(v.color) then
			b:SetRenderMode(RENDERMODE_TRANSALPHA)
			b:SetColor(v.color)
		end
		table.insert(tbl, b)
	end
end

--loottable - the list of tables {string, vector} with the string being the loottable
--run - the curused table, it puts it in a table called items in that table
--amt - the max items to spawn
--minamt - the min items to spawn
local function SpawnLoot(loottable, run, amt, minamt)
	local itm = 0 --cur item number
	
	--randomize the item spawns
	local tmpitems = shuffle(table.Copy(loottable)) --dont want to fuck up the original

	for k,v in pairs(tmpitems) do
		if(itm == amt) then
			break --quit spawning if at max
		end
		--if item count equals or is higher than min
		if(itm >= minamt) then 
			--random number if itll continue spawning
			--this should make it less of a chance the more items there are already
			if(math.Rand(0,1) < (itm/amt)) then
				break
			end
		end

		--pick an item out of the table at v[1], and spawn it at v[2]
		--WHEN MAKING TABLES FOR THESE, DONT USE NONE BECAUSE OF THE MIN/MAX ABOVE
		--its unnecessary
		itm = itm+1
		if(!run.items) then
			run.items = {}
		end
		local loottable = v[1]
		--[[
		if(diff == RUN_DIFF_NORMAL) then
		elseif(diff == RUN_DIFF_HARD) then
			if(loottable == "trashrun") then
				loottable = "trashrunrare"
			elseif(loottable == "trashrunrare") then
				loottable = "tier1"
			elseif(loottable == "tier1" and math.random(1,3) != 2) then
				loottable = "tier2"
			end
		elseif(diff == RUN_DIFF_EXPERT) then
			if(loottable == "trashrun") then
				loottable = "trashrunrare"
			elseif(loottable == "trashrunrare") then
				loottable = "tier1"
			elseif(loottable == "tier1" or loottable == "tier2" and math.random(1,5) != 3) then
				loottable = "tier3"
			end
		end
		]]
		nut.plugin.list["loot"]:SpawnAtPos(loottable, v[2], function(item, entity)
			run.items[k] = entity
				
			--hard overwrite becuz its being annoying
			--its likely never going to be above 1 anyway
			if(item.base == "base_junk") then
				item:setQuantity(1)
			end
			if(item.base == "base_ammo") then
				--~33% chance to be max
				if(math.random(0, 2) != 0) then 
					item:setQuantity(math.random(1, item.maxQuantity))
				end
			end
			
			local ent = entity
			timer.Simple(10800, function()
				if(IsValid(ent)) then
					ent:Remove()
				end
			end)

			entity.temp = true
		end)
	end
end


--easy func to get alive things in a table
local function CheckAliveEnemies(table)
	local cnt = 0
	for k,v in pairs(table) do
		if(IsValid(v)) then
			if(v.Health) then
				if(v:Health() > 0) then
					cnt = cnt + 1
				end
			else
				cnt = cnt+1
			end
		end
	end
	return cnt
end
--todo finish args idk wat do
local function InitDefaultTimer(id, obj)
	timer.Create("killallthink"..id, 30, 0, function()
		if(PLUGIN.curUsed[id] == nil) then timer.Remove("killallthink"..id) return end
		local usedarea = PLUGIN.curUsed[id]

		if(usedarea.deleting) then
			if(usedarea.deletetime < CurTime()) then
				PLUGIN.objs[obj].onCleanup(usedarea)

				timer.Remove("killallthink"..id)
				PLUGIN.curUsed[id] = nil
			end
			return
		end

		if(!usedarea.deleting and PLUGIN.objs[obj].checkComplete(PLUGIN.objs[obj], usedarea)) then
			usedarea.deleting = true
			usedarea.deletetime = CurTime() + 1800
		end
	end)

end

local mutantposs = {
	--[[{
		name = "",
		list = {

		},
	},]]
	{
		name = "FLESHES",
		list = {
			"npc_vj_srp_m_flesh"
		},
	},
	{
		name = "DOGS",
		list = {
			"npc_vj_srp_m_dog"
		},
	},
	{
		name = "BOARS",
		list = {
			"npc_vj_srp_m_boar"
		},
	},
}

PLUGIN.objs = {
	--[[
		[1] = {
			name = "name",
			--available = true,
			--needplayers = false,
			onSpawn = function(obj, area, used) 
			end,
			checkComplete = function(obj, used)
			end,
			onCleanup = function(used)
			end
		},
	]]
	--need: mutantSpawns (same as enemySpawns) and mutantTarget, a vector theyll go to
	[1] = {
		name = "Mutant Attack",
		--available = true,
		needplayers = true,
		onSpawn = function(obj, area, used) 
			local mutants = mutantposs[math.random(#mutantposs)]

			if(!area.mutantSpawns) then
				nut.log.addRaw("area "..used.area.." has no mutant spawn table for mutant attack!")
				return
			end

			SpawnEnemies(mutants.list, area.mutantSpawns, used, 
				math.random(3,5), math.random(2,3), --todo scale based on player count?
				function(npc)
					--send them towards the target, whether they get there
					--or not, who can say lmao
					if(npc.MoveToPos and area.mutantTarget) then
						npc:MoveToPos(area.mutantTarget)
					elseif(area.mutantTarget) then
						npc:StopMoving()
						npc:SetLastPosition(area.mutantTarget)

						if npc.IsVJBaseSNPC == true && (npc.IsVJBaseSNPC_Creature == true or npc.IsVJBaseSNPC_Human == true) then
							npc:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH",function(x) 
								if IsValid(npc:GetEnemy()) && npc:Visible(v:GetEnemy()) then
									x:EngTask("TASK_FACE_ENEMY", 0) 
									x.CanShootWhenMoving = true 
									x.ConstantlyFaceEnemy = true
								end
							end)
						else
							np:SetSchedule(SCHED_FORCED_GO_RUN)
						end
					end
				end)

			netstream.Start(player.GetAll(), "fakepdanote", "WARNING: "..mutants.name.." APPROACHING "..area.name)

			InitDefaultTimer(used["area"], used["obj"])
		end,
		checkComplete = function(obj, used)
			return CheckAliveEnemies(used.enemies) == 0
		end,
		onCleanup = function(used)
			--dont actually need to do anything for this lol
		end
	},
	[2] = {
		name = "Rogue Camp",
		--available = true,
		--needplayers = false,
		onSpawn = function(obj, area, used) 
			used.other = used.other or {}
			SpawnRandomProps(area.props, used.other)

			local enem = {
				--"nb_srp_anorak_bandit",
				"npc_vj_srp_anorak_rogue",
			}
			local canspawn = true			
			if(#ents.FindByClass("sky_bb") == 0) then canspawn = false end --no bountyboards spawned rn

			local spawnedBounty = false
			SpawnEnemies(enem, area.enemySpawns, used,
				math.random(4,5), math.random(2,3),
				function(npc)
					npc.DisableWandering = true
					if(!canspawn) then return end
					
					if(!spawnedBounty && math.random(1,6) == 2) then
						spawnedBounty = true
						local job = nut.plugin.list.bountyboard.jobTemps["banditbounty"]

						local id, reward = job.generate(npc)
						if(!id) then return end --uh just in case

						local tbl = {
							name = Format(job.name, unpack(job.format(npc, area, reward))),
							unique = true,
							type = "banditbounty",
							itemid = id,
							["reward"] = reward
						}
						nut.plugin.list.bountyboard:ForceJob(tbl)
					end
				end) --again prob scale

			SpawnLoot(area.itemSpawns, used, math.random(4,6), math.random(2,3))

			InitDefaultTimer(used["area"], used["obj"])
		end,
		checkComplete = function(obj, used)
			return CheckAliveEnemies(used.enemies) == 0
		end,
		onCleanup = function(used)
			for k,v in pairs(used.enemies or {}) do
				if(IsValid(v)) then v:Remove() end
			end
			--leave items lol
			for k,v in pairs(used.other or {}) do
				if(IsValid(v)) then v:Remove() end
			end
		end
	},
	[3] = {
		name = "Mutant Lair",
		--available = true,
		--needplayers = false,
		onSpawn = function(obj, area, used) 
			used.other = used.other or {}
			SpawnRandomProps(area.props, used.other)

			local enem = {
				--"nb_srp_anorak_bandit",
				{"npc_vj_srp_m_bloodsucker"},
				{"npc_vj_srp_m_dog"},
				{"npc_vj_srp_m_snork"},
			}
			local eid = math.random(#enem)

			SpawnEnemies(enem[eid], area.enemySpawns, used,
				math.random(5,7), math.random(3,4), 
				function(npc)
					npc.DisableWandering = true
				end) --again prob scale

			if(#ents.FindByClass("sky_bb") == 0) then return end --no bountyboards spawned rn
	
			if(math.random(1,4) == 2) then
				local job = nut.plugin.list.bountyboard.jobTemps["mutantbounty"]

				local item, id, reward = job.generate()
				if(!id) then return end --uh just in case

				local tbl = {
					name = Format(job.name, unpack(job.format(eid, area, reward))),
					unique = true,
					type = "mutantbounty",
					itemid = id,
					["reward"] = reward
				}
				nut.plugin.list.bountyboard:ForceJob(tbl)
				
				item:spawn(area.itemSpawns[math.random(#area.itemSpawns)][2]+Vector(0,0,15))
			end

			InitDefaultTimer(used["area"], used["obj"])
			--SpawnLoot(area.itemSpawns, used, math.random(4,6), math.random(2,3))

		end,
		checkComplete = function(obj, used)
			return CheckAliveEnemies(used.enemies) == 0
		end,
		onCleanup = function(used)
			for k,v in pairs(used.enemies or {}) do
				if(IsValid(v)) then v:Remove() end
			end
			--leave items lol
			for k,v in pairs(used.other or {}) do
				if(IsValid(v)) then v:Remove() end
			end
		end
	},
}