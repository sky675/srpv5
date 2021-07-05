PLUGIN.name = "nLogs"
PLUGIN.author = "Nate"
PLUGIN.desc = "New logging system to be used with an external program for administration."

--[[


    local Entry = {


--]]

nLog = nLog or {}

local timeFormat = "%H:%M:%S %d/%m/%Y"
local logFile = nil


if(SERVER) then
    local logTypes = {}

    local thisIP = game.GetIPAddress()
    if thisIP == "loopback" then
        thisIP = "singleplayer"
    end
    --local logHeader = "~~ nLog Created @ " .. os.time() .. " | ".. os.date(timeFormat, os.time()) .. " ~~\nTime Formating: " .. timeFormat .. "\nServer IP: "..thisIP.."\n~~ Begin nLogging ~~\n"
    local logHeader = "[\n"
    --Preliminary checks to make sure log files exist
    if file.Exists( "data", "nLogs" ) and !file.Exists( "data/nLogs", "eventlog.json" ) then
        print("[nLog] No nLog file, creating. . .")
        file.Write("nLogs/eventlog.json", logHeader) --create the log file
        logFile = "nLogs/eventlog.json"

    elseif !file.Exists( "data", "nLogs" ) then
        print("[nLog] No nLog directory or nLog file, creating. . .")
        file.CreateDir( "nLogs" ) -- create directory
        file.Write("nLogs/eventlog.json", logHeader) --create the log file
        logFile = "nLogs/eventlog.json"
    else
        logFile = "nLogs/eventlog.json"
    end
    

    function nLog.addType(newType) --adds new log type
        table.insert(logTypes, string.lower(newType))

    end

    function nLog.addLog(type, logString, logTags) --returns true if event is logged, false otherwise.  --file.Write()
        --local keys = { ... }
        if assert(logFile, "Attempting add nLog entry, but nLog file does not exist or is still nil!", true) then
            
            local entryTable = {
                time = os.time(),
                entrytype = type,
                message = logString,
                tags = logTags,
                map = game.GetMap(),   
            }
            local openedCurCont
            local entryJson = util.TableToJSON(entryTable, true) .. "\n]"
            local curCont = file.Read(logFile)
            if curCont == logHeader then
                openedCurCont = curCont:sub(1, -2) .. "\n"
            else
                openedCurCont = curCont:sub(1, -2) .. ",\n"
            end
            local newCont = openedCurCont .. entryJson
            file.Write(logFile, newCont)
            --[[
            local logStamp = "[" .. os.time() .. "]["..string.upper(game.GetMap()).."][" .. string.upper(type) .."]"
            local keyStamp
            if select("#", keys) == 0 or nil then
                keyStamp = "[NO KEYS]"
            else
                keyStamp = "[KEYS: " 
                for _, v in ipairs(keys) do
                    keyStamp = keyStamp .. "{" .. tostring(v) .. "}"
                end
                keyStamp = keyStamp .. "]"
            end
            local entry = logStamp .. keyStamp .. logString .. "\n"
            --]]

            

        end
    end

    hook.Add("PostPlayerSay", "nLogChat", function(client, message, chatType, anonymous)
        --local sender
        local tags = {
            ["chattype"] = (chatType and chatType:upper() or "??"),
            ["sender"] = client:getChar():getName(),
            ["sender-steamid"] = client:SteamID64(),
            ["anonymous"] = tostring(anonymous)
        }

        nLog.addLog("chat", message, tags)
        
        --if IsValid(client) then nLog.addLog("chat", message, "Chat Type: " .. (chatType and chatType:upper() or "??"), "CharName: " .. client:getChar():getName(), "SteamID: " .. client:SteamID64(),"Anon: " .. tostring(anonymous))
        --else nLog.addLog("chat", message, "Chat Type: " .. (chatType and chatType:upper() or "??"), "Sender: Console", "Anon: " .. tostring(anonymous)) end
    end)

	function PLUGIN:CharacterLoaded(id)
		local character = nut.char.loaded[id]
		local client = character:getPlayer()
        local tags = {
            ["sender-steamid"] = client:SteamID64(),
            ["charid"] = character:getID(),
            ["charname"] = character:getName(),
        }

        local message = (IsValid(client) and client:steamName() or "PLAYER") .. " loaded character "..character:getName() .. " #"..character:getID()
        nLog.addLog("charload", message, tags)
	end

	function PLUGIN:OnCharacterDelete(client, id)
        local tags = {
            ["sender-steamid"] = client:SteamID64(),
            ["charid"] = id,
        }

        local message = (IsValid(client) and client:steamName() or "COMMAND") .. " deleted character ID#"..id
        nLog.addLog("chardelete", message, tags)

	end

	function PLUGIN:OnCharCreated(client, character)
        local tags = {
            ["sender-steamid"] = client:SteamID64(),
            ["charid"] = character:getID(),
            ["charname"] = character:getName(),
        }

        local message = (IsValid(client) and client:steamName() or "PLAYER") .. " created character "..character:getName() .. " #"..character:getID()
        nLog.addLog("charcreate", message, tags)

	end
	
	function PLUGIN:OnTakeShipmentItem(client, itemClass, amount)
		local itemTable = nut.item.list[itemClass]
        local tags = {
            ["sender-steamid"] = client:SteamID64(),
            ["itemname"] = itemTable.name,
            ["charname"] = client:Name(),
            ["takeamount"] = amount,
            ["itemname"] = itemTable.name
        }

        local message = (client:Name() .. " took " .. amount .. "x "..itemTable.name.." from shipment.")
        nLog.addLog("shipmenttake", message, tags)

	end

	function PLUGIN:OnCreateShipment(client, shipmentEntity)
        local tags = {
            ["sender-steamid"] = client:SteamID64(),
            ["charname"] = client:Name(),
        }

        local message = (client:Name() .. " created a shipment.")
        nLog.addLog("shipmentcreate", message, tags)
    end

	function PLUGIN:OnCharTradeVendor(client, vendor, item, issell)
        --local tradeLingo = " bought"
        if (!issell) then
            local tags = {
                ["sender-steamid"] = client:SteamID64(),
                ["charname"] = client:Name(),
                ["vendor"] = vendory:getName(),
                ["itemname"] = item:getName(),
                ["issell"] = tostring(issell)
            }
            --if issell then tradeLingo = " sold" end
            local message = (client:Name().." ("..client:steamName()..")" .. " bought " ..item:getName().." from "..vendor:getName())
            nLog.addLog("vendortrade", message, tags)
        end
        --nut.log.addRaw(client:Name().." ("..client:steamName()..") bought "..item:getName().." from "..vendor:getName())
	end

    function PLUGIN:OnPlayerObserve(client, state, clientPos)
        local pos = tostring(clientPos)
        if(state) then --entered
            local tags = {
                ["sender-steamid"] = client:SteamID64(),
                ["charname"] = client:Name(),
                ["position"] = pos
            }
    
            local message = (client:Name() .. " entered observer @ ".. pos)
            nLog.addLog("observer", message, tags)
        else --exited
            local tags = {
                ["sender-steamid"] = client:SteamID64(),
                ["charname"] = client:Name(),
                ["position"] = pos
            }
    
            local message = (client:Name() .. " exited observer @ ".. pos)
            nLog.addLog("observer", message, tags)

        end
    end

	function PLUGIN:OnPlayerInteractItem(client, action, item)
		if (type(item) == "Entity") then
			if (IsValid(item)) then
				local itemID = item.nutItemID
				item = nut.item.instances[itemID]
			else
				return
			end
		elseif (type(item) == "number") then
			item = nut.item.instances[item]
		end

		if (!item) then
			return
		end
        local tags = {
            ["pos"] = tostring(client:GetPos()),
            ["sender-steamid"] = client:SteamID64(),
            ["charname"] = client:Name(),
            ["itemname"] = item.name,
            ["itemid"] = item.id,
            ["action"] = action
        }

        local message = (client:Name() .. " tried " .. action .. " on " .. item.name .. " #" .. item.id)
        nLog.addLog("item", message, tags)
	end

    function PLUGIN:OnPlyAttack(atk, pl, wep, addtlinfo, msg)
        local tags = {
            ["attacker"] = {
                ["steamid"] = atk:SteamID64(),
                ["charname"] = atk:Name(),
                ["pos"] = tostring(atk:GetPos()),
            },
            ["victim"] = {
                ["steamid"] = pl:SteamID64(),
                ["charname"] = pl:Name(),
                ["pos"] = tostring(pl:GetPos()),
            },
            ["weapon"] = ((wep and (wep.ClassName or wep:GetClass())) or "other"),
            ["additional"] = addtlinfo,

        }

        local message = (msg)
        nLog.addLog("attack", message, tags)
    end

end



