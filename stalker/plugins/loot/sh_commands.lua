local PLUGIN = PLUGIN

nut.command.add("lootspawn", {
	desc = "Create a lootspawn at where you're pointing at that uses tableid and detectionRange as its detectionRange",
	syntax = "<number detectionRange> <string tableid>",
    adminOnly = true,
	onRun = function(client, arguments)
        local pos = client:GetEyeTrace().HitPos
        PLUGIN:CreateSpawn(pos, tonumber(arguments[1]), arguments[2])
        --no need to save, it does it in createspawn

        return "Loot spawn point created! Check the logs to see if it was successful in creating it."
	end
})

nut.command.add("createrandommag", {
	syntax = "<string itemid>",
	desc = "Creates a magazine/ammo box with a random ammo count",
	adminOnly = true,
	onRun = function(client, arguments)
		local item = nut.item.get(arguments[1])
		if(!item) then return "Not a valid item!" end

		if(item.base != "base_magazines" and item.uniqueID != "gasmask" and item.uniqueID != "gasfilter") then 
			return "This command only works on magazines/ammo boxes and gas items!"
		end

		if(item.uniqueID == "gasmask") then
			local data = {}
			local filt = math.random(5, 240)
			data.Filter = filt
			data.FilterDuration = filt
			data.GasmaskHealth = math.random(1,99)

			local magw, magh = item.width, item.height
		
			if(inv:findEmptySlot(magw, magh)) then
				inv:add(arguments[1], 1, {["gasdata"] = data})
				return "Added!"
			end
		end
		if(item.uniqueID == "gasfilter") then
			local data = {}
			local filt = math.random(5, 240)
			data.filter = filt

			local magw, magh = item.width, item.height
		
			if(inv:findEmptySlot(magw, magh)) then
				inv:add(arguments[1], 1, data)
				return "Added!"
			end
		end

		local data = {}
		data["mag"] = math.random(0, item.ammoMax)

		local inv = client:getChar():getInv()
        local magw, magh = item.width, item.height
		
        if(inv:add(arguments[1], 1, data)) then
			nut.item.spawn(arguments[1], client:getItemDropPos(), nil, nil, data)
			return "Added!"
		else
			return "You dont have room for the item!"
		end
	end
})

nut.command.add("lootremove", {
	syntax = "<number id>",
	desc = "Remove specified loot point, see lootshow for positions",
    adminOnly = true,
	onRun = function(client, arguments)
        if(PLUGIN.spawnPos[tonumber(arguments[1])]) then
            table.remove(PLUGIN.spawnPos, arguments[1])
            PLUGIN:SaveData()
        else
            return "There is no point with that ID!"
        end

        return "Loot spawn point #"..arguments[1].." removed!"
	end
})

nut.command.add("lootshow", {
    syntax = "[number timeShown]",
	desc = "Show all loot points for timeShown or 20 seconds",
    adminOnly = true,
    onRun = function(client, arguments)
        local time = 20
        if(tonumber(arguments[1])) then 
            time = tonumber(arguments[1])
        end
        
	local points = PLUGIN.spawnPos
	local scenes = PLUGIN.scenePos
    local limP = {p = {}, s = {}}

    for k,v in pairs(points) do
        limP.p[k] = v.pos
	end
	for k,v in pairs(scenes) do
		limP.s[k] = v.pos
	end

    net.Start("RecLotPoints")
    net.WriteTable(limP)
    net.WriteInt(time, 32)
    net.Send(client)

        return "Loot spawn points showing for "..time.." seconds."
    end
})