local PANEL = {}

PANEL.tabLabel = "Settings"

function PANEL:Init()


	local y = 10
	self.netHandleLabel = self:Add("DLabel")
	self.netHandleLabel:SetPos(10,y)
	self.netHandleLabel:SetFont("nutSmallFont")
	self.netHandleLabel:SetText("Net Handle: Your handle on the network and it's related services.")
	self.netHandleLabel:DockMargin(2,18,2,2)
	self.netHandleLabel:Dock(TOP)
	self.netHandleLabel:SetWrap(true)
	self.netHandleLabel:SetAutoStretchVertical(true)

	y = y+self.netHandleLabel:GetTall() + 22

	self.netHandle = self:Add("DButton")
	self.netHandle:SetPos(10,y)
	self.netHandle:SetSize(ScrW()*0.15, 22)--80,22)
	self.netHandle:DockMargin(2,22,2,2)
	self.netHandle:Dock(TOP)
	--setsize
	self.netHandle:SetFont("nutSmallFont")
	self.netHandle:SetText("Edit Handle")
	self.netHandle.DoClick = function(sel)
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
				print("Your result was "..str)

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

	y = y + self.netHandle:GetTall() + 5
	
	self.titleLabel = self:Add("DLabel")
	self.titleLabel:SetPos(10,y)
	self.titleLabel:SetFont("nutSmallFont")
	self.titleLabel:SetText("Title Message: A short message other online users can see.")
	self.titleLabel:DockMargin(2,7,2,2)
	self.titleLabel:Dock(TOP)
	self.titleLabel:SetWrap(true)
	self.titleLabel:SetAutoStretchVertical(true)


	y = y + self.titleLabel:GetTall() + 22

	self.titleBut = self:Add("DButton")
	self.titleBut:SetPos(10,y)
	self.titleBut:SetSize(ScrW()*0.15, 22)--80,22)
	self.titleBut:DockMargin(2,22,2,2)
	self.titleBut:Dock(TOP)
	--setsize
	self.titleBut:SetFont("nutSmallFont")
	self.titleBut:SetText("Edit Title")
	self.titleBut.DoClick = function(sel)
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

	y = y + self.titleBut:GetTall() + 5
	
	self.partyLabel = self:Add("DLabel")
	self.partyLabel:SetPos(10,y)
	self.partyLabel:SetFont("nutSmallFont")
	self.partyLabel:SetText("Party Channel ID: The ID of the channel you're using for /pdaparty.")
	self.partyLabel:DockMargin(2,7,2,2)
	self.partyLabel:Dock(TOP)
	--netHandleLabel:SetWide(self.Content.Scroll:GetWide())
	self.partyLabel:SetWrap(true)
	self.partyLabel:SetAutoStretchVertical(true)
	--pdaLabel:SizeToContents()


	y = y + self.partyLabel:GetTall() + 22

	self.partyBut = self:Add("DButton")
	self.partyBut:SetPos(10,y)
	self.partyBut:SetSize(ScrW()*0.15, 22)--80,22)
	self.partyBut:DockMargin(2,22,2,2)
	self.partyBut:Dock(TOP)
	--setsize
	self.partyBut:SetFont("nutSmallFont")
	self.partyBut:SetText("Edit Channel")
	self.partyBut.DoClick = function(sel)
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
	y = y + self.partyBut:GetTall() + 5

	self.colorLabel = self:Add("DLabel")
	self.colorLabel:SetPos(10,y)
	self.colorLabel:SetFont("nutSmallFont")
	self.colorLabel:SetText("Color Status: If ORIGINAL, your handle color is white. If FACTION, it will be your factions main color.")
	self.colorLabel:DockMargin(2,7,2,2)
	self.colorLabel:Dock(TOP)
	--netHandleLabel:SetWide(self.Content.Scroll:GetWide())
	self.colorLabel:SetWrap(true)
	self.colorLabel:SetAutoStretchVertical(true)
	--pdaLabel:SizeToContents()


	y = y + self.colorLabel:GetTall() + 22

	self.colorBut = self:Add("DButton")
	self.colorBut:SetPos(10,y)
	self.colorBut:SetSize(ScrW()*0.15, 22)--80,22)
	self.colorBut:DockMargin(2,22,2,2)
	self.colorBut:Dock(TOP)
	--setsize
	self.colorBut:SetFont("nutSmallFont")
	self.colorBut:SetText("Edit Setting")
	self.colorBut.DoClick = function(sel)
		local cur = self.pda:getData("color", false)
		cur = !cur
		net.Start("ChangePDAColor")
		net.WriteBool(cur)
		net.WriteInt(self.pda.id, 32)
		net.SendToServer()
		nut.util.notify("Color setting set to "..(cur and "FACTION" or "ORIGINAL"))
	end
	y = y + self.colorBut:GetTall() + 5
end

function PANEL:onDisplay()
    self.pda = nut.gui.pda:getPDA()

    self.netHandleLabel.PaintOver = function(sel,w,h)
		DisableClipping(true)   --replace temp with self.pda:getData("pdahandle", "invalid")
		draw.SimpleText("Your current handle: "..self.pda:getData("pdahandle", "invalid"), "nutSmallFont", 0, h+15, Color(200,200,200,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		DisableClipping(false)
	end

    self.titleLabel.PaintOver = function(sel,w,h)
		DisableClipping(true)   --replace temp with self.pda:getData("pdahandle", "invalid")
		draw.SimpleText("Your current title: "..self.pda:getData("pdatitle", ""), "nutSmallFont", 0, h+15, Color(200,200,200,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		DisableClipping(false)
	end

    self.partyLabel.PaintOver = function(sel,w,h)
		DisableClipping(true)   --replace temp with self.pda:getData("pdahandle", "invalid")
		draw.SimpleText("Your current channel: "..self.pda:getData("partych", ""), "nutSmallFont", 0, h+15, Color(200,200,200,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		DisableClipping(false)
	end

    self.colorLabel.PaintOver = function(sel,w,h)
		DisableClipping(true)   --replace temp with self.pda:getData("pdahandle", "invalid")
		draw.SimpleText("Your color setting: "..(self.pda:getData("color", false) and "FACTION" or "ORIGINAL"), "nutSmallFont", 0, h+15, Color(200,200,200,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
		DisableClipping(false)
	end
end

vgui.Register("pdaSettings", PANEL, "stalkerPdaTab")
