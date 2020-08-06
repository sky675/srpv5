PLUGIN.name = "Tying"
PLUGIN.author = "Chessnut"
PLUGIN.desc = "Adds the ability to tie players."

nut.util.include("sh_animstuff.lua")
nut.util.include("sh_charsearch.lua")

nut.command.add("struggle", {
	desc = "If you have the Escape Artist trait/skill, you can use this daily to attempt to break free from a tie. See the trait desc for more info. This can also be used by anyone vs duct tape ties.",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
		if(!client:getNetVar("restricted")) then return "You cannot do this while not tied!" end
		if(IsValid(client.nutRagdoll)) then return "You cannot do this while unconcious/fallen over!" end
		if(client:getChar():getData("strugglelast", 0) >= os.time()) then return "The cooldown is not finished yet!" end
		if(!client:getNetVar("tapetied")) then
			if(!nut.traits.hasTrait(client, "gen_escape")) then return "You need the Escape Artist trait to use this!" end
			client:getChar():setData("strugglelast", os.time() + 72000) --jeez
		end


		client.nutBeingUnTied = true
		client:setNetVar("struggling", true)

		nut.chat.send(client, "mes", "begins to struggle against their ties.")

		local val = 20
		val = val * nut.traits.getMod(client, "actiontime")
		client:setAction("Struggling...", val, function()
			if(!client:getNetVar("struggling")) then return end

			client:setNetVar("tapetied")
			client:setRestricted(false)
			client.nutBeingUnTied = false
			client:EndHandcuffAnim()

			client:EmitSound("npc/roller/blade_in.wav")
		end)
	end
})

if (SERVER) then
	function PLUGIN:PlayerLoadout(client)
		client:setNetVar("restricted")
		client:setNetVar("struggling")
		client:setAction()
		client:EndHandcuffAnim()
	end

	function PLUGIN:PlayerUse(client, entity)
		--this should allow untying of ragdolled ppl
		--this should work i think? they might conflict with each other idk
		if(IsValid(entity) and entity:GetClass() == "prop_ragdoll" and IsValid(entity:getNetVar("player"))) then
			entity = entity:getNetVar("player")
		end

		if(!client:getNetVar("restricted") and entity:IsPlayer() and entity:getNetVar("struggling")) then
			entity:setNetVar("struggling")
			entity:setAction()
			client:notify("You have stopped their struggle attempt.")
			return
		end

		if (!client:getNetVar("restricted") and entity:IsPlayer() and entity:getNetVar("restricted") and !entity.nutBeingUnTied) then
			entity.nutBeingUnTied = true

			local val = 5
			val = val * nut.traits.getMod(client, "actiontime")

			entity:setAction("@beingUntied", val)

			client:setAction("@unTying", val)
			client:doStaredAction(entity, function()
				entity:setNetVar("tapetied")
				entity:setRestricted(false)
				entity.nutBeingUnTied = false
				entity:EndHandcuffAnim()

				client:EmitSound("npc/roller/blade_in.wav")
			end, val, function()
				if (IsValid(entity)) then
					entity.nutBeingUnTied = false
					entity:setAction()
				end

				if (IsValid(client)) then
					client:setAction()
				end
			end)
		end
	end

	function PLUGIN:OnPlayerUnRestricted(client)
		client:setNetVar("struggling")
		client:setAction()

		local searcher = client:getNetVar("searcher")
		if (IsValid(searcher)) then
			self:stopSearching(searcher)
		end
	end
else
	local COLOR_TIED = Color(245, 215, 110)

	function PLUGIN:DrawCharInfo(client, character, info)
		if (client:getNetVar("restricted")) then
			if(client:getNetVar("tapetied")) then
				info[#info + 1] = {"Is Tape Tied", COLOR_TIED}
			else
				info[#info + 1] = {"Is Zip Tied", COLOR_TIED}
			end
		end
		if(client:getNetVar("struggling")) then
			info[#info + 1] = {"Is Struggling (Press +use to stop them)", Color(255,60,60)}
		end
	end
end