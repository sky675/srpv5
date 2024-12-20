nut.command.add("roll", {
	desc = "Roll 0 to maximum or 100",
	syntax = "[number maximum]",
	onRun = function(client, arguments)
		local max = math.min(tonumber(arguments[1]) or 100, 100)
		local amt = math.random(0, max)
		nut.log.addRaw(client:Name().." ("..client:SteamID()..") did roll: "..amt.." out of "..max)
		nut.chat.send(client, "roll", amt.." out of "..max)
	end
})

nut.command.add("pm", {
	desc = "OOC PM the specified person",
	syntax = "<string target> <string message>",
	onRun = function(client, arguments)
		local message = table.concat(arguments, " ", 2)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target)) then
			local voiceMail = target:getNutData("vm")

			if (voiceMail and voiceMail:find("%S")) then
				return target:Name()..": "..voiceMail
			end

			if ((client.nutNextPM or 0) < CurTime()) then
				nut.chat.send(client, "pm", message, false, {client, target})

				client.nutNextPM = CurTime() + 0.5
				target.nutLastPM = client
			end
		end
	end
})

nut.command.add("reply", {
	desc = "Quick command to reply to whoever last pm'd you",
	syntax = "<string message>",
	onRun = function(client, arguments)
		local target = client.nutLastPM

		if (IsValid(target) and (client.nutNextPM or 0) < CurTime()) then
			nut.chat.send(client, "pm", table.concat(arguments, " "), false, {client, target})
			client.nutNextPM = CurTime() + 0.5
		end
	end
})

nut.command.add("setvoicemail", {
	desc = "Anyone PMing you will get this returned instead",
	syntax = "[string message]",
	onRun = function(client, arguments)
		local message = table.concat(arguments, " ")

		if (message:find("%S")) then
			client:setNutData("vm", message:sub(1, 240))

			return "@vmSet"
		else
			client:setNutData("vm")

			return "@vmRem"
		end
	end
})

nut.command.add("flaggive", {
	adminOnly = true,
	syntax = "<string name> [string flags]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			local flags = arguments[2]

			if (!flags) then
				local available = ""

				-- Aesthetics~~
				for k, v in SortedPairs(nut.flag.list) do
					if (!target:getChar():hasFlags(k)) then
						available = available..k
					end
				end

				return client:requestString("@flagGiveTitle", "@flagGiveDesc", function(text)
					nut.command.run(client, "flaggive", {target:Name(), text})
				end, available)
			end

			target:getChar():giveFlags(flags)

			if(client:GetInfoNum("nut_broadcast", 1) == 1) then
			nut.util.notifyLocalizedL("flagGive", 2, nil, client:Name(), target:Name(), flags)
			end
		end
	end
})

nut.command.add("flagtake", {
	adminOnly = true,
	syntax = "<string name> [string flags]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			local flags = arguments[2]

			if (!flags) then
				return client:requestString("@flagTakeTitle", "@flagTakeDesc", function(text)
					nut.command.run(client, "flagtake", {target:Name(), text})
				end, target:getChar():getFlags())
			end

			target:getChar():takeFlags(flags)

			if(client:GetInfoNum("nut_broadcast", 1) == 1) then
			nut.util.notifyLocalizedL("flagTake", 2, nil, client:Name(), flags, target:Name())
			end
		end
	end
})

nut.command.add("charsetmodel", {
	adminOnly = true,
	syntax = "<string name> <string model>",
	onRun = function(client, arguments)
		if (!arguments[2]) then
			return L("invalidArg", client, 2)
		end

		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			target:getChar():setModel(arguments[2])
			target:SetupHands()

			if(client:GetInfoNum("nut_broadcast", 1) == 1) then
			nut.util.notifyLocalized("cChangeModel", nil, client:Name(), target:Name(), arguments[2])
			end
		end
	end
})

nut.command.add("charsetskin", {
	adminOnly = true,
	syntax = "<string name> [number skin]",
	onRun = function(client, arguments)
		local skin = tonumber(arguments[2])
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			target:getChar():setData("skin", skin)
			target:SetSkin(skin or 0)

			if(client:GetInfoNum("nut_broadcast", 1) == 1) then
			nut.util.notifyLocalized("cChangeSkin", nil, client:Name(), target:Name(), skin or 0)
			end
		end
	end
})

