local PLUGIN = PLUGIN

PLUGIN.sceneData = PLUGIN.sceneData or {}

if(SERVER) then
hook.Add("InitPostEntity", "loadscenedata", function()
	PLUGIN.sceneData = nut.data.get("lootScenes", {}, true, true)
end)
end

function PLUGIN:sceneDataSave()
	nut.data.set("lootScenes", PLUGIN.sceneData, true, true)
end

nut.command.add("lootscenecreate", {
	syntax = "<string type>",
	operatorOnly = true,
	onRun = function(client, arguments)
		if(!arguments[1]) then return "You must specify a type! (ex corpse)" end
		local tr = client:GetEyeTrace()
		if(!tr.Entity) then return "You must be looking at an entity!" end

		if(tr.Entity:GetClass() == "sky_tempstorage") then
			tr.Entity.dontcreate = nil
		end
		duplicator.SetLocalPos(tr.Entity:GetPos())
		local dup = duplicator.Copy(tr.Entity)
		duplicator.SetLocalPos(Vector(0,0,0))

		PLUGIN.sceneData[arguments[1]] = PLUGIN.sceneData[arguments[1]] or {}
		table.insert(PLUGIN.sceneData[arguments[1]], dup)
		PLUGIN:sceneDataSave()

		return "Added scene to data"
	end
})
PLUGIN.maxSceneItems = 4

PLUGIN.curScenes = PLUGIN.curScenes or {} --current items, when one is made its inserted into this with the index being the point it was spawned at
--[[
	{
		scene = entity of scene
		items = table of items
	}
]]
PLUGIN.scenePos = PLUGIN.scenePos or {} --spawn positions
--[[ scenePos table def
{
    pos = vector (the position of the point)
    detectionRange = number (if a player is in the range of this, its removed from the list for spawning then)
	spawnRange = number (ranger around the center of the spawn that items are dropped)
	table = string (the tableid of this scenePos)
	scene = string (id of the scenepos)
}
]]

function PLUGIN:CreateSceneSpawn(pos, scenetype, loottype, spawnrange, detectionrange)
    local new = {}
    new.pos = pos
	new.detectionRange = detectionrange
	new.spawnRange = spawnrange 
	print("loot "..loottype)
	PrintTable(PLUGIN.lootTables)
    if(!PLUGIN.lootTables[loottype]) then
        nut.log.addRaw("A scene spawn point tried to be made, but the table wasnt valid!")
        return
    end
	new.table = loottype
	if(!self.sceneData[scenetype]) then
		nut.log.addRaw("A scene spawn point tried to be made, but the scene type wasnt valid!")
		return
	end
	new.scene = scenetype

    table.insert(self.scenePos, new)

    self:SaveData()
	
end

