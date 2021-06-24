local PANEL = {}

PANEL.tabLabel = "Online List"

local contW, contH = ScrW()*0.289, ScrH()*0.498

function PANEL:UpdateScoreboard(tbl)
	if(self.pdaLabel) then
		self.pdaLabel:Remove()
	end

    self.pan = {}

	local first = false
	local y = 10
	for k,v in ipairs(tbl) do

        self.pan[k] = self.scoreboard:Add("DPanel")
        self.pan[k]:Dock(TOP)
        self.pan[k]:DockMargin(0,3,0,3)
        self.pan[k]:DockPadding(10,0,10,0)
        self.pan[k]:SetTall(32)

        self.pan[k].handle = self.pan[k]:Add("DLabel")
        self.pan[k].handle:SetText(tbl[k].handle) 
        self.pan[k].handle:SetFont("nutSmallFont")
        self.pan[k].handle:SetWide(contW/3)
        self.pan[k].handle:SetContentAlignment(5)
        self.pan[k].handle:SetWrap(true)
        self.pan[k].handle:Dock(LEFT)

        self.pan[k].title = self.pan[k]:Add("DLabel")
        self.pan[k].title:SetText(tbl[k].title) 
        self.pan[k].title:SetFont("nutSmallFont")
        self.pan[k].title:SetWide(contW/3)
        self.pan[k].title:SetContentAlignment(5)
        self.pan[k].title:SetWrap(true)
        self.pan[k].title:Dock(LEFT)

        self.pan[k].avail = self.pan[k]:Add("DLabel")
        self.pan[k].avail:SetText(tbl[k].avail) 
        if(string.lower(tbl[k].avail) == "active") then
            self.pan[k].avail:SetTextColor(Color(140,204,110))
        elseif (string.lower(tbl[k].avail) == "idle") then
            self.pan[k].avail:SetTextColor(Color(204,202,110))
        end
        self.pan[k].avail:SetFont("nutSmallFont")
        self.pan[k].avail:SetWide(contW/3)
        self.pan[k].avail:SetContentAlignment(5)
        self.pan[k].avail:SetWrap(true)
        self.pan[k].avail:Dock(LEFT)

	end
end


function PANEL:Init()
    	
	local y = 10
    self.scoreboard = self:Add("DScrollPanel")
    self.scoreboard:SetSize(contW, contH)
    self.scoreboard:SetPaintBackground(false)

    self.pdaLabel = self.scoreboard:Add("DLabel")
	self.pdaLabel:SetPos(10, y)
	self.pdaLabel:SetFont("nutSmallFont")
	self.pdaLabel:SetText("Loading List")
	self.pdaLabel:DockMargin(2,2,2,2)
	self.pdaLabel:Dock(FILL)

    self.pdaLabel:SetWrap(true)



end

function PANEL:onDisplay()
    netstream.Start("reqlist")
end

function PANEL:onHide()
    for k,_ in pairs(self.pan) do
        self.pan[k]:Remove()
    end
end

vgui.Register("pdaScoreboard", PANEL, "stalkerPdaTab")
