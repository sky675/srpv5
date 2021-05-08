
local PANEL = {}

function PANEL:DisablePDA()

	--self:ClearContent()
	self:SetVisible(false)
	self.CloseB:SetVisible(false)
end

function PANEL:Reset(newid)
	self:SetVisible(true)
	self.CloseB:SetVisible(true)
	local ply = LocalPlayer()
	local char = ply:getChar()
	local inv = char:getInv()
	
	if(type(newid) == "table") then
		self.pda = newid
	else
		for k,v in pairs(inv:getItems()) do
			if(v.base == "base_npda") then
				if(newid) then
					if(v.id == newid) then
						self.pda = v
						break
					end
				elseif(self.pda:getOwner() == ply) then
					self.pda = v
					break
				end
			end
		end
	end

	--this might be fucky but reload it
	if(self.mode == "scoreboard") then
		self:ClearContent()
		self:CreateScoreboard()
	end
end

function PANEL:Init()
	local ply = LocalPlayer()
	local char = ply:getChar()
	local inv = char:getInv()
	if(!self.pda) then
	for k,v in pairs(inv:getItems()) do
		if(v.base == "base_npda") then
			if(self.instid) then
				if(v.id == self.instid) then
					self.pda = v
					break
				end
			else
				self.pda = v
				break
			end
		end
	end
	end
	
	local scrw, scrh = ScrW(), ScrH()

	--1024/1920 - 0.5333
	local mainpdaw, mainpdwh = scrw*0.5333, scrh*0.65
	--1024/1080 0.65
	self:SetSize(mainpdaw, mainpdwh) -- 1024,702)
	self:Center()
	self:MakePopup()
	self:SetTitle("")
	self:SetDraggable(false)
	self:ShowCloseButton(false)
	if(!IsValid(nut.gui.pda)) then
		nut.gui.pda = self
	end
	local factpda = {
		[FACTION_ECO] = "sky/pda_eco.png"
	}
	self.Paint = function()
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(Material(factpda[LocalPlayer():getChar():getFaction()] or "sky/ui_pda_eng.png"))
		surface.DrawTexturedRect(0,0,mainpdaw, mainpdwh)
	end

	--close button
	self.CloseB = vgui.Create("DImageButton")
	--self.CloseB:SetFont("nutBigFont")
	--self.CloseB:SetText("x")
	--self.CloseB:SetTextColor(Color(250,0,0,255))
	self.CloseB:SetMaterial(Material("sky/buttons/pda_close_on.png"))
	self.CloseB:SetPos((scrw*0.5-63), (scrh*0.825+19))--5+370)) --half pda h 351
	self.CloseB:SetSize(114, 42)
	--self.CloseB:SetZPos(-1)
	self.CloseB:SetMouseInputEnabled(true)
	self.CloseB.DoClick = function()
		self:DisablePDA()--Remove()
	end

	self.Main = vgui.Create("DPanel", self)
	local mainconw, mainconh = scrw*0.405, scrh*0.498
	local mainconx, maincony = scrw*0.0525, scrh*0.075
	self.Main:SetSize(mainconw, mainconh)--775, 537)
	self.Main:SetPos(mainconx, maincony)--102, 80)
	self.Main.Paint = function (self, w, h)
		draw.NoTexture()
	end

	self.Content = vgui.Create("Panel", self.Main)
	local conw = scrw*0.289
	local conx = scrw*0.115
	self.Content:SetSize(conw, mainconh)--555, 537)
	self.Content:SetPos(conx, 0)--220,0)

	self.Scroll = vgui.Create("DScrollPanel", self.Main)
	local sclw = scrw*0.114
	self.Scroll:SetSize(sclw, mainconh)--219, 537)
	self.Scroll:SetPos(0,0)
	self.Scroll:SetBackgroundColor(Color(0,255,0))
	--self.Content:SetVisible(false)

	self.Scroll.Scoreboard = vgui.Create("DButton", self.Scroll)
	self.Scroll.Scoreboard:SetText("Online List")
	self.Scroll.Scoreboard:SetSize(219, 60)
	self.Scroll.Scoreboard:Dock(TOP)
	self.Scroll.Scoreboard.DoClick = function()
		self:ClearContent()
		self:CreateScoreboard()
	end
	
	--display data
	--[[
	self.Scroll.Announcements = vgui.Create("DButton", self.Scroll)
	self.Scroll.Announcements:SetText("data lookup")
	self.Scroll.Announcements:SetSize(219, 60)
	self.Scroll.Announcements:Dock(TOP)
	self.Scroll.Announcements:SetEnabled(LocalPlayer():isCombine() or LocalPlayer():getChar():hasFlags("Z"))
	self.Scroll.Announcements.DoClick = function()
		self:ClearContent(true)
		self:CreateDataLookup()
	end
	]]

	--settings
	self.Scroll.Settings = vgui.Create("DButton", self.Scroll)
	self.Scroll.Settings:SetText("Settings")
	self.Scroll.Settings:SetSize(219, 60)
	self.Scroll.Settings:Dock(TOP)
	self.Scroll.Settings.DoClick = function()
		self:ClearContent(true)
		self:CreateSettings()
	end

	--close alt
	self.Scroll.Close = vgui.Create("DButton", self.Scroll)
	self.Scroll.Close:SetText("Clear")
	self.Scroll.Close:SetSize(219, 60)
	self.Scroll.Close:Dock(TOP)
	self.Scroll.Close.DoClick = function()
		self:ClearContent()
		--self:DisablePDA()--Remove()
	end
