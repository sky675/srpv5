local PANEL = {}
	--local gradient = nut.util.getMaterial("vgui/gradient-d")





	function PANEL:Init()
		self:SetSize(256, 36)
		self:SetContentAlignment(6)
		--self:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		self:SetFont("stalkerNotif")
		self:SetTextColor(Color(158,129,12,255))
		self:SetDrawOnTop(true)
		
	end

	function PANEL:SetLevel(level)


		--local oldPaint = self.Paint
		function self:PaintOver(w, h)
			surface.SetDrawColor(255, 255, 255, 255)
			if (level == 1) then
				surface.SetMaterial(Material("sky/greenBar/lights/green.png"))
			elseif (level == 2) then
				surface.SetMaterial(Material("sky/greenBar/lights/yellow.png"))
			elseif (level == 3) then
				surface.SetMaterial(Material("sky/greenBar/lights/red.png"))
			elseif (level == 0) then
				surface.SetMaterial(Material("sky/greenBar/lights/red.png"))
				surface.SetDrawColor(255, 255, 255, 0)
			else
				surface.SetMaterial(Material("sky/greenBar/lights/yellow.png"))
			end
			surface.DrawTexturedRect(5, (h*0.5)-(25*0.5), 26, 25)
		end
	end

	function PANEL:Paint(w, h)
		
		local LCapMat = "sky/greenBar/LCap.png"

		local fullBar = "sky/greenBar/greenBar.png"

		local RCapMat = "sky/greenBar/RCap.png"

		--background bar
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(Material(fullBar))
		surface.DrawTexturedRect(0, 0, 1666, h)

		--left cap material
		surface.SetMaterial(Material(LCapMat))
		surface.DrawTexturedRect(0, 0, 4, h)

		--right cap material
		surface.SetMaterial(Material(RCapMat))
		surface.DrawTexturedRect(self:GetWide()-4, 0, 4, h)

	end
vgui.Register("nutNotice", PANEL, "DLabel")
