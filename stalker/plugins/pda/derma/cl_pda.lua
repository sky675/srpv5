
local PANEL = {}
--[[
	Just wanted to change up the way the PDA system handles the different tabs so that it'd be easier to implement new tabs in the future
		& also that it would function consistantly
			Also the code for the original tabs is practically the same as when you made it sky, just fitted for the new format,
				so if you need to change any of that it shouldn't be foreign looking

	Hopefully this wasn't completely horribly done <3 <3 <3 <3 <3 <3 <3 <3 
--]]


--[[
	Gathers all the different pages of the PDA to be added to the collection, use the hook to add pda tabs from another plugin. 
	*Use a unique priority identifier* - ideally increments of 100, ya know
	Priority determines order of appearance, lowest number being higher on the list.
--]]
function PANEL:ConfigureTabs()
	self:addTab(vgui.Create("pdaHome"), 1)
	self:addTab(vgui.Create("pdaScoreboard"), 2)
	self:addTab(vgui.Create("pdaMap"), 3)
	self:addTab(vgui.Create("pdaSettings"), 4)
	--self:addTab(vgui.Create("pdaAnnouncements"), 5)  --(Re-implemented your announcements system if you want to do anything with it :])
	self:addTab(vgui.Create("pdaClose"), 9999) --This has a ShouldShow() parameter matching the nut.config option for pdaInternalCloseButton

	hook.Run("pdaConfigureTabs", self)
end

