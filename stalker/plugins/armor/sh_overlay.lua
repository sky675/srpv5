local PLUGIN = PLUGIN

local overlaymats = {
	["gas"] = "sky/overlays/hud_gas1.png",--sunrise, mask
	["hard"] = "sky/overlays/hud_hard1.png", --helm, cs1, cs2
	["tact"] = "sky/overlays/hud_mil1.png", --berill, skat, io7a
	["exo"] = "sky/overlays/hud_exo1.png", --combat
	["sci"] = "sky/overlays/hud_sci1.png", --seva, eco

}

local tp = GetConVar("nut_tp_enabled")
local mov = GetConVar("mask_overlay_en")

if (CLIENT) then
	local NUT_CVAR_MOVOPACITY = CreateClientConVar("nut_mov_opacity", "1", true)

	local PANEL = {}

	local maxValues = {
		height = 30,
		horizontal = 30,
		distance = 100
	}
	function PANEL:Init()
		self:SetTitle("Mask Overlay Configuration")
		self:SetSize(300, 80)
		self:Center()
		self:MakePopup()

		self.list = self:Add("DPanel")
		self.list:Dock(FILL)
		self.list:DockMargin(0, 0, 0, 0)

		local cfg = self.list:Add("DNumSlider")
		cfg:Dock(TOP)
		cfg:SetText("Opacity") // Set the text above the slider
		cfg:SetMin(0)				 // Set the minimum number you can slide to
		cfg:SetMax(1)				// Set the maximum number you can slide to
		cfg:SetDecimals(2)			 // Decimal places - zero for whole number
		cfg:SetConVar("nut_mov_opacity") // Changes the ConVar when you slide
		cfg:DockMargin(10, 0, 0, 5)

	end
	vgui.Register("nutMovConfig", PANEL, "DFrame")

	local allowMovOptions = true

	function PLUGIN:SetupQuickMenu(menu)
		if (allowMovOptions) then
			local button = menu:addButton("Mask Overlay Configuration", function()
				if (nut.gui.movconfig) then
					nut.gui.movconfig:Remove()
					nut.gui.movconfig = nil
				end

				nut.gui.movconfig = vgui.Create("nutMovConfig")
			end)

			menu:addSpacer()
		end
	end
end


hook.Add("RenderScreenspaceEffects", "maskoverlay", function()
	local opacity = GetConVarNumber('nut_mov_opacity')
	local char = LocalPlayer():getChar()
	if(!char or (tp and tp:GetBool())) then return end
	local ovr = char:getData("ovr", "")
	if(overlaymats[ovr]) then
		--render.DrawTextureToScreen(mat:GetTexture("$basetexture"))
		DrawMaterialOverlay(overlaymats[ovr], 0.1)
	end

end)
