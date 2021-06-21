local PANEL = {}

PANEL.tabLabel = "Home"
local contW, contH = ScrW()*0.289, ScrH()*0.498


function PANEL:Init()
    
    self.home = self:Add("DPanel")
    self.home:SetSize(contW, contH)
    self.home:SetPaintBackground(false)

    self.wip = self:Add("DLabel")
    self.wip:SetText("Home Page - Work in Progress")
    self.wip:SizeToContentsX()
    self.wip:Center()

end

function PANEL:onDisplay()
    
end

vgui.Register("pdaHome", PANEL, "stalkerPdaTab")
