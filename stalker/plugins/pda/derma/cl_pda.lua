
local PANEL = {}

function PANEL:Init()
    local ply = LocalPlayer()
    local char = ply:getChar()
    local inv = char:getInv()
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
	self.CloseB:SetMaterial(Material("sky/close_idle.png"))
    self.CloseB:SetPos((scrw*0.5-63), (scrh*0.825+19))--5+370)) --half pda h 351
    self.CloseB:SetSize(126, 96)
    --self.CloseB:SetZPos(-1)
    self.CloseB:SetMouseInputEnabled(true)
    self.CloseB.DoClick = function()
		self:Remove()
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

    --[[self.Scroll.Scoreboard = vgui.Create("DButton", self.Scroll)
    self.Scroll.Scoreboard:SetText("leaderboard")
    self.Scroll.Scoreboard:SetSize(219, 60)
	self.Scroll.Scoreboard:Dock(TOP)
	self.Scroll.Scoreboard:SetEnabled(false) --todo idk? different thing? for announce too
    self.Scroll.Scoreboard.DoClick = function()
        self:ClearContent()
        self:CreateLeaderboard()
    end
    
    self.Scroll.Announcements = vgui.Create("DButton", self.Scroll)
    self.Scroll.Announcements:SetText("announce")
    self.Scroll.Announcements:SetSize(219, 60)
	self.Scroll.Announcements:Dock(TOP)
	self.Scroll.Announcements:SetEnabled(false)
    self.Scroll.Announcements.DoClick = function()
        self:ClearContent()
        self:CreateAnnouncements()
	end]]
	
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
    self.Scroll.Close:SetText("Close")
    self.Scroll.Close:SetSize(219, 60)
    self.Scroll.Close:Dock(TOP)
	self.Scroll.Close.DoClick = function()
        self:Remove()
    end
end

function PANEL:OnRemove()
	PDA_DATA_DISPLAY = nil --reset this
	self.CloseB:Remove()
end

function PANEL:ClearContent(cleardisplay)
	if(cleardisplay) then PDA_DATA_DISPLAY = nil end
    local cont = self.Content:GetChildren()
    for i,panel in pairs(cont) do
        if(IsValid(panel)) then
            panel:Remove()
        end
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
function PANEL:CreateDataLookup() 
    self.Content.Paint = function(self, w, h)
        draw.NoTexture()
        draw.SimpleText("Data Lookup", "nutSmallFont", w/2, 7, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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

	--input + button for id, on submit GivePDAData with all = true and set a bool for func below
	self.Content.Scroll.Input = self.Content.Scroll:Add("DTextEntry")--vgui.Create("DTextEntry", self.Content.Scroll)
	self.Content.Scroll.Input:SetSize(200, 38)
	--i hate derma WITH A FUCKING PASSION
	self.Content.Scroll.Input:SetPos(555*0.325, 516/1.75)--self.Content.Scroll:GetTall()*0.5, self.Content.Scroll:GetWide()*0.5)
	self.Content.Scroll.Input:SetPlaceholderText("Enter CID")
	self.Content.Scroll.Input.OnEnter = function(sel)
		if(!tonumber(sel:GetValue())) then
			nut.util.notify("You have not entered a valid ID!")
			return
		end

		local id = tonumber(sel:GetValue())

		sel:SetText("Processing Data for ID Please Wait..")
		sel:SetDisabled(true)
		self.Content.Scroll.Submit:SetDisabled(true)

		PDA_DATA_DISPLAY = true

		net.Start("GivePDAData")
		net.WriteInt(id, 21)
		net.WriteBool(true)
		net.SendToServer()
	end

	self.Content.Scroll.Submit = self.Content.Scroll:Add("DButton")--vgui.Create("DButton", self.Content.Scroll)
	self.Content.Scroll.Submit:SetSize(200, 28)
	self.Content.Scroll.Submit:SetPos(555*0.325, (516/1.75)+38)--(self.Content.Scroll:GetTall()*0.5), (self.Content.Scroll:GetWide()*0.5)+38)
--	self.Content.Scroll.Submit:CenterHorizontal()
	self.Content.Scroll.Submit:SetText("Submit")
	self.Content.Scroll.Submit.DoClick = function(sel)
		if(!tonumber(self.Content.Scroll.Input:GetValue())) then
			nut.util.notify("You have not entered a valid ID!")
			return
		end

		local id = tonumber(self.Content.Scroll.Input:GetValue())

		self.Content.Scroll.Input:SetText("Processing Data for ID Please Wait..")
		self.Content.Scroll.Input:SetDisabled(true)
		sel:SetDisabled(true)
		
		PDA_DATA_DISPLAY = true

		net.Start("GivePDAData")
		net.WriteInt(id, 21)
		net.WriteBool(true)
		net.SendToServer()
	end
