if(game.SinglePlayer()) then return end

serverToggle = serverToggle or {}

local pass = "lmaooo" --pass to get in when closed
local closedStr = " | Closed" --string to add when closed

serverToggle.curStatus = serverToggle.curStatus or true --false = open

if(SERVER) then
hook.Add("Initialize", "testtoggle", function()
	print("servertoggle: current name", GetHostName())
	serverToggle.originalName = serverToggle.originalName or string.Split(GetHostName(), closedStr)[1]
	serverToggle.curStatus = tobool(cookie.GetNumber("serverTog", 1))
	
	if(serverToggle.curStatus) then
		print("server toggle: true")
		RunConsoleCommand("sv_password", pass)
		if(GetHostName():find(closedStr)) then return end --uh ye
		RunConsoleCommand("hostname", serverToggle.originalName..closedStr)
	else
		--trying to fix
		print("server toggle: false")
		if(GetHostName():find(closedStr)) then 
			print("server toggle: false reset pass")
			RunConsoleCommand("sv_password", "")
			RunConsoleCommand("hostname", serverToggle.originalName)
		end
		//RunConsoleCommand("sv_password", "")
		//RunConsoleCommand("hostname", originalName)
	end
end)

concommand.Add("nut_servertoggle", function(ply, cmd, args)
	if(IsValid(ply) and !ply:IsAdmin()) then return end

	serverToggle:ToggleServer()
	if(nut) then
	nut.log.addRaw("server has been toggled "..(serverToggle.curStatus and "closed" or "open").." by "..(IsValid(ply) and (ply:steamName().." ("..ply:SteamID()..")") or "someone in rcon"))
	end

	print("done curStatus is now ", serverToggle.curStatus)
end, nil, "console command (meant for rcon) to toggle server opening")

function serverToggle:ToggleServer()
	self.curStatus = !self.curStatus
	cookie.Set("serverTog", self.curStatus == true and 1 or 0)
	if(self.curStatus) then
		RunConsoleCommand("sv_password", pass)
		RunConsoleCommand("hostname", self.originalName..closedStr)
	else
		RunConsoleCommand("sv_password", "")
		RunConsoleCommand("hostname", self.originalName)
	end
end

end