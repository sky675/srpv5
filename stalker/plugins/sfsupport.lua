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


PLUGIN.weatherList = PLUGIN.weatherList or {} --list of current weather schedule

nut.command.add("redownloadalllightmaps", {
	desc = "redownload all lightmaps, not very useful anymore lmao",
    onRun = function(client, arguments)
        net.Start("ReDLLM") 
        net.Send(client)
	end
})

if(SERVER) then
	util.AddNetworkString("ReDLLM")
	
--hook.Add("InitPostEntity", "SetSFToNutTime", function()
function PLUGIN:OnLoaded()
	if(StormFox) then
	timer.Simple(2, function()
		local dt = string.Explode(":", os.date("%H:%M:%S", nut.date.get()))
		StormFox.SetTime(dt[1] * 60 + dt[2] + (dt[3] / 60))
		GetConVar("sf_timespeed"):SetFloat(1)--/60) --should set real world speed, doing this because maybe itll stop being unsynced then idk
		print("time set to nutscript date time")
		timer.Create("fixrealtime", 1200, 0, function()
			--run every 20 mins to fix the time, adjust later to determine exactly when it starts getting offset
			local dt = string.Explode(":", os.date("%H:%M:%S", nut.date.get()))
			StormFox.SetTime(dt[1] * 60 + dt[2] + (dt[3] / 60))
			
		end)


	end)
	end
end--)


else
    net.Receive("ReDLLM", function()
        render.RedownloadAllLightmaps()
	end)
end


--should exist by now right?
if(StormFox) then
sfcereate = sfcereate or false

if(!sfcereate) then 
	sfcereate = true

	--adding a "foggy rain" type
RainStorm = StormFox.WeatherType( "foggyrain" )
local max = math.max
RainStorm.CanGenerate = true
RainStorm.StormMagnitudeMin = 0.13
RainStorm.MaxLength = 1440 / 3
RainStorm.GenerateCondition = function()
	return GetConVar("sf_enablefog"):GetBool() and math.random(4) >= 2
end

RainStorm.TimeDependentGenerate = {340,400}

RainStorm.TimeDependentData.SkyTopColor = {
	TIME_SUNRISE = Color(3.0, 2.9, 3.5),
	TIME_SUNSET = Color(0.4, 0.2, 0.54),
}

local rc = Color(143,148,152)
local a,aa = 0.1,0.4
RainStorm.TimeDependentData.SkyBottomColor = {
	TIME_SUNRISE = Color(rc.r * aa,rc.g * aa,rc.b * aa),
	TIME_SUNSET = Color(rc.r * a,rc.g * a,rc.b * a),
}

RainStorm.TimeDependentData.DuskColor = {
	TIME_SUNRISE = Color(3, 2.9, 3.5),
	TIME_SUNSET = Color(3, 2.5, .54),
	TIME_NIGHT = Color(.4, .2, .54)
}

RainStorm.TimeDependentData.DuskScale = {
	TIME_SUNRISE = 1,
	TIME_SUNSET = 0.26,
	TIME_NIGHT = 0
}

RainStorm.TimeDependentData.HDRScale = {
	TIME_SUNRISE = 0.33,
	TIME_SUNSET = 0.1
}

RainStorm.DataCalculationFunctions.Fogdensity = function(flPercent)
	return 0.50 + 0.49 * flPercent
end
RainStorm.DataCalculationFunctions.Fogend = function(flPercent)
	local tv = StormFox.GetTimeEnumeratedValue()
	if tv == "TIME_SUNRISE" or tv == "TIME_NOON" then
		--day
		return 8000 - 7800*flPercent
	else
		--night
		return 8000 - 6900*flPercent
	end
end
RainStorm.DataCalculationFunctions.Fogstart = function(flPercent)
	local tv = StormFox.GetTimeEnumeratedValue()
	local rp = 1 - flPercent
	if tv == "TIME_SUNRISE" or tv == "TIME_NOON" then
		--day
		return 4000 * rp
	else
		--night
		return 2000 * rp
	end
end

RainStorm.TimeDependentData.MapBloom = {
	TIME_SUNRISE = 1.1,
	TIME_SUNSET = 1.3
}
RainStorm.TimeDependentData.MapBloomMax = {
	TIME_SUNRISE = 0.3,
	TIME_SUNSET = 1.3
}

RainStorm.CalculatedData.MapDayLight = 12.5
RainStorm.CalculatedData.MapNightLight = 0
RainStorm.CalculatedData.Gauge = 10

RainStorm.CalculatedData.SunColor = Color(255,255,255,15)
RainStorm.CalculatedData.CloudsAlpha = 255

