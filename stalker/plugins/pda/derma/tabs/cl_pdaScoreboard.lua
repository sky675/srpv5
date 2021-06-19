local PANEL = {}

PANEL.tabLabel = "Online List"

function PANEL:UpdateScoreboard(tbl)
	if(self.pdaLabel) then
		self.pdaLabel:Remove()
	end

    self.pan = {}

	local first = false
	local y = 10
	for k,v in ipairs(tbl) do

        self.pan[k] = vgui.Create("DPanel", self)
		self.pan[k]:SetSize(self:GetWide(), ScrH()*0.04)
		self.pan[k]:DockMargin(2,(first == false and 22 or 2),2,2)
		first = true
		self.pan[k]:Dock(TOP)


		--handle 0.25 wide, status 0.6 wide, avail 0.15 wide

        self.pan[k].handle = vgui.Create("DLabel", self.pan[k])      
        self.pan[k].handle:SetPos(10, y)
        self.pan[k].handle:SetSize(self.pan[k]:GetWide()*0.28, 0)
        self.pan[k].handle:SetFont("nutSmallFont")
        self.pan[k].handle:SetText(tbl[k].handle)
        self.pan[k].handle:DockMargin(6,2,4,2)
        self.pan[k].handle:SetContentAlignment(4)
        first = true
        self.pan[k].handle:Dock(LEFT)
        self.pan[k].handle:SetWrap(true)


        self.pan[k].title = vgui.Create("DLabel", self.pan[k])        
        self.pan[k].title:SetPos(10, y)
        self.pan[k].title:SetSize(self.pan[k]:GetWide()*0.6, 0)
        self.pan[k].title:SetFont("nutSmallFont")
        self.pan[k].title:SetText(tbl[k].title)
        self.pan[k].title:DockMargin(2,2,2,2)
        self.pan[k].title:SetContentAlignment(4)
        first = true
        self.pan[k].title:Dock(FILL)
        self.pan[k].title:SetWrap(true)
		

        self.pan[k].avail = vgui.Create("DLabel", self.pan[k])         
        self.pan[k].avail:SetPos(10, y)
        self.pan[k].avail:SetSize(self.pan[k]:GetWide()*0.12, 0)
        self.pan[k].avail:SetFont("nutSmallFont")
        self.pan[k].avail:SetText(tbl[k].avail)
        self.pan[k].avail:DockMargin(2,2,6,2)
        self.pan[k].avail:SetContentAlignment(6)
        first = true
        self.pan[k].avail:Dock(RIGHT)
        self.pan[k].avail:SetWrap(true)

	end
end


function PANEL:Init()
    	
	local y = 10

    self.pdaLabel = self:Add("DLabel")
	self.pdaLabel:SetPos(10, y)
	self.pdaLabel:SetFont("nutSmallFont")
	self.pdaLabel:SetText("Loading List")
	self.pdaLabel:DockMargin(2,2,2,2)
	self.pdaLabel:Dock(FILL)

    self.pdaLabel:SetWrap(true)

    self:AddItem(self.pdaLabel)



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
