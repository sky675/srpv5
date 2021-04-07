local PLUGIN = PLUGIN
PLUGIN.name = "server opener"
PLUGIN.author = "sky"
PLUGIN.desc = "quick thing for easy access to opening/closing a server"

local pass = "lmaooo" --pass to get in when closed
local closedStr = "| Open on weekends" --string to add when closed

local curStatus = true --false = open

nut.command.add("servertoggle", {
	adminOnly = true,
	desc = "Opens (or closes) the server to players",
	onRun = function(client, arguments)
		PLUGIN:ToggleServer()

		return "server has been toggled "..(curStatus and "closed" or "open")
 	end
})

if(SERVER) then

	local originalName = originalName or GetHostName()

	//if i understand this right, onloaded will run first, need to wait until data is loaded
	function PLUGIN:PostLoadData()//OnLoaded()
		if(curStatus) then
			RunConsoleCommand("sv_password", pass)
			RunConsoleCommand("hostname", originalName..closedStr)
		else
			//RunConsoleCommand("sv_password", "")
			//RunConsoleCommand("hostname", originalName)
		end
	end

	function PLUGIN:ToggleServer()
		curStatus = !curStatus
		if(curStatus) then
			RunConsoleCommand("sv_password", pass)
			RunConsoleCommand("hostname", originalName..closedStr)
		else
			RunConsoleCommand("sv_password", "")
			RunConsoleCommand("hostname", originalName)
		end
	end
	
	function PLUGIN:SaveData()
		self:setData(curStatus, true, true)
	end

	function PLUGIN:LoadData()
		curStatus = self:getData(true, true, true)
	end
end