end

function dataCreateTable(tbl)
	--check if bool set above is true, otherwise fill out settings created
	--on bool, create extra field that can be edited with SetPDAComm
	print("hm?")
	PrintTable(tbl) --?
	if(!tbl or !tbl.id) then return end --eh? just in case
	local id = tbl.id
	local self = nut.gui.pda
	if(!IsValid(self)) then return end --wtf?

	self:ClearContent()

	--this is the display, it should have 1. a form displaying all the stuff in the table
	--(see notepad) and below that an editable field the defaults to the comments from the table
	--on submit it should do SetPDAComm net message with the value then the id
	if(PDA_DATA_DISPLAY) then
		PDA_DATA_DISPLAY = nil
		print("we got it true")
		PrintTable(tbl)

		self.Content.Paint = function(self, w, h)
			draw.NoTexture()
			draw.SimpleText("Data Display - CID: "..tbl.id, "nutSmallFont", w/2, 7, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	
		self.Content.Cont = vgui.Create("DPanel", self.Content)
		self.Content.Cont:SetPos(0,20)
		self.Content.Cont:SetSize(555, 516)
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
		--first: display handle - id
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(5, y)
		handle:SetFont("nutSmallFont")
		handle:SetText("Handle: "..tbl.handle.." - PDA ID: "..tbl.pdaid)
		handle:SizeToContents()

		y = y+handle:GetTall() + 5

		--todo, change this to status
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(5, y)
		handle:SetFont("nutSmallFont")
		if(!tbl.combine) then
			if(!tbl.data.status or tbl.data.status:upper() == "UNKNOWN") then
				handle:SetTextColor(Color(0,0,255))
			elseif(tbl.data.status:upper() == "ANTI-CITIZEN") then
				handle:SetTextColor(Color(255,0,0))
			else --todo: change default color and do one for cwu status
				handle:SetTextColor(Color(0,255,0))
			end
			handle:SetText("Citizen Status: "..(tbl.data.status:upper() or "UNKNOWN"))
		else
			if(tbl.combine == FACTION_CP) then
				handle:SetText("METROPOLICE FORCE")
			elseif(tbl.combine == FACTION_OW) then
				handle:SetText("OVERWATCH")
			else
				handle:SetTextColor(Color(0,255,0))
				handle:SetText("UNKNOWN")
			end
		end

		handle:SizeToContents()

		y = y+handle:GetTall() + 5

		--below: display bannedstat, make color red
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(5, y)
		handle:SetFont("nutSmallFont")
		if(string.find(tbl.bannedstat, "Banned")) then
			handle:SetTextColor(Color(255,0,0))
		elseif(string.find(tbl.bannedstat, "Unknown")) then
			handle:SetTextColor(Color(0,0,255))
		end
		handle:SetText("PDA Channel Bans: "..tbl.bannedstat)
		handle:SizeToContents()

		y = y+handle:GetTall() + 15
		--little space
		--name: name
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(5, y)
		handle:SetFont("nutSmallFont")
		handle:SetText("Name")
		handle:SizeToContents()

		y = y+handle:GetTall() + 2--5

		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(5, y)
		handle:SetFont("nutSmallFont")
		handle:SetText(tbl.combine and tbl.crank or tbl.data.name or "None")
		handle:SizeToContents()

		y = y+handle:GetTall() + 5
		--height: height weight: weight dob: dob
		local xes = {}
		local x = 5
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(x, y)
		xes[1] = x
		handle:SetFont("nutSmallFont")
		handle:SetText("Height")
		handle:SizeToContents()
		x = x+handle:GetWide() + 10
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(x, y)
		xes[2] = x
		handle:SetFont("nutSmallFont")
		handle:SetText("Weight")
		handle:SizeToContents()
		x = x+handle:GetWide() + 10
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(x, y)
		xes[3] = x
		handle:SetFont("nutSmallFont")
		handle:SetText("Date Of Birth") --japans is yy/mm/dd but thats ok
		handle:SizeToContents()
		x = x+handle:GetWide() + 10
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(x, y)
		xes[4] = x
		handle:SetFont("nutSmallFont")
		handle:SetText("Eye Color")
		handle:SizeToContents()
		x = x+handle:GetWide() + 30
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(x, y)
		xes[5] = x
		handle:SetFont("nutSmallFont")
		handle:SetText("Loyalist Points")
		handle:SizeToContents()

		y = y+handle:GetTall() + 2--5
		
		local heightpick = self.Content.Scroll:Add("DTextEntry")
		heightpick:SetPos(xes[1], y)
		heightpick:SetFont("nutSmallFont")
		heightpick:SetText(tbl.data.height or "None")
		heightpick:SizeToContents()
		heightpick:SetWidth(heightpick:GetWide()*0.7)
		
		local weightpick = self.Content.Scroll:Add("DTextEntry")
		weightpick:SetPos(xes[2], y)
		weightpick:SetFont("nutSmallFont")
		weightpick:SetText(tbl.data.weight or "None")
		weightpick:SizeToContents()
		weightpick:SetWidth(weightpick:GetWide()*0.7)

		local dobpick = self.Content.Scroll:Add("DTextEntry")
		dobpick:SetPos(xes[3], y)
		dobpick:SetFont("nutSmallFont")
		dobpick:SetText(tbl.data.dob or "None")
		dobpick:SetTooltip("Format mm/dd/yy")
		dobpick:SizeToContents()
		dobpick:SetWidth(dobpick:GetWide()*0.7)
		
		local eyepick = self.Content.Scroll:Add("DTextEntry")
		eyepick:SetPos(xes[4], y)
		eyepick:SetFont("nutSmallFont")
		eyepick:SetText(tbl.data.eye or "None")
		eyepick:SizeToContents()
		eyepick:SetWidth(eyepick:GetWide()*0.7)
		
		local pointpick = self.Content.Scroll:Add("DTextEntry")
		pointpick:SetPos(xes[5], y)
		pointpick:SetFont("nutSmallFont")
		pointpick:SetText(tbl.data.lp or "None")
		pointpick:SizeToContents()
		pointpick:SetWidth(pointpick:GetWide()*0.7)

		y = y+handle:GetTall() + 5
		--languages spoken: list langs
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(5, y)
		handle:SetFont("nutSmallFont")
		handle:SetText("Languages Spoken")
		handle:SizeToContents()

		y = y+handle:GetTall() + 2--5

		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(5, y)
		handle:SetFont("nutSmallFont")
		handle:SetText(table.concat(tbl.langs, ", "))
		handle:SizeToContents()

		y = y+handle:GetTall() + 20--5
		--whatever else

			
		local handle = self.Content.Scroll:Add("DButton")
		handle:SetPos(5, y)
		handle:SetSize(80, 22)
		handle:SetFont("nutSmallFont")
		handle:SetText("Edit Bio")
		handle.DoClick = function(sel)
			net.Start("SetPDAData")
			local tbl = {
				["height"] = heightpick:GetValue(),
				["weight"] = weightpick:GetValue(),
				["dob"] = dobpick:GetValue(),
				["eye"] = eyepick:GetValue(),
				["lp"] = pointpick:GetValue(),
			}
			net.WriteTable(tbl)
			net.WriteInt(id, 21)
			net.SendToServer()
		end

		y = y+handle:GetTall() + 20

		--at bottom display large textbox (limit to like certain number of chars tho)
		--like wats said above
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(5, y)
		handle:SetFont("nutSmallFont")
		handle:SetText("Comments")
		handle:SizeToContents()

		y = y+handle:GetTall() + 2--5

		local comments = self.Content.Scroll:Add("DTextEntry")
		comments:SetPos(5, y)
		comments:SetSize(380, 180)
		comments:SetFont("nutSmallFont")
		comments:SetMultiline(true)
		if(!tbl.fake) then-- or tbl.comment) then
			comments:SetText(tbl.comment or "")
		else
			comments:SetText("This user appears to not be online and has no set data, as a result it may not be a real ID so comments are disabled.")
			comments:SetDisabled(true)
		end
		comments.OnTextChanged = function(sel)
			--[[local txt = sel:GetValue()
			local amt = string.len(txt)
			if amt > 120 then
				sel:SetText(sel.OldText)
				sel:SetValue(sel.OldText)
				sel:SetCaretPosition(120) --idk?
			else
				sel.OldText = txt
			end]]
		end
		
		y = y+comments:GetTall() + 5

		local handle = self.Content.Scroll:Add("DButton")
		handle:SetPos(5, y)
		handle:SetSize(150, 22)
		handle:SetFont("nutSmallFont")
		handle:SetText("Submit Comments")
		if(tbl.fake) then
			handle:SetDisabled(true)
		end
		handle.DoClick = function(sel)
			net.Start("SetPDAComm")
			net.WriteString(comments:GetValue())
			net.WriteInt(id, 21)
			net.SendToServer()
		end
	else
		--this is the editor, accessible in settings
		--everything should be editable, and have a save button
		--on click that get values of everything should do SetPDAData net message,
		--table of all the values and then the item id
		print("we got it nil")
		PrintTable(tbl)

		
		self.Content.Paint = function(self, w, h)
			draw.NoTexture()
			draw.SimpleText("Data Edit - CID: "..tbl.id, "nutSmallFont", w/2, 7, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	
		self.Content.Cont = vgui.Create("DPanel", self.Content)
		self.Content.Cont:SetPos(0,20)
		self.Content.Cont:SetSize(555, 516)
		self.Content.Cont.Paint = function(self, w, h)
			draw.NoTexture()
			surface.SetDrawColor(Color(150,150,150,255))
			surface.DrawOutlinedRect(0,0,w,h)
			surface.SetDrawColor(Color(255,255,255,255))
		end
	
		self.Content.Scroll = vgui.Create("DScrollPanel", self.Content.Cont)
		self.Content.Scroll:DockMargin(2,2,2,2)
		self.Content.Scroll:Dock(FILL)

		--do similar as above but with editable fields
		--ofc exclude stuff that isnt included (banned, wanted, langs)
		--handle can be retrieved from item (self.pda)
		local y = 10
		--first: display handle - id
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(5, y)
		handle:SetFont("nutSmallFont")
		handle:SetText("Handle: "..self.pda:getData("pdahandle", "invalid").." - PDA ID: "..self.pda:getData("simid", "000000"))
		handle:SizeToContents()

		y = y+handle:GetTall() + 5
		
		local handle = self.Content.Scroll:Add("DLabel")
		handle:SetPos(5, y)
		handle:SetFont("nutSmallFont")
		if(!tbl.combine) then
			if(tbl.data.status == "ANTI-CITIZEN") then
				handle:SetTextColor(Color(255,0,0))
			elseif(tbl.data.status == "UNKNOWN" or !tbl.data.status) then
				handle:SetTextColor(Color(0,0,255))
			else
				handle:SetTextColor(Color(0,255,0))
			end
			handle:SetText("Citizen Status: "..(tbl.data.status:upper() or "UNKNOWN"))
		else
			if(tbl.combine == FACTION_CP) then
				handle:SetText("METROPOLICE FORCE")
			elseif(tbl.combine == FACTION_OW) then
				handle:SetText("OVERWATCH")
			else
				handle:SetTextColor(Color(0,255,0))
				handle:SetText("UNKNOWN")
			end
		end

		handle:SizeToContents()

		y = y+handle:GetTall() + 5
		
		local namelabel = self.Content.Scroll:Add("DLabel")
		namelabel:SetPos(5, y)
		namelabel:SetFont("nutSmallFont")
		namelabel:SetText("Name")
		namelabel:SizeToContents()

		y = y+namelabel:GetTall() + 2--5

		local namepick = self.Content.Scroll:Add("DLabel")
		namepick:SetPos(5, y)
		namepick:SetSize(namelabel:GetWide()*2.5, 28)
		namepick:SetFont("nutSmallFont")
		namepick:SetText(tbl.combine and tbl.crank or tbl.data.name or "None")

		y = y+namepick:GetTall() + 5
		--height: height weight: weight dob: dob
		local xes = {}
		local x = 5
		local heightlabel = self.Content.Scroll:Add("DLabel")
		heightlabel:SetPos(x, y)
		xes[1] = x
		heightlabel:SetFont("nutSmallFont")
		heightlabel:SetText("Height")
		heightlabel:SizeToContents()
		x = x+heightlabel:GetWide() + 10
		local weightlabel = self.Content.Scroll:Add("DLabel")
		weightlabel:SetPos(x, y)
		xes[2] = x
		weightlabel:SetFont("nutSmallFont")
		weightlabel:SetText("Weight")
		weightlabel:SizeToContents()
		x = x+weightlabel:GetWide() + 10
		local doblabel = self.Content.Scroll:Add("DLabel")
		doblabel:SetPos(x, y)
		xes[3] = x
		doblabel:SetFont("nutSmallFont")
		doblabel:SetText("Date Of Birth") --japans is yy/mm/dd but thats ok
		doblabel:SizeToContents()
		x = x+weightlabel:GetWide() + 10
		local doblabel = self.Content.Scroll:Add("DLabel")
		doblabel:SetPos(x, y)
		xes[4] = x
		doblabel:SetFont("nutSmallFont")
		doblabel:SetText("Eye Color") --japans is yy/mm/dd but thats ok
		doblabel:SizeToContents()

		y = y+doblabel:GetTall() + 2--5
		
		local heightpick = self.Content.Scroll:Add("DTextEntry")
		heightpick:SetPos(xes[1], y)
		heightpick:SetFont("nutSmallFont")
		heightpick:SetText(tbl.data.height or "")
		heightpick:SizeToContents()
		heightpick:SetWidth(heightpick:GetWide()*0.7)
		
		local weightpick = self.Content.Scroll:Add("DTextEntry")
		weightpick:SetPos(xes[2], y)
		weightpick:SetSize(weightlabel:GetWide()+5, 28)
		weightpick:SetFont("nutSmallFont")
		weightpick:SetText(tbl.data.weight or "")
		weightpick:SizeToContents()
		weightpick:SetWidth(weightpick:GetWide()*0.7)

		local dobpick = self.Content.Scroll:Add("DTextEntry")
		dobpick:SetPos(xes[3], y)
		dobpick:SetSize(doblabel:GetWide()+5, 28)
		dobpick:SetFont("nutSmallFont")
		dobpick:SetText(tbl.data.dob or "")
		dobpick:SizeToContents()
		dobpick:SetWidth(dobpick:GetWide()*0.7)

		local eyepick = self.Content.Scroll:Add("DTextEntry")
		eyepick:SetPos(xes[4], y)
		eyepick:SetSize(doblabel:GetWide()+5, 28)
		eyepick:SetFont("nutSmallFont")
		eyepick:SetText(tbl.data.eye or "")
		eyepick:SizeToContents()
		eyepick:SetWidth(eyepick:GetWide()*0.7)

		y = y+dobpick:GetTall() + 5
		
		local handle = self.Content.Scroll:Add("DButton")
		handle:SetPos(5, y)
		handle:SetSize(80, 22)
		handle:SetFont("nutSmallFont")
		handle:SetText("Submit Bio")
		handle.DoClick = function(sel)
			net.Start("SetPDAData")
			local tbl = {
				["height"] = heightpick:GetValue(),
				["weight"] = weightpick:GetValue(),
				["dob"] = dobpick:GetValue(),
			}
			net.WriteTable(tbl)
			net.WriteInt(id, 21)
			net.SendToServer()
		end
	end
end

function PANEL:CreateLeaderboard() 

    self.Content.Paint = function(self, w, h)
        draw.NoTexture()    --nil should be "nutSmallFont"
        draw.SimpleText("Leaderboard", "nutSmallFont", w/2, 7, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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
    self.Content.Scroll:OpenURL("http://rprstalker.site.nfoservers.com/test/leaderboards.php")
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
    netHandle:DockMargin(2,22.,2,2)
    netHandle:Dock(TOP)
    --setsize
    netHandle:SetFont("nutSmallFont")
    netHandle:SetText("Edit Handle")
    netHandle.DoClick = function(sel)
        Derma_StringRequest(
            "Edit Net Handle",
            "Input a new handle here. Must be at least 3 and no more than 32 characters long.\nNo spaces.\nExtremely vulgar and/or racist names may get removed without warning.",
            "",
            function(text)
                local str = text:gsub("%s+", "")
                if(string.len(str) < 3 or string.len(str) > 32) then
                    nut.util.notify("The handle you input is too short/long.")
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
	
	--clear content and create form, recieve default via GivePDAData with all = false, will be filled out above in dataCreateTable
	--[[
    local dataLabel = vgui.Create("DLabel", self.Content.Scroll)
    dataLabel:SetPos(10,y)
    dataLabel:SetFont("nutSmallFont")
    dataLabel:SetText("Data: Enter various information about yourself in this menu.")
    dataLabel:SizeToContents()
    self.Content.Scroll:AddItem(dataLabel)
    y = y+dataLabel:GetTall() + 5

    local dataButton = vgui.Create("DButton", self.Content.Scroll)
    dataButton:SetPos(10,y)
    dataButton:SetSize(80,22)
    --setsize
    dataButton:SetFont("nutSmallFont")
    dataButton:SetText("Edit Data")
	dataButton.DoClick = function(sel)
		local id = tonumber(LocalPlayer():getCID())--self.pda:getData("simid")
		if(!id) then dataLabel:SetText("Your CID is invalid!") end
		
		PDA_DATA_DISPLAY = nil --just to make 100% sure

		dataLabel:SetText("Retrieving Info Please Wait..")
		dataButton:SetDisabled(true)
		netHandle:SetDisabled(true)
		
		net.Start("GivePDAData")
		net.WriteInt(id, 21)
		net.WriteBool(false)
		net.SendToServer()
    end
    self.Content.Scroll:AddItem(dataButton)
	y = y+dataButton:GetTall() + 5
	]]
end

vgui.Register("pdaPanel", PANEL, "DFrame")