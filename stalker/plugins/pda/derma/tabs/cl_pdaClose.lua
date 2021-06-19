local PANEL = {}

PANEL.tabLabel = "Close"

function PANEL:Init()
    
    self.sampleTextHome = self:Add("DLabel")
    self.sampleTextHome:SetText("Closing. . .")
    self.sampleTextHome:SizeToContentsX()

end

function PANEL:shouldShow()
    return nut.config.get("pdaInternalCloseButton")
end

function PANEL:onDisplay()
    nut.gui.pda:SetTab(1)
	nut.gui.pda:DisablePDA()

end

vgui.Register("pdaClose", PANEL, "stalkerPdaTab")
