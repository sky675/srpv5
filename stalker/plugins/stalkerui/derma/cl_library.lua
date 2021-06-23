if (CLIENT) then
    function stalkerLibrary(winTitle, dictTabs, fnClose, openTo)

        --Window is over-all container, background image
        local Window = vgui.Create( "DFrame" )

        local libraryText = (Material("sky/srp_library.png"))
        local textH = 630
        local textW = 870
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
        InnerPanel:SetSize(scaledW, scaledH)
        
        --Title
        local Text = vgui.Create( "DLabel", Window )
        Text:SetFont("nutScaledInvenLight")
        Text:SetText( winTitle or "Message Text (Second Parameter)" )
        Text:SetPos(popupX+(35*(scaledW/textW)), (popupY+(42*(scaledH/textH))))
        Text:SizeToContents()
        Text:SetTextColor( Color(255,255,255,150) )
        
        --Body text scroll window, body text to be child
        local bodyContainer = vgui.Create( "DScrollPanel", Window)
        bodyContainer:SetPaintBackground( false )
        bodyContainer:SetBackgroundColor(Color(255,100,100,150))
        bodyContainer:SetSize((556*(scaledW/textW)), ((515*(scaledH/textH))))
        bodyContainer:SetPos(popupX+(288*(scaledW/textW)), (popupY+(78*(scaledH/textH))))
        local sbar = bodyContainer:GetVBar()
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
        

        --Body Text
        local bodyText = " "
        local Body = vgui.Create( "DHTML", bodyContainer )

        --bodyContainer:AddItem(Body)

        libraryHtmlBody = 0
        Body:SetAllowLua(true)
        --Body:Dock( FILL )
        --Body:SetSize((556*(scaledW/textW)), ((515*(scaledH/textH))))
        Body:SetWidth((550*(scaledW/textW))) --, 516*(scaledH/textH)
        --Body:Dock( FILL )
        --Body:SetFont("nutScaledInvenLight")
        --Body:SetText(bodyText)
        --Body:SetPos(popupX+(35*(scaledW/textW)), (popupY+(42*(scaledH/textH))))
        --Body:SetWide((550*(scaledW/textW)))
        --Body:SetTextColor( Color(255,255,255,150) )
        --Body:SetWrap(true)
        --Body:SetAutoStretchVertical(true)

        local tabContainer = vgui.Create( "DScrollPanel", Window)
        tabContainer:SetPaintBackground( false )
        tabContainer:SetSize((245*(scaledW/textW)), ((515*(scaledH/textH))))
        tabContainer:SetPos(popupX+(28*(scaledW/textW)), (popupY+(78*(scaledH/textH))))

        --sortedOrder = table.SortByMember(dictTabs, "order", true))


		

        --htmlBodyHeight = 620
        local barPosX = popupX+(26*(scaledW/textW))
        local barPosStartY = (popupY+(78*(scaledH/textH)))
        local i = 1
        local pages = table.Count(dictTabs)
        local fbuttonY = 0
        local n = pages
        local gap = 50
        local baseHtml =
[[<html>

<head>
  <meta charset="utf-8">
  <title></title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style type="text/css">
  	body
  	{
  		font-family: 'Arial';
  		color: #c7c7c7;
  		line-height: 1.6;
        overflow: hidden;
    }
  </style>
</head>

<body>
<div id="content">
]]
        local tagHtml =
[[
</div>
</body>
</html>
]]
        Body:AddFunction("returnvar", "gettall", function(str)
            Body:SetTall(tonumber(str) + 10)
        end)

        openTo = openTo or nil

        if openTo != nil then
            Body:SetHTML(baseHtml .. dictTabs[openTo].body .. tagHtml)
            Body:RunJavascript(
[[var elmnt = document.getElementById("content");
var y = elmnt.scrollHeight;
returnvar.gettall(y)]])
        end

        for k,v in pairs(dictTabs) do
            if k == 1 then
                fbuttonY = barPosStartY + gap
            end
            if k != 1 then
                fbuttonY = (gap * k) + barPosStartY 
            end
            stalkerLongButton(k, barPosX, fbuttonY, dictTabs[k].title, function() 
                Body:SetHTML(baseHtml .. dictTabs[k].body .. tagHtml)
                Body:RunJavascript(
[[var elmnt = document.getElementById("content");
var y = elmnt.scrollHeight;
returnvar.gettall(y)]])

            end,
            false, Window, dictTabs[k].color or Color(255,255,255))

            --i = i + 1

        end


        --Close button
        stalkerGreyButton("closeButton", (popupX+(771*(scaledW/textW))), (popupY+(600*(scaledH/textH))),
        "Close",
        function() Window:Close() if ( fnClose ) then fnClose() end end,
        false, Window)

        Window:SetSize(ScrW(), ScrH())

        Window:MakePopup()
        Window:DoModal()

        function Window:Paint(w, h)
            Derma_DrawBackgroundBlur( self, 0 )
            surface.SetDrawColor(255,255,255,255)
            surface.SetMaterial(libraryText)
            surface.DrawTexturedRect(popupX, popupY, scaledW, scaledH)	
        end

    end
end