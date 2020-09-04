local PLUGIN = PLUGIN
PLUGIN.name = "Blowout"
PLUGIN.author = "sky"
PLUGIN.desc = "adds a custom blowout sequence"

--per map spawn/end points for wave and such
local spawnPoints = {
	["arp_raspad_ep4_1"] = {
		xory = "x",
		pos = true, --if false goes negative
		spawn = -9176.97, --the x point to start at
		add = 9176.97, --makes calculations always positive
		done = 11768.96, --the x point to end at
		wavemulti = 620, --how fast it travels
	},
	["rp_limansk_cs"] = {
		xory = "y",
		pos = false, --if false, goes negative
		spawn = 10959.96, --the x point to start at
		add = 16127.97, --makes calculations always positive
		done = -16127.97, --the x point to end at
		wavemulti = 1220, --how fast it travels
	},
	["rp_stalker_resurgence"] = {
		xory = "y",
		pos = false, --if false, goes negative
		spawn = 14335.96, --the x point to start at
		add = 14335.96, --makes calculations always positive
		done = -14335.96, --the x point to end at
		wavemulti = 1220, --how fast it travels
	}
}
util.PrecacheSound("blowout/blowout_siren.ogg")
util.PrecacheSound("blowout/blowout_begin.ogg")
util.PrecacheSound("blowout/blowout_begin_02.ogg")
util.PrecacheSound("blowout/blowout_wave_01.ogg")
util.PrecacheSound("blowout/blowout_wave_02.ogg")
util.PrecacheSound("blowout/blowout_wave_03.ogg")
util.PrecacheSound("blowout/blowout_wave_04.ogg")
util.PrecacheSound("blowout/blowout_wave_04.ogg")
util.PrecacheSound("blowout/blowout_hit_03.ogg")
util.PrecacheSound("blowout/blowout_rumble.wav")
util.PrecacheSound("blowout/blowout_particle_wave.wav")

local bbegins = {
	"blowout/blowout_begin.ogg", "blowout/blowout_begin_02.ogg", 
}
local bhits = {
	"blowout/blowout_impact.ogg", "blowout/blowout_impact_02.ogg", 
}
local bwaves = {
	"blowout/blowout_wave_01.ogg", "blowout/blowout_wave_02.ogg", 
	"blowout/blowout_wave_03.ogg", "blowout/blowout_wave_04.ogg", 

}

--shit frmo the wiki
local LoadedSounds
if CLIENT then
	LoadedSounds = {} -- this table caches existing CSoundPatches
end

local function ReadSound( FileName )
	local sound
	local filter
	if SERVER then
		filter = RecipientFilter()
		filter:AddAllPlayers()
	end
	if SERVER or !LoadedSounds[FileName] then
		-- The sound is always re-created serverside because of the RecipientFilter.
		sound = CreateSound( game.GetWorld(), FileName, filter ) -- create the new sound, parented to the worldspawn (which always exists)
		if sound then
			sound:SetSoundLevel( 0 ) -- play everywhere
			if CLIENT then
				LoadedSounds[FileName] = { sound, filter } -- cache the CSoundPatch
			end
		end
	else
		sound = LoadedSounds[FileName][1]
		filter = LoadedSounds[FileName][2]
	end
	if sound then
		if CLIENT then
			sound:Stop() -- it won't play again otherwise
		end
		sound:Play()
	end
	return sound -- useful if you want to stop the sound yourself
end

	local wavex = wavex or nil
	local wavesound = wavesound or nil
	local wavemoving = false
local function DoWave()
	if(wavesound) then wavesound:Stop() end
	wavesound = ReadSound("blowout/blowout_particle_wave.wav")
	wavesound:SetSoundLevel(0)
	wavesound:Play()
	wavesound:ChangeVolume(0)
	wavex = spawnPoints[game.GetMap()].spawn
	wavemoving = true
	print("wave")
