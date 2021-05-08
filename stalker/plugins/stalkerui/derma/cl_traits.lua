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
        print(dictTabs)

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
        print("#########Total width allowed: " .. (425*(scaledW/textW)) .. " -- Desired width of columns: " .. ((217*(scaledW/textW)) + (152*(scaledW/textW)) + (56*(scaledW/textW))))
        --Table
        local traitsTable = vgui.Create( "DListView", InnerPanel )
        print("setting up properties")
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
        
        for k,v in pairs(nut.traits.list) do
            if(traits[k]) then
                print("if passed")
                --create it
                local xpt = "N/A"
                print("xp if")
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

        print("invalidating")
        traitsTable:InvalidateLayout(true)
        traitsTable.Columns[1]:SetFixedWidth(col1Width*(scaledW/textW))
        traitsTable.Columns[2]:SetFixedWidth(col2Width*(scaledW/textW))
        traitsTable.Columns[3]:SetFixedWidth(col3Width*(scaledW/textW))
        traitsTable.Columns[3]:SetTextAlign(5)


        
        -- for k,v in pairs(nut.traits.list) do
        --     local xpt = "None"
        --     if(v.xp and v.xp[traits[k]]) then
        --         xpt = tostring(xp[k] or 0).."/"..v.xp[traits[k]]
        --     end
        --     traitsTable:AddLine(v.getName(char), v.desc, xpt)
        -- end
        --traitsTable:AddLine( "Super Strong", "This trait makes you super strong!", "5/10" )
        --traitsTable:AddLine( "Mega Weak", "This trait unfortunately makes you mega Weak!", "10/10" )
        --iterating over & stylizing list elements
        --traitsTable.Columns[1].Header:SetTextColor(Color(255,255,255))
        --traitsTable.Columns[2].Header:SetTextColor(Color(255,255,255))
        --traitsTable.Columns[3].Header:SetTextColor(Color(255,255,255))
        
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