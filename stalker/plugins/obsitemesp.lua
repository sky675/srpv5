PLUGIN.name = "Item ESP in observer"
PLUGIN.author = "sky"
PLUGIN.desc = "Adds an Item ESP to the Admin ESP for observer."

if CLIENT then
    NUT_CVAR_ITEMESP = CreateClientConVar("nut_obsitemesp", 1, true, true)

    function PLUGIN:HUDPaint()
        local client = LocalPlayer()

        if (client:IsSuperAdmin() and client:GetMoveType() == MOVETYPE_NOCLIP and !client:InVehicle() and NUT_CVAR_ADMINESP:GetBool() and NUT_CVAR_ITEMESP:GetBool()) then
            local sx, sy = surface.ScreenWidth(), surface.ScreenHeight()

            for k, v in ipairs(ents.GetAll()) do
                if(v:GetClass() == "nut_item") then
                local scrPos = v:GetPos():ToScreen()
				local marginx, marginy = sy*.1, sy*.1
                local x, y = math.Clamp(scrPos.x, marginx, sx - marginx), math.Clamp(scrPos.y, marginy, sy - marginy)
                local distance = client:GetPos():Distance(v:GetPos())
                local factor = 1 - math.Clamp(distance/1024, 0, 1)
                local size = math.max(10, 32*factor)
                local alpha = math.Clamp(255*factor, 80, 255)

                surface.SetDrawColor(30, 30, 30, alpha)
                surface.DrawRect(x - size/2, y - size/2, size, size)
                
                local name = "invalid"
                if(v.getItemTable and v:getItemTable()) then
                    name = v:getItemTable().name
                end

                nut.util.drawText("item: "..name, x, y-size, ColorAlpha(Color(220,220,220,255),alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
				end
				---[[
				if(v:GetClass() == "gas_zone1") then
					local scrPos = v:GetPos():ToScreen()
					local marginx, marginy = sy*.1, sy*.1
					local x, y = math.Clamp(scrPos.x, marginx, sx - marginx), math.Clamp(scrPos.y, marginy, sy - marginy)
					local distance = client:GetPos():Distance(v:GetPos())
					local factor = 1 - math.Clamp(distance/1024, 0, 1)
					local size = math.max(10, 32*factor)
					local alpha = math.Clamp(255*factor, 80, 255)
	
					surface.SetDrawColor(30, 30, 30, alpha)
					surface.DrawRect(x - size/2, y - size/2, size, size)
	
					nut.util.drawText("Gas Zone", x, y-size, ColorAlpha(Color(0,220,0,255),alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)	
				end
				--]]
            end
        end
    end

    function PLUGIN:SetupQuickMenu(menu)
    	if (LocalPlayer():IsSuperAdmin()) then
            local buttonItem = menu:addCheck("Toggle Item ESP", function(panel, state)
                if(state) then
                    RunConsoleCommand("nut_obsitemesp", "1")
                else
                    RunConsoleCommand("nut_obsitemesp", "0")
                end
            end, NUT_CVAR_ITEMESP:GetBool())

            menu:addSpacer()
        end
    end
end