local PLUGIN = PLUGIN
PLUGIN.name = "PDA System"
PLUGIN.author = "sky"
PLUGIN.desc = "stalker PDAs and gui"

PDA_AVAILABLE = true

PLUGIN.globBan = PLUGIN.globBan or {}
PLUGIN.tradeBan = PLUGIN.tradeBan or {}
PLUGIN.dataList = PLUGIN.dataList or {}
PLUGIN.dataComList = PLUGIN.dataComList or {} --comments

nut.flag.add("Z", "PDA sysadmin. Allows use of special commands.")

local split = string.Split


local playerMeta = FindMetaTable("Player")
do

    function playerMeta:GetPDA()
        if(self:getChar()) then
            local pdaid = nil
            local char = self:getChar()
            if(char:getData("activePDA")) then
                pdaid = char:getData("activePDA")
            end
            local inv = char:getInv()
            for k,v in pairs(inv:getItems()) do
				local item = nut.item.instances[v.id]
                if(item.base == "base_npda" and !item:getData("isoff")) then
                    if(pdaid) then --if we have an active pda get that first
                        if(pdaid == item.id) then
                            return item
                        end
                    else --otherwise just get the first one we find
                        return item
                    end
                end
            end
        end
        return nil
    end

    function playerMeta:HasPDA()
        if(self:GetPDA() != nil) then
            return true
        end
        return false
    end

    function playerMeta:GetPDAHandle()
        local pda = self:GetPDA()
        if(pda) then
            local ind, data = pda:GetPDAData()
            return data.Handle
        end

        return "invalid"
    end

    function playerMeta:GetPDABlockList()
        local pda = self:GetPDA()
        if(pda) then
            local ind, data = pda:GetPDAData()
            return data.Blocked
        end

        return ""
    end

	function playerMeta:GetPDAID()
        local pda = self:GetPDA()
        if(pda) then
            local ind, data = pda:GetPDAData()
            return ind
        end
    
        return 0
    end

    function playerMeta:GetPDAMono()
        local pda = self:GetPDA()
        if(pda) then
            return pda.mono or false
        end

        return false
    end
    function playerMeta:GetPDAMPF()
        local pda = self:GetPDA()
        if(pda) then
            return pda.mpf or false
        end

        return false
    end

    function playerMeta:GetPDATradeOpt()
        local pda = self:GetPDA()
        if(pda) then
            return pda:getData("pdanotrade", false)
        end

        return false
	end
	
	function playerMeta:GetPDADataList()
		local pda = self:GetPDA()
		if(pda) then
			return PLUGIN.dataList[self:GetPDAID()] or {}
		end
		return {}
	end
end

nut.chat.register("pdabroad", {
	desc = "Broadcast channel usage",
    onCanSay = function(speaker, text)
        return speaker:HasPDA() and speaker:getChar():hasFlags("Z") and PDA_AVAILABLE
    end,
    onCanHear = function(speaker, listener)
		if(listener:getNetVar("isjammed")) then return false end
        return listener:HasPDA()
    end,
	onChatAdd = function(speaker, text, anonymous)
		if(text == "") then return end
        chat.AddText(Color(37,65,206),"[PDA-NOTIF] ", Color(255,255,255), text)
    end,
    filter = "pda",
    prefix = {"/pdanotif"}
})

nut.chat.register("pdalocal", {
	onCanSay = function(speaker, text)
        
		return speaker:HasPDA()
	end,
	onCanHear = function(speaker, listener)
		local inv = listener:getChar():getInv()
        local block = string.find(listener:GetPDABlockList(), tostring(speaker:GetPDAID()))
        if(block) then
            return false
        end
		if(listener:getNetVar("isjammed")) then return false end
		return listener:HasPDA()
	end,
	onChatAdd = function(speaker, text, anonymous)
		if(text == "") then return end
        local args = split(text, "|")
		local name = args[1]

		if(anonymous) then
			if(speaker:GetPDAMPF()) then
				name = "Metropolice Force"
			elseif(speaker:GetPDAMono()) then
				name = "invalid"
			end
		end

        if(args[2]) then
		chat.AddText(Color(100, 255, 50),"[PDA-LOCAL] ", Color(255, 255, 255), name..": "..args[2])
        end
	end,
    filter = "pda"
})

local factionChans = {
	[1] = "BAND",
	[2] = "CSKY",
	[3] = "DUTY",
	[4] = "ECOL",
	[5] = "FREE",
	[6] = "LONE", --they wont have one but eh
	[7] = "MERC",
	[8] = "MILI",
	[9] = "MONO",
}