end
local lastticktime = 0
hook.Add("Think", "Wavemovement", function()
	if(wavemoving) then
		if(lastticktime == 0) then
			lastticktime = CurTime()
			return --frame delay is ok
		end
		local lt = CurTime() - lastticktime
		lastticktime = CurTime()
		local sp = spawnPoints[game.GetMap()]
		if(sp.pos) then
			wavex = wavex + (lt * sp.wavemulti)
		else
			wavex = wavex - (lt * sp.wavemulti)
		end
		if(debugwavex) then
			print("wavex",lt,wavex)
		end

		local s = sp.add
		if(CLIENT) then
			--set vol
			local x = LocalPlayer():GetPos()
			local dis
			if(sp.xory == "x") then
				dis = x:DistToSqr(Vector(wavex, x.y, x.z))
			else
				dis = x:DistToSqr(Vector(x.x, wavex, x.z))
			end
			local val = 1-(dis/8500000)

			wavesound:ChangeVolume(math.Clamp(val, 0.02, 1))


			if((sp.pos and wavex >= sp.done) or (!sp.pos and wavex <= sp.done)) then
				print("wave done")
				wavemoving = false
				lastticktime = 0
				wavesound:Stop()
			end
		else--server
			local p = player.GetAll()
			for k,v in pairs(p) do
				--within 200 range
				local x= v:GetPos()
				local dis
				if(sp.xory == "x") then
					dis = x:DistToSqr(Vector(wavex, x.y, x.z))
				else
					dis = x:DistToSqr(Vector(x.x, wavex, x.z))
				end

				if(v:Alive() and v:GetMoveType() != MOVETYPE_NOCLIP and !v:getNetVar("neardeath") and dis < 50000) then
					--roof check
					local res = util.TraceLine({
						start = v:GetPos(),
						endpos = v:GetPos()+Vector(0,0,20000), --i remember up is last
						filter = {v},
					})
					if(!res or (res and (res.HitSky or !res.Hit))) then --out of cover
						--v:TakeDamage(20)
						local dmg = DamageInfo()
						dmg:SetDamage(20)
						dmg:SetDamageType(DMG_SONIC)
						v:TakeDamageInfo(dmg)
						nut.log.addRaw(v:Name().." ("..v:steamName()..") was killed by a blowout!", FLAG_WARNING)
					end
				end
			end

			if((sp.pos and wavex >= sp.done) or (!sp.pos and wavex <= sp.done)) then
				wavemoving = false
				lastticktime = 0
			end
		end
	end
end)

local oldWeather = nil

