local PLUGIN = PLUGIN
PLUGIN.name = "server opener"
PLUGIN.author = "sky"
PLUGIN.desc = "quick thing for easy access to opening/closing a server"
if(game.SinglePlayer()) then return end --dont want this setting up in sp

local pass = "lmaooo" --pass to get in when closed
local closedStr = " | Open on weekends" --string to add when closed

PLUGIN.curStatus = PLUGIN.curStatus or true --false = open

nut.command.add("servertoggle", {
	adminOnly = true,
	desc = "Opens (or closes) the server to players",
	onRun = function(client, arguments)
		PLUGIN:ToggleServer()

		return "server has been toggled "..(PLUGIN.curStatus and "closed" or "open")
 	end
})

if(SERVER) then

	PLUGIN.originalName = PLUGIN.originalName or string.Split(GetHostName(), closedStr)[1]

	//if i understand this right, onloaded will run first, need to wait until data is loaded
	function PLUGIN:PostLoadData()//OnLoaded()
		if(self.curStatus) then
			RunConsoleCommand("sv_password", pass)
			if(GetHostName():find(closedStr)) then return end --uh ye
			RunConsoleCommand("hostname", PLUGIN.originalName..closedStr)
		else
			--trying to fix
			if(GetHostName():find(closedStr)) then 
				RunConsoleCommand("sv_password", "")
				RunConsoleCommand("hostname", PLUGIN.originalName)
			end
			//RunConsoleCommand("sv_password", "")
			//RunConsoleCommand("hostname", originalName)
		end
	end

	function PLUGIN:ToggleServer()
		self.curStatus = !self.curStatus
		if(self.curStatus) then
			RunConsoleCommand("sv_password", pass)
			RunConsoleCommand("hostname", PLUGIN.originalName..closedStr)
		else
			RunConsoleCommand("sv_password", "")
			RunConsoleCommand("hostname", PLUGIN.originalName)
		end
	end
	
	function PLUGIN:SaveData()
		self:setData(self.curStatus, true, true)
	end

	function PLUGIN:LoadData()
		self.curStatus = self:getData(true, true, true)
	end
end