nut.chat.register("pdafac", {
	onCanSay = function(speaker, text)
        
		return speaker:getChar():getFaction() != FACTION_LONER and speaker:HasPDA()
	end,
	onCanHear = function(speaker, listener)
		local inv = listener:getChar():getInv()
        local block = string.find(listener:GetPDABlockList(), tostring(speaker:GetPDAID()))
        if(block) then
            return false
        end
		if(listener:getNetVar("isjammed")) then return false end
		return listener:HasPDA() and speaker:getChar():getFaction() == listener:getChar():getFaction()
	end,
	onChatAdd = function(speaker, text, anonymous)
		if(text == "") then return end
        local args = split(text, "|")
		local name = args[1]

		if(anonymous) then
			if(speaker:GetPDAMPF()) then
				name = "Metropolice Force"
			elseif(speaker:GetPDAMono()) then
				name = "invalid"
			end
		end
		local facnum = speaker:getChar():getFaction()
		local fac = nut.faction.indices[facnum]
		if(!fac) then print("tried to display faction message, but this isnt a valid faction?????") return end

        if(args[2]) then
		chat.AddText(fac.color or Color(100, 255, 50), "[PDA-"..(factionChans[facnum] or "LMK IF THIS SHOWS").."] ", Color(255, 255, 255), name..": "..args[2])
        end
	end,
    filter = "pda"
})


nut.chat.register("pdaparty", {
	onCanSay = function(speaker, text)
        local pdas = speaker:GetPDA()
		return pdas and pdas:getData("partych")
	end,
	onCanHear = function(speaker, listener)
		local pdas, pdal = speaker:GetPDA(), listener:GetPDA()
		if(!pdal or pdal:getData("partych") == nil) then
			return false
		end
        local block = string.find(listener:GetPDABlockList(), tostring(speaker:GetPDAID()))
        if(block) then
            return false
        end
		if(listener:getNetVar("isjammed")) then return false end
		return pdas:getData("partych") == pdal:getData("partych")
	end,
	onChatAdd = function(speaker, text, anonymous)
		if(text == "") then return end
        local args = split(text, "|")
		local name = args[1]

		if(anonymous) then
			if(speaker:GetPDAMPF()) then
				name = "Metropolice Force"
			elseif(speaker:GetPDAMono()) then
				name = "invalid"
			end
		end

        if(args[2]) then
		chat.AddText(Color(153, 0, 0),"[PDA-PARTY] ", Color(255, 255, 255), name..": "..args[2])
        end
	end,
    filter = "pda"
})

nut.chat.register("pdapm", {
	onCanSay = function(speaker, text)
		if(speaker:GetClass() == "worldspawn") then return true end --this is so i can make automatic stuff
        return speaker:HasPDA()
	end,
	onCanHear = function(speaker, listener)
		if(speaker:GetClass() == "worldspawn") then return listener:HasPDA() end
		if(listener:getNetVar("isjammed")) then return false end
		local inv = listener:getChar():getInv()
		local block = string.find(listener:GetPDABlockList(), tostring(speaker:GetPDAID()))
        if(block) then
            speaker:notify("It appears "..listener:GetPDAHandle().." has your PDA blocked.", 2)
            return false
        end
		return listener:HasPDA()
	end,
	onChatAdd = function(speaker, text, anonymous)
		if(text == "") then return end
		local args = split(text, "|")
        local name

        if(speaker == LocalPlayer()) then --if AddText can be called it must be clientside right?
            name = "to @"
            name = name..args[1]
            
        else
            name = "from @"
            name = name..args[2]
            
		    if(anonymous) then
				if(speaker:GetPDAMPF()) then
					name = "from Metropolice Force"
				elseif(speaker:GetPDAMono()) then
					name = "from invalid"
				end
		    end
        end

		--name = name..args[1]


		chat.AddText(Color(206, 82, 24),"[PDA-PM] ", Color(255, 255, 255), name..": "..args[3])
	end,
    filter = "pda"
})