end

function PANEL:OnRemove()
	PDA_DATA_DISPLAY = nil --reset this
	self.CloseB:Remove()
end

function PANEL:ClearContent(cleardisplay)
	self.mode = nil
	if(cleardisplay) then PDA_DATA_DISPLAY = nil end
	local cont = self.Content:GetChildren()
	for i,panel in pairs(cont) do
		if(IsValid(panel)) then
			panel:Remove()
		end
	end
	self.Content.Paint = function(self, w, h)
		draw.NoTexture()
	end
end

function PANEL:CreateAnnouncements()
	self.Content.Paint = function(self, w, h)
		draw.NoTexture()    --nil should be "nutSmallFont"
		draw.SimpleText("Announcements", "nutSmallFont", w/2, 7, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	self.Content.Cont = vgui.Create("DPanel", self.Content)
	self.Content.Cont:SetPos(0,20)
	self.Content.Cont:SetSize(555, 516)
	self.Content.Cont:Dock(FILL)
	self.Content.Cont.Paint = function(self, w, h)
		draw.NoTexture()
		surface.SetDrawColor(Color(150,150,150,255))
		surface.DrawOutlinedRect(0,0,w,h)
		surface.SetDrawColor(Color(255,255,255,255))
	end

	self.Content.Scroll = vgui.Create("HTML", self.Content.Cont)
	self.Content.Scroll:DockMargin(2,2,2,2)
	self.Content.Scroll:Dock(FILL)
	self.Content.Scroll:OpenURL("http://rprstalker.site.nfoservers.com/test/hello.php")
	--[[
	self.Content.RefreshBut = vgui.Create("DButton", self.Content)
	self.Content.RefreshBut:SetPos(1, 1)
	self.Content.RefreshBut:SetSize(120, 20)
	self.Content.RefreshBut:SetText("Refresh")
	self.Content.RefreshBut:SizeToContents()
	self.Content.RefreshBut.DoClick = function()
		self.Content.Scroll:OpenURL("http://rprstalker.site.nfoservers.com/test/hello.php")
	end
	]]
end

function PANEL:UpdateScoreboard(tbl)
	if(self.Content.Scroll.pdaLabel) then
		self.Content.Scroll.pdaLabel:Remove()
	end

	--add button if not exist (put it topleft, not in line with anything)
	--use mains size+a little bit more
	--[[local netHandle = vgui.Create("DButton", self.Content)
	netHandle:SetPos(0,0)
	netHandle:SetSize(ScrW()*0.15, 22)--80,22)
	--netHandle:DockMargin(2,22,2,2)
	--netHandle:Dock(TOP)
	--setsize
	netHandle:SetFont("nutSmallFont")
	netHandle:SetText("Refresh")
	netHandle.DoClick = function(sel)
		self:ClearContent()
		self:CreateScoreboard()
	end]]

	--loop table and add
	--{handle,}
	local first = false
	local y = 10
	for k,v in ipairs(tbl) do
		--replace with panel,
		local pan = vgui.Create("DPanel", self.Content.Scroll)
		pan:SetSize(self.Content.Scroll:GetWide(), ScrH()*0.04)
		pan:DockMargin(2,(first == false and 22 or 2),2,2)
		first = true
		pan:Dock(TOP)
		self.Content.Scroll:AddItem(pan)


		--handle 0.25 wide, status 0.6 wide, avail 0.15 wide
		local pdaLabel = vgui.Create("DLabel", pan)
		pdaLabel:SetPos(10, y)
		pdaLabel:SetSize(pan:GetWide()*0.28, 0)
		pdaLabel:SetFont("nutSmallFont")
		pdaLabel:SetText(tbl[k].handle)
		pdaLabel:DockMargin(6,2,4,2)
		pdaLabel:SetContentAlignment(4)
		first = true
		pdaLabel:Dock(LEFT)
		--pdaLabel:SetWide(self.Content.Scroll:GetWide())
		pdaLabel:SetWrap(true)
		--pdaLabel:SizeToContents()
		--self.Content.Scroll:AddItem(pdaLabel)
		
		pdaLabel = vgui.Create("DLabel", pan)
		pdaLabel:SetPos(10, y)
		pdaLabel:SetSize(pan:GetWide()*0.6, 0)
		pdaLabel:SetFont("nutSmallFont")
		pdaLabel:SetText(tbl[k].title)
		pdaLabel:DockMargin(2,2,2,2)
		pdaLabel:SetContentAlignment(4)
		first = true
		pdaLabel:Dock(FILL)
		--pdaLabel:SetWide(self.Content.Scroll:GetWide())
		pdaLabel:SetWrap(true)
		--pdaLabel:SizeToContents()
		--self.Content.Scroll:AddItem(pdaLabel)

		pdaLabel = vgui.Create("DLabel", pan)
		pdaLabel:SetPos(10, y)
		pdaLabel:SetSize(pan:GetWide()*0.12, 0)
		pdaLabel:SetFont("nutSmallFont")
		pdaLabel:SetText(tbl[k].avail)
		pdaLabel:DockMargin(2,2,6,2)
		pdaLabel:SetContentAlignment(6)
		first = true
		pdaLabel:Dock(RIGHT)
		--pdaLabel:SetWide(self.Content.Scroll:GetWide())
		pdaLabel:SetWrap(true)
		--pdaLabel:SizeToContents()
		--self.Content.Scroll:AddItem(pdaLabel)
	end
