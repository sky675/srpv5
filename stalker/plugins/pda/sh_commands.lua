--icly, all chat messages in ami are automatically translated to your set language
--for automated messages, its the equivalent in that english,
--for user messages its machine translated (such as google translate),
--so icly its not always perfect
nut.command.add("pdalocal", {
	desc = "Use local channel, requires a PDA",
	syntax = "<string message>",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		local message = table.concat(arguments, " ")
        local item = client:HasPDA()
        if(!item) then return "You need a PDA that is turned on to use PDA commands." end
		if(client:getNetVar("isjammed")) then return "Something is preventing you from sending PDA messages." end
        if(!PDA_AVAILABLE) then return "The chat servers are currently unavailable." end

        local anonymous = false

        if(client:HasPDA()) then
            if(client:GetPDAHandle() == "invalid" and !client:GetPDAMono()) then return "You need to set up your handle first! Open the PDA and go to Settings to do so." end
        end
        if(nut.plugin.list["pda"].globBan[client:GetPDAID()]) then
            return "You have been banned from using local chat by a system administrator."
        end


		if(message:sub(1, 1) == "?" and message:sub(2):find("%S")) then
			anonymous = true
			message = message:sub(2)
		end

        message = client:GetPDAHandle().."|"..message

		if(item) then
			nut.chat.send(client, "pdalocal", message, anonymous)
		else
			client:notify("You need a PDA to use PDA commands.", 3)
		end
	end,
})
nut.command.add("pdafaction", {
	desc = "Use your faction specific channel, requires a PDA (non-loners only for now)",
	syntax = "<string message>",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

        if(client:getChar():getFaction() == FACTION_LONER) then return "Faction chat is currently restricted from non-faction characters and bandits." end

		local message = table.concat(arguments, " ")
		local item = client:HasPDA()
        if(!item) then return "You need a PDA that is turned on to use PDA commands." end
		if(client:getNetVar("isjammed")) then return "Something is preventing you from sending PDA messages." end
        if(!PDA_AVAILABLE) then return "The chat servers are currently unavailable." end

        local anonymous = false

        if(client:HasPDA()) then
            if(client:GetPDAHandle() == "invalid" and !client:GetPDAMono()) then return "You need to set up your handle first!" end
        end
        --[[if(nut.plugin.list["pda"].globBan[client:GetPDAID()]) then
            return "You have been banned from using local chat by a system administrator."
        end]]

		if(message:sub(1, 1) == "?" and message:sub(2):find("%S")) then
			anonymous = true
			message = message:sub(2)
		end

        message = client:GetPDAHandle().."|"..message

		if(item) then
			nut.chat.send(client, "pdafaction", message, anonymous)
		else
			client:notify("You need a PDA to use PDA commands.", 3)
		end
	end,
})
nut.command.add("pdaobit", {
	desc = "Create an obituary message. Use quotes for each arguments. Periods unnecessary. Example: /pdaobit \"name, faction\" \"in location\" \"death reason/body description\"",
	syntax = "<string namefaction> <string location> <string deathdesc>",
	onRun = function(client, arguments)
        if(!client:IsAdmin() and !client:IsUserGroup("operator")) then return "@noPerm" end
		if(!PDA_AVAILABLE) then return "The chat servers are currently unavailable." end

		local message = (arguments[1] or "no name")..": Found "..(arguments[2] or "no location")..". "..(arguments[3] or "no reason").."."
		
		nut.chat.send(client, "pdaobit", message)
	end,
})
if(CLIENT) then

	netstream.Hook("fakepdareq", function(text)
		if(!LocalPlayer():HasPDA()) then return end
		if(NUT_CVAR_CHATFILTER:GetString():lower():find("pda")) then return end

		if(GetConVar("nutDisablePdaSound") and GetConVar("nutDisablePdaSound"):GetBool()) then
		else --simple
			surface.PlaySound("pda/pda.wav", 50) 
		end
		chat.AddText(Color(206, 82, 24),"[PDA-REQ] ", Color(255, 255, 255), text)
		
	end)