RainStorm.DataCalculationFunctions.StarFade = function( flPercent ) return max( 1 - flPercent * 10, 0 ) end
RainStorm.DataCalculationFunctions.SunSize = function( flPercent ) return max( 0, 10 - ( 10 * flPercent ) ) end
RainStorm.DataCalculationFunctions.MoonVisibility = function( flPercent ) return 100 - flPercent * 90 end

RainStorm.StaticData.GaugeColor = Color(255,255,255)
RainStorm.StaticData.EnableThunder = true
RainStorm.StaticData.EnableSnow = true
RainStorm.StaticData.RainTexture = Material("stormfox/raindrop.png","noclamp smooth")
RainStorm.StaticData.RainMultiTexture = Material("stormfox/raindrop-multi.png","noclamp smooth")
RainStorm.StaticData.SnowTexture = Material("particle/snow")
RainStorm.StaticData.SnowMultiTexture = Material("stormfox/snow-multi.png","noclamp smooth")

local snd = {
	"stormfox/footstep/footstep_snow0.ogg",
	"stormfox/footstep/footstep_snow1.ogg",
	"stormfox/footstep/footstep_snow2.ogg",
	"stormfox/footstep/footstep_snow3.ogg",
	"stormfox/footstep/footstep_snow4.ogg",
	"stormfox/footstep/footstep_snow5.ogg",
	"stormfox/footstep/footstep_snow6.ogg",
	"stormfox/footstep/footstep_snow7.ogg",
	"stormfox/footstep/footstep_snow8.ogg",
	"stormfox/footstep/footstep_snow9.ogg"
}
-- Temp: -2 = 0.3, -6 = 1
function RainStorm.DataCalculationFunctions.MapMaterial(amount,temp)
	if temp > -2 then -- Rain
		return
	end
	local lvl = round(amount * 3) * min(max(temp * -0.166,0),1)
	return "nature/snowfloor001a",lvl,snd -- ,"nature/snowfloor002a","nature/snowfloor003a" doesn't look seemless together
end

function RainStorm:GetName( nTemperature, nWindSpeed, bThunder )
		nWindSpeed = nWindSpeed or StormFox.GetNetworkData("Wind",0)
		bThunder = bThunder or StormFox.GetNetworkData("Thunder",false)
		nTemperature = nTemperature or StormFox.GetNetworkData("Temperature",20)
	if nWindSpeed >= 10 then
		return "Foggy Storm"
	end
	if bThunder then return "Foggy Thunder" end
	return ( nTemperature < 4 and nTemperature >=0 ) and "Foggy Sleet"
		or ( nTemperature < 0 and "Foggy Snowing" or "Foggy Raining" )
end

local m = Material("stormfox/symbols/Raining.png")
local m2 = Material("stormfox/symbols/Raining - Thunder.png")
local m3 = Material("stormfox/symbols/RainingSnowing.png")
local m4 = Material("stormfox/symbols/Snowing.png")
local m5 = Material("stormfox/symbols/Raining - Windy.png")
function RainStorm:GetIcon( nTemperature, nWindSpeed, bThunder )
		nWindSpeed = nWindSpeed or StormFox.GetNetworkData("Wind",0)
		bThunder = bThunder or StormFox.GetNetworkData("Thunder",false)
		nTemperature = nTemperature or StormFox.GetNetworkData("Temperature",20)
	if bThunder then return m2 end
	if nWindSpeed > 14 then return m5 end
	if nTemperature < 0 then return m4 end
	if nTemperature < 4 then return m3 end
	return m
end
function RainStorm:GetStaticIcon()
	return m
end

StormFox.AddWeatherType( RainStorm ) --end foggy rain generation
end --end weather type creation

for k,v in pairs(StormFox.WeatherTypes) do
	if(v.MaxLength) then
	v.MaxLength = v.MaxLength/2 --half their lengths, they wont go on forever?
	end