nut.command.add("charsetbodygroup", {
	adminOnly = true,
	syntax = "<string name> <string bodyGroup> [number value]",
	onRun = function(client, arguments)
		local value = tonumber(arguments[3])
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			local index = target:FindBodygroupByName(arguments[2])

			if (index > -1) then
				if (value and value < 1) then
					value = nil
				end

				local groups = target:getChar():getData("groups", {})
					groups[index] = value
				target:getChar():setData("groups", groups)
				target:SetBodygroup(index, value or 0)

				if(client:GetInfoNum("nut_broadcast", 1) == 1) then
				nut.util.notifyLocalized("cChangeGroups", nil, client:Name(), target:Name(), arguments[2], value or 0)
				end
			else
				return "@invalidArg", 2
			end
		end
	end
})

nut.command.add("charsetname", {
	adminOnly = true,
	syntax = "<string name> [string newName]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and !arguments[2]) then
			return client:requestString("@chgName", "@chgNameDesc", function(text)
				nut.command.run(client, "charsetname", {target:Name(), text})
			end, target:Name())
		end

		table.remove(arguments, 1)

		local targetName = table.concat(arguments, " ")

		if (IsValid(target) and target:getChar()) then
			if(client:GetInfoNum("nut_broadcast", 1) == 1) then
			nut.util.notifyLocalized("cChangeName", nil, client:Name(), target:Name(), targetName)
			end

			target:getChar():setName(targetName)
		end
	end
})

nut.command.add("chargiveitem", {
	adminOnly = true,
	syntax = "<string name> <string item> <integer amount>",
	onRun = function(client, arguments)
		if (!arguments[2]) then
			return L("invalidArg", client, 2)
		end

		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			local uniqueID = arguments[2]:lower()
			local amount = tonumber(arguments[3])

			if (!nut.item.list[uniqueID]) then
				for k, v in SortedPairs(nut.item.list) do
					if (nut.util.stringMatches(v.name, uniqueID)) then
						uniqueID = k

						break
					end
				end
			end

			if (arguments[3] and arguments[3] != "") then
				if (!amount) then
					return L("invalidArg", client, 3)
				end
			end

			target:getChar():getInv():add(uniqueID, amount or 1)
				:next(function(res)
					if (IsValid(target)) then
						target:notifyLocalized("itemCreated")
					end
					if (IsValid(client) and client ~= target) then
						client:notifyLocalized("itemCreated")
					end
				end)
				:catch(function(err)
					if (IsValid(client)) then
						client:notifyLocalizedL(err, 3)
					end
				end)
		end
	end
})

nut.command.add("charkick", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target)) then
			local char = target:getChar()
			if (char) then
				if(client:GetInfoNum("nut_broadcast", 1) == 1) then
				for k, v in ipairs(player.GetAll()) do
					v:notifyLocalizedL("charKick", 3, client:Name(), target:Name())
				end
				end

				char:kick()
			end
		end
	end
})

nut.command.add("charban", {
	syntax = "<string name>",
	adminOnly = true,
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target)) then
			local char = target:getChar()

			if (char) then
				if(client:GetInfoNum("nut_broadcast", 1) == 1) then
				nut.util.notifyLocalizedL("charBan", 3, client:Name(), target:Name())
				end
				char:ban()
			end
		end
	end
})

nut.command.add("charunban", {
	syntax = "<string name>",
	adminOnly = true,
	onRun = function(client, arguments)
		if ((client.nutNextSearch or 0) >= CurTime()) then
			return L("charSearching", client)
		end

		local name = table.concat(arguments, " ")

		for k, v in pairs(nut.char.loaded) do
			if (nut.util.stringMatches(v:getName(), name)) then
				if (v:getData("banned")) then
					v:setData("banned")
					v:setData("permakilled")
				else
					return "@charNotBanned"
				end

				if(client:GetInfoNum("nut_broadcast", 1) == 1) then
				return nut.util.notifyLocalized("charUnBan", nil, client:Name(), v:getName())
				end
				return "Unbanned "..v:getName()
			end
		end

		client.nutNextSearch = CurTime() + 15

		nut.db.query("SELECT _id, _name, _data FROM nut_characters WHERE _name LIKE \"%"..nut.db.escape(name).."%\" LIMIT 1", function(data)
			if (data and data[1]) then
				local charID = tonumber(data[1]._id)
				local name = data[1]._name
				local data = util.JSONToTable(data[1]._data or "[]")

				client.nutNextSearch = 0

				if (!data.banned) then
					return client:notifyLocalized("charNotBanned")
				end

				data.banned = nil
				
				nut.db.updateTable({_data = data}, nil, nil, "_id = "..charID)
				if(client:GetInfoNum("nut_broadcast", 1) == 1) then
				nut.util.notifyLocalized("charUnBan", nil, client:Name(), v:getName())
				else
					client:notify("Unbanned "..v:getName())
				end
			end
		end)
	end
})

