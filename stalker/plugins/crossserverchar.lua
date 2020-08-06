PLUGIN.name = "Cross-Server Chars"
PLUGIN.author = "sky"
PLUGIN.desc = "allows chars to only be able to picked on specific servers"

CROSSSERVER_ID = 1 
--the id it checks, you cant load the char if it doesnt match this
CROSSSERVER_TEMP = false --if true, wont load if the char doesnt have a cur id
--and will reset the id when the player dies and kick them
CROSSSERVER_MAINIP = nil 
--the ip to reconnect the player to when they die if its temp
CROSSSERVER_NAMES = {
	[1] = "temp"
}


hook.Add("CanPlayerUseChar", "crossserver", function(ply, char)
	if(char:getData("crossserverid") != nil) then
		local id = char:getData("crossserverid")
		if(id != CROSSSERVER_ID) then
			return false, "You cannot use this character on this server! This character is at "..(CROSSSERVER_NAMES[id] or "unknown").."."
		end
	elseif(CROSSSERVER_TEMP) then
		return false, "You cannot use this character on this server!"
	end

end)

--set the id to this server even if its already set, should be fine
hook.Add("PlayerLoadedChar", "cross", function(ply, char, lastChar)
	char:setData("crossserverid", CROSSSERVER_ID)
end)

if(SERVER) then
	hook.Add("PlayerDisconnected", "cross", function(ply)
		if(CROSSSERVER_TEMP) then
			char:setData("crossserverid") --reset it when they dc
		end
	end)

	hook.Add("PostPlayerDeath", "cross", function(ply)
		if(CROSSSERVER_TEMP and CROSSSERVER_MAINIP) then --make them reconnect to the server
			ply:ConCommand("connect "..CROSSSERVER_MAINIP)
		end
	end)
	hook.Add("OnDown", "cross", function(ply)
		if(CROSSSERVER_TEMP and CROSSSERVER_MAINIP) then --make them reconnect to the server
			ply:notify("On acd, you will be reconnected to the main server.")
		end
	end)

	--convinence function for changing server ids
	function SetCrossServerID(ply, id)
		if(!ply:getChar()) then return end
		ply:getChar():setData("crossserverid", id)
	end

end