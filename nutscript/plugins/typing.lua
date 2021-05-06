PLUGIN.name = "Typing Indicator"
PLUGIN.desc = "Shows some text when someone types."
PLUGIN.author = "Chessnut"

if (CLIENT) then
	local TYPE_OFFSET = Vector(0, 0, 80)
	local TYPE_OFFSET_CROUCHED = Vector(0, 0, 48)
	local TYPE_COLOR = Color(250, 250, 250)

	function PLUGIN:StartChat()
		net.Start("nutTypeStatus")
			net.WriteBool(true)
		net.SendToServer()
	end

	function PLUGIN:FinishChat()
		net.Start("nutTypeStatus")
			net.WriteBool(false)
		net.SendToServer()
		net.Start("nutTypeType")
			net.WriteString("")
		net.SendToServer()
	end

	local function getName(text)
		local prefix = utf8.sub(text, 1, 1) --idk if utf8sub is a thing so

		if(!prefix:find("[!@#%%/%.]") and utf8.len(text) > 1) then
			return "ic"
		else
			--this shit is mega lazy but eh
			if(text:StartWith("/y")) then return "y" end
			if(text:StartWith("/w")) then return "w" end
			if(text:StartWith("/me")) then return "me" end
			if(text:StartWith("/action")) then return "me" end
			if(text:StartWith("/it")) then return "me" end
			if(text:StartWith("/radiow")) then return "w" end
			if(text:StartWith("/radio")) then return "ic" end
			if(text:StartWith("/rw")) then return "w" end
			if(text:StartWith("/r")) then return "ic" end
			if(text:StartWith("/")) then return "ooc" end
			return "ooc"
		end
		return ""
	end

	function PLUGIN:ChatTextChanged(text)
		if(!IsValid(LocalPlayer())) then return end

		local character = LocalPlayer():getChar()
		if (!character) then return end

		if(text == "") then 
			net.Start("nutTypeType")
				net.WriteString("")
			net.SendToServer()
			return 
		end

		net.Start("nutTypeType")
			net.WriteString(getName(text))
		net.SendToServer()
	end

	local transtabl = {
		["ic"] = "Talking...",
		["me"] = "Performing...",
		["y"] = "Yelling...",
		["w"] = "Whispering...",
		["ooc"] = "Typing..."
	}

	local data = {}
	local offset1, offset2, offset3, alpha, y

	function PLUGIN:HUDPaint()
		local ourPos = LocalPlayer():GetPos()
		local localPlayer = LocalPlayer()
		local time = RealTime() * 5

		data.start = localPlayer:EyePos()
		data.filter = localPlayer

		for k, v in ipairs(player.GetAll()) do
			if (
				v ~= localPlayer and
				v:getNetVar("typing") and
				v:GetMoveType() == MOVETYPE_WALK
			) then
				data.endpos = v:EyePos()
				if (util.TraceLine(data).Entity ~= v) then continue end
				local position = v:GetPos()
				alpha = (1 - (ourPos:DistToSqr(position) / 262144)) * 255
				if (alpha <= 0) then continue end

				local screen = (
					position +
					(v:Crouching() and TYPE_OFFSET_CROUCHED or TYPE_OFFSET)
				):ToScreen()
				offset1 = math.sin(time + 2) * alpha
				offset2 = math.sin(time + 1) * alpha
				offset3 = math.sin(time) * alpha
				y = screen.y - 20

				local stat = v:getNetVar("typingType")
				if(!stat or stat == "") then
					nut.util.drawText("•", screen.x - 8, y, ColorAlpha(TYPE_COLOR, offset1), 1, 1, "nutChatFont", offset1)
					nut.util.drawText("•", screen.x, y, ColorAlpha(TYPE_COLOR, offset2), 1, 1, "nutChatFont", offset2)
					nut.util.drawText("•", screen.x + 8, y, ColorAlpha(TYPE_COLOR, offset3), 1, 1, "nutChatFont", offset3)
				else
					nut.util.drawText(transtabl[stat] or "ERRORLOL", screen.x, y, ColorAlpha(TYPE_COLOR, alpha), 1, 1, "nutChatFont", offset2)
					
				end
			end
		end
	end
else
	util.AddNetworkString("nutTypeStatus")
	util.AddNetworkString("nutTypeType")

	net.Receive("nutTypeStatus", function(_, client)
		local bool = net.ReadBool()
		client:setNetVar("typing", bool)
		hook.Run("OnPlayerTypingChange", client, bool)
	end)
	net.Receive("nutTypeType", function(_, client)
		local bool = net.ReadString()
		print("recieved typestat", bool)
		client:setNetVar("typingType", bool)
	end)
end
