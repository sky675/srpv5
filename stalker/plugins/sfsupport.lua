--make sf work better
--[[
    make it redownload lightmaps on joining i guess on client (may not be needed? do a command for it idk)
    change fog so the fog still hides the render distance but still works with the fog weather type
]]
local PLUGIN = PLUGIN
PLUGIN.name = "stormfox support"
PLUGIN.author = "sky"
PLUGIN.desc = "sets stormfox's time to ns's time"
--sf_maplight_auto 0
--sf_maplight_dynamic 1
--lua_run StormFox2.Time.Set("12:00 PM")
if(StormFox2) then
	if(SERVER) then
		function PLUGIN:OnLoaded()
			timer.Simple(2, function()
				local dt = string.Explode(":", os.date("%H:%M:%S", nut.date.get()))
				StormFox2.Time.Set(dt[1] * 60 + dt[2] + (dt[3] / 60))
				StormFox2.Setting.Set("time_speed", 1) --should set real world speed, doing this because maybe itll stop being unsynced then idk
				print("time set to nutscript date time")
				--id like to believe that the time offset was fixed, but
				--its here anyway, uncomment if it is
				--it was and this causes periodic lag
				--[[timer.Create("fixrealtime", 1200, 0, function()
					--run every 20 mins to fix the time, adjust later to determine exactly when it starts getting offset
					local dt = string.Explode(":", os.date("%H:%M:%S", nut.date.get()))
					StormFox2.Time.Set(dt[1] * 60 + dt[2] + (dt[3] / 60))	
				end)]]
			end)
		end

		hook.Add("PlayerConnect", "sffix", function(ply)
			if(#player.GetAll() == 0) then
				print("it worked! syncing")
				local dt = string.Explode(":", os.date("%H:%M:%S", nut.date.get()))
				StormFox2.Time.Set(dt[1] * 60 + dt[2] + (dt[3] / 60))
			end
		end)
	else
		net.Receive("StormFox2.lightstyle", function(len)
			local c_var = net.ReadUInt(7)
			if last_sv and last_sv == c_var then return end -- No need
			last_sv = c_var
			timer.Simple(1, function()
				render.RedownloadAllLightmaps()
			end)
		end)
		
	end

	return
end
