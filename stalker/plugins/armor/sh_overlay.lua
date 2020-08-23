local PLUGIN = PLUGIN

local overlaymats = {
	["gas"] = "sky/overlays/hud_gas1.png",--sunrise, mask
	["hard"] = "sky/overlays/hud_hard1.png", --helm, cs1, cs2
	["tact"] = "sky/overlays/hud_mil1.png", --berill, skat, io7a
	["exo"] = "sky/overlays/hud_exo1.png", --combat
	["sci"] = "sky/overlays/hud_sci1.png", --seva, eco

}

local tp = GetConVar("nut_tp_enabled")

hook.Add("RenderScreenspaceEffects", "maskoverlay", function()
	local char = LocalPlayer():getChar()
	if(!char or (tp and tp:GetBool())) then return end
	local ovr = char:getData("ovr", "")
	if(overlaymats[ovr]) then
		--render.DrawTextureToScreen(mat:GetTexture("$basetexture"))
		DrawMaterialOverlay(overlaymats[ovr], 0.1)
	end

end)
