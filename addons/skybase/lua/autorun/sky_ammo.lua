game.AddAmmoType({
    name = "sky9x19",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky9x18",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky9x39",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky45acp",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky46",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky57",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky50ae",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky762x25",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky762x39",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky762x51",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky762x54",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky556",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky545",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "sky338",
    tracer = TRACER_LINE_AND_WHIZ
})
game.AddAmmoType({
    name = "skyar3ammo",
	tracer = TRACER_LINE_AND_WHIZ
	--todo do getammoforce for ar2 ammo to determine force
})
game.AddAmmoType({
    name = "sky23mm",
    tracer = TRACER_LINE
})

game.AddAmmoType({
    name = "skygp25",
    tracer = TRACER_LINE
})
game.AddAmmoType({
    name = "skym203",
    tracer = TRACER_LINE
})

player_manager.AddValidModel("neohead", "models/sky/heads/neo.mdl")

--[[hook.Add("AcceptInput", "test", function(ent, input, activator, caller, value)
	print("acceptinput", ent, input, activator, caller, value)
end)]]

hook.Add("PostPlayerSay", "bot test", function(client, message, type, anon)
	for k,v in pairs(FAKE_PLAYER_CACHE or {}) do
		if(IsValid(v) and client != v and nut.chat.classes[type].onCanHear(client, v)) then
			v:RespondTo(message, type, client)
		end
	end
end)

--tfa devs make me really upset sometimes, but the base works so well
if(SERVER) then
	CreateConVar("sv_tfa_door_respawn", -1, {FCVAR_REPLICATED, FCVAR_NOTIFY, FCVAR_ARCHIVE}, "How long until door respawned when killed by TFA weapons BECAUSE THEY REMOVED THIS CONVAR????")
end

sound.Add({
    name = "SKY_TFAQuietIronIn",
    channel = CHAN_USER_BASE + 13,
    volume = 0.4,
    sound = {"weapons/ins2/uni/uni_ads_in_01.wav", "weapons/ins2/uni/uni_ads_in_02.wav", "weapons/ins2/uni/uni_ads_in_03.wav", "weapons/ins2/uni/uni_ads_in_04.wav", "weapons/ins2/uni/uni_ads_in_05.wav", "weapons/ins2/uni/uni_ads_in_06.wav" },
    pitch = {97, 103},
    level = 60
})

sound.Add({
    name = "SKY_TFAQuietIronOut",
    channel = CHAN_USER_BASE + 13,
    volume = 0.4,
    sound = "weapons/ins2/uni/uni_ads_out_01.wav",
    pitch = {97, 103},
    level = 60
})

hook.Add("TFA_Pump", "manualpump", function(wep)
	if(!wep:GetOwner():KeyDown(IN_RELOAD)) then --should only allow r pumps
		return true
	end
end)


