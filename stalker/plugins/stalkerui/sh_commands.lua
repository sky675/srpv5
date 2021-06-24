nut.command.add("discord", {
	desc = "Get information on our discord & an invite link",
	onRun = function(client, arguments)
		netstream.Start(client, "discord_help")
		return "Done"
	end
})

nut.command.add("printcommands", {
	desc = "Prints all commands to console, this is for dev purposes",
	superAdminOnly = true,
	onRun = function()
		netstream.Start(client, "printcommands")
	end
})

if(CLIENT) then
	netstream.Hook("printcommands", function()
		for k, v in SortedPairs(nut.command.list) do --sa only
			if(v.superAdminOnly) then
				print("------------------\n")
				print("/"..k)
				local description = v:getDescription()
				if (description != "") then
					print("\t"..description)
				end
				print("\tSyntax: " ..v.syntax)
				print("\t*Useable by: Super Admin Only*\n")
			end
		end
		for k, v in SortedPairs(nut.command.list) do --admin only
			if(v.adminOnly) then
				print("------------------\n")
				print("/"..k)
				local description = v:getDescription()
				if (description != "") then
					print("\t"..description)
				end
				print("\tSyntax: " ..v.syntax)
				print("\t*Useable by: Admin Only*\n")
			end
		end
		for k, v in SortedPairs(nut.command.list) do --user only
			if(!v.adminOnly and !v.superAdminOnly) then
				print("------------------\n")
				print("/"..k)
				local description = v:getDescription()
				if (description != "") then
					print("\t"..description)
				end
				print("\tSyntax: " ..v.syntax)
				print("\t*Useable by: Any User*\n")
			end
		end
	end)

	netstream.Hook("discord_help", function()
		print("wooo discord got to this woah")
		stalkerLibrary("Help Information", STALKER_HELP_TEXT, false, 7)
	end)
end