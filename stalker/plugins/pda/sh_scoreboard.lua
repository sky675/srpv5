local PLUGIN = PLUGIN

--disable current scoreboard plugin
hook.Add("PluginShouldLoad", "disablescoreboard", function(id)
	if(id == "scoreboard") then return false end
end)

if(SERVER) then
	--get info for page

else--client
	--unhide/create pda
	hook.Add("ScoreboardHide", "aaahide", function()--function PLUGIN:ScoreboardHide()
		if (IsValid(nut.gui.pda)) then
			nut.gui.pda:DisablePDA()
			CloseDermaMenus()
		end

		return true
	end)

	hook.Add("ScoreboardShow", "aaashow", function() --function PLUGIN:ScoreboardShow()
		local pd = LocalPlayer():GetPDA()
		if(!pd) then return true end
		if (IsValid(nut.gui.pda) && nut.gui.pda:IsVisible()) then
			--get active pda
			nut.gui.pda:Reset(pd)
		else
			nut.gui.pda = vgui.Create("pdaPanel")
			nut.gui.pda.pda = pd
		end

		return true
	end)

	function PLUGIN:OnReloaded()
		-- Reload the scoreboard.
		if (IsValid(nut.gui.pda) && nut.gui.pda:IsVisible()) then
			nut.gui.pda:DisablePDA()
		end
	end
end