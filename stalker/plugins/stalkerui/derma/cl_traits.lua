if (CLIENT) then
    function stalkerDisplayStats(char)


        local transtype = {
            ["pos"] = "Positive",
            ["neg"] = "Negative",
        }

        local traits = char:getTrait()--Data("traits", {})
        local xp = char:getData("xp", {})


        --Window is over-all container, background image
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

        --I don't know what this is for tbh but i'm not risking removing it :)
        local InnerPanel = vgui.Create( "DPanel", Window )
        InnerPanel:SetPaintBackground( false )
        --InnerPanel:SetSize(scaledW, scaledH)
        InnerPanel:SetSize((425*(scaledW/textW)), ((326*(scaledH/textH))))
        InnerPanel:SetPos(popupX+(41*(scaledW/textW)), (popupY+(67*(scaledH/textH))))
        --Table
        local traitsTable = vgui.Create( "DListView", InnerPanel )
        traitsTable:UpdateColours(nutscript)
        traitsTable:SetPaintBackground( false )
        traitsTable:SetPaintBorderEnabled( false )
        traitsTable:Dock( FILL )
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
        --traitTitle:SetText("Trait Title")
        traitTitle:SetFont("nutScaledInvenLight")

        local traitCat = vgui.Create("DLabel", Window)
        traitCat:SetPos(popupX+(35*(scaledW/textW)), (popupY+(450*(scaledH/textH))))
        traitCat:SetSize(440*(scaledW/textW), 20*(scaledH/textH))
        --traitCat:SetText("Category")
        traitCat:SetFont("nutScaledInvenLight")
        traitCat:SetColor(Color(155, 200, 200))

        local traitType = vgui.Create("DLabel", Window)
        traitType:SetPos(popupX+(35*(scaledW/textW)), (popupY+(465*(scaledH/textH))))
        traitType:SetSize(440*(scaledW/textW), 20*(scaledH/textH))
        --traitType:SetText("Positive/Negative")
        traitType:SetFont("nutScaledInvenLight")
        traitType:SetColor(Color(0, 255, 200))
        
        local traitDesc = vgui.Create("DLabel", Window)
        traitDesc:SetContentAlignment(1)
        traitDesc:SetPos(popupX+(35*(scaledW/textW)), (popupY+(470*(scaledH/textH))))
        traitDesc:SetSize(440*(scaledW/textW), 70*(scaledH/textH))
        --traitDesc:SetText("This is the description. Usually longer than other elements, it must take up more room than said other elements, nice.")
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
    
                traitsTable:AddLine(v.getName and v.getName(char) or v.name, v.category, xpt or "Nil")
                

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
                end
            end
        end
        
        traitsTable:InvalidateLayout(true)
        traitsTable.Columns[1]:SetFixedWidth(col1Width*(scaledW/textW))
        traitsTable.Columns[2]:SetFixedWidth(col2Width*(scaledW/textW))
        traitsTable.Columns[3]:SetFixedWidth(col3Width*(scaledW/textW))
        traitsTable.Columns[3]:SetTextAlign(5)

        

        highlightColor = Color(101, 133, 101) --background highlight for when you hover over a traight

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
                if (label:GetParent():IsLineSelected())  then return label:SetTextStyleColor( highlightColor ) end
                label:SetPaintBorderEnabled( false )
                label:SetFont("nutScaledInvenLight")
            end
        end        







        --Close button
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