end

	--stalker edit: 6500 fogstart, 9900 fogend
	if(game.GetMap() == "rp_stalker_resurgence") then
        for k,v in pairs(StormFox.WeatherTypes) do
			v.TimeDependentData.Fogdensity = {}
            v.TimeDependentData.Fogdensity["TIME_SUNRISE"] = 1
			v.TimeDependentData.Fogdensity["TIME_SUNSET"] = 1
			
            if(k == "clear") then
				v.TimeDependentData.Fogend = {}
                v.TimeDependentData.Fogend["TIME_SUNRISE"] = 9900
                v.TimeDependentData.Fogend["TIME_SUNSET"] = 9900
                v.TimeDependentData.Fogstart = 6500
                --v.TimeDependentData.Fogcolor = Color(123, 146, 169)
            end
            if(k == "cloudy") then
				v.TimeDependentData.Fogend = {}
                v.TimeDependentData.Fogend["TIME_SUNRISE"] = 9900
                v.TimeDependentData.Fogend["TIME_SUNSET"] = 9900
                v.TimeDependentData.Fogstart = 6500
				--v.TimeDependentData.Fogcolor = Color(71, 76, 79)
            end
            if(k == "foggy") then
				v.TimeDependentData.Fogend = {}
                v.TimeDependentData.Fogend["TIME_SUNRISE"] = 6500
                v.TimeDependentData.Fogend["TIME_SUNSET"] = 6500
                v.TimeDependentData.Fogstart = 4500
                --v.TimeDependentData.Fogcolor = Color(123, 146, 169)
            end
            if(k == "foggyrain") then
				v.TimeDependentData.Fogend = {}
                v.TimeDependentData.Fogend["TIME_SUNRISE"] = 6500
                v.TimeDependentData.Fogend["TIME_SUNSET"] = 6500
                v.TimeDependentData.Fogstart = 4500
                --v.TimeDependentData.Fogcolor = Color(123, 146, 169)
            end
            if(k == "rain") then
				v.TimeDependentData.Fogend = {}
                v.TimeDependentData.Fogend["TIME_SUNRISE"] = 9000
				v.TimeDependentData.Fogend["TIME_SUNSET"] = 9000
				v.TimeDependentData.Fogstart = {}
                v.TimeDependentData.Fogstart["TIME_SUNRISE"] = 6500
                v.TimeDependentData.Fogstart["TIME_SUNSET"] = 6500
                --v.TimeDependentData.Fogcolor = Color(38, 44, 51)
            end
		end
	end

    --4000 farz
    if(game.GetMap() == "rp_necro_evocity_v33x_final") then
        for k,v in pairs(StormFox.WeatherTypes) do
            v.TimeDependentData.Fogdensity["TIME_SUNRISE"] = 1
            v.TimeDependentData.Fogdensity["TIME_SUNSET"] = 1
    
            if(k == "clear") then
                v.TimeDependentData.Fogend["TIME_SUNRISE"] = 3700
                v.TimeDependentData.Fogend["TIME_SUNSET"] = 3700
                v.TimeDependentData.Fogstart = 1800
                --v.TimeDependentData.Fogcolor = Color(123, 146, 169)
            end
            if(k == "cloudy") then
                v.TimeDependentData.Fogend["TIME_SUNRISE"] = 3200
                v.TimeDependentData.Fogend["TIME_SUNSET"] = 2800
                v.TimeDependentData.Fogstart["TIME_SUNRISE"] = 1600
                v.TimeDependentData.Fogstart["TIME_SUNSET"] = 1600
                --v.TimeDependentData.Fogcolor = Color(71, 76, 79)
            end
            if(k == "foggy") then
                v.TimeDependentData.Fogend["TIME_SUNRISE"] = 2000
                v.TimeDependentData.Fogend["TIME_SUNSET"] = 2100
                v.TimeDependentData.Fogstart = 1400
                --v.TimeDependentData.Fogcolor = Color(123, 146, 169)
            end
            if(k == "radioactive") then
                v.TimeDependentData.Fogend["TIME_SUNRISE"] = 3000
                v.TimeDependentData.Fogend["TIME_SUNSET"] = 2800
                v.TimeDependentData.Fogstart["TIME_SUNRISE"] = 1800
                v.TimeDependentData.Fogstart["TIME_SUNSET"] = 1800
            end
            if(k == "rain") then
                v.TimeDependentData.Fogend["TIME_SUNRISE"] = 3050
                v.TimeDependentData.Fogend["TIME_SUNSET"] = 2700
                v.TimeDependentData.Fogstart["TIME_SUNRISE"] = 1550
                v.TimeDependentData.Fogstart["TIME_SUNSET"] = 1550
                --v.TimeDependentData.Fogcolor = Color(38, 44, 51)
            end
		end
	elseif(game.GetMap() == "rp_city8_neo_v1") then
		for k,v in pairs(StormFox.WeatherTypes) do
            if(k == "foggy") then
                v.TimeDependentData.Fogend["TIME_SUNRISE"] = 620
                v.TimeDependentData.Fogend["TIME_SUNSET"] = 560
                v.TimeDependentData.Fogstart = -1000
				v.CalculatedData.CloudsAlpha = 255 --i think this is all needed for cloudy
                --v.TimeDependentData.Fogcolor = Color(123, 146, 169)
			end
			if(k == "clear") then
				--this is literally just the stuff for cloudy
				local v = v --huh? not sure why it was a number value, or why this stuff was called again
				--v.StormMagnitudeMin = 0.13
				--v.StormMagnitudeMax = 0.8
				--[[
				v.TimeDependentData.SkyTopColor = {
					TIME_SUNRISE = Color(3.0, 2.9, 3.5),
					TIME_SUNSET = Color(0.4, 0.2, 0.54),
				}

				v.TimeDependentData.SkyBottomColor = {
					TIME_SUNRISE = Color(3.0, 2.9, 3.5),
					TIME_SUNSET = Color(0, 0.15, 0.525),
				}
				]]
				v.TimeDependentData.DuskColor = {
					TIME_SUNRISE = Color(3, 2.9, 3.5),
					TIME_SUNSET = Color(3, 2.5, .54),
					TIME_NIGHT = Color(.4, .2, .54)
				}

				v.TimeDependentData.DuskScale = {
					TIME_SUNRISE = 1,
					TIME_SUNSET = 0.26,
					TIME_NIGHT = 0
				}

				v.TimeDependentData.HDRScale = {
					TIME_SUNRISE = 0.33,
					TIME_SUNSET = 0.1
				}

				v.TimeDependentData.Fogdensity = {
					TIME_SUNRISE = 0.9,
					TIME_SUNSET = 0.95
				}

				v.TimeDependentData.Fogstart = {
					TIME_SUNRISE = 0,
					TIME_SUNSET = -1000
				}

				v.TimeDependentData.Fogend = {
					TIME_SUNRISE = 54000,
					TIME_SUNSET = 30000
				}
				--v.CalculatedData.MapDayLight = 25
				--v.CalculatedData.MapNightLight = 0
				v.CalculatedData.CloudsAlpha = 255

				v.CalculatedData.SunColor = Color(255,255,255,15)
				local max = math.max

				v.DataCalculationFunctions.StarFade = function( flPercent ) return max( 1 - flPercent * 5, 0 ) end
				v.DataCalculationFunctions.SunSize = function( flPercent ) return max( 0, 10 - ( 10 * flPercent ) ) end
				v.DataCalculationFunctions.MoonVisibility = function( flPercent ) return 100 - flPercent * 90 end

				--v.StaticData.EnableThunder = true

				function v:GetName( nTemperature, nWindSpeed, bThunder  )
					if bThunder then return "Thunder" end

					return "Cloudy"
				end

				local m = Material("stormfox/symbols/Cloudy.png")
				local m2 = Material("stormfox/symbols/Thunder.png")
				local m3 = Material("stormfox/symbols/Cloudy_Windy.png")
				local m4 = Material("stormfox/symbols/Night - Cloudy.png")
				function v:GetIcon(_, nWindSpeed, bThunder )
					bThunder = bThunder or StormFox.GetNetworkData("Thunder",false)
					nWindSpeed = nWindSpeed or StormFox.GetNetworkData("Wind",0)
					if bThunder then return m2 end
					if nWindSpeed > 14 then return m3 end
					local flTime = StormFox.GetTime()
					local bIsNight = flTime < 340 or flTime > 1075
					return bIsNight and m4 or m
				end

				function v:GetStaticIcon()
					return m
				end
			end
		end
		
    else --default
    --[[for k,v in pairs(StormFox.WeatherTypes) do
        v.TimeDependentData.Fogdensity["TIME_SUNRISE"] = 1
        v.TimeDependentData.Fogdensity["TIME_SUNSET"] = 1

        if(k == "clear") then
            v.TimeDependentData.Fogend["TIME_SUNRISE"] = 4800
            v.TimeDependentData.Fogend["TIME_SUNSET"] = 4800
            v.TimeDependentData.Fogstart = 2000
        end
        if(k == "cloudy") then
            v.TimeDependentData.Fogend["TIME_SUNRISE"] = 4400
            v.TimeDependentData.Fogend["TIME_SUNSET"] = 4000
            v.TimeDependentData.Fogstart["TIME_SUNRISE"] = 1800
            v.TimeDependentData.Fogstart["TIME_SUNSET"] = 1800
        end
        if(k == "foggy") then
            v.TimeDependentData.Fogend["TIME_SUNRISE"] = 2700
            v.TimeDependentData.Fogend["TIME_SUNSET"] = 2800
            v.TimeDependentData.Fogstart = 1500
        end
        if(k == "radioactive") then
            v.TimeDependentData.Fogend["TIME_SUNRISE"] = 4000
            v.TimeDependentData.Fogend["TIME_SUNSET"] = 3600
            v.TimeDependentData.Fogstart["TIME_SUNRISE"] = 1800
            v.TimeDependentData.Fogstart["TIME_SUNSET"] = 1800
        end
        if(k == "rain") then
            v.TimeDependentData.Fogend["TIME_SUNRISE"] = 4500
            v.TimeDependentData.Fogend["TIME_SUNSET"] = 4000
            v.TimeDependentData.Fogstart = 1800 --["TIME_SUNRISE"] = 1800
            v.TimeDependentData.Fogstart = 1800 --["TIME_SUNSET"] = 1800
        end
	end]]
end
end