PLUGIN.name = "Observer"
PLUGIN.author = "Chessnut"
PLUGIN.desc = "Adds on to the no-clip mode to prevent instrusion."

if (CLIENT) then
	-- Create a setting to see if the player will teleport back after noclipping.
	NUT_CVAR_OBSTPBACK = CreateClientConVar("nut_obstpback", 0, true, true)
	NUT_CVAR_ADMINESP = CreateClientConVar("nut_obsesp", 1, true, true)
	NUT_CVAR_ADMINESPAVANCED = CreateClientConVar("nut_obsespadvanced", 1, true, true)

	local client, sx, sy, scrPos, marginx, marginy, x, y, teamColor, distance, factor, size, alpha
	local dimDistance = 1024
	function PLUGIN:HUDPaint()
		client = LocalPlayer()

		if (client:IsAdmin() and client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle() and NUT_CVAR_ADMINESP:GetBool()) then--(client:IsAdmin() or client:IsUserGroup("operator"))  and client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle() and NUT_CVAR_ADMINESP:GetBool()) then
			sx, sy = surface.ScreenWidth(), surface.ScreenHeight()

			for k, v in ipairs(player.GetAll()) do
				if (v == client) then continue end

				scrPos = v:GetPos():ToScreen()
				marginx, marginy = sy*.1, sy*.1
				x, y = math.Clamp(scrPos.x, marginx, sx - marginx), math.Clamp(scrPos.y, marginy, sy - marginy)
				teamColor = team.GetColor(v:Team())
				distance = client:GetPos():Distance(v:GetPos())
				factor = 1 - math.Clamp(distance/dimDistance, 0, 1)
				size = math.max(10, 32*factor)
				alpha = math.Clamp(255*factor, 80, 255)

				surface.SetDrawColor(teamColor.r, teamColor.g, teamColor.b, alpha)
				if (NUT_CVAR_ADMINESPAVANCED:GetBool()) then
					surface.DrawLine(sx * 0.5, sy * 0.5, x, y)
					surface.DrawRect(x - size/2, y - size/2, size, size)
				end

				nut.util.drawText(v:Name():gsub("#", "\226\128\139#"), x, y - size, ColorAlpha(teamColor, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
				nut.util.drawText(v:steamName(), x, y-size+12, ColorAlpha(Color(220,220,220,255), alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
			end
		end
	end

	function PLUGIN:SetupQuickMenu(menu)
		if (LocalPlayer():IsSuperAdmin()) then--IsAdmin() or LocalPlayer():IsUserGroup("operator")) then
			local buttonESP = menu:addCheck(L"toggleESP", function(panel, state)
				if (state) then
					RunConsoleCommand("nut_obsesp", "1")
				else
					RunConsoleCommand("nut_obsesp", "0")
				end
				net.Start("switchESPLog")
				net.WriteBool(state)
				net.SendToServer()
			end, NUT_CVAR_ADMINESP:GetBool())

			local buttonESPAdvanced = menu:addCheck(L"toggleESPAdvanced", function(panel, state)
				if (state) then
					RunConsoleCommand("nut_obsespadvanced", "1")
				else
					RunConsoleCommand("nut_obsespadvanced", "0")
				end
			end, NUT_CVAR_ADMINESPAVANCED:GetBool())

			local buttonTP = menu:addCheck(L"toggleObserverTP", function(panel, state)
				if (state) then
					RunConsoleCommand("nut_obstpback", "1")
				else
					RunConsoleCommand("nut_obstpback", "0")
				end
			end, NUT_CVAR_OBSTPBACK:GetBool())

			menu:addSpacer()
		end
	end

	function PLUGIN:ShouldDrawEntityInfo(entity)
		if (IsValid(entity)) then
			if (entity:IsPlayer() or IsValid(entity:getNetVar("player"))) then
				if (entity.IsAdmin and entity:IsAdmin() and entity:GetMoveType() == MOVETYPE_NOCLIP) then
					return false
				end
			end
		end
	end
else
	util.AddNetworkString("switchESPLog")
	net.Receive("switchESPLog", function (_, ply)
		local on = net.ReadBool()

		if(on) then
			nut.log.add(ply:Name().." switched the admin ESP on")
		else
			nut.log.add(ply:Name().." switched the admin ESP off")
		end
	end)

	function PLUGIN:PlayerNoClip(client, state)
		-- Observer mode is reserved for administrators.
		if (client:IsAdmin() or client:IsUserGroup("operator")) then
			-- Check if they are entering noclip.
			if (state) then
				-- Store their old position and looking		 at angle.
				client.nutObsData = {client:GetPos(), client:EyeAngles()}
				-- Hide them so they are not visible.
				client:SetNoDraw(true)
				client:SetNotSolid(true)
				client:DrawWorldModel(false)
				client:DrawShadow(false)
				-- Don't allow the player to get hurt.
				client:GodEnable()
				-- Don't allow npcs to target the player.
				client:SetNoTarget(true)
				local clientPos = client:GetPos()
				nut.log.addRaw(client:Name().." turned on observer. Pos: "..tostring(clientPos))
				hook.Run("OnPlayerObserve", client, state, clientPos)
			else
				if (client.nutObsData) then
					-- Move they player back if they want.
					if (client:GetInfoNum("nut_obstpback", 0) > 0) then
						local position, angles = client.nutObsData[1], client.nutObsData[2]

						-- Do it the next frame since the player can not be moved right now.
						timer.Simple(0, function()
							client:SetPos(position)
							client:SetEyeAngles(angles)
							-- Make sure they stay still when they get back.
							client:SetVelocity(Vector(0, 0, 0))
						end)
					end

					-- Delete the old data.
					client.nutObsData = nil
				end

				-- Make the player visible again.
				client:SetNoDraw(false)
				client:SetNotSolid(false)
				client:DrawWorldModel(true)
				client:DrawShadow(true)
				-- Let the player take damage again.
				client:GodDisable()
				-- Let npcs target the player again.
				client:SetNoTarget(false)
				local clientPos = client:GetPos()
				nut.log.addRaw(client:Name().." turned off observer. Pos: "..tostring(clientPos))
				hook.Run("OnPlayerObserve", client, state, clientPos)
			end
		end
	end
end
