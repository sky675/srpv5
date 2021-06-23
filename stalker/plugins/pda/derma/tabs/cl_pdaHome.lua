local PANEL = {}

PANEL.tabLabel = "Home"
local contW, contH = ScrW()*0.289, ScrH()*0.498
local textLength = 0
local maxText = 250
local allowedText
local format = "%X"--"%A, %d %B %Y %X"
local isDisplayed = false


function PANEL:Init()
    
    self.home = self:Add("DPanel")
    self.home:SetSize(contW, contH)
    self.home:SetPaintBackground(false)
    
    self.handle = self:Add("DLabel")
    self.handle:SetText("No Handle Set")
    self.handle:SetFont("nutMediumFont")
    self.handle:SizeToContents()
    self.handle:CenterHorizontal()

    self.time = self:Add("DLabel")
    self.time:SetText(os.date(format, nut.date.get()))
    self.time:SetFont("nutMediumLightFont")
    self.time:SizeToContents()
    self.time:SetY(self.handle:GetY() + self.handle:GetTall() + (self.handle:GetTall()*0.5))
    self.time.Think = function(this)
        if ((this.nextTime or 0) < CurTime()) then
            this:SetText(os.date(format, nut.date.get()))
            this.nextTime = CurTime() + 0.5
            if (isDisplayed) then
                self.time:SetX((contW*0.5) - (self.time:GetWide() * 0.5))
            end
        end
    end

    self.currentWeather = self.home:Add("DLabel")
    self.currentWeather:SetText("Unable to retrieve current weather...")
    self.currentWeather:SetFont("nutMediumLightFont")

    self.forecastType = {}
    self.forecastTime = {}
    self.forecastIcon = {}

    self.notes = self.home:Add("DPanel")
    self.notes:SetSize(contW, contH*0.25)
    self.notes:SetPaintBackground(false)
    self.notes:Dock(BOTTOM)

    self.save = self.notes:Add("DButton")
    self.save:SetText("Save Notes")
    self.save:SetTextColor(Color(255,255,255,190))
    self.save:SizeToContentsX()
    self.save:Dock(TOP)

    self.length = self.notes:Add("DLabel")
    self.length:SetText(textLength .. "/" .. maxText)
    self.length:SetPos(0, self.save:GetTall() + 5)
    self.length:SizeToContentsX()
    self.length:CenterHorizontal()
    self.length:SetTextColor(Color(255,255,255,255))

    self.TextEntryContainer = self.notes:Add("DPanel")
    self.TextEntryContainer:SetPos(0, self.save:GetTall() + 25)
    self.TextEntryContainer:SetSize(self.notes:GetWide(), self.notes:GetTall() - self.save:GetTall() - 35)

    self.textentry = self.TextEntryContainer:Add("DTextEntry")
    self.textentry:SetMultiline(true)
    self.textentry:SetUpdateOnType(true)
    self.textentry:SetPaintBackground(false)
    self.textentry:SetCursorColor(Color(255,255,255,255))
    self.textentry:SetTextColor(Color(255,255,255,255))
    self.textentry:SetPos(0, 0)
    self.textentry:SetSize(self.TextEntryContainer:GetSize())
    self.textentry.OnValueChange = function(panel, value)
        allowedText = string.sub( value, 1, maxText-1 )
        textLength = string.len(value)
        self.length:SetText(textLength .. "/" .. maxText)
        self.length:SizeToContentsX()
        self.length:CenterHorizontal()
        if textLength >= maxText then
            self.length:SetTextColor(Color(255,71,71))
        elseif textLength > maxText * 0.9 then
            self.length:SetTextColor(Color(220,221,129))
        else
            self.length:SetTextColor(Color(255,255,255,255))
        end

        if textLength > maxText then
            self.textentry:SetText(allowedText)
            textLength = string.len(value)
            self.length:SetText(textLength .. "/" .. maxText)
            self.length:SizeToContentsX()
            self.length:CenterHorizontal()
        end
    end
    
    self.save.DoClick = function(but)
        local submittedText = string.sub(self.textentry:GetValue(), 1, maxText)
        self.save:SetTextColor(Color(100,255,100,190))
        self.save:ColorTo(Color(255,255,255,190), 0.5)
        surface.PlaySound( "interface/beep.ogg" )
        net.Start("ChangePDANotes")
        net.WriteString(submittedText)
        net.WriteInt(self.pda.id, 32)
        net.SendToServer()
    end



end

