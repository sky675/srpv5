if (CLIENT) then
    function stalkerDisplayStats(char)

        
        local transtype = {
            ["pos"] = "Positive",
            ["neg"] = "Negative",
        }

        local traits = char:getTrait()--Data("traits", {})
        local xp = char:getData("xp", {})


        --Window is Main Trait Window container, background image
        local Window = vgui.Create( "DFrame" )
       
        local statsText = (Material("sky/srp_stats.png"))
        local textH = 607
        local textW = 505
        local scaledH = (textH*(invh/invTextureH))
        local scaledW = (textW*(invw/invTextureW))
        local popupX = (ScrW()*0.5)-(scaledW*0.5)
        local popupY = (ScrH()*0.5)-(scaledH*0.5)

        Window:SetDraggable( false )
        Window:ShowCloseButton( false )
        Window:SetBackgroundBlur( true )
        Window:SetDrawOnTop( true )


        --Scroll panel for all the traits
        local InnerPanel = vgui.Create( "DScrollPanel", Window )
        InnerPanel:SetPaintBackground( false )
        --InnerPanel:SetSize(scaledW, scaledH)
        InnerPanel:SetSize((443*(scaledW/textW)), ((326*(scaledH/textH))))
        InnerPanel:SetPos(popupX+(41*(scaledW/textW)), (popupY+(67*(scaledH/textH))))

        --Stylizing the scrollbar
        local sbar = InnerPanel:GetVBar()
        function sbar:Paint(w, h)
            draw.RoundedBox(10, 0, 0, w, h, Color(80,80,80, 100))
        end
        function sbar.btnUp:Paint(w, h)
            draw.RoundedBoxEx(10, 0, 0, w, h, Color(112,112,112, 100), true, true, false, false)
        end
        function sbar.btnDown:Paint(w, h)
            draw.RoundedBoxEx(10, 0, 0, w, h, Color(112,112,112, 100), false, false, true, true)
        end
        function sbar.btnGrip:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(112,112,112, 100))
        end

        --Table for traits
        local traitsTable = vgui.Create( "DListView", InnerPanel )
        traitsTable:SetSkin("stalker")
        traitsTable:UpdateColours(nutscript)
        traitsTable:DisableScrollbar()
        traitsTable:SetPaintBackground( false )
        traitsTable:SetPaintBorderEnabled( false )
        

        traitsTable:SetHeaderHeight(18*(scaledH/textH))
        traitsTable:SetDataHeight(18*(scaledH/textH))
        traitsTable:SetMultiSelect( false )

        local widthAllowed = (425*(scaledW/textW))

        -- total: 425
        -- col1:217   col2:152   col3:56
        --      51%        35%        13%
        col1Width = 425*0.51
        col2Width = 425*0.35
        col3Width = 425*0.13

        traitsTable:AddColumn( "Trait" )
        traitsTable:AddColumn( "Category" )
        traitsTable:AddColumn( "   " )

        --box under traits table

        local traitTitle = vgui.Create("DLabel", Window)
        traitTitle:SetPos(popupX+(35*(scaledW/textW)), (popupY+(435*(scaledH/textH))))
        traitTitle:SetSize(440*(scaledW/textW), 20*(scaledH/textH))
        traitTitle:SetText("No Trait Selected")
        traitTitle:SetFont("nutScaledInvenLight")

        local traitCat = vgui.Create("DLabel", Window)
        traitCat:SetPos(popupX+(35*(scaledW/textW)), (popupY+(450*(scaledH/textH))))
        traitCat:SetSize(440*(scaledW/textW), 20*(scaledH/textH))
        traitCat:SetText(" ")
        traitCat:SetFont("nutScaledInvenLight")
        traitCat:SetColor(Color(155, 200, 200))

        local traitType = vgui.Create("DLabel", Window)
        traitType:SetPos(popupX+(35*(scaledW/textW)), (popupY+(465*(scaledH/textH))))
        traitType:SetSize(440*(scaledW/textW), 20*(scaledH/textH))
        traitType:SetText(" ")
        traitType:SetFont("nutScaledInvenLight")
        traitType:SetColor(Color(0, 255, 200))
        
        local traitDesc = vgui.Create("DLabel", Window)
        traitDesc:SetContentAlignment(1)
        traitDesc:SetPos(popupX+(35*(scaledW/textW)), (popupY+(480*(scaledH/textH))))
        traitDesc:SetSize(440*(scaledW/textW), 70*(scaledH/textH))
        traitDesc:SetText(" ")
        traitDesc:SetFont("nutScaledInvenLight")
        traitDesc:SetWrap( true )
        traitDesc:SetColor(Color(155, 155, 155))

        for k,v in pairs(nut.traits.list) do
            if(traits[k]) then
                --create it
                local xpt = "N/A"
                if(v.xp and v.xp[traits[k]]) then
                    xpt = tostring(xp[k] or 0).."/"..v.xp[traits[k]]
                end

                --local button
                --local pts
                --if(char:getData("traitlevelups",{})[k]) then
                    --button = vgui.Create("DButton")
                    --pts = char:getData("traitlevelups", {})[k]
                --end
                traitsTable:AddLine(v.getName and v.getName(char) or v.name, v.category, xpt)
                

                --li:SetTooltip(v.desc)
            end
        end
        traitsTable.OnRowSelected = function(panel, rowIndex, row)
            for k,v in pairs(nut.traits.list) do
                if (v.getName and v.getName(char) or v.name) == row:GetValue(1) then
                    traitTitle:SetText(v.getName and v.getName(char) or v.name)
                    traitCat:SetText(v.category)
                    traitType:SetText(transtype[v.type] or "Neutral")

                    if v.type == "pos" then
                        traitType:SetColor(Color(0, 255, 200))
                    
                    elseif v.type == "neg" then
                        traitType:SetColor(Color(255, 0, 76))
                    
                    else
                        traitType:SetColor(Color(155, 155, 155))
                    end

                    traitDesc:SetText(v.desc)

                    local function dermaadd(text)
                        if(!text) then return end
                        netstream.Start("LevelupSkill", k, text)
                        --base:Remove()
                    end
                    
                    if(char:getData("traitlevelups",{})[k]) then
                        local res = nut.plugin.list.traits:GetSkillChoiceForSkill(k)
                        pts = char:getData("traitlevelups", {})[k]
                        stalkerGreyButton("levelUp", (popupX+(25*(scaledW/textW))), (popupY+(579*(scaledH/textH))),
                        "New Trait",

                        function() 
                            if (res) then
                                Window:Close()
                                stalkerQuery("Pick a new trait - " .. pts .. " point(s) available.",
                                res[1] and res[1].name, function() dermaadd(res[1] and res[1].id) end,
                                res[2] and res[2].name, function() dermaadd(res[2] and res[2].id) end,
                                res[3] and res[3].name, function() dermaadd(res[3] and res[3].id) end,
                                res[4] and res[4].name, function() dermaadd(res[4] and res[4].id) end)
                            else
                                nut.util.notify("There are no available trait picks.")
                            end
                        end,

                        false, Window, Color(147,255,188))
                    elseif (IsValid(Window.levelUp)) then
                        Window.levelUp:Remove()
                        Window.levelUp.label:Remove()
                    end
                end
            end
        end
        
        traitsTable:InvalidateLayout(true)
        
        --This makes it so you cannot drag or change column headers and their width
        traitsTable.Columns[1]:SetFixedWidth(col1Width*(scaledW/textW))
        traitsTable.Columns[2]:SetFixedWidth(col2Width*(scaledW/textW))
        traitsTable.Columns[3]:SetFixedWidth(col3Width*(scaledW/textW))
        traitsTable.Columns[3]:SetTextAlign(5)
        
        --Sets the height of the table inside by just manually calculating what the height would be
        local rowCount = table.Count(traitsTable:GetLines())
        traitsTable:SetSize((425*(scaledW/textW)), ((((rowCount+1)*18)*(scaledH/textH))))
        

        --never figured out how to implement this so we get the default gmod blue instead. todo?
        highlightColor = Color(101, 133, 101) --background highlight for when you hover over a traight.

        for _, column in pairs(traitsTable.Columns) do
            column.Header:SetTextColor(Color(255,255,255))
            --column.Header:SetPaintBorderEnabled( false ) --not sure if its this one or the other one tbh that does it
            column.Header:SetPaintBackground(false)
            column.Header:SetFont("nutScaledInvenLight")
        end

        for _, line in pairs(traitsTable:GetLines()) do
            for _, label in pairs(line.Columns) do
                label:SetWrap( false )
                label:SetTextColor(Color(255, 255 ,255))
                --label:SetBackgroundColor(highlightColor)
                label:SetPaintBorderEnabled( false )
                label:SetFont("nutScaledInvenLight")

                --highlight traits with a new pick available
                for k,v in pairs(nut.traits.list) do
                    if (v.getName and v.getName(char) or v.name) == label:GetText() then
                        if(char:getData("traitlevelups",{})[k]) then
                            label:SetTextColor(Color(26,194,90))
                            label:SetExpensiveShadow(2, Color(138,138,138,100))
                        end
                    end
                end
            end
        end        
        local tPanelw, tPanelh = traitsTable:GetSize()
        local sPanelw, sPanelh = InnerPanel:GetSize()
        traitsTable:SizeToContentsY()








        --Close button+
        print("close button")
        stalkerGreyButton("closeButton", (popupX+(403*(scaledW/textW))), (popupY+(579*(scaledH/textH))),
        "Close",
        function() Window:Close() end,
        false, Window)

        Window:SetSize(ScrW(), ScrH())

        Window:MakePopup()
        Window:DoModal()

        function Window:Paint(w, h)
            Derma_DrawBackgroundBlur( self, 0 )
            surface.SetDrawColor(255,255,255,255)
            surface.SetMaterial(statsText)
            surface.DrawTexturedRect(popupX, popupY, scaledW, scaledH)	
        end

    end
end