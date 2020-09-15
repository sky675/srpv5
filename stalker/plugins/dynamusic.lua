local PLUGIN = PLUGIN
PLUGIN.name = "Dynamic Music"
PLUGIN.author = "sky"
PLUGIN.desc = "Adds dynamic music. also supports and autoadds nombat packs and dynamo :)"

M_STATE_DEAD = -1
M_STATE_PASSIVE = 0
M_STATE_ACTIVE = 1

local musicaddonlink = "https://steamcommunity.com/sharedfiles/filedetails/?id=2228478997"
local defaultmusiccheck = "sound/music/stalker/*"

local defaultMusicType = "stalker"

nut.music = nut.music or {}
--types to choose from
nut.music.types = {
	--[[
		["id"] = {
			[M_STATE_PASSIVE] = {} --table of songs to play during passive/non-combat state
			[M_STATE_ACTIVE] = {} --table of songs to play during active/combat state
		}
	]]
	["halflife2"] = {
		[M_STATE_PASSIVE] = {
			"music/hl1_song19.mp3",
			"music/hl1_song20.mp3",
			"music/hl2_song13.mp3",
			"music/hl2_song17.mp3",
			"music/hl2_song19.mp3",


		},
		[M_STATE_ACTIVE] = {
			"music/hl2_song12_long.mp3",
			"music/hl2_song14.mp3",
			"music/hl2_song20_submix0.mp3",
			"music/hl2_song20_submix4.mp3",
			"music/hl2_song3.mp3",
			"music/hl2_song31.mp3",

		},
	},

}
nut.command.add("playdynamusic", {
	syntax = "<string music> [string player]",
	--custom edit to ns i did allows descs for commands, im not releasing this (however its based on code from before helix renamed everything to ix)
	desc = "Force a certain sound file to be played through the dynamic music, relies on the player having dynamic music enabled. Leave out the 2nd argument to play it for all players",
	adminOnly = true,
	onRun = function(client, arguments)
		local target
		if(arguments[2]) then
			target = nut.util.findPlayer(arguments[2])
			if(!IsValid(target)) then return "No target" end
		end

		nut.music.forceMusic(arguments[1], target)
	end
})