sound.Add({
	name = "neo.corpvoice",
	channel = CHAN_USER_BASE + 11,
	volume = 1.0,
	sound = { --voice files of all the lines to play
	--honestly i should make my own of these, so thered be sooo much more
		"hot_work_o.mp3",
		"life_cuts_o.mp3",
		"saitama_corp_o.mp3",
		"shipping_area_o.mp3",
		"warning_lvl3_o.mp3"
	},
	level = 120
})
--[[
function GM:CanTool(client, trace, tool)
	print("cantool", tool)
end
]]
--unbreakable fix
--[[
timer.Simple(2, function()
if(PermaProps and PermaProps.SpecialENTSSave and PermaProps.SpecialENTSSpawn) then
PermaProps.SpecialENTSSave["prop_physics"] = function(ent)
	if(ent:GetVar("Unbreakable")) then
		return {Other = {Unbreakable = true}}
	end
end
PermaProps.SpecialENTSSpawn["prop_physics"] = function(ent,data)
	if(data.Unbreakable) then
        ent:SetVar( "Unbreakable", true )
		ent:Fire  ( "SetDamageFilter", "FilterDamage", 0 )
	end
end
end
end)
]]
--[[
local teest = {
	[DMG_ACID] = "acid",
	[DMG_AIRBOAT] = "airboat",
	[DMG_BLAST] = "blast",
	[DMG_BLAST_SURFACE] = "blast surface",
	[DMG_BUCKSHOT] = "buckshot",
	[DMG_BULLET] = "bullet",
	[DMG_BURN] = "burn",
	[DMG_CLUB] = "club",
	[DMG_CRUSH] = "crush",
	[DMG_DIRECT] = "direct",
	[DMG_DISSOLVE] = "dissolve",
	[DMG_DROWN] = "drown",
	[DMG_ENERGYBEAM] = "energybeam",
	[DMG_FALL] = "fall",
	[DMG_GENERIC] = "generic",
	[DMG_MISSILEDEFENSE] = "missle defense",
	[DMG_NERVEGAS] = "nervegas",
	[DMG_PARALYZE] = "paralyze",
	[DMG_PHYSGUN] = "physgun",
	[DMG_PLASMA] = "plasma",
	[DMG_POISON] = "poison",
	[DMG_RADIATION] = "radiation",
	[DMG_SHOCK] = "shock",
	[DMG_SLASH] = "slash",
	[DMG_SLOWBURN] = "slowburn",
	[DMG_SNIPER] = "sniper",
	[DMG_SONIC] = "sonic",
	[DMG_VEHICLE] = "vehicle"
}
hook.Add("EntityTakeDamage", "teete", function(ent, dmg)
	if(ent:IsPlayer()) then
		print("start of dmg check", dmg:GetAttacker())
		for k,v in pairs(teest) do
			if(dmg:IsDamageType(k)) then
				print("dmg", v)
			end
		end
	end
end)
]]

if(CLIENT) then-- and game.SinglePlayer()) then --will this work?
	--nothing for ur current pos+ang, f for eyetrace hitpos
concommand.Add("_printpos", function(ply, cmd, args)
	if(args[1] == "f") then
		local tr = ply:GetEyeTrace()
		local pos = tr.HitPos
		print("pos: "..tostring(tr.HitPos))
		SetClipboardText("Vector("..pos.x..", "..pos.y..", "..pos.z..")")
		return
	end
	print("pos: ", ply:GetPos(), " ang: ", tostring(ply:EyeAngles()), ", clipboarded with just y")
	local pos, ang = ply:GetPos(), ply:EyeAngles()
	SetClipboardText("{Vector("..pos.x..", "..pos.y..", "..pos.z.."), Angle(0, "..ang.y..", 0)},\n")
end, nil, "this is something i made for run configs, ignore it")

concommand.Add("_printentdata", function(ply, cmd, args)
	print("copied")
	local ent = ply:GetEyeTrace().Entity
	local pos, ang = ent:GetPos(), ent:GetAngles()
	SetClipboardText([[{
		class = "]]..ent:GetClass()..[[",
		model = "]]..ent:GetModel()..[[",
		skin = ]]..ent:GetSkin()..[[,
		pos = Vector(]]..pos.x..[[, ]]..pos.y..[[, ]]..pos.z..[[),
		angle = Angle(]]..ang.p..[[, ]]..ang.y..[[, ]]..ang.r..[[),
	},]])
end, nil, "this is something i made for run configs, ignore it")
end

--testing


