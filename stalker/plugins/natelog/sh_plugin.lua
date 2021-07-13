PLUGIN.name = "nLogs"
PLUGIN.author = "Nate"
PLUGIN.desc = "New logging system to be used with an external program for administration."

--[[


    if file.Exists( "nLogs", "DATA" ) and !file.Exists( "nLogs/eventlog.json", "DATA" ) then
        print("[nLog] No nLog file, creating. . .")
        file.Write("nLogs/eventlog.json", logHeader) --create the log file
        logFile = "nLogs/eventlog.json"

    elseif !file.Exists( "nLogs", "DATA" ) then
        print("[nLog] No nLog directory or nLog file, creating. . .")
        file.CreateDir( "nLogs" ) -- create directory
        file.Write("nLogs/eventlog.json", logHeader) --create the log file
        logFile = "nLogs/eventlog.json"
    else
        logFile = "nLogs/eventlog.json"
    end

    TODO:
        LUA: 
            Seperate Logs per session
        Python: 
            Dynamically create list of all filter types

--]]


nLog = nLog or {}

local timeFormat = "%H:%M:%S %d/%m/%Y"

if(SERVER) then
    local logTypes = {}
	nLog.logFile = nLog.logFile or nil

    local thisIP = game.GetIPAddress()
    if thisIP == "loopback" then
        thisIP = "singleplayer"
    end
    --local logHeader = "~~ nLog Created @ " .. os.time() .. " | ".. os.date(timeFormat, os.time()) .. " ~~\nTime Formating: " .. timeFormat .. "\nServer IP: "..thisIP.."\n~~ Begin nLogging ~~\n"
    local logHeader = "[\n"
    --Preliminary checks to make sure log dir exist
    if !file.Exists( "nLogs", "DATA" ) then
        print("[nLog] No nLog directory or nLog file, creating. . .")
        file.CreateDir( "nLogs" ) -- create directory
    end
	--thisll fix it making new files on refreshes
	if(!nLog.logFile) then
		print("HOW")
	    nLog.logFile = "nLogs/eventlog_"..os.time()..".json"
	    file.Write(nLog.logFile, logHeader) --create the log file
	end
    
    function nLog.addType(newType) --adds new log type
        table.insert(logTypes, string.lower(newType))
    end

	hook.Add("ShutDown", "closelog", function()
		if(nLog.logFile) then
			file.Append(nLog.logFile, "]")
		end
	end)
	
	nLog.inited = nLog.inited or false
    function nLog.addLog(type, logString, logTags) --returns true if event is logged, false otherwise.  --file.Write()
        --local keys = { ... }
        if assert(nLog.logFile, "Attempting add nLog entry, but nLog file does not exist or is still nil!", true) then
            if logString == "" or logString == nil then
                logstring = "This log has no message, please fix."
            end
            local entryTable = {
                time = os.time(),
                entrytype = type,
                message = logString,
                tags = logTags,
                map = game.GetMap(),   
            }
            local openedCurCont
			--im fairly certain this was the cause of the lag, so im rewriting it so it appends to the log instead of grabbing it and rewriting it every time
            local entryJson = util.TableToJSON(entryTable, true) .. "\n"
            --local curCont = file.Read(logFile)
            if !nLog.inited then--curCont == logHeader then
                openedCurCont = "\n"--curCont:sub(1, -2) .. "\n"
				nLog.inited = true
            else
                openedCurCont = ",\n"--curCont:sub(1, -2) .. ",\n"
            end
            local newCont = openedCurCont .. entryJson
            file.Append(nLog.logFile, newCont)
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
                ["vendor"] = vendor:getName(),
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

    function PLUGIN:OnPlyUseCommand(client, text, match, realCommand, arguments)

        local character = client:getChar()

        local tags = {
            ["sender-steamid"] = client:SteamID64(),
            ["charid"] = character:getID(),
            ["charname"] = character:getName(),
            ["pos"] = tostring(client:GetPos()),
            ["command"] = tostring(realCommand),
            ["command-text"] = tostring(text),
            ["command-match"] = tostring(match)
        }

        local message = (IsValid(client) and client:steamName() or "PLAYER") .. " as " .. character:getName() .. " used command ".. text
        nLog.addLog("command", message, tags)

	end

    function PLUGIN:PlayerAuthed(client, steamID, uniqueID)
        local tags = {
            ["sender-steamid"] = steamID,
            ["uniqueID"] = uniqueID,
            ["sender-steamname"] = client:steamName()
        }
        local message = (IsValid(client) and client:steamName() or "PLAYER") .. " joined the server."
        nLog.addLog("connect", message, tags)
    end

    function PLUGIN:PlayerDisconnected(client)
        local tags = {
            ["sender-steamid"] = client:SteamID64(),
            --["uniqueID"] = client:UniqueID()
            ["sender-steamname"] = client:steamName()
        }
        local message = (IsValid(client) and client:steamName() or "PLAYER") .. " left the server."
        nLog.addLog("disconnect", message, tags)
    end

    function PLUGIN:PlayerDeath(client, inflictor, attacker)
        if client == attacker then
            local tags = {
                ["death-type"] = "suicide",
                ["inflictor"] = inflictor:GetName(),
                ["victim"] = {
                    ["steamid"] = client:SteamID64(),
                    ["charname"] = client:Name(),
                    ["pos"] = tostring(client:GetPos()),
                }
            }
            local message = client:Name() .. " killed themselves."
        else
            local tags = {
                ["death-type"] = "kill",
                ["inflictor"] = inflictor:GetName(),
                ["attacker"] = {
                    ["steamid"] = attacker:IsPlayer() and attacker:SteamID64() or attacker:GetClass(),
                    ["charname"] = attacker:GetName() ~= "" and attacker:GetName() or attacker:GetClass() or "No Name",
                    ["pos"] = tostring(attacker:GetPos()) or "No Position",
                },
                ["victim"] = {
                    ["steamid"] = client:SteamID64(),
                    ["charname"] = client:Name(),
                    ["pos"] = tostring(client:GetPos()),
                }
            }
            local message = (attacker:GetName() ~= "" and attacker:GetName() or attacker:GetClass()).." ("..attacker:GetClass()..") killed "..client:Name()
        end
        nLog.addLog("plydeath", message, tags)
    end

    function PLUGIN:OnPlyDowned(atk, ply)
        local attacker, client = atk, ply
        local tags = {
            ["death-type"] = "kill",
            ["attacker"] = {
                ["steamid"] = attacker:IsPlayer() and attacker:SteamID64() or attacker:GetClass(),
                ["charname"] = attacker:GetName() ~= "" and attacker:GetName() or attacker:GetClass() or "No Name",
                ["pos"] = tostring(attacker:GetPos()) or "No Position",
            },
            ["victim"] = {
                ["steamid"] = client:SteamID64(),
                ["charname"] = client:Name(),
                ["pos"] = tostring(client:GetPos()),
            }
        }
        local message = (attacker:GetName() ~= "" and attacker:GetName() or attacker:GetClass()).." ("..attacker:GetClass()..") downed "..client:Name()
        nLog.addLog("plydown", message, tags)
    end
    
    function PLUGIN:PlayerHurt(client, attacker, health, damage)
        local health, damage = health, damage
        local tags = {
            ["attacker"] = {
                ["steamid"] = attacker:IsPlayer() and attacker:SteamID64() or attacker:GetClass(),
                ["charname"] = attacker:GetName() ~= "" and attacker:GetName() or attacker:GetClass() or "No Name",
                ["pos"] = tostring(attacker:GetPos()) or "No Position",
                ["health"] = tostring(health),
                ["damage"] = tostring(damage)
            },
            ["victim"] = {
                ["steamid"] = client:SteamID64(),
                ["charname"] = client:Name(),
                ["pos"] = tostring(client:GetPos()),
            }
        }
        local message = (attacker:IsPlayer() and attacker:Name() or attacker:GetClass()) .." hurt "..client:Name().." for " .. damage .. "(" .. health+damage .."->".. health ..")"
        nLog.addLog("plyhurt", message, tags)
    end

    function PLUGIN:OnCharMoney(client, amount)
        local client, amount = client, amount
        local tags = {
            ["sender-steamid"] = client:SteamID64(),
            ["charname"] = client:Name(),
            ["pos"] = client:GetPos(),
            ["amount-changed"] = tostring(amount)
        }
        if amount < 0 then
            local message = client:Name() or "CHARACTER" .. ' has lost ' .. amount .. ' in money'
        else
            local message = client:Name() or "CHARACTER" .. ' has gained ' .. amount .. ' in money'
        end
        nLog.addLog("money", message, tags)
    end

    function PLUGIN:OnPlayerPurchaseDoor(client, entity, buy)
        local client, entity, buy = client, entity, buy
        local intertype
        if buy then
            intertype = "bought"
        else
            intertype = "sold"
        end
        local tags = {
            ["sender-steamid"] = client:SteamID64(),
            ["charname"] = client:Name(),
            ["pos"] = client:GetPos(),
            ["doorinteraction"] = intertype .. ' door'
        }
        local message = client:Name() or "CHARACTER" .. ' ' .. intertype .. ' a door'
        nLog.addLog("doorownership", message, tags)
    end

    --vendor buy, sell, exit, access


end



