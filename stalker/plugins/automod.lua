local PLUGIN = PLUGIN

PLUGIN.name = "Automod"
PLUGIN.author = "sky"
PLUGIN.desc = "just gives donator stuff automatically rn"

--prop collision vs players
if(SERVER) then
	hook.Add("OnPhysgunPickup", "stoppropkill", function(ply, ent)
		--should only get normal props, so this doesnt happen if theyre nocollide and reset it
		if(ent:GetClass() == "prop_physics" and ent:GetCollisionGroup() == COLLISION_GROUP_NONE) then
			ent:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
		end
	end)
	hook.Add("PhysgunDrop", "stoppropkill", function(ply, ent)
		if(ent:GetClass() != "prop_physics") then return end
		--should only get normal props, so this doesnt happen if theyre nocollide and reset it
		timer.Simple(5, function() --little bit of a delay to prevent flinging at ppl
			if(IsValid(ent) and ent:GetCollisionGroup() == COLLISION_GROUP_PASSABLE_DOOR) then
				ent:SetCollisionGroup(COLLISION_GROUP_NONE)
			end
		end)
	end)
end

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
