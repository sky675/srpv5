local PANEL = {}

PANEL.tabLabel = "Map"

function PANEL:Init()
    
    self.sampleTextHome = self:Add("DLabel")
    self.sampleTextHome:SetText("Map Page - WIP")
    self.sampleTextHome:SizeToContentsX()

end

function PANEL:onDisplay()
    
end

vgui.Register("pdaMap", PANEL, "stalkerPdaTab")
