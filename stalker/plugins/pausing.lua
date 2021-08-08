local PLUGIN = PLUGIN
PLUGIN.name = "Pause System"
PLUGIN.author = "sky"
PLUGIN.desc = "Implements a pausing system to go with s2rp"

--pauseadd
nut.command.add("pauseadd", {
	desc = "Create a pause group/Add players to a pause group",
	syntax = "<string groupname> <string spaceseparatedlistofplynames>",
	adminOnly = true,
	onRun = function(client, arguments)
		local grp = arguments[1]
		local added = ""
		for k,v in ipairs(arguments) do
			if(k == 1) then continue end --ye
			local target = nut.util.findPlayer(v)
			if(!IsValid(target)) then continue end

			added = added.." "..target:Name()
			PLUGIN:AddUserToGroup(grp, target)
		end
		
		return "added"..added.." to group "..grp
	end
})
--pausetoggle
nut.command.add("pausetoggle", {
	desc = "Toggle a pause group",
	syntax = "<string groupname>",
	adminOnly = true,
	onRun = function(client, arguments)
		local grp = arguments[1]
		if(!PLUGIN.pauseGroup[grp]) then return "group does not exist" end
		PLUGIN:ToggleFreeze(grp)
		
		return "toggled group "..tostring(PLUGIN.pauseGroup[grp].paused)
	end
})
--pauseget
nut.command.add("pauseget", {
	desc = "See the current pause status of a group",
	syntax = "<string groupname>",
	adminOnly = true,
	onRun = function(client, arguments)
		local grp = arguments[1]
		if(!PLUGIN.pauseGroup[grp]) then return "group does not exist" end
		
		return "pause status: "..tostring(PLUGIN.pauseGroup[grp].paused)
	end
})

nut.command.add("pausegetply", {
	desc = "Get all players in a group",
	syntax = "<string groupname>",
	adminOnly = true,
	onRun = function(client, arguments)
		local grp = arguments[1]
		if(!PLUGIN.pauseGroup[grp]) then return "group does not exist" end
		
		return "players in group "..table.concat(PLUGIN.pauseGroup[grp].players, ", ")
	end
})
--pauseremove
nut.command.add("pauseremove", {
	desc = "Remove players from a pause group",
	syntax = "<string groupname> <string spaceseparatedlistofplynames>",
	adminOnly = true,
	onRun = function(client, arguments)
		local grp = arguments[1]
		local added = ""
		for k,v in ipairs(arguments) do
			if(k == 1) then continue end --ye
			local target = nut.util.findPlayer(v)
			if(!IsValid(target)) then continue end

			added = added.." "..target:Name()
			PLUGIN:RemoveUserFromGroup(grp, target)
		end
		
		if(added == "") then
			return "could not find any targets"
		end

		return "removed"..added.." from group "..grp
	end
})
--pausedisband
nut.command.add("pausedisband", {
	desc = "Completely disband a pause group",
	syntax = "<string groupname>",
	adminOnly = true,
	onRun = function(client, arguments)
		local grp = arguments[1]
		if(!PLUGIN.pauseGroup[grp]) then return "group does not exist" end
		PLUGIN:DisbandGroup(grp)
		
		return "disbanded group "..grp
	end
})


--[[
	["groupname"] = {
		paused = false,
		players = {
			player, player, player
		}
	}
]]
PLUGIN.pauseGroup = PLUGIN.pauseGroup or {}

function PLUGIN:ToggleFreeze(grp)
	local group = self.pauseGroup[grp]
	if(!group) then return end
	group.paused = !group.paused

	if(group.paused) then
		nut.log.addRaw("pausing group "..grp)
		nut.util.notify("Pausing", group.players)
		for k, ply in ipairs(group.players) do
			ply:Lock()
		end
	else
		local amt = 0
		nut.log.addRaw("unpausing group "..grp.." in 5 seconds")
		timer.Create("unpauseTimer"..grp, 1, 5, function()
			amt = amt + 1
			if(amt != 5) then nut.util.notify("Unpausing in "..(5-amt), group.players) return end
			nut.util.notify("Resume!", group.players)
			nut.log.addRaw("unpaused group "..grp)
			for k, ply in ipairs(group.players) do
				ply:UnLock()
			end
		end)
	end
end

function PLUGIN:AddUserToGroup(grp, ply)
	local group = self.pauseGroup[grp]
	if(!group) then
		group = {paused = false, players = {}}
	end

	table.insert(group.players, ply)
	if(group.paused) then
		ply:Lock()
	end
	self.pauseGroup[grp] = group
end

function PLUGIN:RemoveUserFromGroup(grp, ply)
	local group = self.pauseGroup[grp]
	if(!group) then return end
	
	local id
	for k, v in ipairs(group.players) do
		if(v == ply) then
			id = k
		end
	end
	if(id) then
		table.remove(group.players, id)
	end
	if(group.paused) then
		ply:UnLock()
	end
end

function PLUGIN:DisbandGroup(group)
	local group = self.pauseGroup[group]
	if(!group) then return end

	for k, ply in ipairs(group.players) do
		if(group.paused) then
			ply:UnLock()
		end
	end

	self.pauseGroup[group] = nil
end