--[[
	Adds a tab to the tab collection, initalizing the vgui elements and setting them invisible.
--]]
function PANEL:addTab(tab, priority)

	assert(IsValid(tab), "Invalid panel for tab")
	assert(tab.isTab, "Panel must inherit stalkerPdaTab")
	if (isnumber(priority)) then
		table.insert(self.tabs, math.min(priority, #self.tabs + 1), tab)
	else
		self.tabs[#self.tabs + 1] = tab
	end
	tab:SetParent(self.Content)
	
end

--[[
	Gets all pages created in ConfigureTabs() and, if shouldShow() is true, adds them to the scroll list on the left.
--]]
function PANEL:AddTabsToList(tbl)
	for k,tab in pairs(tbl) do
		if (tab:shouldShow()) then
			self.Scroll.tab[k] = vgui.Create("DButton", self.Scroll)
			self.Scroll.tab[k]:SetText(tab.tabLabel or "No Label Set")
			self.Scroll.tab[k]:SetTextColor(Color(255,255,255,150))
			self.Scroll.tab[k]:SetFont("nutMediumLightFont")
			self.Scroll.tab[k]:SetSize(219, 35)
			self.Scroll.tab[k]:Dock(TOP)
			self.Scroll.tab[k].DoClick = function()
				self:SetTab(k)
			end
		end
	end
end


--[[
	Used to get PDA data from within a tabs content panel
--]]
function PANEL:getPDA()
	return self.pda
end

--[[
	Forces a tab to be opened, should be passed the "priority" of the tab set in addTab()

	This doesn't check if shouldShow() is true, so do with that what you will
--]]
function PANEL:SetTab(newTab)
	self.Scroll.tab[self.curTab]:SetTextColor(Color(255,255,255,150)) --Unselected tab color
	self.tabs[self.curTab]:onHide()
	self.tabs[self.curTab]:KillFocus()
	self.tabs[self.curTab]:SetVisible(false)
	self.curTab = newTab
	self.Scroll.tab[self.curTab]:SetTextColor(Color(100,255,100,190)) --Selected tab highlight color
	self.tabs[self.curTab]:SetVisible(true)
	self.tabs[self.curTab]:RequestFocus()
	self.tabs[self.curTab]:onDisplay()
end

--[[
	These two functions remove all tabs from the tab list and all panels from the content window (respectively)
	(You better have a backup plan, buddy!)
--]]
function PANEL:NukeTabs()
	for k,_ in pairs(self.Scroll.tab) do
		self.Scroll.tab[k]:Remove()
	end
end

function PANEL:NukePages()
	for k,_ in pairs(self.tabs) do
		self.tabs[k]:Remove()
	end
end


--[[
	From the ashes - a phoenix! These two functions rebuild the tab & page collection respectively, assuming you've nuked them, or something.
		If you're rebuilding both at the same time, rebuild pages first.
--]]
function PANEL:RebuildTabs()
	assert(#self.Scroll.tab > 0, "Trying to rebuild PDA tabs list, but some of the tab list still exists")
	self.Scroll.tab = {}
	self:AddTabsToList(self.tabs)
end

function PANEL:RebuildPages()
	assert(#self.tabs > 0, "Trying to rebuild PDA pages, but some pages still exist.")
	self.tabs = {}
	self.curTab = 1
	self:ConfigureTabs()
end

--[[
	Disables (hides) the pda
--]]
function PANEL:DisablePDA()
	self:SetVisible(false)
	self.CloseB:SetVisible(false)
end

--[[
	Resets the pda, getting new PDA data & rebuilding the tab and page list
--]]
function PANEL:Reset(newid)

	local ply = LocalPlayer()
	local char = ply:getChar()
	local inv = char:getInv()

	self:NukeTabs()
	self:NukePages()
	self:RebuildPages()
	self:RebuildTabs()

	self:SetTab(1) --Go to home page

	self:SetVisible(true)
	if (nut.config.get("pdaExternalCloseButton")) then
		self.CloseB:SetVisible(true)
		self.CloseB:SetMouseInputEnabled(true)
	end

	
	if(type(newid) == "table") then
		self.pda = newid
	else
		for k,v in pairs(inv:getItems()) do
			if(v.base == "base_npda") then
				if(newid and v.id == newid) then
					self.pda = v
					break
				elseif(self.pda:getOwner() == ply) then
					self.pda = v
					break
				end
			end
		end
	end
end

function PANEL:OnRemove()
	PDA_DATA_DISPLAY = nil
	self.CloseB:Remove()
end

function PANEL:Init()
	local ply = LocalPlayer()
	local char = ply:getChar()
	local inv = char:getInv()

	if(!IsValid(nut.gui.pda)) then
		nut.gui.pda = self
	end

	--[[
		Retrieving PDA data
	--]]
	if(!self.pda) then
		for _,v in pairs(inv:getItems()) do
			if(v.base == "base_npda" and self.instid and v.id == self.istid) then
				self.pda = v
				break 
			elseif(v.base == "base_npda" and self.instid) then
				self.pda = v
				break
			end
		end
	end
	

	--[[
		Setting up & Configuring PDA Size
			1025/1920 is 0.5333
			1024/1080 is 0.65
	--]]
	local pdaW, pdaH = ScrW()*0.5333, ScrH()*0.65
	self:SetSize(pdaW, pdaH)

	self:Center()
	self:MakePopup()
	self:SetTitle("")
	self:SetDraggable(false)
	self:ShowCloseButton(false)
	
	self.Paint = function()
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(Material("sky/ui_pda_eng.png"))
		surface.DrawTexturedRect(0,0,pdaW, pdaH)

	end


	--[[ 
		Optional Close Button appearing beneath PDA gui (toggle from nut config)	
	--]]
	self.CloseB = vgui.Create("DImageButton")
	self.CloseB:SetMaterial(Material("sky/buttons/pda_close_on.png"))

	local closeButtonPadding = 20
	self.CloseB:SetY(self:GetY() + self:GetTall() + closeButtonPadding)
	self.CloseB:SetSize(114, 42)
	self.CloseB:CenterHorizontal()

	self.CloseB:SetMouseInputEnabled(false)
	self.CloseB:SetVisible(false)
	self.CloseB.DoClick = function()
		self:DisablePDA()
	end

	if (nut.config.get("pdaExternalCloseButton")) then
		self.CloseB:SetVisible(true)
		self.CloseB:SetMouseInputEnabled(true)
	end


	--[[
		MAIN PDA SCREEN CONTAINER
			width, height is *0.405, *0.498 --775, 537
			x, y is ScrX*0.0525, *0.075 --102, 80
	--]]
	local screenW, screenH = ScrW()*0.405, ScrH()*0.498
	local screenX, screenY = ScrW()*0.0525, ScrH()*0.075

	self.Main = vgui.Create("DPanel", self)

	self.Main:SetSize(screenW, screenH)
	self.Main:SetPos(screenX, screenY)

	self.Main.Paint = function (self, w, h)
		draw.NoTexture()
	end


	--[[
		TABLIST SCROLL WINDOW (ON LEFT)
			width is ScrW() * 0.114 = 219
	--]]
	local tabScrollW = ScrW()*0.114

	self.Scroll = vgui.Create("DScrollPanel", self.Main)

	self.Scroll:SetSize(tabScrollW, screenH)
	self.Scroll:SetPos(0,0)

	self.Scroll:SetBackgroundColor(Color(0,255,0))

	self.Scroll.Paint = function (self, w, h)
		--A divider line between the tab list & the content window
		DisableClipping(true)
		surface.SetDrawColor(255,255,255,155)
		surface.DrawLine(self:GetWide(), 0, self:GetWide(), self:GetTall())
		DisableClipping(false)

	end


	--[[
		CONTENT DISPLAY (ON RIGHT)
			width is ScrW() * 0.289 = 555
			x position is ScrW() * 0.115 = 220 
	--]]	
	self.Content = vgui.Create("Panel", self.Main)
	local contW = ScrW()*0.289
	local contX = ScrW()*0.115
	self.Content:SetSize(contW-2, screenH)
	self.Content:SetPos(contX+2, 0)

	--[[
		And finally, configure & add all the tabs :)
	--]]
	self.Scroll.tab = {}
	self.tabs = {}
	self.curTab = 1 --Go to home page
	self.context = {}
	self:ConfigureTabs()
	self:AddTabsToList(self.tabs)
	self:SetTab(1) --Go to home page but also set the tab as selected
end

vgui.Register("pdaPanel", PANEL, "DFrame")