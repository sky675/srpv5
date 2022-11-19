if(game.SinglePlayer()) then return end

serverToggle = serverToggle or {}

local pass = "shazbot" --pass to get in when closed
local closedStr = "| https://discord.gg/kolobok" --string to add when closed
local defName = "Kolobok|STALKER Serious Roleplay"

serverToggle.curStatus = serverToggle.curStatus or (cookie.GetNumber("serverTog", 0) == 1)  --false = open

if(SERVER) then
hook.Add("InitPostEntity", "testtoggle", function()
	print("servertoggle: current name at init", GetHostName())
	
	serverToggle.originalName = defName
	serverToggle.curStatus = tobool(cookie.GetNumber("serverTog", 0))
	
	if(serverToggle.curStatus) then
		RunConsoleCommand("sv_password", pass)
		if(GetHostName():find(closedStr)) then return end --uh ye
		RunConsoleCommand("hostname", serverToggle.originalName..closedStr)
	else
		--trying to fix
		if(GetHostName():find(closedStr)) then 
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