local PLUGIN = PLUGIN

--disable current scoreboard plugin
hook.Add("PluginShouldLoad", "disablescoreboard", function(id)
	if(id == "scoreboard") then return false end
end)

if(SERVER) then
	--get info for page
	netstream.Hook("reqlist", function(ply)
		local tbl = {}

		--go through all players
		for k,ply in ipairs(player.GetAll()) do
			local got = false
			if(ply:getChar()) then
				local char = ply:getChar()
				for _,item in pairs(char:getInv():getItems()) do
					if(item.base == "base_npda" and !item:getData("isoff")) then
						if(char:getData("activePDA") and item.id == char:getData("activePDA")) then
							got = true
							--active pda
							tbl[#tbl+1] = {
								["handle"] = item:getData("pdahandle", "invalid"),
								["title"] = item:getData("pdatitle", ""),
								["avail"] = "active" --todo different statuses
							}
						elseif(!char:getData("activePDA") and !got) then
							tbl[#tbl+1] = {
								["handle"] = item:getData("pdahandle", "invalid"),
								["title"] = item:getData("pdatitle", ""),
								["avail"] = "active" --todo different statuses
							}
						else--inactive pda
							tbl[#tbl+1] = {
								["handle"] = item:getData("pdahandle", "invalid"),
								["title"] = item:getData("pdatitle", ""),
								["avail"] = "idle"
							}
							
						end
					end
				end
			end
		end
		--then find storages (both of these should have a unique status)
		for k,v in ipairs(ents.FindByClass("nut_storage")) do
			for _,item in pairs(v:getInv():getItems()) do
				if(item.base == "base_npda" and !item:getData("isoff")) then
					tbl[#tbl+1] = {
						["handle"] = item:getData("pdahandle", "invalid"),
						["title"] = item:getData("pdatitle", ""),
						["avail"] = "idle"
					}
				end
			end
		end
		--then find ents
		for k,v in ipairs(ents.FindByClass("nut_item")) do
			local item = nut.item.instances[v.nutItemID]
			if(item.base == "base_npda" and !item:getData("isoff")) then
				tbl[#tbl+1] = {
					["handle"] = item:getData("pdahandle", "invalid"),
					["title"] = item:getData("pdatitle", ""),
					["avail"] = "idle"
				}
			end
		end


		netstream.Start(ply, "addlist", tbl)
	end)

else--client
	netstream.Hook("addlist", function(tbl)
		if(IsValid(nut.gui.pda) && nut.gui.pda:IsVisible()) then
			local pda = nut.gui.pda
			pda.tabs[2]:UpdateScoreboard(tbl)
		end
	end)
	--unhide/create pda
	hook.Add("ScoreboardHide", "aaahide", function()--function PLUGIN:ScoreboardHide()
		--if (IsValid(nut.gui.pda)) then
		--	nut.gui.pda:DisablePDA()
		--	CloseDermaMenus()
		--end
		--print("hide")

		return true
	end)

	hook.Add("ScoreboardShow", "aaashow", function() --function PLUGIN:ScoreboardShow()
		return true

	end)

	local nxtTh = 0
	hook.Add("Think", "aaatogglepls", function()
		local ct = CurTime()
		if(nxtTh > ct) then return end
		
		if(input.IsKeyDown(KEY_TAB) and (!nut.gui.menu or !nut.gui.menu:IsVisible())) then
			local pd = LocalPlayer():GetPDA()
			if(!pd or LocalPlayer():getNetVar("typing")) then nxtTh = ct + 0.5 return true end

			if (IsValid(nut.gui.pda)) then
				--get active pda
				--hopefully this makes it a toggle?
				if(nut.gui.pda:IsVisible()) then
					nut.gui.pda:DisablePDA()
				else
					nut.gui.pda:Reset(pd)
				end
			else
				nut.gui.pda = vgui.Create("pdaPanel")
				nut.gui.pda.pda = pd
			end

			nxtTh = ct + 0.5
		end
	end)

	function PLUGIN:OnReloaded()
		-- Reload the scoreboard.
		if (IsValid(nut.gui.pda) && nut.gui.pda:IsVisible()) then
			nut.gui.pda:DisablePDA()
		end
	end
end