if CLIENT then
	NUT_CVAR_DYNAMUSIC = CreateClientConVar("nut_dynamusic", 0, true, true)
	CreateClientConVar("nut_dynaoverride", -2, true, true, "Used to force the dynamic music system into a specific state and make it stay there. Current values: -2 for disabled, -1 for no music, 0 for passive, 1 for active/combat")
	cvars.AddChangeCallback("nut_dynaoverride", function(name, old, new)
		--if theres like special music for something happening dont let them override
		if(MUSIC_FORCEDOVERRIDE) then return end 
		if(tonumber(new) == -2) then
			MUSIC_OVERRIDE = nil
		else
			MUSIC_OVERRIDE = tonumber(new)
		end
	end)
	concommand.Add("nut_dynareset", function()
		MUSIC_TOCHANGE = M_STATE_PASSIVE
	end, nil, "On use will reset the music's status to passive, use if it gets stuck in active")

	MUSIC_STATE = M_STATE_PASSIVE
	MUSIC_TYPE = "halflife2"
	MUSIC_PATCH = nil

	--more specified parts to get translated into passive/active just in case
	--unused currently
	local musictrans = {
		
	}
	
	function PLUGIN:SetupQuickMenu(menu)
		
        local buttonItem = menu:addCheck("Toggle Dynamic Music", function(panel, state)
            if(state) then
                RunConsoleCommand("nut_dynamusic", "1")
            else
                RunConsoleCommand("nut_dynamusic", "0")
            end
		end, NUT_CVAR_DYNAMUSIC:GetBool())
		local button = menu:addButton("Dynamic Music Config", function(p)
			--gui of list of valid types here
			local frm = vgui.Create("DFrame")
			frm:Center()
			frm:SetSize(ScrW()*0.2, ScrH()*0.05)
			frm:SetTitle("Select Music Type - Volume can be controlled with nutMusicLevel")
			frm:SetDraggable(true)
			frm:MakePopup()

			local d = frm:Add("DComboBox")
			d:Dock(FILL)
			d:Center()
			d:SetValue(MUSIC_TYPE)
			for k,v in pairs(nut.music.types) do
				d:AddChoice(k)
			end
			d.OnSelect = function(self, index, val)
				print("changed to "..val)
				cookie.Set("nutmustype", val)
				MUSIC_TYPE = val
				MusicFade(2)
			end
		end)

		menu:addSpacer()
	end


	net.Receive("ForceDynaMusic", function()
		local source = net.ReadString()
		if(!NUT_CVAR_DYNAMUSIC:GetBool()) then return end
		if(!LocalPlayer():Alive()) then return end

		--MUSIC_TOCHANGE = -1
		MUSIC_OVERRIDE = -1
		MUSIC_FORCEDOVERRIDE = true


		if(MUSIC_PATCH) then
			MUSIC_PATCH:Stop()
			MUSIC_PATCH = nil
		end

		local function callback(music, errorID, fault)
			if (music) then
				music:SetVolume((ConVarExists("nutMusicLevel") and math.Clamp(GetConVar("nutMusicLevel"):GetFloat(), 0, 1)) or 0.5)					
				music:EnableLooping(one or false)

				MUSIC_PATCH = music
				MUSIC_PATCH:Play()

				local length = MUSIC_PATCH:GetLength()
				timer.Simple(length, function()
					MUSIC_TOCHANGE = 0
					MUSIC_OVERRIDE = nil
					MUSIC_FORCEDOVERRIDE = nil
				end)
			else
				MsgC(Color(255, 50, 50), errorID.." ")
				MsgC(color_white, fault.."\n")
			end
		end

		if (source:find("http")) then
			sound.PlayURL(source, "noplay", callback)
		else
			sound.PlayFile("sound/"..source, "noplay", callback)
		end
	end)

	hook.Add("InitPostEntity", "dynamusic", function()
		MUSIC_TYPE = cookie.GetString("nutmustype", "shadowrun")
		timer.Create("dynamain", 0.5, 0, function()
			if(!NUT_CVAR_DYNAMUSIC:GetBool() and !timer.Exists("dynaMusicFader")) then MusicFade(2) return
			elseif(!NUT_CVAR_DYNAMUSIC:GetBool()) then return end
			if(!LocalPlayer():Alive() and !timer.Exists("dynaMusicFader")) then MusicFade(2) return 
			elseif(!LocalPlayer():Alive()) then return end

			if(IsValid(nut.gui.char) and nut.gui.char:IsVisible()) then 
				if(!LocalPlayer().getChar or !LocalPlayer():getChar() and MUSIC_PATCH) then
					MUSIC_PATCH:Stop()
					MUSIC_PATCH = nil
				elseif(MUSIC_PATCH and !timer.Exists("dynaMusicFader")) then
					MusicFade(2)
				end
				return
			end

			if(!MUSIC_OVERRIDE and MUSIC_TOCHANGE and MUSIC_TOCHANGE != MUSIC_STATE and !timer.Exists("dynaMusicFader")) then
				--change type
				--MusicFade(2, function()
					print("change")
					if(MUSIC_PATCH) then
						MUSIC_PATCH:Stop()
						MUSIC_PATCH = nil
					end
					MUSIC_STATE = MUSIC_TOCHANGE
					MUSIC_TOCHANGE = nil

					--CreateMusic(MUSIC_STATE)
				--end)
			end

			if(MUSIC_OVERRIDE and MUSIC_OVERRIDE != -2 and MUSIC_OVERRIDE != MUSIC_STATE and !timer.Exists("dynaMusicFader")) then
				--[[if(MUSIC_PATCH) then
					print("stop override")
					MUSIC_PATCH:Stop()
					MUSIC_PATCH = nil
				end]]
				MUSIC_STATE = MUSIC_OVERRIDE
			end

			if(!MUSIC_PATCH) then
				--create
				CreateMusic(MUSIC_STATE)
			elseif(MUSIC_PATCH and MUSIC_PATCH.GetState and MUSIC_PATCH:GetState() == GMOD_CHANNEL_STOPPED) then
				--do it again
				CreateMusic(MUSIC_STATE)
			--[[
			elseif(MUSIC_PATCH and MUSIC_PATCH.IsPlaying and !MUSIC_PATCH:IsPlaying()) then
				--do it again
				CreateMusic(MUSIC_STATE)]]
			end
		end)

		--see if you can check what sounds they have for nombat thing?
		--if(file.Exists("sound/nombat*", "GAME")) then
		local _, filelist = file.Find("sound/nombat/*", "WORKSHOP")
		if(filelist) then
		for k,v in pairs(filelist) do
			print("nombat check ", k, v)
			nut.music.types[v] = {[M_STATE_PASSIVE] = {}, [M_STATE_ACTIVE] = {}}
			local plist = file.Find("sound/nombat/"..v.."/a*", "WORKSHOP")
			for k2,v2 in ipairs(plist) do
				table.insert(nut.music.types[v][M_STATE_PASSIVE], "sound/nombat/"..v.."/"..v2)
			end
			local alist = file.Find("sound/nombat/"..v.."/c*", "WORKSHOP")
			for k2,v2 in ipairs(alist) do
				table.insert(nut.music.types[v][M_STATE_ACTIVE], "sound/nombat/"..v.."/"..v2)
			end
			--gotta play it differently with these
			nut.music.types[v].altplay = true
		end
		end

		--dynamo support
		local amblist = file.Find("sound/ayykyu_dynmus/ambient/*", "WORKSHOP")
		local ambients = {} --saving the ambients to add later
		if(amblist) then
		for k,v in pairs(amblist) do
			if(string.find(v, "playtime in seconds")) then continue end --just in case someone leaves that in
			table.insert(ambients, "sound/ayykyu_dynmus/ambient/"..v)
		end
		end

		_, filelist = file.Find("sound/ayykyu_dynmus/combat/*", "WORKSHOP")
		if(filelist) then
		local all = {}
		for k,v in pairs(filelist) do
			local com = {}
			local dlist = file.Find("sound/ayykyu_dynmus/combat/"..v.."/*", "WORKSHOP")
			for k2, v2 in ipairs(dlist) do
				table.insert(com, "sound/ayykyu_dynmus/combat/"..v.."/"..v2)
				table.insert(all, "sound/ayykyu_dynmus/combat/"..v.."/"..v2)
			end
			nut.music.types["dynamo-"..v] = {[M_STATE_PASSIVE] = ambients, [M_STATE_ACTIVE] = com}
		end
		if(#all != 0) then --combine them all
			nut.music.types["dynamo-all"] = {[M_STATE_PASSIVE] = ambients, [M_STATE_ACTIVE] = com}
		end
		end
	end)

	function CreateMusic(typ, one) --one is one time play idk
		--just support to play specific stuff just in case
		if(type(typ) == "string") then
			local source = typ

			if(MUSIC_PATCH) then
				MUSIC_PATCH:Stop()
				MUSIC_PATCH = nil
			end

			local function callback(music, errorID, fault)
				if (music) then
					music:SetVolume((ConVarExists("nutMusicLevel") and math.Clamp(GetConVar("nutMusicLevel"):GetFloat(), 0, 1)) or 0.5)					
					music:EnableLooping(one or false)

					MUSIC_PATCH = music
					MUSIC_PATCH:Play()
				else
					MsgC(Color(255, 50, 50), errorID.." ")
					MsgC(color_white, fault.."\n")
				end
			end

			if (source:find("http")) then
				sound.PlayURL(source, "noplay", callback)
			else
				sound.PlayFile("sound/"..source, "noplay", callback)
			end
		
		else
			if(!typ) then typ = MUSIC_STATE end
			if(!nut.music.types[MUSIC_TYPE]) then print("your current type, "..MUSIC_TYPE.." is not valid")return end --just in case
			if(nut.music.types[MUSIC_TYPE][typ]) then
				local source = nut.music.types[MUSIC_TYPE][typ][math.random(#nut.music.types[MUSIC_TYPE][typ])]
				if(source) then
					--just in case
					if(MUSIC_PATCH) then
						MUSIC_PATCH:Stop()
						MUSIC_PATCH = nil
					end

					local function callback(music, errorID, fault)
						if (music) then
							music:SetVolume((ConVarExists("nutMusicLevel") and math.Clamp(GetConVar("nutMusicLevel"):GetFloat(), 0, 1)) or 0.5)					
							music:EnableLooping(one or false)
		
							MUSIC_PATCH = music
							MUSIC_PATCH:Play()
						else
							MsgC(Color(255, 50, 50), errorID.." ")
							MsgC(color_white, fault.."\n")
						end
					end


					if(nut.music.types[MUSIC_TYPE].altplay) then
						source = string.gsub(source, "sound/", "")
					end
					
					print("creating sound for ", source)

					if (source:find("http")) then
						sound.PlayURL(source, "noplay", callback)
					else
						sound.PlayFile("sound/"..source, "noplay", callback)
					end
					--end
				end
			else
				if(MUSIC_PATCH) then
					MUSIC_PATCH:Stop()
					MUSIC_PATCH = nil
				end
			end
		end
	end
	
	function MusicFade(time, custom)
		if (MUSIC_PATCH) then
			--[[
			if(MUSIC_PATCH.FadeOut) then
				MUSIC_PATCH:FadeOut(time)
				timer.Simple(time, function()
					MUSIC_PATCH:Stop()
					MUSIC_PATCH = nil
					if(custom) then
						custom()
					end
				end)
				return
			end]]

			local fraction = 1
			local start, finish = RealTime(), RealTime() + (time or 10)

			timer.Create("dynaMusicFader", 0.1, 0, function()
				if (MUSIC_PATCH) then
					fraction = 1 - math.TimeFraction(start, finish, RealTime())
					MUSIC_PATCH:SetVolume(fraction * 0.5)

					if (fraction <= 0) then
						MUSIC_PATCH:Stop()
						MUSIC_PATCH = nil
						if(custom) then
							custom()
						end

						timer.Remove("dynaMusicFader")
					end
				else
					timer.Remove("dynaMusicFader")
				end
			end)
		end
	end
	
	net.Receive("SetDynaMusicStatus", function()
		local stat = net.ReadInt(4)
		--print("1 2 switch")
		--if(MUSIC_TOCHANGE) then print("trying to switch but no") return end
		MUSIC_TOCHANGE = stat
		timer.Create("mustimeout", 12, 1, function()
			--thisll need to be changed for more broader things but watever
			if(MUSIC_STATE == M_STATE_ACTIVE) then
				
				print("swapping back")
				MusicFade(2, function()		
					MUSIC_TOCHANGE = M_STATE_PASSIVE
				end)
--[[
				if(MUSIC_PATCH) then
					print("STOP ", tostring(MUSIC_PATCH), MUSIC_PATCH:GetFileName())
					MUSIC_PATCH:Stop()
					MUSIC_PATCH = nil
				end
				]]
			end
		end)
	end)

else--server (if needed idk)
	util.AddNetworkString("SetDynaMusicStatus")
	util.AddNetworkString("ForceDynaMusic")

	--i know this can be done in one line with netstream but 
	--im too used to just using net
	--also ply can be a table too (or a CRecipientFilter too i guess idk)
	function nut.music.setActive(ply, state)
		--true = active, false = passive
		net.Start("SetDynaMusicStatus")
		net.WriteInt(state, 4)
		net.Send(ply)
	end

	function nut.music.forceMusic(string, ply)
		net.Start("ForceDynaMusic")
		net.WriteString(string)
		if(!ply) then
			net.Broadcast()
		else
			net.Send(ply)
		end
	end


	--if target or attacker is player, 
	--the ones that are (or both) get set to true
	hook.Add("EntityTakeDamage", "dynamusic", function(target, dmg)
		local atk = dmg:GetAttacker()
		if(target:IsPlayer() and (!IsValid(atk) or !atk:IsWorld())) then
			--print("target take")
			nut.music.setActive(target, M_STATE_ACTIVE)
		end
		if(atk:IsPlayer() and (target:IsPlayer() or target:IsNPC() or target.NEXTBOT)) then
			--print("atk take ", tostring(target))
			nut.music.setActive(atk, M_STATE_ACTIVE)
		end
	end)
	
	dynaloaded = dynaloaded or nil
	function PLUGIN:OnLoaded()
		if(dynaloaded) then
			return
		else
			dynaloaded = true
		end

		timer.Create("enemycheck", 2, 0, function()
			local ent = ents.FindByClass("npc*")
			local nz = ents.FindByClass("nz*")
			local sent = {}
			--this might be really laggy tbh lmao idk
			for k,v in ipairs(ent) do
				if(IsValid(v) and v.GetEnemy and IsValid(v:GetEnemy()) and v:GetEnemy():IsPlayer()) then
					if(!sent[v:GetEnemy()]) then
						sent[v:GetEnemy()] = true
					end
				end
			end
			for k,v in ipairs(nz) do
				if(IsValid(v) and v.GetEnemy and IsValid(v:GetEnemy()) and v:GetEnemy():IsPlayer()) then
					if(!sent[v:GetEnemy()]) then
						sent[v:GetEnemy()] = true
					end
				end
			end
			--PrintTable(sent)
			for k,v in pairs(sent) do
				nut.music.setActive(k, M_STATE_ACTIVE)
			end
		end)
	end

	--this is support for my suppression edit plugin
	--the attacker (if player) and target of those get set to true
	hook.Add("OnSuppression", "dyna", function(ply, atk)
		if(atk:IsPlayer()) then
		--	print("atk supp")
			nut.music.setActive(atk, M_STATE_ACTIVE)
		end
		--only players should be ply, it checks
		--print("ply supp")
		nut.music.setActive(ply, M_STATE_ACTIVE)

	end)


end