if(SERVER) then

	hook.Add("OnEntityCreated", "setrelationship", function(entity)
		if(IsValid(entity) and entity:GetClass() == "dronesrewrite_nukedr") then entity:Remove() end

		if(#ents.FindByClass("run_wave") == 0) then return end --dont matter
		if(IsValid(entity) and entity:IsNPC() and entity:GetClass() != "ob_vj_bullseye") then
		timer.Simple(0.02, function()
			if(IsValid(entity) and entity:IsNPC() and entity:GetClass() != "ob_vj_bullseye") then

			local ents = ents.FindByClass("run_wave")
			for k,v in pairs(ents) do
				local bullseye = v.Bullseye
		
				if !IsValid( bullseye ) then
					SafeRemoveEntity( bullseye )
				return end
		
						entity:AddEntityRelationship( bullseye, D_HT, 99 )
		

				
			end
			end
		end)
		end
	end)

	--** == needs to be done
	--**hacking stuff
	--**buttons in sv hooks
	--c8neo script stuff
	--[[ lua_run print(Entity(1):GetEyeTrace().Entity:MapCreationID())
	 
	lua_run PrintTable(ents.FindInSphere(Entity(1):GetPos(), 50))
	lua_run print(ents.FindInSphere(Entity(1):GetPos(), 50)[1]:MapCreationID())
	]]
	--**1 double doors that should be partnered together
	local doors = {
		{2328, 2326}, --warehouse 3
		{1438, 1437},
		{2476, 2477},
		{1574, 1575},
		{1450, 1451},
		{2424, 2423},
		{1622, 1623},
		
		{5476, 5475},
		{5432, 5431},

	}
	--**2 all soundscapes 
	--lua_run for k,v in pairs(ents.FindByClass("env_soundscape")) do print("["..v:MapCreationID().."] = true,") end
	local dumbsoundscapes = {
	[1348] = true,[2179] = true,[2180] = true,[2181] = true,[2182] = true,
	[2183] = true,[2184] = true,[2185] = true,[2186] = true,[2187] = true,
	[2188] = true,[2189] = true,[2190] = true,[2191] = true,[2192] = true,
	[2193] = true,[2620] = true,[3276] = true,[3484] = true,[3529] = true,
	[3530] = true,[3610] = true,[3766] = true,[3788] = true,[3837] = true,
	[3838] = true,[3849] = true,[3850] = true,[3851] = true,[3852] = true,
	[3853] = true,[3854] = true,[3855] = true,[3856] = true,[3857] = true,
	[3858] = true,[3859] = true,[3860] = true,[3861] = true,[3862] = true,
	[3863] = true,[3864] = true,[3865] = true,[3866] = true,[3867] = true,
	[3868] = true,[3869] = true,[3870] = true,[3871] = true,[3872] = true,
	[3873] = true,[3874] = true,[3875] = true,[3876] = true,[3877] = true,
	[3878] = true,[3879] = true,[3880] = true,[3881] = true,[3882] = true,
	[3883] = true,[3884] = true,[3885] = true,[3886] = true,[3887] = true,
	[3888] = true,[3889] = true,[3890] = true,[3891] = true,[4893] = true,
	[4949] = true,[4950] = true,[5300] = true,[5324] = true,[5377] = true,
	[5424] = true,[5793] = true,[5794] = true,[5795] = true,[5796] = true,
	[5797] = true,[5798] = true,[5799] = true,[5800] = true,[5801] = true,
	[5802] = true,[5803] = true,[5804] = true,[5805] = true,[5806] = true,
	[5807] = true,[5808] = true,[5809] = true,[5810] = true,[5811] = true,
	[5812] = true,[5813] = true,[5814] = true,[5815] = true,[5816] = true,
	[5817] = true,[5818] = true,[5819] = true,[5820] = true,[5821] = true,
	
	}

	function toggleStupidSoundscapes()
		if(dumbsoundscapes) then
			for k,v in pairs(dumbsoundscapes) do
				local wtf = ents.GetMapCreatedEntity(k)

				--on the server this is true for some reason, but in sp its not
				--if(wtf:GetInternalVariable("m_bDisabled")) then
				wtf:Fire("ToggleEnabled")
				--end
			end
		end
		
	end

	function FUCKYOUDOORS()
		for k,v in pairs(doors) do
			local door1 = ents.GetMapCreatedEntity(v[1])
			local door2 = ents.GetMapCreatedEntity(v[2])

			if(IsValid(door1) and IsValid(door2)) then
				door1.nutPartner = door2
				door2.nutPartner = door1
			end
		end
	end

	SETUPMAPTHING = SETUPMAPTHING or false
	hook.Add("PlayerInitialSpawn", "c8neo", function(ply)
	--hook.Add("InitPostEntity", "c8neo", function(ply)
		if(game.GetMap() != "rp_city8_c72_v2") then return end --**f change
		if(SETUPMAPTHING) then return end
		SETUPMAPTHING = true

		for k,v in pairs(doors) do
			local door1 = ents.GetMapCreatedEntity(v[1])
			local door2 = ents.GetMapCreatedEntity(v[2])

			if(IsValid(door1) and IsValid(door2)) then
				door1.nutPartner = door2
				door2.nutPartner = door1
			end
		end

		--**idk what this is lol
		--[[local door = ents.GetMapCreatedEntity(3796)
		if(IsValid(door)) then
			door:SetSaveValue("m_flWait", 4)
		end]]

		timer.Simple(0, function()
			--[[timer.Simple(2, function() --just in case
				if(!nut or !nut.xhair or !nut.xhair.entIgnore) then return end

				--**change door, secret button, and secret door in deep tunnels
				local secr = ents.GetMapCreatedEntity(3804)
				if(secr) then
					nut.xhair.entIgnore[secr:EntIndex()] = true
					--theyre different ents clientside
					--secr:setNetVar("crosshairhide", true)
				end
	
				secr = ents.GetMapCreatedEntity(3796)
				if(secr) then
					nut.xhair.entIgnore[secr:EntIndex()] = true
					--theyre different ents clientside
					--secr:setNetVar("crosshairhide", true)
				end
			end)]]

			--[[--it works now that ive added soundscapes manifest to the map file..?
			--still only works in sp..
			if(dumbsoundscapes and !game.SinglePlayer()) then
				for k,v in pairs(dumbsoundscapes) do
					local wtf = ents.GetMapCreatedEntity(k)

					--on the server this is true for some reason, but in sp its not
					--if(wtf:GetInternalVariable("m_bDisabled")) then
					wtf:Fire("ToggleEnabled")
				--	end
				end
			end
			]]
		end)
	end)

	--disables widgets (apparently has an impact on server performance? idk), should be done SERVERSIDE
	hook.Add( "PreGamemodeLoaded", "widgets_disabler_cpu", function()
		if(game.SinglePlayer()) then return end
	
		function widgets.PlayerTick()
			-- empty
		end
		hook.Remove( "PlayerTick", "TickWidgets" )
		MsgN( "Widgets disabled!" )
	end )

else--client
	local ignore = {
		[1619] = true,
		[1919] = true,
		[1622] = true,
		[2462] = true,
		[2463] = true,
	}
	hook.Add("Initialize", "c8neo", function(ply)
		if(game.GetMap() != "rp_city8_c72_v2") then return end

		
		timer.Simple(2, function() --just in case
			if(!nut or !nut.xhair or !nut.xhair.entIgnore) then return end

			for k,v in pairs(ignore) do
				nut.xhair.entIgnore[k] = true
			end
		end)
	end)

end

csgo_flashtime = 5
csgo_flashfade = 2
csgo_flashdistance = 1280
csgo_flashdistancefade = 1280 - 512

local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0.0,
	["$pp_colour_contrast"] = 1.0,
	["$pp_colour_colour"] = 1.0,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

hook.Add("RenderScreenspaceEffects", "TFA_CSGO_FLASHBANG", function()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	local flashtime = ply:GetNWFloat("LastFlash", -999)
	local flashdistance = ply:GetNWFloat("FlashDistance", 0)
	local flashfac = ply:GetNWFloat("FlashFactor", 1)
	local distancefac = 1 - math.Clamp((flashdistance - csgo_flashdistance + csgo_flashdistancefade) / csgo_flashdistancefade, 0, 1)
	local intensity = 1 - math.Clamp(((CurTime() - flashtime) / distancefac - csgo_flashtime + csgo_flashfade) / csgo_flashfade, 0, 1)
	intensity = intensity * distancefac
	intensity = intensity * math.Clamp(flashfac + 0.1, 0.35, 1)

	if intensity > 0.01 then
		tab["$pp_colour_brightness"] = math.pow(intensity, 3)
		tab["$pp_colour_colour"] = 1 - intensity * 0.33
		DrawColorModify(tab) --Draws Color Modify effect
		DrawMotionBlur(0.2, intensity, 0.03)
	end
end)

--mmod stuff

sound.Add({
	name = 			"AR2_Ball.Empty",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ar2/ar2_empty2.wav"
})
sound.Add({
	name = 			"AR2.Activate",
	channel = 		CHAN_ITEM,
	volume = 		1.0,
	sound = 			"weapons/ar2/ar2b.wav"
})
sound.Add({
	name = 			"AR2.Altf",
	channel = 		CHAN_VOICE,
	volume = 		1.0,
	sound = 			"weapons/irifle/irifle_fire2.wav"
})
sound.Add({
	name = 			"AR2.Altchar",
	channel = 		CHAN_VOICE,
	volume = 		1.0,
	sound = 			"weapons/cguard/charging.wav"
})