function PANEL:onDisplay()

    --[[
        Doing the weather forecast for next 9 hours
    --]]
    local forecastJson = StormFox2.WeatherGen.GetForcast()
    local unix = forecastJson.unix_stamp
    local idCast = -1
    local time = StormFox2.Time.Get()
    if not unix then
        for i = 1, 8 do
            if forecastJson[i].Time * 60 <= time then
                idCast = idCast + 1
            end
        end
    else
        for i = 1, 8 do
            if forecastJson[i].Unix <= os.time() then
                idCast = idCast + 1
            end
        end
    end

    self.currentWeather:SetText("Currently " .. StormFox2.Weather.GetDescription())
    self.currentWeather:SizeToContents()
    self.currentWeather:SetY(self.time:GetY() + self.time:GetTall() + (self.time:GetTall()/2))
    self.currentWeather:SetX((contW/2) - (self.currentWeather:GetWide()/2))

    for i = 2, 4 do
        local data = forecastJson[i + idCast]
        if not data then break end
        --local x = i * ws - ws --something for rendering on the tv, ignore.
            ----Weather type & Icon
        --surface.SetMaterial( data.Icon )
        --surface.DrawTexturedRect(x + ws * 0.3, y + 10, ws * 0.7, ws * 0.7, 0)
        --draw.DrawText(data.Desc,"SF_Display_H2",x + ws / 2,y + 70,color_white,TEXT_ALIGN_CENTER)
        --draw.DrawText(data.DisplayTime,"SF_Display_H2",x + ws / 2,y + h - 30,color_white,TEXT_ALIGN_CENTER)

        self.forecastIcon[i-1] = self.home:Add("DImage")
        self.forecastIcon[i-1]:SetMaterial(data.Icon)
        self.forecastIcon[i-1]:SetSize(contW/8, contW/8)
        self.forecastIcon[i-1]:SetY(self.currentWeather:GetY() + self.currentWeather:GetTall() * 2.5)
        self.forecastIcon[i-1]:SetX((contW/3 * i-1) - ((contW/3 * i-1)/2) - (self.forecastIcon[i-1]:GetWide()/2))

        self.forecastType[i-1] = self.home:Add("DLabel")
        self.forecastType[i-1]:SetText(data.Desc)
        self.forecastType[i-1]:SizeToContents()
        self.forecastType[i-1]:SetY(self.forecastIcon[i-1]:GetY() + self.forecastIcon[i-1]:GetTall() * 1.2)
        self.forecastType[i-1]:SetX((contW/3 * i-1) - ((contW/3 * i-1)/2) - (self.forecastType[i-1]:GetWide()/2))

        self.forecastTime[i-1] = self.home:Add("DLabel")
        self.forecastTime[i-1]:SetText(data.DisplayTime)
        self.forecastTime[i-1]:SizeToContents()
        self.forecastTime[i-1]:SetY(self.forecastType[i-1]:GetY() + self.forecastType[i-1]:GetTall() * 1.5)
        self.forecastTime[i-1]:SetX((contW/3 * i-1) - ((contW/3 * i-1)/2) - (self.forecastTime[i-1]:GetWide()/2))
    
        ---- Temp
        --max_temp = math.max(max_temp,data.Temperature)
        --min_temp = math.min(min_temp,data.Temperature)
    end



    self.pda = nut.gui.pda:getPDA()
    isDisplayed = true
    if (self.pda != nil) then
        self.handle:SetText(self.pda:getData("pdahandle", "invalid"))
        self.handle:SizeToContents()
        --self.handle:CenterHorizontal()
        self.handle:SetX((contW*0.5) - (self.handle:GetWide() * 0.5))
        self.textentry:SetText(self.pda:getData("pdanotes", ""))

        textLength = string.len(self.textentry:GetValue())
        self.length:SetText(textLength .. "/" .. maxText)
        self.length:SizeToContentsX()
        self.length:CenterHorizontal()

        if textLength >= maxText then
            self.length:SetTextColor(Color(255,71,71))
        elseif textLength > maxText * 0.9 then
            self.length:SetTextColor(Color(220,221,129))
        else
            self.length:SetTextColor(Color(255,255,255,255))
        end

        self.home:InvalidateLayout()
    end

end

function PANEL:onHide()
    isDisplayed = false
    --self.forecastType = {}
    --self.forecastTime = {}
    --self.forecastIcon = {}

    for k,_ in pairs(self.forecastTime) do
        self.forecastTime[k]:Remove()
    end

    for k,_ in pairs(self.forecastType) do
        self.forecastType[k]:Remove()
    end

    for k,_ in pairs(self.forecastIcon) do
        self.forecastIcon[k]:Remove()
    end

        --[[
            Auto-save onHide for the notes does NOT work when the notes are on the homepage because when the PDA gets disabled it calls onHide, even if the pda isn't set.
        --]]
        -- local submittedText = string.sub(self.textentry:GetValue(), 1, maxText)

        -- net.Start("ChangePDANotes")
        -- net.WriteString(submittedText)
        -- net.WriteInt(self.pda.id, 32)
        -- net.SendToServer()
end

vgui.Register("pdaHome", PANEL, "stalkerPdaTab")
