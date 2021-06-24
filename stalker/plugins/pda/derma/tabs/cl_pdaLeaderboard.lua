
local PANEL = {}

PANEL.tabLabel = "Leaderboard"

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
    return nut.config.get("leaderboardEnabled")
end

vgui.Register("pdaLeaderboard", PANEL, "stalkerPdaTab")
