nut.command.add("setfemale", {
	syntax = "<string name>",
	desc = "Utility function to set a character to use female sounds even if their model isnt",
	adminOnly = true,
	onRun = function(client, arguments)
		local target = nut.util.findPlayer(arguments[1])
		if(!IsValid(target)) then return "No target" end

		local char = target:getChar()
		if(!char) then return "No char" end

		if(char:getData("cFemale")) then
			char:setData("cFemale", nil, nil, player.GetAll())
			client:notify("set "..char:getName().."'s female status to false")
		else
			char:setData("cFemale", true, nil, player.GetAll())
			client:notify("set "..char:getName().."'s female status to true")
		end
	end
})