--spawn a round of loot
--will not try to spawn loot at points that have players near them
function PLUGIN:SpawnSceneRound()
	if(!self.scenePos) then self.scenePos = {} end
    if(#self.scenePos == 0) then return end

    local realL = {}
    for k,v in pairs(self.lootTables) do
        realL[k] = {}
        for k2, v2 in pairs(v.loot) do
            for i=1, v2[2] do
                table.insert(realL[k], v2[1])
            end
        end
    end

    for k,v in pairs(self.scenePos) do
		if(self:IsPointClear(k)) then 
			if(math.random(1,100) < 10) then return end
			if(self.curScenes[k]) then
				local good = 0
				local num = table.maxn(self.curScenes[k].scene)
				if(self.curScenes[k].scene and IsValid(self.curScenes[k].scene[num]) and self.curScenes[k].scene[num]:GetClass() == "sky_tempstorage") then
					return --it gets rid of itself
				end
				if(!self.curScenes[k].items) then
					local ents = self.curScenes[k].scene
					for _,its in pairs(ents) do
						SafeRemoveEntity(its)
					end
					self.curScenes[k] = nil
					return
				end
				for e,d in pairs(self.curScenes[k].items) do
					if(!IsValid(d)) then
						good = good+1
					end
				end
				if(good == #self.curScenes[k].items) then
					local ents = self.curScenes[k].scene
					for _,its in pairs(ents) do
						SafeRemoveEntity(its)
					end
					self.curScenes[k] = nil
				end
				return
			end

            --if(#self.curItems == self.maxItems) then return end
            if(!realL[v.table]) then
                nut.log.addRaw("Scene spawn position "..k.." was deleted: The table it used is invalid now!", FLAG_WARNING)
                table.remove(self.scenePos, k)
                self:SaveData()
                return
			end
			if(!self.sceneData[v.scene]) then
                nut.log.addRaw("Scene spawn position "..k.." was deleted: The scene type it used is invalid now!", FLAG_WARNING)
                table.remove(self.scenePos, k)
                self:SaveData()
                return
			end


			local actualPos = v.pos + Vector(0,0,18) --make it a little higher
			duplicator.SetLocalPos(actualPos)
			duplicator.SetLocalAng(Angle(0, math.random(0,360), 0))
			local sceneee = self.sceneData[v.scene][math.random(1,#self.sceneData[v.scene])]
			local paste = duplicator.Paste(nil, sceneee.Entities, sceneee.Constraints)
			duplicator.SetLocalPos(Vector(0,0,0))
			duplicator.SetLocalAng(Angle(0,0,0))
			self.curScenes[k] = {}
			self.curScenes[k].scene = paste

			PrintTable(paste)
			if(paste[table.maxn(paste)]:GetClass() == "sky_tempstorage") then --should only be 1
				local num = table.maxn(paste)
				paste[num].itemtype = v.table
				if(!paste[num].invname) then 
					nut.log.addRaw("hey just letting you know temp storage doesnt have invname sooo do another way :(")
				else
				nut.item.newInv(0, "tst"..paste[num].invname, function(inventory)
					inventory.vars.isTempStorage = true
					inventory.vars.isStorage = true
					--print(inventory:getID())
					if (IsValid(paste[num])) then
						paste[num]:setInventory(inventory)
					end
				end)
				end
				return
			end

			for i=1, math.random(1,self.maxSceneItems) do
            local it = table.Random(realL[v.table])
            if(it == "none") then continue end --dont spawn anything

            local item = nut.item.get(it)
            if(!item) then continue end --invalid item
            
            local data = {}
            local durabilityMin, durabilityMax = self.lootTables[v.table].durability[1], self.lootTables[v.table].durability[2]
            -- random mag amt if ammo, random durability if wep
            if(item.base == "base_mweapons") then
                data["durability"] = math.random(durabilityMin, durabilityMax)
            end
            if(item.base == "base_suit") then
                data["armor"] = {}
                for k,v in pairs(item.armor) do
                    data["armor"][k] = v
                    data["armor"][k].durability = math.random(durabilityMin, durabilityMax)
                end
            end
            if(item.base == "base_magazines") then
                if(self.lootTables[v.table].randomAmmo != 2) then
                    if(self.lootTables[v.table].randomAmmo == 1) then
                        if(!item.ammoBox) then
                            data["mag"] = math.random(0, item.ammoMax)
                        end
                    else
                        data["mag"] = math.random((item.ammoBox and 1) or 0, item.ammoMax)
                    end
                end
            end

            nut.item.spawn(it, actualPos+Vector(math.random(-v.spawnRange, v.spawnRange), math.random(-v.spawnRange, v.spawnRange), 0), function(item, entity)
				self.curScenes[k].items = self.curScenes[k].items or {}
				table.insert(self.curScenes[k].items, entity)
                    
                entity.temp = true
			end, nil, data)
			end
        end
    end
end

if(SERVER) then
hook.Add("InitPostEntity", "LootSceneSpawning", function()
	timer.Simple(10, function()
		PLUGIN:SpawnSceneRound() --spawn an initial round of items       
	end)
	timer.Create("LootSceneSpawningT", 1, 0, function()
	--	if(player.GetCount() <= 5) then return end --we dont want stuff to spawn while there is no players
		if(PLUGIN.curSpawnRate > PLUGIN.curSpawnTime) then
			return --its not time yet
		end

		--since scenes are rare dont need to check if over, probably will never be

		PLUGIN:SpawnSceneRound() --do eeeet
	end)
end)
end

nut.command.add("lootscenespawn", {
	syntax = "<string scenetype> <string loottype> <number spawnRange> <number detectionRange>",
	operatorOnly = true,
	onRun = function(client, arguments)
		local scenetype = arguments[1]
		local loottype = arguments[2]
		local spawnrange = tonumber(arguments[3])
		local detectrange = tonumber(arguments[4])
		if(!PLUGIN.sceneData[scenetype]) then return "Scenetype doesnt exist!" end
		if(!PLUGIN.lootTables[loottype]) then return "Loottype doesnt exist!" end
		
		PLUGIN:CreateSceneSpawn(client:GetEyeTrace().HitPos, scenetype, loottype, spawnrange, detectrange)
		return "Loot scene spawn point created!"
	end
})


nut.command.add("lootsceneremove", {
	syntax = "<number id>",
    adminOnly = true,
	onRun = function(client, arguments)
        if(PLUGIN.scenePos[tonumber(arguments[1])]) then
            table.remove(PLUGIN.scenePos, arguments[1])
            PLUGIN:SaveData()
        else
            return "There is no point with that ID!"
        end

        return "Loot scene spawn point #"..arguments[1].." removed!"
	end
})