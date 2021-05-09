if(CLIENT) then
    function stalkerGreyButton(id, x, y, label, callback, autoScale, parent, bttnColor)
        local hue = bttnColor or Color(255,255,255) 
        local self = parent or self
        local bttnUnclick = hue
        local bttnClick = Color(math.Clamp(hue.r-112, 0, 255), math.Clamp(hue.g-112, 0, 255), math.Clamp(hue.b-112, 0, 255))
        local unclick = Color(255,255,255)
        local click = Color(143,143,143)

        self[id] = self:Add("DImageButton") 
        self[id]:SetImage("sky/buttons/grey_bar.png")
        self[id]:SetColor(bttnUnclick)

        if (autoScale) then
            self[id]:SetPos(invPosX+(x*(invw/invTextureW)), (invPosY+(y*(invh/invTextureH))))	
        else
            self[id]:SetPos(x, y)
        end
            
        self[id]:SetSize((77*(invw/invTextureW)), ((27*(invh/invTextureH))))

        self[id].label = self:Add("DLabel")
        self[id].label:SetFont("nutScaledInvenLight")
        self[id].label:SetText(label)
        self[id].label:SizeToContents()
        self[id].label:SetTextColor(unclick)

        local ButtonX, ButtonY = self[id]:GetPos()
        local ButtonXsize, ButtonYsize = self[id]:GetSize()
        local LabelXsize, LabelYsize = self[id].label:GetSize()
        local labelOffsetX = ((ButtonXsize - LabelXsize)*0.5)
        local labelOffsetY = ((ButtonYsize - LabelYsize)*0.45)

        self[id].label:SetPos(ButtonX + (labelOffsetX), ButtonY + (labelOffsetY))


        self[id].OnDepressed = function(this)
            this:SetImage("sky/buttons/grey_bar_press.png")
            this:SetColor(bttnClick)
            labelXpos, labelYpos = self[id].label:GetPos()
            self[id].label:SetTextColor(click)
            self[id].label:SetPos(labelXpos, labelYpos + ((2*(invh/invTextureH))))

        end

        self[id].OnReleased = function(this)
            surface.PlaySound( "interface/beep.ogg" )
            this:SetImage("sky/buttons/grey_bar.png")
            this:SetColor(bttnUnclick)
            self[id].label:SetTextColor(unclick)
            self[id].label:SetPos(ButtonX + (labelOffsetX), ButtonY + (labelOffsetY))

            callback()
        end
    end

    function stalkerLongButton(id, x, y, label, callback, autoScale, parent, bttnColor)
        local hue = bttnColor or Color(255,255,255) 
        local self = parent or self
        local bttnUnclick = hue
        local bttnClick = Color(math.Clamp(hue.r-112, 0, 255), math.Clamp(hue.g-112, 0, 255), math.Clamp(hue.b-112, 0, 255))
        local unclick = Color(255,255,255)
        local click = Color(143,143,143)

        self[id] = self:Add("DImageButton") 
        self[id]:SetImage("sky/buttons/long_grey_bar.png")
        self[id]:SetColor(bttnUnclick)

        if (autoScale) then
            self[id]:SetPos(invPosX+(x*(invw/invTextureW)), (invPosY+(y*(invh/invTextureH))))	
        else
            self[id]:SetPos(x, y)
        end
            
        self[id]:SetSize((236*(invw/invTextureW)), ((27*(invh/invTextureH))))

        self[id].label = self:Add("DLabel")
        self[id].label:SetFont("nutScaledInvenLight")
        self[id].label:SetText(label)
        self[id].label:SizeToContents()
        self[id].label:SetTextColor(unclick)

        local ButtonX, ButtonY = self[id]:GetPos()
        local ButtonXsize, ButtonYsize = self[id]:GetSize()
        local LabelXsize, LabelYsize = self[id].label:GetSize()
        local labelOffsetX = ((ButtonXsize - LabelXsize)*0.5)
        local labelOffsetY = ((ButtonYsize - LabelYsize)*0.45)

        self[id].label:SetPos(ButtonX + (labelOffsetX), ButtonY + (labelOffsetY))


        self[id].OnDepressed = function(this)
            this:SetImage("sky/buttons/long_grey_bar_press.png")
            this:SetColor(bttnClick)
            labelXpos, labelYpos = self[id].label:GetPos()
            self[id].label:SetTextColor(click)
            self[id].label:SetPos(labelXpos, labelYpos + ((2*(invh/invTextureH))))

        end

        self[id].OnReleased = function(this)
            surface.PlaySound( "interface/beep.ogg" )
            this:SetImage("sky/buttons/long_grey_bar.png")
            this:SetColor(bttnUnclick)
            self[id].label:SetTextColor(unclick)
            self[id].label:SetPos(ButtonX + (labelOffsetX), ButtonY + (labelOffsetY))

            callback()
        end
    end

    function stalkerStringRequest(strPrompt, strDefaultText, fnEnter, fnCancel, strButtonText, strButtonCancelText)
        --self.m_fCreateTime = SysTime()
        local Window = vgui.Create( "DFrame" )

        local stringReqTexture = (Material("sky/srp_textbox.png"))
        local textH = 261
        local textW = 444
        local scaledH = (textH*(invh/invTextureH))
        local scaledW = (textW*(invw/invTextureW))
        local popupX = (ScrW()*0.5)-(scaledW*0.5)
        local popupY = (ScrH()*0.5)-(scaledH*0.5)



        --SetPos(popupX+(19*(scaledW/textW)), (popupY+(396*(scaledH/textH))))

        --Window:SetTitle( strTitle or "Message Title (First Parameter)" )
        Window:SetDraggable( false )
        Window:ShowCloseButton( false )
        Window:SetBackgroundBlur( true )
        Window:SetDrawOnTop( true )
        --Window:SetAlpha(0)
    
        local InnerPanel = vgui.Create( "DPanel", Window )
        InnerPanel:SetPaintBackground( false )
        --InnerPanel:SetBackgroundBlur( true )
        --InnerPanel:SetDrawOnTop(true)
        --InnerPanel:SetPos(popupX, popupY)
        InnerPanel:SetSize(scaledW, scaledH)
        
        local Text = vgui.Create( "DLabel", Window )
        Text:SetFont("nutScaledInvenLight")
        Text:SetText( strPrompt or "Message Text (Second Parameter)" )
        Text:SetPos(popupX+(35*(scaledW/textW)), (popupY+(42*(scaledH/textH))))
        Text:SizeToContents()
        Text:SetTextColor( Color(255,255,255,150) )
    
        local TextEntry = vgui.Create( "DTextEntry", Window )
        TextEntry:SetMultiline(true)
        TextEntry:SetFont("nutScaledInvenLight")
        TextEntry:SetTextColor( Color(255,255,255,150) )
        TextEntry:SetCursorColor(Color(255,255,255,255))
        TextEntry:SetSize((388*(scaledW/textW)), (143*(scaledH/textH)))
        TextEntry:SetDrawBackground(false)
        TextEntry:SetDrawBorder(false)
        TextEntry:SetPos(popupX+(32*(scaledW/textW)), (popupY+(80*(scaledH/textH))))
        TextEntry:SetText( strDefaultText or "" )
        TextEntry.OnEnter = function() Window:Close() fnEnter( TextEntry:GetValue() ) end
    
        stalkerGreyButton("confirmButton", (popupX+(135*(scaledW/textW))), (popupY+(231*(scaledH/textH))),
        strButtonText or "Confirm",
        function() Window:Close() fnEnter( TextEntry:GetValue() ) end,
        false, Window)


        stalkerGreyButton("cancelButton", (popupX+(242*(scaledW/textW))), (popupY+(231*(scaledH/textH))),
        strButtonCancelText or "Cancel",
        function() Window:Close() if ( fnCancel ) then fnCancel( TextEntry:GetValue() ) end end,
        false, Window)
    
        Window:SetSize(ScrW(), ScrH())

        Window:MakePopup()
        Window:DoModal()

        function Window:Paint(w, h)
            Derma_DrawBackgroundBlur( self, 0 )
            surface.SetDrawColor(255,255,255,255)
            surface.SetMaterial(stringReqTexture)
            surface.DrawTexturedRect(popupX, popupY, scaledW, scaledH)	
        end


    
        return InnerPanel
    
    end

    function stalkerQuery(qryPromt, bttn1text, bttn1func, bttn2text, bttn2func, bttn3text, bttn3func, bttn4text, bttn4func) --cancelable)
        local qryWindow = vgui.Create("DFrame")
        
        local qryReqTexture = (Material("sky/srp_query.png"))
        local textH = 261
        local textW = 444
        local scaledH = (textH*(invh/invTextureH))
        local scaledW = (textW*(invw/invTextureW))
        local popupX = (ScrW()*0.5)-(scaledW*0.5)
        local popupY = (ScrH()*0.5)-(scaledH*0.5)

        qryWindow:SetDraggable( false )
        qryWindow:ShowCloseButton( false )
        qryWindow:SetBackgroundBlur( true )
        qryWindow:SetDrawOnTop( true )
        --Window:SetAlpha(0)
    
        local InnerPanel = vgui.Create( "DPanel", qryWindow )
        InnerPanel:SetPaintBackground( false )
        InnerPanel:SetSize(scaledW, scaledH)

        local Text = vgui.Create( "DLabel", qryWindow )
        Text:SetFont("nutScaledInvenLight")
        Text:SetText( qryPromt or "Query Prompt (First Parameter)" )
        Text:SetPos(popupX+(35*(scaledW/textW)), (popupY+(42*(scaledH/textH))))
        Text:SizeToContents()
        Text:SetTextColor( Color(255,255,255,150) )
        print(bttn1text)
        if bttn1text != nil then
            stalkerLongButton("bttn1", popupX+(110*(scaledW/textW)), popupY+(85*(scaledH/textH)), bttn1text, 
                function()
                    print("bttn 1 pushed!")
                    bttn1func()
                    qryWindow:Close()
                end,
                false, qryWindow)
        end

        if bttn2text != nil then
            stalkerLongButton("bttn2", popupX+(110*(scaledW/textW)), popupY+(121*(scaledH/textH)), bttn2text, 
                function()
                    print("bttn 2 pushed!")
                    bttn2func()
                    qryWindow:Close()
                end,
                false, qryWindow)
        end
        if bttn3text != nil then
            stalkerLongButton("bttn3", popupX+(110*(scaledW/textW)), popupY+(157*(scaledH/textH)), bttn3text, 
                function()
                    print("bttn 3 pushed!")
                    bttn3func()
                    qryWindow:Close()
                end,
                false, qryWindow)
        end
        
        if bttn4text != nil then
            stalkerLongButton("bttn4", popupX+(110*(scaledW/textW)), popupY+(193*(scaledH/textH)), bttn4text, 
                function()
                    print("bttn 4 pushed!")
                    bttn4func()
                    qryWindow:Close()
                end,
                false, qryWindow)
        end

        -- local canCancel = cancelable or false

        -- if (canCancel) then
        stalkerGreyButton("qryCancelButton", (popupX+(184*(scaledW/textW))), (popupY+(231*(scaledH/textH))),
        "Cancel",
        function() qryWindow:Close() end,
        false, qryWindow)
        -- end
        qryWindow:SetSize(ScrW(), ScrH())

        qryWindow:MakePopup()
        qryWindow:DoModal()

        function qryWindow:Paint(w, h)
            Derma_DrawBackgroundBlur( self, 0 )
            surface.SetDrawColor(255,255,255,255)
            surface.SetMaterial(qryReqTexture)
            surface.DrawTexturedRect(popupX, popupY, scaledW, scaledH)	
        end
    end

end