nut.chat.register("pdatrade", {
    onCanHear = function(speaker, listener)
        if(listener:GetPDATradeOpt()) then
            return false
        end
		if(listener:getNetVar("isjammed")) then return false end
		
        return listener:HasPDA()
        
        --[[if(item:getData("pdanotrade")) then --fuck this part for now
            return false
        end]]
    end,
    onChatAdd = function(speaker, text, anonymous)
		if(text == "") then return end
        local args = split(text, "|")
		local name = args[1]

		if(anonymous) then
			if(speaker:GetPDAMPF()) then
				name = "Metropolice Force"
			elseif(speaker:GetPDAMono()) then
				name = "invalid"
			end
		end

        if(args[2]) then
		    chat.AddText(Color(37, 231, 245),"[PDA-TRADE] ", Color(255, 255, 255), name..": "..args[2])
        end
    end,
    filter = "pda"
})

function PLUGIN:GetSimList()
    local simList = {}
    for k, v in pairs(nut.item.instances) do
        if(v:getData("simid")) then
            simList[v.id] = v:getData("simid")
        end
    end

    return simList
end

nut.util.include("sh_commands.lua")
nut.util.include("sh_scoreboard.lua")

if (CLIENT) then
    net.Receive("OpenPDA", function()
        local id = net.ReadInt(20)
        local inst = net.ReadInt(32)

            if(IsValid(nut.gui.menu)) then
                nut.gui.menu:Remove()
			end
			if(!nut.gui.pda) then
            nut.gui.pda = vgui.Create("pdaPanel")
			nut.gui.pda.instid = inst
			else
				nut.gui.pda:Reset(inst)
			end
	end)
	
	net.Receive("RecPDAData", function()
		print("got pda data")
		curTable = net.ReadTable()
		if(dataCreateTable) then
			dataCreateTable(curTable)
		end
	end)
	


	CreateClientConVar("nutDisablePdaSound", "0")

    function PLUGIN:OnChatReceived(client, chatType, text, anonymous)
		--local class = nut.chat.classes[chatType]

    	if(chatType:find("pda")) then--chatType == "pdalocal" or chatType == "pdaparty" or chatType == "pdapm" or chatType == "pdabroad" or chatType == "pdatrade") then
	    	if(!PDA_AVAILABLE) then return "" end
			local args = split(text, "|")
			local message = ""
			if(chatType == "pdabroad") then-- o or chatType == "pdaparty" or chatType == "pdatrade") then
		    	message = args[1]
    		elseif(chatType == "pdapm") then
	    		message = args[3]
		    else
    			message = args[2]
	    	end
		    if(!message) then message = "" end
		
    		if(!string.find(message, "%S")) then return text end
	    	if(NUT_CVAR_CHATFILTER:GetString():lower():find("pda") or (GetConVar("nutDisablePdaSound") and GetConVar("nutDisablePdaSound"):GetBool())) then return text end

			if(chatType == "pdabroad") then
				surface.PlaySound("pda/pda_news.ogg", 50)
			else
			surface.PlaySound("pda/pda.wav", 50)
			end
	    	return text
	    end
	end
	
	netstream.Hook("fakepdanote", function(text)
		--if(!LocalPlayer():HasPDA()) then return end
		if(NUT_CVAR_CHATFILTER:GetString():lower():find("pda")) then return end

		if(GetConVar("nutDisablePdaSound") and GetConVar("nutDisablePdaSound"):GetBool()) then
		else --simple
			surface.PlaySound("pda/pda.wav", 50) 
		end
		chat.AddText(Color(37,65,206),"[PDA-NOTIF] ", Color(255, 255, 255), text)
		
	end)
