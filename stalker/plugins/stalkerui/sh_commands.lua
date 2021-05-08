nut.command.add("discord", {
	desc = "Get information on our discord & an invite link",
	onRun = function(client, arguments)
		netstream.Start(client, "discord_help")
		return "Done"
	end
})

if(CLIENT) then
netstream.Hook("discord_help", function()
	print("wooo discord got to this woah")
	stalkerLibrary("Help Information", STALKER_HELP_TEXT, false, 7)
end)
end