local PLUGIN = PLUGIN

PLUGIN.name = "Automod"
PLUGIN.author = "sky"
PLUGIN.desc = "just gives donator stuff automatically rn"

--ill do dono stuff under here i guess
	if(SERVER) then
		hook.Add("OnCharCreated", "givedono", function(ply, char)
			if(ply:IsUserGroup("donator")&&!ply:getNutData("donatorimm")) then
				char:giveFlags("petWP") --unsure about W with new stuff but watever
			end
		end)
	end

	function PLUGIN:PlayerLoadedChar(ply, char, lastchar)
		if(char) then
			if(ply:IsUserGroup("donator")&&!ply:getNutData("donatorimm")&&!char:hasFlags("petWP")) then
				char:giveFlags("petWP") --unsure about W with new stuff but watever
			end
		end
	end

	nut.command.add("setdonatordisable", {
		desc = "Set it so specified donator wont automatically get petW on char creation",
		syntax = "<string name>",
		adminOnly = true,
		onRun = function(client, arguments)
			local target = nut.util.findPlayer(arguments[1])
	
			if(!IsValid(target)) then return "No target" end        
			if(target == client) then
				return "You cannot toggle it on yourself!"
			end
	
			local setTo = true
			if(target:getNutData("donatorimm")) then
				setTo = nil
			end
	
			target:setNutData("donatorimm", setTo)
			target:saveNutData()
			
			local on = "disabled"
			if(setTo == nil) then
				on = "enabled"
			end
	
			client:notify(on.." "..target:Name().."'s ability to be automatically given the donator flags.")
		end
	})

--??? strike system idk lol
