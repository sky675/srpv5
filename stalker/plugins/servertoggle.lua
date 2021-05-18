local PLUGIN = PLUGIN
PLUGIN.name = "server opener"
PLUGIN.author = "sky"
PLUGIN.desc = "quick thing for easy access to opening/closing a server"
if(game.SinglePlayer()) then return end --dont want this setting up in sp

local pass = "lmaooo" --pass to get in when closed
local closedStr = " | Closed" --string to add when closed

PLUGIN.curStatus = PLUGIN.curStatus or true --false = open

nut.command.add("servertoggle", {
	adminOnly = true,
	desc = "Opens (or closes) the server to players",
	onRun = function(client, arguments)
		PLUGIN:ToggleServer()

		nut.log.addRaw("server has been toggled "..(PLUGIN.curStatus and "closed" or "open").." by "..client:steamName().." ("..client:SteamID()..")")
		return "server has been toggled "..(PLUGIN.curStatus and "closed" or "open")
 	end
})

if(SERVER) then

	function PLUGIN:InitPostEntity()
		PLUGIN.originalName = PLUGIN.originalName or string.Split(GetHostName(), closedStr)[1]
	end

	concommand.Add("nut_servertoggle", function(ply, cmd, args)
		if(IsValid(ply) and !ply:IsAdmin()) then return end

		PLUGIN:ToggleServer()
		nut.log.addRaw("server has been toggled "..(PLUGIN.curStatus and "closed" or "open").." by "..(IsValid(ply) and (ply:steamName().." ("..ply:SteamID()..")") or "someone in rcon"))

		print("done curStatus is now ", PLUGIN.curStatus)
	end, nil, "console command (meant for rcon) to toggle server opening")

	//if i understand this right, onloaded will run first, need to wait until data is loaded
	function PLUGIN:PostLoadData()//OnLoaded()
		if(self.curStatus) then
			RunConsoleCommand("sv_password", pass)
			if(GetHostName():find(closedStr)) then return end --uh ye
			RunConsoleCommand("hostname", self.originalName..closedStr)
		else
			--trying to fix
			if(GetHostName():find(closedStr)) then 
				RunConsoleCommand("sv_password", "")
				RunConsoleCommand("hostname", self.originalName)
			end
			//RunConsoleCommand("sv_password", "")
			//RunConsoleCommand("hostname", originalName)
		end
	end

	function PLUGIN:ToggleServer()
		self.curStatus = !self.curStatus
		if(self.curStatus) then
			RunConsoleCommand("sv_password", pass)
			RunConsoleCommand("hostname", self.originalName..closedStr)
		else
			RunConsoleCommand("sv_password", "")
			RunConsoleCommand("hostname", self.originalName)
		end
	end
	
	function PLUGIN:SaveData()
		self:setData(self.curStatus, true, true)
	end

	function PLUGIN:LoadData()
		self.curStatus = self:getData(true, true, true)
	end
end