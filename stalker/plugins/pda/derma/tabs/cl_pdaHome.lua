local PANEL = {}

PANEL.tabLabel = "Home"

function PANEL:Init()
    
    self.sampleTextHome = self:Add("DLabel")
    self.sampleTextHome:SetText("Home Page - WIP")
    self.sampleTextHome:SizeToContentsX()

end

function PANEL:onDisplay()
    
end

vgui.Register("pdaHome", PANEL, "stalkerPdaTab")
