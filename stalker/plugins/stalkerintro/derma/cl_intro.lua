local gradient = nut.util.getMaterial("vgui/gradient-r.vtf")
local glow = surface.GetTextureID("particle/Particle_Glow_04_Additive")


netstream.Hook("langDisclaimer", function(discTable)
	local disclaimersTbl = discTable
	print("disclaimer table exists...")
	PrintTable(disclaimersTbl)
	local self = nut.gui.intro

	self.disclaimers = {}
	for k, v in ipairs(disclaimersTbl) do
		self.disclaimers[k] = self:Add("DLabel")
		self.disclaimers[k]:SetFont("nutCharButtonFont")
		self.disclaimers[k]:SetColor(Color(235, 100, 52, 255))
		self.disclaimers[k]:SetText(v)
		self.disclaimers[k]:SetTall(36)
		self.disclaimers[k]:SizeToContents()
		self.disclaimers[k]:CenterHorizontal()
		self.disclaimers[k]:SetY(36+36*k)
	end


end)


local PANEL = {}

	function PANEL:Init()

		if (IsValid(nut.gui.intro)) then
			nut.gui.intro:Remove()
		end

		netstream.Start("ipgive")

		nut.gui.intro = self

		self:SetSize(ScrW(), ScrH())
		self:SetZPos(9997)

		local url = "http://stalker-kolobok.com/intro/intro.html"
		self.sound = CreateSound(LocalPlayer(), "intro/intro_audio.mp3")
		self.sound:Play()
		self.info = self:Add("DLabel")
		self.info:SetTall(36)
		self.info:DockMargin(0, 0, 0, 5)
		self.info:SetText("Developed by SKY & NATE")
		self.info:SetFont("stalkerCharButtonFont")
		self.info:SizeToContents()
		self.info:Center()
		if (IsValid(nut.gui.intro)) then
		timer.Simple(16, function()
			if(IsValid(self)) then
				self.info:SetText("Nutscript created by Chessnut & Black Tea")
				self.info:SizeToContents()
				self.info:Center()
		
			end
		end)
		end
		
		timer.Simple(22, function()

			if(IsValid(self)) then
				self.background = self:Add("HTML")
				
				self.background:SetSize(ScrW(), ScrH())
				self.background:OpenURL(url)
				self.background.OnDocumentReady = function(background)
					
					self.info:Remove()
		
					self.background:SetAlpha(255)
					timer.Simple(0.1, function()
						self.background:SetSize(ScrW(), ScrH())
						--print("screen size: " .. ScrW() ..", " .. ScrH() .. " dhtml size: " .. self.background:GetWide() .. ", " .. self.background:GetTall())
						if (!IsValid(self)) then
							return
						end

						--self.sound:ChangePitch(80, 0)
					end)
					timer.Simple(67, function()

						if(IsValid(self)) then
							
							self.closing = true
							self:Remove()
						end
					end)
				end
			end
		end)

		-- self.bgLoader = self:Add("DPanel")
		-- self.bgLoader:SetSize(ScrW(), ScrH())
		-- self.bgLoader:SetZPos(9997)
		-- self.bgLoader.Paint = function(loader, w, h)
		-- 	surface.SetDrawColor(20, 20, 20)
		-- 	surface.DrawRect(0, 0, w, h)
		-- end

		timer.Simple(13, function()
			if (IsValid(self)) then
				self:addContinue()
			end
		end)
	end


	

	function PANEL:addContinue()
		self.info = self:Add("DLabel")
		self.info:SetZPos(9999)
		self.info:SetTall(36)
		self.info:SetText("Space to Skip ▶")
		self.info:SetFont("stalkerCharButtonFont")
		self.info:SetContentAlignment(2)
		self.info:SizeToContents()
		self.info:SetPos((ScrW()-self.info:GetWide()-20), ScrH()-self.info:GetTall())
		self.info:SetAlpha(0)
		self.info:AlphaTo(200, 2, 0)
		self.info:SetExpensiveShadow(1, color_black)
	end

	function PANEL:Think()
		if (IsValid(self.info) and input.IsKeyDown(KEY_SPACE) and !self.closing) then
			self.closing = true
			self:Remove()
		end
	end

	function PANEL:OnRemove()
		if (self.sound) then
			self.sound:FadeOut(1)
			self.sound = nil

			if (IsValid(nut.gui.char)) then
				nut.gui.char:playMusic()
			end
		end

	end

	function PANEL:Paint(w, h)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawRect(0, 0, w, h)

		-- if (self.glow) then
		-- 	self.delta = math.Approach(self.delta, 100, FrameTime() * 10)

		-- 	local x, y = ScrW()*0.5 - 700, ScrH()*0.5 - 340

		-- 	surface.SetDrawColor(self.delta, self.delta, self.delta, self.delta + math.sin(RealTime() * 0.7)*10)
		-- 	surface.SetTexture(glow)
		-- 	surface.DrawTexturedRect(x, y, 1400, 680)
		-- end
	end
vgui.Register("nutIntro", PANEL, "EditablePanel")