else
	util.AddNetworkString("OpenPDA")
	util.AddNetworkString("ChangePDAHandle")
	util.AddNetworkString("ChangePDATitle")
	util.AddNetworkString("ChangePDAParty")
	
	net.Receive("ChangePDAHandle", function(len, ply)
		local change = net.ReadString()
		local idd = net.ReadInt(32)
	
		for k, v in pairs(nut.item.instances) do
			if(v:getData("pdahandle", "") == change) then
				ply:notify("This handle is taken!", 3)
				return
			end
		end
	
		nut.item.instances[idd]:setData("pdahandle", change, player.GetAll())
	end)
	
    net.Receive("ChangePDATitle", function(len, ply)
        local change = net.ReadString()
        local idd = net.ReadInt(32)

        nut.item.instances[idd]:setData("pdatitle", change, player:GetAll())
	end)
	
    net.Receive("ChangePDAParty", function(len, ply)
        local change = net.ReadString()
        local idd = net.ReadInt(32)

        nut.item.instances[idd]:setData("partych", change, player:GetAll())
    end)
	
	util.AddNetworkString("RecPDAData")
	util.AddNetworkString("GivePDAData")
	util.AddNetworkString("SetPDAData")
	util.AddNetworkString("SetPDAComm")

    net.Receive("SetPDAData", function(len, ply)
		local tbl = net.ReadTable()
		local id = net.ReadInt(21)
		
		for k,v in pairs(tbl) do
			CMBD:changeInDB(id, k, v)
		end

		--PLUGIN.dataList[id] = tbl

		PLUGIN:SaveDataList()
	end)
    net.Receive("SetPDAComm", function(len, ply)
		local tbl = net.ReadString()
		local id = net.ReadInt(21)
		
		PLUGIN.dataComList[id] = tbl
		
		PLUGIN:SaveDataList()
	end)

	net.Receive("GivePDAData", function(len, ply)
		local id = net.ReadInt(21)
		local all = net.ReadBool()
		
		if(ply:getNetVar("isjammed")) then ply:notify("Something is preventing you from communicating with the db.") return end

		--nut.log.addRaw("give data test "..ply:Name())

		local tbl = {}

		tbl.data = CMBD:getFromDB(id) or {}--PLUGIN.dataList[id] or {}
		tbl.id = id --id just in case
		local char = tbl.data.charid and nut.char.loaded[tbl.data.charid]

		if(char and (char:getFaction() == FACTION_CP or char:getFaction() == FACTION_OW)) then
			tbl.combine = char:getFaction()
			tbl.crank = char:getCombineRank()
		end

		if(all) then
			local pl = char and char:getPlayer()

			if(!char) then
				tbl.handle = "NON_EXISTANT"
				tbl.pdaid = "000000"
			else
				if(!pl) then
					tbl.handle = "UNKNOWN"
					tbl.pdaid = "000000"
				else
					tbl.handle = pl:GetPDAHandle()
					tbl.pdaid = pl:GetPDAID()
				end
			end


			--[[ --status which is equivalent is in data
			if(pl) then
				
				if(GLOBALWANTED and GLOBAL_WANTED[pl:getChar():getID()] and GLOBAL_WANTED[pl:getChar():getID()].masked == 0) then
					tbl.wanted = pl:getChar():getVar("wanted") and "WANTED"
				else
					if(pl:getChar():getTrait("big_mostwanted")) then
						tbl.wanted = "WANTED"
					else
						tbl.wanted = "NOT WANTED"
					end
				end
			else
				tbl.wanted = "UNKNOWN"
			end
			]]

			tbl.bannedstat = "Clean PDA Record"
			if(pl) then
		        if(PLUGIN.tradeBan[pl:GetPDAID()]) then
		            tbl.bannedstat = "Trade Banned"
				end
				if(PLUGIN.globBan[pl:GetPDAID()]) then
					if(tbl.bannedstat != "") then
						tbl.bannedstat = "Trade+Local Banned"
					else
						tbl.bannedstat = "Local Banned"
					end
				end
			else
				tbl.bannedstat = "Ban Status Unknown"
			end

			local function firstToUpper(str)
				return (str:gsub("^%l", string.upper))
			end

			tbl.langs = {}
			if(pl) then
				if(!char:getTrait("big_nonenglish")) then
					tbl.langs[#tbl.langs+1] = "English"
				end
				for k,v in pairs(char:getTrait()) do
					if(string.find(k, "lang_")) then
						tbl.langs[#tbl.langs+1] = firstToUpper(string.Split(k, "_")[2])
					end
				end
			else
				tbl.langs = {"Unknown"}
			end
			
			if(table.Count(tbl.data) == 0) then
				tbl.fake = true
			else
				tbl.comment = PLUGIN.dataComList[id] or ""
			end
		else
		end
		
		


		net.Start("RecPDAData")
		net.WriteTable(tbl)
		net.Send(ply)
	end)
	
	
    function PLUGIN:LoadData()
        local banlis = nut.data.get("pdabanlist", {})
        self.globBan = banlis
        local trad = nut.data.get("pdatradebanlist", {})
        self.tradeBan = trad
        local dat = nut.data.get("pdadatalist", {})
        self.dataList = dat
        local exx = nut.data.get("pdadataexlist", {})
        self.dataComList = exx
	end
	
	function PLUGIN:SaveDataList()
        nut.data.set("pdadatalist", self.dataList)
        nut.data.set("pdadataexlist", self.dataComList)
	end
    
    function PLUGIN:SaveBanList()
        nut.data.set("pdabanlist", self.globBan)
        nut.data.set("pdatradebanlist", self.tradeBan)
    end
end