nut.command.add("givemoney", {
	desc = "Give the specified amount to who you're looking at, if you have that amount.",
	syntax = "<number amount>",
	onRun = function(client, arguments)
		local number = tonumber(arguments[1])
		number = number or 0
		local amount = math.floor(number)

		if (!amount or !isnumber(amount) or amount <= 0) then
			return L("invalidArg", client, 1)
		end

		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local target = util.TraceLine(data).Entity

		if (IsValid(target) and target:IsPlayer() and target:getChar()) then
			amount = math.Round(amount)

			if (!client:getChar():hasMoney(amount)) then
				return
			end

			target:getChar():giveMoney(amount)
			client:getChar():takeMoney(amount)

			target:notifyLocalized("moneyTaken", nut.currency.get(amount))
			client:notifyLocalized("moneyGiven", nut.currency.get(amount))

			client:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)
		end
	end
})

nut.command.add("charsetmoney", {
	adminOnly = true,
	syntax = "<string target> <number amount>",
	onRun = function(client, arguments)
		local amount = tonumber(arguments[2])

		if (!amount or !isnumber(amount) or amount < 0) then
			return "@invalidArg", 2
		end

		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target)) then
			local char = target:getChar()
			
			if (char and amount) then
				amount = math.Round(amount)
				char:setMoney(amount)
				client:notifyLocalized("setMoney", target:Name(), nut.currency.get(amount))
			end
		end
	end
})

nut.command.add("dropmoney", {
	desc = "Drop the specified amount on the ground, if you have that amount.",
	syntax = "<number amount>",
	onRun = function(client, arguments)
		local amount = tonumber(arguments[1])

		if (!amount or !isnumber(amount) or amount < 1) then
			return "@invalidArg", 1
		end

		amount = math.Round(amount)
		
		if (!client:getChar():hasMoney(amount)) then
			return
		end

		client:getChar():takeMoney(amount)
		local money = nut.currency.spawn(client:getItemDropPos(), amount)
		money.client = client
		money.charID = client:getChar():getID()
		
		client:doGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)
	end
})

nut.command.add("plywhitelist", {
	adminOnly = true,
	syntax = "<string name> <string faction>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		local name = table.concat(arguments, " ", 2)

		if (IsValid(target)) then
			local faction = nut.faction.teams[name]

			if (!faction) then
				for k, v in ipairs(nut.faction.indices) do
					if (nut.util.stringMatches(L(v.name, client), name) or nut.util.stringMatches(v.uniqueID, name)) then
						faction = v

						break
					end
				end
			end

			if (faction) then
				if (target:setWhitelisted(faction.index, true)) then
					if(client:GetInfoNum("nut_broadcast", 1) == 1) then
					for k, v in ipairs(player.GetAll()) do
						v:notifyLocalized("whitelist", client:Name(), target:Name(), L(faction.name, v))
					end
					end
				end
			else
				return "@invalidFaction"
			end
		end
	end
})

nut.command.add("chargetup", {
	onRun = function(client, arguments)
		if(client:getNetVar("neardeath")) then return end --sorry i have to do it here

		local entity = client.nutRagdoll

		if (IsValid(entity) and entity.nutGrace and entity.nutGrace < CurTime() and entity:GetVelocity():Length2D() < 8 and !entity.nutWakingUp) then
			entity.nutWakingUp = true

			client:setAction("@gettingUp", 5, function()
				if (!IsValid(entity)) then
					return
				end

				entity:Remove()
			end)
		end
	end
})

