
netstream.Hook("sendleaderboard", function(tbl)
    local contW, contH = ScrW()*0.289, ScrH()*0.498
    self = nut.gui.pda.tabs[4]

    self.entry = {}

    for k,v in ipairs(tbl) do
        self.entry[k] = self.leader:Add("DPanel")
        self.entry[k]:Dock(TOP)
        self.entry[k]:DockMargin(0,3,0,3)
        self.entry[k]:DockPadding(10,0,10,0)
        self.entry[k]:SetTall(32)
        self.entry[k].OnMouseReleased = function()
            if (LocalPlayer():IsAdmin()) then
                print(v.name .. " has the ID of: " .. v.id)
                nut.util.notify("Character ID of " .. v.name .." was print to console.")
            end
        end

        self.entry[k].char = self.entry[k]:Add("DLabel")
        self.entry[k].char:SetText(v.name) 
        self.entry[k].char:SetFont("nutSmallFont")
        self.entry[k].char:SetWide(contW/4)
        self.entry[k].char:SetContentAlignment(5)
        self.entry[k].char:SetWrap(true)
        self.entry[k].char:Dock(LEFT)

        self.entry[k].fac = self.entry[k]:Add("DLabel")
        self.entry[k].fac:SetText(nut.faction.indices[v.fac].name)
        self.entry[k].fac:SetTextColor(nut.faction.indices[v.fac].color)
        self.entry[k].fac:SetFont("nutSmallFont")
        self.entry[k].fac:SetWide(contW/4)
        self.entry[k].fac:SetContentAlignment(5)
        self.entry[k].fac:SetWrap(true)
        self.entry[k].fac:Dock(LEFT)

        self.entry[k].xp = self.entry[k]:Add("DLabel")
        self.entry[k].xp:SetText(v.xp)
        self.entry[k].xp:SetFont("nutSmallItalicFont")
        self.entry[k].xp:SetWide(contW/4)
        self.entry[k].xp:SetContentAlignment(5)
        self.entry[k].fac:SetWrap(true)
        self.entry[k].xp:Dock(LEFT)

        self.entry[k].rank = self.entry[k]:Add("DLabel")
        self.entry[k].rank:SetText(RANK_TRANS[v.rank])
        self.entry[k].rank:SetFont("nutSmallFont")
        self.entry[k].rank:SetWide(contW/4)
        self.entry[k].rank:SetContentAlignment(5)
        self.entry[k].fac:SetWrap(true)
        self.entry[k].rank:Dock(LEFT)
    end     
end)

local PANEL = {}

PANEL.tabLabel = "Leaderboard"

local contW, contH = ScrW()*0.289, ScrH()*0.498
local rankleaderboard = {}




function PANEL:Init()
    
    self.leader = self:Add("DScrollPanel")
    self.leader:SetSize(contW, contH)
    self.leader:SetPaintBackground(false)

end

function PANEL:onDisplay()
    netstream.Start("getleaderboard")
end

function PANEL:onHide()
    if (self.entry) then
        for k,v in pairs(self.entry) do
            self.entry[k]:Remove()
        end 
    end
end

function PANEL:shouldShow()
    return nut.config.get("leaderboardEnabled")
end

vgui.Register("pdaLeaderboard", PANEL, "stalkerPdaTab")
