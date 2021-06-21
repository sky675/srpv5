local PANEL = {}

PANEL.tabLabel = "Notes"

local contW, contH = ScrW()*0.289, ScrH()*0.498
local textLength = 0
local maxText = 250
local allowedText

function PANEL:Init()
    
    self.notes = self:Add("DPanel")
    self.notes:SetSize(contW, contH)
    self.notes:SetPaintBackground(false)

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
        allowedText = string.sub( value, 1, maxText )
        textLength = string.len(value)
        self.length:SetText(textLength .. "/" .. maxText)
        self.length:SizeToContentsX()
        self.length:CenterHorizontal()
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

        net.Start("ChangePDANotes")
        net.WriteString(submittedText)
        net.WriteInt(self.pda.id, 32)
        net.SendToServer()
    end

end

function PANEL:onDisplay()
    self.pda = nut.gui.pda:getPDA()
    self.textentry:SetText(self.pda:getData("pdanotes", ""))

    textLength = string.len(self.textentry:GetValue())
    self.length:SetText(textLength .. "/" .. maxText)
    self.length:SizeToContentsX()
    self.length:CenterHorizontal()
    
end

function PANEL:onHide()
        local submittedText = string.sub(self.textentry:GetValue(), 1, maxText)

        net.Start("ChangePDANotes")
        net.WriteString(submittedText)
        net.WriteInt(self.pda.id, 32)
        net.SendToServer()
end

vgui.Register("pdaNotes", PANEL, "stalkerPdaTab")