nut.command.add("plyunwhitelist", {
	adminOnly = true,
	syntax = "<string name> <string faction>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		local name = table.concat(arguments, " ", 2)

		if (IsValid(target)) then
			local faction = nut.faction.teams[name]

			if (!faction) then
				for k, v in ipairs(nut.faction.indices) do
					if (nut.util.stringMatches(L(v.name, client), name) or nut.util.stringMatches(v.uniqueID, name)) then
						faction = v

						break
					end
				end
			end

			if (faction) then
				if (target:setWhitelisted(faction.index, false)) then
					if(client:GetInfoNum("nut_broadcast", 1) == 1) then
					for k, v in ipairs(player.GetAll()) do
						v:notifyLocalized("unwhitelist", client:Name(), target:Name(), L(faction.name, v))
					end
					end
				end
			else
				return "@invalidFaction"
			end
		end
	end
})

nut.command.add("fallover", {
	syntax = "[number time]",
	onRun = function(client, arguments)
		if(client:getNetVar("neardeath")) then return end
		
		local time = tonumber(arguments[1])

		if (!isnumber(time)) then
			time = 5
		end

		if (time > 0) then
			time = math.Clamp(time, 1, 60)
		else
			time = nil
		end

		if (!IsValid(client.nutRagdoll)) then
			client:setRagdolled(true, time)
		end
	end
})

nut.command.add("beclass", {
	syntax = "<string class>",
	onRun = function(client, arguments)
		local class = table.concat(arguments, " ")
		local char = client:getChar()

		if (IsValid(client) and char) then
			local num = isnumber(tonumber(class)) and tonumber(class) or -1
			
			if (nut.class.list[num]) then
				local v = nut.class.list[num]

				if (char:joinClass(num)) then
					client:notifyLocalized("becomeClass", L(v.name, client))

					return
				else
					client:notifyLocalized("becomeClassFail", L(v.name, client))

					return
				end
			else
				for k, v in ipairs(nut.class.list) do
					if (nut.util.stringMatches(v.uniqueID, class) or nut.util.stringMatches(L(v.name, client), class)) then
						if (char:joinClass(k)) then
							client:notifyLocalized("becomeClass", L(v.name, client))

							return
						else
							client:notifyLocalized("becomeClassFail", L(v.name, client))

							return
						end
					end
				end
			end
			
			client:notifyLocalized("invalid", L("class", client))
		else
			client:notifyLocalized("illegalAccess")
		end
	end
})

nut.command.add("chardesc", {
	syntax = "<string desc>",
	onRun = function(client, arguments)
		arguments = table.concat(arguments, " ")

		if (!arguments:find("%S")) then
			return client:requestString("@chgDesc", "@chgDescDesc", function(text)
				nut.command.run(client, "chardesc", {text})
			end, client:getChar():getDesc())
		end

		local info = nut.char.vars.desc
		local result, fault, count = info.onValidate(arguments)

		if (result == false) then
			return "@"..fault, count
		end

		client:getChar():setDesc(arguments)

		return "@descChanged"
	end
})

nut.command.add("plytransfer", {
	adminOnly = true,
	syntax = "<string name> <string faction>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		local name = table.concat(arguments, " ", 2)
		local character = target:getChar()

		if (not IsValid(target) or not character) then
			return "@plyNotExist"
		end

		-- Find the specified faction.
		local oldFaction = nut.faction.indices[character:getFaction()]
		local faction = nut.faction.teams[name]
		if (not faction) then
			for k, v in pairs(nut.faction.indices) do
				if (nut.util.stringMatches(L(v.name, client), name)) then
					faction = v
					break
				end
			end
		end
		if (not faction) then
			return "@invalidFaction"
		end

		-- Change to the new faction.
		target:getChar():setFaction(faction.index)
		if (faction.onTransfered) then
			faction:onTransfered(target, oldFaction)
		end
		hook.Run("CharacterFactionTransfered", character, oldFaction, faction)

		-- Notify everyone of the change.
		if(client:GetInfoNum("nut_broadcast", 1) == 1) then
		for k, v in ipairs(player.GetAll()) do
			nut.util.notifyLocalized(
				"cChangeFaction",
				v, client:Name(), target:Name(), L(faction.name, v)
			)
		end
		end
	end
})

-- Credit goes to SmithyStanley
nut.command.add("clearinv", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function (client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		
		if (IsValid(target) and target:getChar()) then
			for k, v in pairs(target:getChar():getInv():getItems()) do
				v:remove()
			end

			client:notifyLocalized("resetInv", target:getChar():getName())
		end
	end
})

nut.command.add("content", {
	desc = "Here's another content link I guess.",
	onRun = function(client)
		client:SendLua([[gui.OpenURL(nut.config.get("contentURL", "https://nutscript.net"))]])
	end
})