end

function PANEL:CreateScoreboard()
	self.Content.Paint = function(self, w, h)
		draw.NoTexture()
		draw.SimpleText("Online List", "nutSmallFont", w/2, 7, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	self.mode = "scoreboard"

	self.Content.Cont = vgui.Create("DPanel", self.Content)
	self.Content.Cont:SetPos(0,20)
	self.Content.Cont:SetSize(555, 516)
	self.Content.Cont:Dock(FILL)
	self.Content.Cont.Paint = function(self, w, h)
		draw.NoTexture()
		surface.SetDrawColor(Color(150,150,150,255))
		surface.DrawOutlinedRect(0,0,w,h)
		surface.SetDrawColor(Color(255,255,255,255))
	end

	self.Content.Scroll = vgui.Create("DScrollPanel", self.Content.Cont)
	self.Content.Scroll:DockMargin(2,2,2,2)
	self.Content.Scroll:Dock(FILL)
	
	local y = 10
	--do default here, centered
	self.Content.Scroll.pdaLabel = vgui.Create("DLabel", self.Content.Scroll)
	self.Content.Scroll.pdaLabel:SetPos(10, y)
	self.Content.Scroll.pdaLabel:SetFont("nutSmallFont")
	self.Content.Scroll.pdaLabel:SetText("Loading List")
	self.Content.Scroll.pdaLabel:DockMargin(2,2,2,2)
	self.Content.Scroll.pdaLabel:Dock(FILL)
	--pdaLabel:SetWide(self.Content.Scroll:GetWide())
	self.Content.Scroll.pdaLabel:SetWrap(true)
	--pdaLabel:SetAutoStretchVertical(true)
	--pdaLabel:SizeToContents()
	self.Content.Scroll:AddItem(self.Content.Scroll.pdaLabel)

	--send request, result sent back should call update scoreboard
	netstream.Start("reqlist")
end

function PANEL:CreateSettings() 
	self.Content.Paint = function(self, w, h)
		draw.NoTexture()
		draw.SimpleText("Settings", "nutSmallFont", w/2, 7, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	self.Content.Cont = vgui.Create("DPanel", self.Content)
	self.Content.Cont:SetPos(0,20)
	self.Content.Cont:SetSize(555, 516)
	self.Content.Cont:Dock(FILL)
	self.Content.Cont.Paint = function(self, w, h)
		draw.NoTexture()
		surface.SetDrawColor(Color(150,150,150,255))
		surface.DrawOutlinedRect(0,0,w,h)
		surface.SetDrawColor(Color(255,255,255,255))
	end

	self.Content.Scroll = vgui.Create("DScrollPanel", self.Content.Cont)
	self.Content.Scroll:DockMargin(2,2,2,2)
	self.Content.Scroll:Dock(FILL)
	
	local y = 10
	--[[local pdaLabel = vgui.Create("DLabel", self.Content.Scroll)
	pdaLabel:SetPos(10, y)
	pdaLabel:SetFont("nutSmallFont")
	pdaLabel:SetText("PDA Settings")
	pdaLabel:DockMargin(2,12,2,2)
	pdaLabel:Dock(TOP)
	--pdaLabel:SetWide(self.Content.Scroll:GetWide())
	pdaLabel:SetWrap(true)
	--pdaLabel:SetAutoStretchVertical(true)
	--pdaLabel:SizeToContents()
	self.Content.Scroll:AddItem(pdaLabel)
	y = y+pdaLabel:GetTall() + 5]]
	
	local netHandleLabel = vgui.Create("DLabel", self.Content.Scroll)
	netHandleLabel:SetPos(10,y)
	netHandleLabel:SetFont("nutSmallFont")
	netHandleLabel:SetText("Net Handle: Your handle on the network and it's related services.")
	netHandleLabel:DockMargin(2,18,2,2)
	netHandleLabel:Dock(TOP)
	--netHandleLabel:SetWide(self.Content.Scroll:GetWide())
	netHandleLabel:SetWrap(true)
	netHandleLabel:SetAutoStretchVertical(true)
	--pdaLabel:SizeToContents()
	netHandleLabel.PaintOver = function(sel,w,h)
		DisableClipping(true)   --replace temp with self.pda:getData("pdahandle", "invalid")
		draw.SimpleText("Your current handle: "..self.pda:getData("pdahandle", "invalid"), "nutSmallFont", 0, h+15, Color(200,200,200,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		DisableClipping(false)
	end
	self.Content.Scroll:AddItem(netHandleLabel)
	y = y+netHandleLabel:GetTall() + 22

	local netHandle = vgui.Create("DButton", self.Content.Scroll)
	netHandle:SetPos(10,y)
	netHandle:SetSize(ScrW()*0.15, 22)--80,22)
	netHandle:DockMargin(2,22,2,2)
	netHandle:Dock(TOP)
	--setsize
	netHandle:SetFont("nutSmallFont")
	netHandle:SetText("Edit Handle")
	netHandle.DoClick = function(sel)
		Derma_StringRequest(
			"Edit Net Handle",
			"Input a new handle here. Must be at least 3 and no more than 32 characters long.\nNo spaces.\nExtremely vulgar and/or racist/etc names may get removed without warning.",
			"",
			function(text)
				local str = text:gsub("%s+", "")
				if(string.len(str) < 3 or string.len(str) > 32) then
					nut.util.notify("The handle you input is too short/long.", 3)
					return
				end
				if(str == "invalid") then
					nut.util.notify("You cannot return your name to default.", 3)
					return
				end
				--[[if(isnumber(str) and !LocalPlayer():isCombine()) then
					nut.util.notify("You are not allowed to have a handle of only numbers!")
					return
				end]]
				print("ur result was "..str)

				net.Start("ChangePDAHandle")
				net.WriteString(str)
				net.WriteInt(self.pda.id, 32)
				net.SendToServer()
			end,
			function(text) end,
			"Submit Handle",
			"Cancel"
		)
	end
	self.Content.Scroll:AddItem(netHandle)
	y = y+netHandle:GetTall() + 5
	
	local titleLabel = vgui.Create("DLabel", self.Content.Scroll)
	titleLabel:SetPos(10,y)
	titleLabel:SetFont("nutSmallFont")
	titleLabel:SetText("Title Message: A short message other online users can see.")
	titleLabel:DockMargin(2,7,2,2)
	titleLabel:Dock(TOP)
	--netHandleLabel:SetWide(self.Content.Scroll:GetWide())
	titleLabel:SetWrap(true)
	titleLabel:SetAutoStretchVertical(true)
	--pdaLabel:SizeToContents()
	titleLabel.PaintOver = function(sel,w,h)
		DisableClipping(true)   --replace temp with self.pda:getData("pdahandle", "invalid")
		draw.SimpleText("Your current title: "..self.pda:getData("pdatitle", ""), "nutSmallFont", 0, h+15, Color(200,200,200,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		DisableClipping(false)
	end
	self.Content.Scroll:AddItem(titleLabel)
	y = y+titleLabel:GetTall() + 22

	local titleBut = vgui.Create("DButton", self.Content.Scroll)
	titleBut:SetPos(10,y)
	titleBut:SetSize(ScrW()*0.15, 22)--80,22)
	titleBut:DockMargin(2,22,2,2)
	titleBut:Dock(TOP)
	--setsize
	titleBut:SetFont("nutSmallFont")
	titleBut:SetText("Edit Title")
	titleBut.DoClick = function(sel)
		Derma_StringRequest(
			"Edit Title",
			"Input a new title here. Must be no more than 96 characters long.\nInappropriate titles will be removed.",
			"",
			function(text)
				local str = text--:gsub("%s+", "")
				if(string.len(str) > 96) then
					nut.util.notify("The handle you input is too long.", 3)
					return
				end
				--[[if(isnumber(str) and !LocalPlayer():isCombine()) then
					nut.util.notify("You are not allowed to have a handle of only numbers!")
					return
				end]]
				print("ur result was "..str)

				net.Start("ChangePDATitle")
				net.WriteString(str)
				net.WriteInt(self.pda.id, 32)
				net.SendToServer()
			end,
			function(text) end,
			"Submit Title",
			"Cancel"
		)
	end
	self.Content.Scroll:AddItem(titleBut)
	y = y+titleBut:GetTall() + 5
	
	local partyLabel = vgui.Create("DLabel", self.Content.Scroll)
	partyLabel:SetPos(10,y)
	partyLabel:SetFont("nutSmallFont")
	partyLabel:SetText("Party Channel ID: The ID of the channel you're using for /pdaparty.")
	partyLabel:DockMargin(2,7,2,2)
	partyLabel:Dock(TOP)
	--netHandleLabel:SetWide(self.Content.Scroll:GetWide())
	partyLabel:SetWrap(true)
	partyLabel:SetAutoStretchVertical(true)
	--pdaLabel:SizeToContents()
	partyLabel.PaintOver = function(sel,w,h)
		DisableClipping(true)   --replace temp with self.pda:getData("pdahandle", "invalid")
		draw.SimpleText("Your current channel: "..self.pda:getData("partych", ""), "nutSmallFont", 0, h+15, Color(200,200,200,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		DisableClipping(false)
	end
	self.Content.Scroll:AddItem(partyLabel)
	y = y+partyLabel:GetTall() + 22

	local partyBut = vgui.Create("DButton", self.Content.Scroll)
	partyBut:SetPos(10,y)
	partyBut:SetSize(ScrW()*0.15, 22)--80,22)
	partyBut:DockMargin(2,22,2,2)
	partyBut:Dock(TOP)
	--setsize
	partyBut:SetFont("nutSmallFont")
	partyBut:SetText("Edit Channel")
	partyBut.DoClick = function(sel)
		Derma_StringRequest(
			"Edit Channel",
			"Input a new channel here. Must be no more than 12 characters long.",
			"",
			function(text)
				local str = text--:gsub("%s+", "")
				if(string.len(str) > 12) then
					nut.util.notify("The handle you input is too long.", 3)
					return
				end
				--[[if(isnumber(str) and !LocalPlayer():isCombine()) then
					nut.util.notify("You are not allowed to have a handle of only numbers!")
					return
				end]]
				print("ur result was "..str)

				net.Start("ChangePDAParty")
				net.WriteString(str)
				net.WriteInt(self.pda.id, 32)
				net.SendToServer()
			end,
			function(text) end,
			"Submit Channel ID",
			"Cancel"
		)
	end
	self.Content.Scroll:AddItem(partyBut)
	y = y+partyBut:GetTall() + 5
	
end

vgui.Register("pdaPanel", PANEL, "DFrame")