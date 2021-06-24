
local PANEL = {}

PANEL.tabLabel = "Sys. Admin"

local contW, contH = ScrW()*0.289, ScrH()*0.498

function PANEL:Init()
    
    self.leader = self:Add("DPanel")
    self.leader:SetSize(contW, contH)
    self.leader:SetPaintBackground(false)

end

function PANEL:onDisplay()
    
end

function PANEL:onHide()

end

function PANEL:shouldShow()
    local ply = LocalPlayer()
	local char = ply:getChar()
    
    return char:hasFlags("Z")
end

vgui.Register("pdaAdmin", PANEL, "stalkerPdaTab")