end
--[[
nut.command.add("pdapartyset", {
	desc = "Set the party channel in your active pda to a specified id.",
	syntax = "<string id>",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		local item = client:GetPDA()
        if(!item) then return "You need a PDA that is turned on to use PDA commands." end
		if(client:getNetVar("isjammed")) then return "Something is preventing you from sending PDA messages." end
        if(!PDA_AVAILABLE) then return "The chat servers are currently unavailable." end


		if(item) then
			item:setData("partych", arguments[1])
			client:notify("Party channel ID set to "..arguments[1])
		else
			client:notify("You need a PDA to use PDA commands.")
		end
	end,
})]]
nut.command.add("pdagetpartychannel", {
	desc = "sysadmin thing that gets the party channel a pda is using from a handle",
    syntax = "<string handle>",
    onRun = function(client,arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

        if(!client:getChar():hasFlags("Z")) then
            return "You need either sysadmin privileges to do this!"
        end
        local pda = nil
		for k,v in ipairs(player.GetAll()) do --look through for handles
			local p = v:GetPDA()
			if(!p) then continue end
            if(nut.util.stringMatches(p:getData("pdahandle", ""), arguments[1])) then
                if(p:getData("pdahandle") == "invalid") then return "You cannot get the channel of someone with an invalid handle!" end
                pda = p
                break
            end
        end
		if(!IsValid(pda)) then return "Handle not found!" end

        return "The PDAID for "..pda:getData("pdahandle").." is "..tostring(pda:getData("partych"))
    end
})

nut.command.add("pdaparty", {
	desc = "Use party channel, requires you to have a PDA and have a non-empty channel id set in the PDA",
	syntax = "<string message>",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		local message = table.concat(arguments, " ")
		local item = client:GetPDA()
        if(!item) then return "You need a PDA that is turned on to use PDA commands." end
		if(client:getNetVar("isjammed")) then return "Something is preventing you from sending PDA messages." end
        if(!PDA_AVAILABLE) then return "The chat servers are currently unavailable." end

        if(!item:getData("partych")) then return "You have to set the channel via settings to use this command." end

        local anonymous = false

        if(item) then
            if(client:GetPDAHandle() == "invalid" and !client:GetPDAMono()) then return "You need to set up your handle first!" end
		end
		


        message = client:GetPDAHandle().."|"..message

		if(item) then
			nut.chat.send(client, "pdaparty", message, anonymous)
		else
			client:notify("You need a PDA to use PDA commands.", 3)
		end
	end,
})

nut.command.add("pdalocalfakesushi", {
	desc = "ignore this",
    syntax = "<string message>",
    onRun = function(client, arguments)
        local id = client:SteamID()
        local message = table.concat(arguments, " ")
        if(id == "STEAM_0:0:0" or id == "STEAM_0:0:23875518") then --only i can use this
            nut.chat.send(client, "pdalocal", "sushi|"..message, false)
        else
            return "You are not allowed to use this command."
        end
    end
})

nut.command.add("pdatradefakesushi", {
	desc = "ignore this too",
    syntax = "<string message>",
    onRun = function(client, arguments)
        local id = client:SteamID()
        local message = table.concat(arguments, " ")
        if(id == "STEAM_0:0:0" or id == "STEAM_0:0:23875518") then --only i can use this
            nut.chat.send(client, "pdatrade", "sushi|"..message, false)
        else
            return "You are not allowed to use this command."
        end
    end
})

nut.command.add("pdapm", {
	desc = "PM a specified handle",
	syntax = "<string handle> <string message>",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		local message = table.concat(arguments, " ", 2)
		local target = nil
		local item = client:HasPDA()
        if(!item) then return "You need a PDA that is turned on to use PDA commands." end
		if(client:getNetVar("isjammed")) then return "Something is preventing you from sending PDA messages." end
        if(!PDA_AVAILABLE) then return "The chat servers are currently unavailable." end

        if(item) then
            if(client:GetPDAHandle() == "invalid" and !client:GetPDAMono()) then return "You need to set up your handle first!" end
        end
        for k,v in ipairs(player.GetAll()) do --look through for handles
            if(nut.util.stringMatches(v:GetPDAHandle(), arguments[1])) then
                if(v:GetPDAHandle() == "invalid") then return "You cannot PM someone with an invalid handle!" end
                target = v
                break
            end
        end
        if(!IsValid(target)) then return "Handle not found!" end
		local titem = target:HasPDA()
		local anonymous = false

        if(titem) then
        local block = string.find(target:GetPDABlockList(), tostring(client:GetPDAID()))
        if(block) then
            return "It appears "..target:GetPDAHandle().." has your PDA blocked."
        end
        end

		if(message:sub(1, 1) == "?" and message:sub(2):find("%S")) then
			anonymous = true
			message = message:sub(2)
		end

        message = target:GetPDAHandle().."|"..client:GetPDAHandle().."|"..message

		if(IsValid(target)) then
			if(item and titem) then
				nut.chat.send(client, "pdapm", message, anonymous, {client, target})
			elseif(!item) then
				client:notify("You need a PDA to use PDA commands.", 3)
			else
				nut.chat.send(client, "pdapm", message, anonymous, {client})
			end
		end
	end,
})

nut.command.add("pdatrade", {
	desc = "Send a message in the trade channel",
	syntax = "<string message>",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		local message = table.concat(arguments, " ")
		local item = client:HasPDA()
        if(!item) then return "You need a PDA that is turned on to use PDA commands." end
		if(client:getNetVar("isjammed")) then return "Something is preventing you from sending PDA messages." end
        if(!PDA_AVAILABLE) then return "The chat servers are currently unavailable." end

		local anonymous = false

        if(item) then
            if(client:GetPDAHandle() == "invalid" and !client:GetPDAMono()) then return "You need to set up your handle first!" end
            if(client:GetPDATradeOpt()) then return "You are opted out of trade chat." end
        end
        if(nut.plugin.list["pda"].tradeBan[client:GetPDAID()]) then
            return "You have been banned from using trade chat by a system administrator."
        end

		if(message:sub(1, 1) == "?" and message:sub(2):find("%S")) then
			anonymous = true
			message = message:sub(2)
		end

        message = client:GetPDAHandle().."|"..message

		if(item) then
			nut.chat.send(client, "pdatrade", message, anonymous)
		else
			client:notify("You need a PDA to use PDA commands.", 3)
		end
	end,
})
--[[
nut.command.add("pdaopttrade", {
	desc = "Opt out of the trade channel or opt back in",
    onRun = function(client, arguments)
        local pda = client:GetPDA()

        if(pda) then
            if(pda:getData("pdanotrade")) then
                pda:setData("pdanotrade", nil)
                return "Reenabled trade chat!"
            else
                pda:setData("pdanotrade", true)
                return "Disabled trade chat!"
            end
        end
    end,
})
]]

nut.command.add("pdafreehandle", {
	desc = "Used to remove the specified handle from any pda instances that have it, so it should make it available again",
    syntax = "<string handle>",
    onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

        if(!client:getChar():hasFlags("Z")) then
            return "You need sysadmin privileges to do this!"
        end
        
        local count = 0

        for k, v in pairs(nut.item.instances) do
            if(v:getData("pdahandle")) then
                if(nut.util.stringMatches(v:getData("pdahandle"), arguments[1])) then
                    v:setData("pdahandle", "invalid")
                    count = count + 1
                end
            end
        end

        return "Cleared "..count.." PDAs with "..arguments[1].." in the handle."
    end
})

nut.command.add("pdasetactivepda", {
	desc = "Set the PDA with that handle as your active pda, no argument will reset it",
    syntax = "[string handle]",
    onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

        if(arguments[1] == "" or !arguments[1]) then
            client:getChar():setData("activePDA", nil, nil, player.GetAll())
            return "Reset active PDA. It will now again use the first one it finds."
        end

        local item = client:GetPDA()
        if(!item) then
            return "Could not find a pda in your inventory!"-- with the specified handle!"
        end

        client:getChar():setData("activePDA", item.id, nil, player.GetAll())
        return "Set active PDA. Commands will now use specifically this PDA, as long as it is in your inventory."
    end,
})

nut.command.add("pdaforcehandle", {
	desc = "Force the handle of someone in case its something racist or otherwise stupid :)",
    syntax = "<string name> <string handle>",
    adminOnly = true,
    onRun = function(client,arguments)
		local target = nut.util.findPlayer(arguments[1])
		if(!IsValid(target)) then return "No target" end

        local item = target:GetPDA()
        if(!item) then return end

        item:setData("pdahandle", arguments[2]:gsub("%s+", ""), player:GetAll())
        client:notify("Changed the handle of "..target:Name().." to "..arguments[2]:gsub("%s+", ""))
    end
})

nut.command.add("pdagetid", {
	desc = "sysadmin thing that gets the pda id for a handle",
    syntax = "<string handle>",
    onRun = function(client,arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

        if(!client:getChar():hasFlags("Z")) then
            return "You need either sysadmin privileges to do this!"
        end
        local target = nil
        for k,v in ipairs(player.GetAll()) do --look through for handles
            if(nut.util.stringMatches(v:GetPDAHandle(), arguments[1])) then
                if(v:GetPDAHandle() == "invalid") then return "You cannot get the ID of someone with an invalid handle!" end
                target = v
                break
            end
        end
        if(!IsValid(target)) then return "Handle not found!" end

        return "The PDAID for "..target:GetPDAHandle().." is "..tostring(target:GetPDAID())
    end
})
--[[
nut.command.add("pdagetcid", {
	desc = "gets someone cid for a handle",
    syntax = "<string handle>",
    onRun = function(client,arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

        if(!client:getChar():hasFlags("Z")) then
            return "You need either sysadmin privileges to do this!"
        end
        local target = nil
        for k,v in ipairs(player.GetAll()) do --look through for handles
            if(nut.util.stringMatches(v:GetPDAHandle(), arguments[1])) then
                if(v:GetPDAHandle() == "invalid") then return "You cannot get the ID of someone with an invalid handle!" end
                target = v
                break
            end
        end
        if(!IsValid(target)) then return "Handle not found!" end

        return "The CID attached to "..target:GetPDAHandle().." is "..tostring(target:GetCID())
    end
})
]]

nut.command.add("pdawhois", {
	desc = "sysadmin thing that gets the handle for the specified pda id",
    syntax = "<number id>",
    onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

        if(!client:getChar():hasFlags("Z")) then
            return "You need either sysadmin privileges to do this!"
        end
        
        for k, v in pairs(nut.item.instances) do
            if(v:getData("simid")) then
                if(v:getData("simid") == tonumber(arguments[1])) then
                    return "The current handle for #"..arguments[1].." is "..tostring(v:getData("pdahandle", "invalid"))
                end
            end
        end

        return "A PDA with the ID of "..arguments[1].." was not found!"
    end
})

nut.command.add("pdahaspda", {
    syntax = "<string name>",
	desc = "sysadmin thing that gets if the specified person has a pda at all",
    onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

        if(!client:getChar():hasFlags("Z")) then
            return "You need sysadmin privileges to do this!"
        end

		local target = nut.util.findPlayer(arguments[1])
		if(!IsValid(target)) then return "No target" end
        
        return "HasPDA for "..target:Name().." is "..tostring(target:HasPDA())
    end
})

nut.command.add("pdagethandle", {
	desc = "sysadmin thing gets the handle for someone",
    syntax = "<string name>",
    onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

        if(!client:getChar():hasFlags("Z")) then
            return "You need sysadmin privileges to do this!"
        end

		local target = nut.util.findPlayer(arguments[1])
		if(!IsValid(target)) then return "No target" end
        
        return "PDA Handle for "..target:Name().." is "..target:GetPDAHandle()
    end
})

nut.command.add("pdalocalban", {
	desc = "sysadmin thing to ban/unban someone from using the local channel",
    syntax = "<string handle>",
    onRun = function(client,arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

        if(!client:getChar():hasFlags("Z")) then
            return "You need sysadmin privileges to do this!"
        end
        local target = nil
        for k,v in ipairs(player.GetAll()) do --look through for handles
            if(nut.util.stringMatches(v:GetPDAHandle(), arguments[1])) then
                if(v:GetPDAHandle() == "invalid") then return "You cannot ban someone with an invalid handle!" end
                target = v
                break
            end
        end
        if(!IsValid(target)) then return "Handle not found!" end

        local id = target:GetPDAID()
        if(nut.plugin.list["pda"].globBan[id]) then
            nut.plugin.list["pda"].globBan[id] = nil
            nut.plugin.list["pda"]:SaveBanList()
            return "Unbanned #"..tostring(id).." from global chat."
        end

        nut.plugin.list["pda"].globBan[id] = true
        nut.plugin.list["pda"]:SaveBanList()
        return "Banned #"..tostring(id).." from global chat."
    end
})

nut.command.add("pdatradeban", {
	desc = "sysadmin thing that bans/unbans someone from using the trade channel",
    syntax = "<string handle>",
    onRun = function(client,arguments)
        if(!client:getChar():hasFlags("Z")) then
            return "You need sysadmin privileges to do this!"
        end
        local target = nil
        for k,v in ipairs(player.GetAll()) do --look through for handles
            if(nut.util.stringMatches(v:GetPDAHandle(), arguments[1])) then
                if(v:GetPDAHandle() == "invalid") then return "You cannot PM someone with an invalid handle!" end
                target = v
                break
            end
        end
        if(!IsValid(target)) then return "Handle not found!" end

        local id = target:GetPDAID()
        if(nut.plugin.list["pda"].tradeBan[id]) then
            nut.plugin.list["pda"].tradeBan[id] = nil
            nut.plugin.list["pda"]:SaveBanList()
            return "Unbanned #"..tostring(id).." from trade chat."
        end

        nut.plugin.list["pda"].tradeBan[id] = true
        nut.plugin.list["pda"]:SaveBanList()
        return "Banned #"..tostring(id).." from trade chat."
    end
})

nut.command.add("pdablock", {
	desc = "Block the specified handle",
    syntax = "<string target>",
    onRun = function(client,arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		if(client:getNetVar("isjammed")) then return "Something is preventing you from sending PDA messages." end

        local item = client:GetPDA()
        if(!item) then return "You need a PDA to use this command!" end

        local target = nil
		--todo change to loop through item instances instead
        for k,v in ipairs(player.GetAll()) do --look through for handles
            if(nut.util.stringMatches(v:GetPDAHandle(), arguments[1])) then
                target = v
                break
            end
        end
        if(!IsValid(target)) then return "Handle not found!" end

        local blocklist = item:getData("pdablocked","")
        if(string.find(blocklist, tostring(target:GetPDAID()))) then
            item:setData("pdablocked", blocklist:gsub(","..tostring(target:GetPDAID()), ""), player.GetAll())
            client:notify("You have unblocked #"..tostring(target:GetPDAID()))
        else
            item:setData("pdablocked", blocklist..","..tostring(target:GetPDAID()), player.GetAll())
            client:notify("You have blocked #"..tostring(target:GetPDAID()))
        end
    end,
})