BLOWOUT_RUMBLE = BLOWOUT_RUMBLE or nil
--stages of it
PLUGIN.stages = {
	--[[
	["modename"] = {
		{
			--can also set BLOWOUT_AUTOSWITCH in serverThink to automatically
			--skip to the next stage
			length = 1, --seconds length, or {min, max}
			--for serverside of any of these V do server instead of on (serverStart)
			--clientside(?) when stage is started
			onStart = function() 
			end,
			--clientside(?) in timer
			onThink = function() 
			end,
			--clientside(?) when stage ends and about to switch to next stage
			onEnd = function() 
			end,
		},
	}
	]]
	["blowout"] = {
		--start rumble
		{
			length = 20,
			serverStart = function()
				timer.Simple(math.random(3,5), function() 
					netstream.Start(player.GetAll(), "fakepdanote", "Connection Lost...")
					PDA_AVAILABLE = false
				end)
				if(StormFox) then
					oldWeather = StormFox.GetWeather()
					StormFox.SetWeather("rain", 0.95)
					StormFox.SetNetworkData("Thunder", true)
				end
				local ticks = 0
				local max = 200
				local tbl = ents.FindByName("blowoutdome") or {}
				local bld = tbl[1]
				local al = 0
				timer.Create("fading", 0.3, 200,function()
					ticks = ticks + 1
					if(IsValid(bld)) then
						al = Lerp(ticks/max, 0, 255)
						bld:SetColor(Color(255,255,255,al))
					end
				end)
			end,
			onStart = function()

				EmitSound(bbegins[math.random(#bbegins)], Vector(0,0,0), -2)
				timer.Simple(7, function()
					EmitSound("blowout/blowout_siren.ogg", Vector(0,0,0), -2)
				end)
				local cc = {
					--default
					[ "$pp_colour_addr" ] = 0,
					[ "$pp_colour_addg" ] = 0,
					[ "$pp_colour_addb" ] = 0,
					[ "$pp_colour_brightness" ] = -0.01,
					[ "$pp_colour_contrast" ] = 0.98,
					[ "$pp_colour_colour" ] = 0.9,
					[ "$pp_colour_mulr" ] = 0.01,
					[ "$pp_colour_mulg" ] = 0.01,
					[ "$pp_colour_mulb" ] = 0.01
					
				}
				local tab = {
					--default
					[ "$pp_colour_addr" ] = 0,
					[ "$pp_colour_addg" ] = 0,
					[ "$pp_colour_addb" ] = 0,
					[ "$pp_colour_brightness" ] = -0.01,
					[ "$pp_colour_contrast" ] = 0.98,
					[ "$pp_colour_colour" ] = 0.9,
					[ "$pp_colour_mulr" ] = 0.01,
					[ "$pp_colour_mulg" ] = 0.01,
					[ "$pp_colour_mulb" ] = 0.01
					
				}
				local cctarg = {
					[ "$pp_colour_addr" ] = 0.03,
					[ "$pp_colour_addg" ] = 0,
					[ "$pp_colour_addb" ] = 0,
					[ "$pp_colour_brightness" ] = -0.13,
					[ "$pp_colour_contrast" ] = 1.12,
					[ "$pp_colour_colour" ] = 0.46,
					[ "$pp_colour_mulr" ] = 15.5,
					[ "$pp_colour_mulg" ] = 0.03,
					[ "$pp_colour_mulb" ] = 0.03

				}
				OVERRIDE_PP = true
				hook.Add( "RenderScreenspaceEffects", "zzzzzzz", function()
					
					DrawColorModify( tab )
					--return true
				
				end )
				local ticks = 0
				local max = 200
				timer.Create("fading", 0.3, 200,function()
					ticks = ticks + 1
					for k,v in pairs(tab) do
						--maybe this willf ucking work
						tab[k] = Lerp(ticks/max, cc[k], cctarg[k])
					end
				end)
				
			end,
			onEnd = function(earlyexit)
				if(earlyexit) then hook.Remove( "RenderScreenspaceEffects", "zzzzzzz") OVERRIDE_PP = nil return end --dont want to have this playing forever if it gets canceled in this stage lol

			end
		},
		{
			length = {min = 15,max = 20},
			serverStart = function()
				timer.Simple(math.random(1,3), function()  end)
			end,
			onEnd = function(earlyexit)
				if(earlyexit) then return end --dont want to have this playing forever if it gets canceled in this stage lol
				EmitSound(bhits[math.random(#bhits)], Vector(0,0,0), -2)
			end
		},
		{
			length = 20,
			onStart = function()
				timer.Simple(3, function()	
					if(BLOWOUT_RUMBLE and BLOWOUT_RUMBLE:IsPlaying()) then BLOWOUT_RUMBLE:Stop() end
					BLOWOUT_RUMBLE = CreateSound(game.GetWorld(), "blowout/blowout_rumble.wav")
					BLOWOUT_RUMBLE:SetSoundLevel(0)
					BLOWOUT_RUMBLE:ChangeVolume(0)
					BLOWOUT_RUMBLE:ChangeVolume(0.75, 25)
					BLOWOUT_RUMBLE:Play()
				end)
			end,
			onEnd = function(earlyexit)
				if(earlyexit) then hook.Remove("RenderScreenspaceEffects", "zzzzzzz") OVERRIDE_PP = nil BLOWOUT_RUMBLE:Stop() end --dont want to have this playing forever if it gets canceled in this stage lol
			end
		},
		{
			length = 15,
			serverStart = function()

			end,
			onStart = function()
				util.ScreenShake(Vector(0,0,0), 3, 5, 60, 100)
			end,
			onEnd = function(earlyexit)
				if(earlyexit) then hook.Remove("RenderScreenspaceEffects", "zzzzzzz") OVERRIDE_PP = nil BLOWOUT_RUMBLE:Stop() end --dont want to have this playing forever if it gets canceled in this stage lol
			end
		},
		{ --first wave start
			length = 15,
			onStart = function()
				timer.Simple(5, function()
					util.ScreenShake(Vector(0,0,0), 5, 6, 112, 100)
					EmitSound(bwaves[math.random(#bwaves)], Vector(0,0,0), -2)
					
				end)
			end,
			onEnd = function(earlyexit)
				if(earlyexit) then hook.Remove("RenderScreenspaceEffects", "zzzzzzz") OVERRIDE_PP = nil BLOWOUT_RUMBLE:Stop() end --dont want to have this playing forever if it gets canceled in this stage lol
			end
		},
		{
			length = 20,
			serverStart = function()
				DoWave()
			end,
			onStart = function()
				DoWave()
			end,
			onEnd = function(earlyexit)
				if(earlyexit) then hook.Remove("RenderScreenspaceEffects", "zzzzzzz") OVERRIDE_PP = nil BLOWOUT_RUMBLE:Stop() end --dont want to have this playing forever if it gets canceled in this stage lol
			end
		},
		{ --2nd wave start
			length = 10,
			onStart = function()
				timer.Simple(4, function()
					EmitSound(bwaves[math.random(#bwaves)], Vector(0,0,0), -2)
					
				end)
			end,
			onEnd = function(earlyexit)
				if(earlyexit) then hook.Remove("RenderScreenspaceEffects", "zzzzzzz") OVERRIDE_PP = nil BLOWOUT_RUMBLE:Stop() end --dont want to have this playing forever if it gets canceled in this stage lol
			end
		},
		{
			length = 20,
			serverStart = function()
				DoWave()
			end,
			onStart = function()
				DoWave()
			end,
			onEnd = function(earlyexit)
				if(earlyexit) then hook.Remove("RenderScreenspaceEffects", "zzzzzzz") OVERRIDE_PP = nil BLOWOUT_RUMBLE:Stop() end --dont want to have this playing forever if it gets canceled in this stage lol
			end
		},
		{
			length = 60,
			onStart = function()
				BLOWOUT_RUMBLE:FadeOut(10)
				EmitSound("blowout/blowout_hit_3.ogg", Vector(0,0,0), -2)
				
				local cc = {
					--default
					[ "$pp_colour_addr" ] = 0,
					[ "$pp_colour_addg" ] = 0,
					[ "$pp_colour_addb" ] = 0,
					[ "$pp_colour_brightness" ] = -0.01,
					[ "$pp_colour_contrast" ] = 0.98,
					[ "$pp_colour_colour" ] = 0.9,
					[ "$pp_colour_mulr" ] = 0.01,
					[ "$pp_colour_mulg" ] = 0.01,
					[ "$pp_colour_mulb" ] = 0.01
					
				}
				local tab = {
					--default
					[ "$pp_colour_addr" ] = 0.04,
					[ "$pp_colour_addg" ] = 0,
					[ "$pp_colour_addb" ] = 0,
					[ "$pp_colour_brightness" ] = -0.06,
					[ "$pp_colour_contrast" ] = 1.19,
					[ "$pp_colour_colour" ] = 0.56,
					[ "$pp_colour_mulr" ] = 25.5,
					[ "$pp_colour_mulg" ] = 0.01,
					[ "$pp_colour_mulb" ] = 0.01
					
				}
				local cctarg = {
					[ "$pp_colour_addr" ] = 0.04,
					[ "$pp_colour_addg" ] = 0,
					[ "$pp_colour_addb" ] = 0,
					[ "$pp_colour_brightness" ] = -0.06,
					[ "$pp_colour_contrast" ] = 1.19,
					[ "$pp_colour_colour" ] = 0.56,
					[ "$pp_colour_mulr" ] = 25.5,
					[ "$pp_colour_mulg" ] = 0.01,
					[ "$pp_colour_mulb" ] = 0.01

				}
				hook.Add( "RenderScreenspaceEffects", "zzzzzzz", function()
				
					DrawColorModify( tab )
					--return true
				
				end )
				local ticks = 0
				local max = 60
				--fading out
				timer.Create("fading", 0.2, 300,function()
					ticks = ticks + 0.2
					for k,v in pairs(tab) do
						tab[k] = Lerp(ticks/max, cctarg[k], cc[k])
					end
				end)

					
			end,
			serverStart = function()
				local ticks = 0
				local max = 60
				local tbl = ents.FindByName("blowoutdome") or {}
				local bld = tbl[1]
				local al = 0
				--fading out
				timer.Create("fading", 0.2, 300,function()
					ticks = ticks + 0.2
					if(IsValid(bld)) then
						al = Lerp(ticks/max, 255, 0)
						bld:SetColor(Color(255,255,255,al))
					end
				end)
				
				--start rain if can?
				if(StormFox) then
					StormFox.SetWeather("rain", 0.75)
					StormFox.SetNetworkData("Thunder", true)
					timer.Simple(math.random(900,1800), function()
						if(StormFox.GetWeather() == "Thunder") then
							StormFox.SetNetworkData("Thunder", false)
							timer.Simple(math.random(600,1200), function()
								--hopefully will return it to the other weather
								if(oldWeather) then
									StormFox.SetWeather(oldWeather)
								end
							end)
						end
					end)
				end
			end,
			serverEnd = function()
				timer.Simple(2, function() 
				netstream.Start(player.GetAll(), "fakepdanote", "Connection reestablished...")
				end)
				PDA_AVAILABLE = true
			end,
			onEnd = function()
				hook.Remove("RenderScreenspaceEffects", "zzzzzzz")
				if(BLOWOUT_RUMBLE) then BLOWOUT_RUMBLE:Stop() end --idk
				OVERRIDE_PP = nil
			end
		}
		--start turning red
		--start global psy dmg
		--first wave (autoswitch when done)
		--2nd wave (autoswitch when done)
		--psy damage stops, start returning to normal, force rain

	},
	--psistorm
	["psistorm"] = {

	},
}

nut.command.add("startblowout", {
	adminOnly = true,
	desc = "Function to start a blowout.",
	onRun = function(client, arguments)
		if(BLOWOUT_ACTIVE) then return "You cannot start a blowout when theres already a sequence active!" end

		PLUGIN:StartBlowout()
 	end
})
nut.command.add("startpsistorm", {
	adminOnly = true,
	desc = "Function to start a psi-storm.",
	onRun = function(client, arguments)
		if(BLOWOUT_ACTIVE) then return "You cannot start a psi-storm when theres already a sequence active!" end
		return "lol havent done this yet sry"
		--PLUGIN:StartBlowout("psistorm")
 	end
})

if(SERVER) then
	--need player initial spawn hook for networking the current stage on spawn?

	local curStage = curStage or 0
	local nextTime = 0
	local mode = mode or nil
	BLOWOUT_ACTIVE = false
	function PLUGIN:StartBlowout(modeoverride)
		--do a timer that automatically changes stages, local to change?
		--use StartStage to change stage
		if(BLOWOUT_ACTIVE) then return end --nope
		curStage = 1 --first stage
		mode = modeoverride or "blowout"
		BLOWOUT_ACTIVE = true
		self:StartStage(curStage, mode) --start 1
		local nextlength = istable(self.stages[mode][curStage].length) and
			math.random(self.stages[mode][curStage].length.min, self.stages[mode][curStage].length.max) or
			self.stages[mode][curStage].length
		nextTime = CurTime() + nextlength
		timer.Create("blowouttimer", 1, 0, function()
			if(self.stages[mode][curStage].serverThink) then
				self.stages[mode][curStage].serverThink()
			end
			--if true should switch in?
			if(!BLOWOUT_AUTOSWITCH and CurTime() < nextTime) then return end
			BLOWOUT_AUTOSWITCH = nil

			--next stage
			if(self.stages[mode][curStage].serverEnd) then
				self.stages[mode][curStage].serverEnd()
			end
			curStage = curStage + 1
			print("next stage",curStage)
			if(!self.stages[mode][curStage]) then --its over
				timer.Remove("blowouttimer")
				--idk if ill need this tbh
				BLOWOUT_ACTIVE = false
				net.Start("BlowoutStop")
				net.Broadcast()
				return
			end
			local nextlength = istable(self.stages[mode][curStage].length) and
				math.random(self.stages[mode][curStage].length.min, self.stages[mode][curStage].length.max) or
				self.stages[mode][curStage].length
			nextTime = CurTime() + nextlength
			self:StartStage(curStage, mode)
		end)
	end
	function PLUGIN:EndBlowout()
		--end the blowout early and kill the timer over
		timer.Remove("blowouttimer")
		--idk if ill need this tbh
		BLOWOUT_ACTIVE = false
		net.Start("BlowoutStop")
		net.Broadcast()
	end
	--wont auto end lol
	function PLUGIN:StartStage(stage, mode)
		if(!mode) then
			print("no mode specified for blowout plugin")
		end

		if(self.stages[mode][stage].serverStart) then
			self.stages[mode][stage].serverStart()
		end
		--broadcast the stage to everyone using BlowoutStage
		net.Start("BlowoutStage")
		net.WriteInt(stage, 8)
		net.WriteString(mode)
		net.Broadcast()
	end

	util.AddNetworkString("BlowoutStage")
	util.AddNetworkString("BlowoutStop")
else--client
	local activestage = activestage or nil
	local mode = mode or nil

	net.Receive("BlowoutStage", function()
		local stage = net.ReadInt(8)
		mode = net.ReadString()
		local self = PLUGIN

		if(activestage and activestage != stage) then
			if(self.stages[mode][activestage].onEnd) then
				self.stages[mode][activestage].onEnd()
			end
			if(timer.Exists("blowoutthink")) then
				timer.Remove("blowoutthink")
			end
		end
		activestage = stage
		
		if(self.stages[mode][stage].onStart) then
			self.stages[mode][stage].onStart()
		end
		if(self.stages[mode][stage].onThink) then
			timer.Create("blowoutthink", 1, 0, function()
				self.stages[mode][stage].onThink()
			end)
		end
	end)
	net.Receive("BlowoutStop", function()
		--use to reset everything
		if(activestage and mode) then
			local self = PLUGIN
			if(self.stages[mode][activestage].onEnd) then
				self.stages[mode][activestage].onEnd(true)
			end
			if(timer.Exists("blowoutthink")) then
				timer.Remove("blowoutthink")
			end
		end
		activestage = nil
	end)

end