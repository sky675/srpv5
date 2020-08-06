local PLUGIN = PLUGIN

nut.command.add("directorspawn", {
	desc = "Add a spawn at your current position, it will spawn [class] or synth enemies at a random point in a ring around pos from rangeMin to rangeMax.",
	syntax = "<number rangeMin> <number rangeMax> [string class]",
    adminOnly = true,
	onRun = function(client, arguments)
        local pos = client:GetPos()
        PLUGIN:CreatePoint(pos, {tonumber(arguments[1]), tonumber(arguments[2])}, 1, false, arguments[3])
        --no need to save, it does it in createpoint, and removepoint too

        return "Director spawn point made!"
	end
})

nut.command.add("directorremove", {
	syntax = "<number id>",
	desc = "Remove a spawn with that id, show ids with directorshow",
    adminOnly = true,
	onRun = function(client, arguments)
        if(PLUGIN.spawnPos[tonumber(arguments[1])]) then
            PLUGIN:RemovePoint(tonumber(arguments[1]))
        else
            return "There is no point with that ID!"
        end

        return "Director spawn point #"..arguments[1].." removed!"
	end
})

nut.command.add("directorshow", {
    syntax = "[number timeShown]",
	desc = "Show all spawn points on the map for timeShown or 20 seconds",
    adminOnly = true,
    onRun = function(client, arguments)
        local time = 20
        if(tonumber(arguments[1])) then 
            time = tonumber(arguments[1])
        end
        
    local points = PLUGIN.spawnPos
    local limP = {}

    for k,v in pairs(points) do
        limP[k] = v[1]
    end

    net.Start("RecDirPoints")
    net.WriteTable(limP)
    net.WriteInt(time, 32)
    net.Send(client)

        return "Director spawn points showing for "..time.." seconds."
    end
})

nut.command.add("directorstats", {
	syntax = "<number id>",
	desc = "Returns a notify for stats about the specified point (see with directorshow).",
    adminOnly = true,
	onRun = function(client, arguments)
        local point
        if(PLUGIN.spawnPos[tonumber(arguments[1])]) then
            point = PLUGIN.spawnPos[tonumber(arguments[1])]
        else
            return "There is no point with that ID!"
        end

        local range = point[2]
        local detect = point[3]
        local curLv = point[4]
		local disabl = point["disabled"]
		local class = point["class"]

        return "Stats for point #"..arguments[1]..": range:"..range[1]..","..range[2].." detectionRange:"..detect.." currentLevel:"..curLv.." isDisabled:"..tostring(disabl or false).." class:"..(class or "default")
	end
})

nut.command.add("directordisable", {
	syntax = "<number id>",
	desc = "Disable specified point (see points with directorshow)",
    adminOnly = true,
	onRun = function(client, arguments)
        if(PLUGIN.spawnPos[tonumber(arguments[1])]) then
            local p = PLUGIN.spawnPos[tonumber(arguments[1])]
            local old = p["disabled"] or false

            p["disabled"] = !old
            PLUGIN:SaveData()

            local yes = "disabled!"
            if(old) then
                yes = "enabled!"
            end

            return "Director spawn point #"..arguments[1].." "..yes
        end
	end
})
