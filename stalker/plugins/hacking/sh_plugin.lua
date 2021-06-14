local PLUGIN = PLUGIN
PLUGIN.name = "Hacking"
PLUGIN.author = "sky"
PLUGIN.desc = "hacking framework and stuff"

--table of things so theyll stay the same between restarts (button disabled, etc)
PLUGIN.mapdata = PLUGIN.mapdata or {}

PLUGIN.programlist = {
	["suspend"] = {
		name = "Suspend V1.0",
		desc = "Stop timer for 5 seconds.",
		itemid = "hackprog_suspend", --itemid to give back
		type = "active", --passive/active
		onstart = function() --should be ran after the games are created
			
		end,
		onuse = function() --for active programs
			if(suspendused) then return end
			local timen = hackmenu.hackpanel.hackp.time
			if(!timen) then return end
			if(hackmenu.hackpanel.hackp.fail) then return end

			suspendactive = true
			timer.Simple(5, function() suspendactive = nil end)
			suspendused = true
		end,
		onfinish = function()
			suspendused = nil
		end
	},
	["rangeext"] = {
		name = "Range Extension V1.0",
		desc = "increases range by 50 percent",
		itemid = "hackprog_rangeext", --itemid to give back
		type = "passive", --passive/active
		oninstall = function(tool)
			tool:setData("hackrange", tool.hackrange * 1.5)
		end,
		onuninstall = function(tool)
			tool:setData("hackrange")
		end,
	},
}

--custom diff numbers that do something when used
--to use these in custom hack base ents, add reallevel which is the actual diff it checks for visibility
local customdiffs = {
	--these are clientside, when the diff is chosen
	[7] = function()
		--return the diff to base it off of, return 0 or below to close the ui
		--could be the same diff as the one to check the trait with
		--or could not be lmao
		nut.util.notify("custom diff test")
		return 0
	end,
}

--lua_run print(Entity(1):GetEyeTrace().Entity:MapCreationID())

local disabledents = {
--filtered ents (buttons/doors that arent hackable)
--MapCreationID so this will need to be fixed each build
--[1471] = true,
	[3796] = true, --secret door
	[3804] = true, --secret door control lock
	[3799] = true, --secret door control
	[3801] = true, --other secret door control
	[4321] = true, --rebel hatch
	[3805] = true, --the door in the garage
	[1483] = true, --shop shutters
	[3664] = true, --shop shutter control
	--all these are shutters and buttons from across of that
	[1460] = true, 
	[3663] = true,
	[3576] = true,
	[3636] = true,
	[3640] = true, --the shutter building thing near the clamp
	[3639] = true, --control for ^
	[1991] = true, --rations announce button
	--a bunch of nexus prison doors
	[2084] = true,
	[2085] = true,
	[2133] = true,
	[2134] = true,
	[2553] = true, --the weird button in the training area, supposed to turn lights off i think
	[3137] = true, --building vent out
	[3136] = true, --building vent in
	[2492] = true, --other vent 
	[2491] = true, --other vent side
	--apt building b sliding apt doors
	[1426] = true,
	[1427] = true,
	[1428] = true,
	[1429] = true,
	[3552] = true, --vent in
	[3555] = true, --vent out
}

local hacktypes = {
	--to use custom diffs, make the value a table: {level = 1, real = 8}
	["prop_physics"] = {
		["playsound"] = 2,
	},
	["prop_physics_multiplayer"] = {
		["playsound"] = 2,
	},
	["nut_item"] = {
		["c4disarm"] = 1,
		["biolockdisable"] = 3, --idk?
	},
	--[["base_entity"] = { --for whatever reason, item is this clientside
		["c4disarm"] = 1,
	}]]
	["func_button"] = {
		--["togglelock"] = 1, --this supports it too
		["toggle"] = 1,
	},
	["func_door"] = {
		["togglelock"] = 1,
		["toggledoor"] = 1,
	},
	["dronesrewrite_base"] = {
		["drone_power"] = 2,
	},
	["npc_turret_floor"] = {
		["turrettoggle"] = 1,
		["friendlytoyou"] = 2,
		["selfdestructturret"] = 3,
	},
	["nut_cmblock"] = {
		["toggleclock"] = 1,
		["detonatelock"] = 2
	},
	["nut_forcefield"] = {
		["switchmode1"] = 1,
		["switchmode2"] = 1,
		["switchmode3"] = 1,
		["switchmode4"] = 1,
		["disablefield"] = 2,
	},
	["nut_hopper"] = {
		["deactivatehop"] = 1,
		["switchfrihop"] = 2,
		["activatehop"] = 2,
	},
	["sky_metaldetector"] = {
		["detectdisable"] = 1,
	}
}

local hackleveloverride = { --overrides the level needed to hack the ent
	--to use custom diffs, make the value a table: {level = 1, real = 8}
	--[[
	[2098] = { --clamp door
		["togglelock"] = 4, --the max is 3, this just adds more difficulty
	},
	[2477] = { --clamp button
		["toggle"] = 4,
	},
	]]
	--[[] = { --get mapid for clamp door
		["togglelock"] = 4,	
	},]]
	[3638] = { --clamp button
		["toggle"] = 4,
	},
	[1926] = { --nexus main
		["togglelock"] = 4,
		["toggledoor"] = 4,
	},
	[3783] = { --nexus garage
		["togglelock"] = 4,
		["toggledoor"] = 4,
	},
	[3795] = { --garage to nexus
		["togglelock"] = 4,
		["toggledoor"] = 4,
	},
	[1544] = { --nexus side
		["togglelock"] = 4,
		["toggledoor"] = 4,
	},
}

local allowedclasses = {
	["prop_physics"] = true,
	["prop_physics_multiplayer"] = true,
	["nut_item"] = true,
	["func_button"] = true,
	["func_door"] = true,
	["dronesrewrite_base"] = true,
	["customhackbase"] = true,
	["npc_turret_floor"] = true,
	["nut_cmblock"] = true,
	["nut_forcefield"] = true,
	["nut_hopper"] = true,
	["sky_metaldetector"] = true,
}

--these doors can be toggled via hacking
local toggleabledoors = {
	[1926] = true,
	[3783] = true,
	[3795] = true,
	[2507] = true,
	[2534] = true,
	[1544] = true,
	[1542] = true,
	[2507] = true,
	[2053] = true,
	[1539] = true,
	[1555] = true,
	[1374] = true,
	[1535] = true,
	[1621] = true,
}

local hackreq = {
	["playsound"] = {
		["models/nt/props_tech/girlbot_head.mdl"] = true,
	},
	["c4"] = function(ent)
		if(ent:getData("armed")) then
			return true
		end
		return false
	end,
	["general_item"] = function(ent) --generic item here
		--biolock hacking
		if(ent:getItemTable().IsWeapon) then
			local itemTable = nut.item.instances[ent.nutItemID]
			if(itemTable and (itemTable.biolock or itemTable:getData("biolock"))) then
				return "biolock"
			end
		end
		return false
	end,
	["toggledoor"] = function(ent)
		if(toggleabledoors[ent:MapCreationID()]) then
			return true
		end
		return false
	end,
}

local playsounds = {
	["models/nt/props_tech/girlbot_head.mdl"] = {
		"gameplay/ghost_equip.wav",
		"gameplay/ghost_equip2.wav",
		"gameplay/ghost_equip3.wav",
		"gameplay/ghost_equip4.wav",
		"gameplay/ghost_equip5.wav",
	}
}
--lua_run print(Entity(1):GetEyeTrace().Entity:GetName())
--map ents name translations
local transl = {
	--ent name or map creaiton id
	--["secretdoor"] = "NotASecretDoor",
	--[1614] = "secret door control",
	["UMdoor"] = "hospital door",
	["UMDoor"] = "hospital door",
	[2278] = "hospital door control out",
	[2279] = "hospital door control in",
	[1992] = "cwu side door in",
	[3673] = "cwu side door out",
	[1996] = "cwu road door control",
	["door5"] = "cwu road door",
	["garagedoor"] = "cwu garage door",
	[3784] = "cwu garage door control",
	[3810] = "garage lift start",
	[3811] = "garage lift stop",
	[3812] = "garage lift reverse",
	[3795] = "garage nexus door",
	["amariadoor"] = "cwu office door",
	[2033] = "cwu office door control in",
	[2035] = "cwu office door control out",
	[2043] = "cwu office lift control bot",
	[2044] = "cwu office lift control top",
	["mainhoteldoor"] = "apt building b main door",
	[1443] = "apt building b door control in",
	[1444] = "apt building b door control out",
	["shackdoor"] = "genericslidingdoor",
	[1458] = "door control out",
	[1457] = "door control in",
	["clamp"] = "!CLAMP DOOR",
	[1621] = "ration door",
	[3638] = "!CLAMP CONTROL",
	[1926] = "!NEXUS MAIN DOOR",
	[3783] = "!NEXUS GARAGE DOOR",
	[2507] = "!NEXUS TRAINING DOOR",
	[2534] = "!NEXUS TRAINING CONTROL DOOR",
	["controlroomdoor"] = "!NEXUS CONTROL ROOM DOOR",
	[1982] = "!NEXUS CONTROL DOOR CONTROL IN",
	[1983] = "!NEXUS CONTROL DOOR CONTROL OUT",
	[1544] = "!NEXUS SIDE DOOR",
	["officedoor"] = "!NEXUS OFFICE DOOR",
	[2065] = "!NEXUS OFFICE DOOR CONTROL IN",
	[2061] = "!NEXUS OFFICE DOOR CONTROL OUT",
	[2053] = "!NEXUS STORAGE DOOR",
	[1542] = "!TRANSPORT SIDE DOOR",
	[1539] = "road door 3 side door",
	["door3"] = "road door 3",
	[1547] = "road door 3 control",
	[1552] = "road door 4 control",
	["door4"] = "road door 4",
	[1555] = "road door 4 side door",
	["door1"] = "road door 1",
	[1374] = "road door 1 side door",
	[1997] = "road door 1 control",
	[1658] = "lift control bot",
	[1519] = "lift control top",
	[1534] = "road door 2 control",
	["door2"] = "road door 2",
	[1535] = "road door 2 side door",
	[4264] = "d3 checkpoint control door",
	[4266] = "d3 checkpoint top door control",
	[4267] = "d3 checkpoint bot door control",--bot control
	[4263] = "d3 checkpoint top door", --top door
	[4262] = "d3 checkpoint bot door", --bot door
}

local function getentname(ent)
	if(transl[ent:MapCreationID()]) then
		return transl[ent:MapCreationID()]
	end
	if(transl[ent:GetName()]) then
		return transl[ent:GetName()]
	end

	if(ent.hackname) then 
		if(type(ent.hackname) == "function") then
			return ent:hackname()
		end
		return ent.hackname 
	end

	if(ent.getItemID and ent:getItemID() == "c4") then
		return "RemoteExpID"..ent.nutItemID
	end
	if(ent.getItemTable and ent:getItemTable().IsWeapon) then
		local itemTable = nut.item.instances[ent.nutItemID]
		if(itemTable and (itemTable.biolock or itemTable:getData("biolock"))) then
			return "BiolockID"..ent.nutItemID
		end
	end

	if(ent:GetModel() == "models/nt/props_tech/girlbot_head.mdl") then
		return "girlbotid#"..ent:GetCreationID()
	end

	if(ent.Base == "dronesrewrite_base") then
		return ent:GetUnit()
	end

	return ent:GetName()
end

local enttrans = {
	["func_button"] = "Button Interface",
	["func_door"] = "Door Interface",
	["npc_turret_floor"] = "Turret",
}

local function getenttype(ent)
	if(enttrans[ent:MapCreationID()]) then
		return enttrans[ent:MapCreationID()]
	end
	if(enttrans[ent:GetClass()]) then
		return enttrans[ent:GetClass()]
	end

	if(ent.hacktype) then 
		if(type(ent.hacktype) == "function") then
			return ent:hacktype()
		end
		return ent.hacktype 
	end

	if(ent.getItemID and ent:getItemID() == "c4") then
		return "Explosive"
	end
	if(ent.getItemTable and ent:getItemTable().IsWeapon) then
		local itemTable = nut.item.instances[ent.nutItemID]
		if(itemTable and (itemTable.biolock or itemTable:getData("biolock"))) then
			return "Weapon with Biolock"
		end
	end

	if(ent:GetModel() == "models/nt/props_tech/girlbot_head.mdl") then
		return "GIRLBOT Prototype"
	end

	if(ent.Base == "dronesrewrite_base") then
		return ent.UNIT.."-type drone"
	end

	return ent:GetClass()
end

do
	local playerMeta = FindMetaTable("Player")
	function playerMeta:getHackTool()
		if(!self:getChar()) then return nil end
		local inv = self:getChar():getInv()
		for k,v in pairs(inv:getItems()) do
			if(v.base == "base_hacktool" and v:getData("equip")) then
				return v
			end
		end
		return nil --not sure if this is needed tbh, probably isnt
	end
end

nut.command.add("hackmenu", {
	desc = "Open the menu for your hacktool if you have it equipped",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		if(client:getHackTool()) then --umm better once this is done out
			net.Start("openhkmenu")
			net.Send(client)
		else
			return "You don't have a hacking tool."
		end
	end
})
if(SERVER) then
	util.AddNetworkString("requestnearbyents")
	util.AddNetworkString("givenearbyents")
	util.AddNetworkString("openhkmenu")
	util.AddNetworkString("hackent")
	util.AddNetworkString("hackfail")
	net.Receive("requestnearbyents", function(len, ply)
		if(ply:getNetVar("isjammed")) then ply:notify("There is a jammer nearby!") return end
						--honestly this should just fail if they forwhateverreason dont have a hacktool but whatever lmao
		local ents = ents.FindInSphere(ply:getHackTool():getSearchPos() or ply:GetPos(), ply:getHackTool():getData("hackrange") or ply:getHackTool().hackrange or 5)
		local tbl = {}
		local finished = {}
		for k,v in pairs(ents) do
			if(!allowedclasses[v:GetClass()] and !allowedclasses[v.Base]) then continue end --add way to get stuff through that arent normally hackable but can be atm

			if(disabledents[v:MapCreationID()]) then continue end

			if((v:GetClass() == "prop_physics" or v:GetClass() == "prop_physics_multiplayer") and !hackreq["playsound"][v:GetModel()]) then 
				--chcek other things here if theres more idk
				continue 
			end --special thing becuz this only supports 1 model rn

			--print(v, v:GetClass(), v.getItemID and v:getItemID() or "no", tostring((v.getItemID and hackreq[v:getItemID()] and hackreq[v:getItemID()](v) == false) or "no"))
			if(v:GetClass() == "nut_item" and (!hackreq[v:getItemID()] or (hackreq[v:getItemID()] and hackreq[v:getItemID()](v) == false))) then continue end
			if(v:GetClass() == "nut_item" and hackreq["general_item"](v) == false) then	continue end

			if(finished[v:GetName()]) then continue end
			if(v:MapCreationID() != -1 and v:GetName() != "") then
				finished[v:GetName()] = true
			end

			tbl[v:EntIndex()] = {getentname(v), getenttype(v), math.Round(ply:getHackTool():getSearchPos():Distance(v:GetPos())), (v:GetClass() == "nut_item" and "nut_item" or (!v.Base or v.Base == "base_gmodentity") and v:GetClass() or v.Base)} --idk, filter and stuff

			tbl[v:EntIndex()][6] = ((v.Base and v.Base == "customhackbase") and v)
			tbl[v:EntIndex()][9] = v:MapCreationID()
		end

		net.Start("givenearbyents")
		net.WriteTable(tbl)
		net.Send(ply)
	end)
	
	net.Receive("hackent", function(len, ply)
		local entid = net.ReadInt(32)
		local type = net.ReadString()

		HackEnt(ply, ents.GetByIndex(entid), type)
	end)
	net.Receive("hackfail", function(len, ply)
		local entid = net.ReadInt(32)
		local type = net.ReadString()
		local ent = ents.GetByIndex(entid)
		if(IsValid(ent)) then
			if(ent.Base == "customhackbase") then
				if(ent.hackTypes[type]) then 
					if(ent.hackTypes[type].onFail) then
						ent.hackTypes[type].onFail(ent, ply)
					end
				end
			end
		end
	end)


	function HackEnt(ply, entity, type)
		--ply verification
		if(!IsValid(entity)) then return end

		if(disabledents[entity:MapCreationID()]) then return end --this should never be true but just in case

		if(entity.Base == "customhackbase") then
			if(entity.hackTypes[type]) then --THERESADIFFERENCE
				if(entity.hackTypes[type].level > (nut.traits.hasTrait(ply, "tech_hack") or 0)) then
					nut.log.addRaw(ply:Name().." just tried to hack ("..type..") an entity ("..entity:GetClass().."), but they dont have the level to do this, this should NEVER happen normally :thinking:", FLAG_WARNING)
					return
				end

				entity.hackTypes[type].onRun(entity, ply)
				return
			end
		end


		if((hacktypes[entity:GetClass()] and hacktypes[entity:GetClass()][type]) or (hacktypes[entity.Base] and hacktypes[entity.Base][type])) then
			local amt = (hacktypes[entity:GetClass()] and hacktypes[entity:GetClass()][type]) or (hacktypes[entity.Base] and hacktypes[entity.Base][type])
			if(istable(amt)) then amt = amt.real end --will this work?
			
			if(amt > (nut.traits.hasTrait(ply, "tech_hack") or 0)) then
				nut.log.addRaw(ply:Name().." just tried to hack ("..type..") an entity ("..entity:GetClass().."), but they dont have the level to do this, this should NEVER happen normally :thinking:", FLAG_WARNING)
				return
			end

			if(type == "playsound" and hackreq[type][entity:GetModel()]) then
				local ed = EffectData()
				ed:SetOrigin(entity:GetPos())
				ed:SetMagnitude(math.Rand(1, 2))
				ed:SetAngles(Angle(0, math.Rand(75, 125), math.Rand(0, 359)))

				util.Effect("ElectricSpark", ed)
				entity:EmitSound(playsounds[entity:GetModel()][math.random(#playsounds[entity:GetModel()])], 65, math.Rand(97, 103))
				--no xp
			end
			if(type == "c4disarm" and hackreq[entity:getItemID()](entity)) then
				local item = nut.item.instances[entity.nutItemID]
				item:setData("armed", nil)
				--just realized i dont think itll update so here
				local d = entity:getNetVar("data", {})
				d["armed"] = nil
				entity:setNetVar("data", d)

				nut.traits.addXp(ply, "tech_hack", 2)
				--no xp
			end
			if(type == "biolockdisable" and entity:GetClass() == "nut_item" and hackreq["general_item"](entity) == "biolock") then	
				local itemTable = nut.item.instances[entity.nutItemID]
				if(itemTable and itemTable.HackUnlockBio) then
					itemTable:HackUnlockBio()
				end
				nut.traits.addXp(ply, "tech_hack", 6)
			end
			if(type == "toggle") then
				entity:Fire("Press")
				 --no xp
				nut.traits.addXp(ply, "tech_hack", 1)
			end
			if(type == "togglelock") then
				if(entity:MapCreationID() != -1 and entity:GetName() != "") then
					for k,v in pairs(ents.FindByName(entity:GetName())) do
						
						if(v:GetInternalVariable("m_bLocked")) then--GetSaveTable()["m_bLocked"]) then 
							v:Fire("Unlock")
							if(!v.notlockedbydefault) then
							timer.Create("relockdoor"..v:MapCreationID(), 180, 1, function()
								if(IsValid(v)) then
									v:Fire("Lock")
								end
							end)
							end
						else
							v:Fire("Lock")
							v.notlockedbydefault = true
							timer.Remove("relockdoor"..v:MapCreationID())
						end
					end
				end
				nut.traits.addXp(ply, "tech_hack", 1)
			end
			if(type == "toggledoor") then
				local old = entity:GetInternalVariable("m_toggle_state")
				entity:Fire("toggle")
				 --no xp
				timer.Simple(12, function()
					if(!IsValid(entity)) then return end
					local cur = entity:GetInternalVariable("m_toggle_state")
					if(old == 1 or old == 3) then
						if(cur == 1 or cur == 3) then
							return  --no change
						end
						entity:Fire("toggle")
					else
						if(cur == 0 or cur == 2) then
							return  --no change
						end
						entity:Fire("toggle")
					end
				end)
				nut.traits.addXp(ply, "tech_hack", 1)
			end

			--turret
			if(type == "turrettoggle") then
				v:Fire("Toggle")
				timer.Simple(180, function()
					v:Fire("Toggle") --thisll fuck up if more than 1 person does it but thatll work for now
				end)
				nut.traits.addXp(ply, "tech_hack", 2)
			end
			if(type == "friendlytoyou") then
				v:AddEntityRelationship(ply, D_LI, 99)
			end
			if(type == "selfdestructturret") then
				v:Fire("SelfDestruct")
				nut.traits.addXp(ply, "tech_hack", 8) --1
			end

			--drone hacking
			if(type == "drone_power") then
				entity:SetEnabled(!entity.Enabled) --swap
			end

			--cmb lock
			if(type == "toggleclock") then
				entity:toggle(nil, true)
				nut.traits.addXp(ply, "tech_hack", 4)
			end
			if(type == "detonatelock") then
				entity:detonate(ply, true)
				nut.traits.addXp(ply, "tech_hack", 8)
			end
			
			--forcefield
			if(type:find("switchmode")) then
				local var = type[-1]

				entity:HackChangeMode(tonumber(var))
				nut.traits.addXp(ply, "tech_hack", 1)
			end
			if(type == "disablefield") then
				entity:HackDisableUsage()
				nut.traits.addXp(ply, "tech_hack", 4)
			end

			--hopper
			if(type == "deactivatehop") then
				entity:Disable(true)
				nut.traits.addXp(ply, "tech_hack", 2)
			end
			if(type == "switchfrihop") then
				entity:setNetVar("switched", true)
			
				SCHEMA:addDisplay("!WARN: MINE"..ent:EntIndex().." REPORT ERROR USER DISP_CHANGE", RARITY_COLORS[RARITY_NOTWARN])

				nut.traits.addXp(ply, "tech_hack", 4)
			end
			if(type == "activatehop") then
				entity:Enable(true)
				nut.traits.addXp(ply, "tech_hack", 2)
			end

			--detector
			if(type == "detectdisable") then
				entity:ToggleField(nil, true)
				nut.traits.addXp(ply, "tech_hack", 2)
			end
		end
	end
else
	net.Receive("givenearbyents", function()
		local list = hackmenu.list
		if(!list) then return end --wtf?

		list:Clear()
		
		local ents = net.ReadTable()
		for k,v in pairs(ents) do
			
			local li = list:AddLine(k, v[1], v[2], v[3])
			li.realclass = v[4]
			if(v[6]) then
				li.ent = v[6]
			end
			if(v[9]) then
				li.mapid = v[9]
			end
		end
	end)

	net.Receive("openhkmenu", function()
		if(LocalPlayer() and LocalPlayer().getChar and LocalPlayer():getChar()) then
			DisplayHackMenu()
		end
	end)


	hackmenu = hackmenu or nil

	--[[
	--remove this and make it on an item prob
	concommand.Add("nut_displayhack", function()
		if(LocalPlayer() and LocalPlayer().getChar and LocalPlayer():getChar()) then
			DisplayHackMenu()
		end
	end, nil, "displays hack menu for testing")
	]]

	function DisplayHackMenu()
		hackmenu = vgui.Create("DFrame")
		local base = hackmenu
		base:SetSize(ScrW()/1.5, ScrH()/1.5)
		base:SetTitle("hack tool ui v0.026")
		base:SetDraggable(true)
		base:MakePopup()
		base:SetKeyboardInputEnabled(false)
		base:Center()
		base:DockPadding(0, 25, 0, 0)
		function base:OnRemove()
			if(LocalPlayer():getHackTool() and LocalPlayer():getHackTool():getData("programs")) then
				local progs = LocalPlayer():getHackTool():getData("programs")
				
				for k,v in pairs(progs) do
					if(PLUGIN.programlist[k] and PLUGIN.programlist[k].onfinish) then
						PLUGIN.programlist[k].onfinish()
					end
				end
			end
		end

		--good ents in list on left, button on top for refresh
		local left = base:Add("DPanel")
		left:SetSize(base:GetWide()*0.3, base:GetTall())
		left:Dock(LEFT)

		--hacking window on right?
		local right = base:Add("DPanel")
		hackmenu.hackpanel = right
		--right:SetPos(base:GetWide()*0.25, 0)
		right:SetSize(base:GetWide()*0.7, base:GetTall())
		right:Dock(RIGHT)

		--putting this up here lmao
		local list = left:Add("DListView")
		hackmenu.list = list
		list:SetSize(left:GetWide(), left:GetTall())
		list:Dock(FILL)
		list:SetSortable(true)
		list:SetPaintBackground(false)
		--probably will be changed
		list:AddColumn("ID")
		list:AddColumn("Name")
		list:AddColumn("Type")
		list:AddColumn("Distance")


		list.OnRowSelected = function(self, ind, row)
			if(hackmenu.locked) then hackmenu.list:ClearSelection() return end --dont let them change while in minigame

			--hack move
			DisplayHackGame({row:GetColumnText(1), row:GetColumnText(2), row:GetColumnText(3), row:GetColumnText(4), row.realclass, row.ent, row.mapid})
		--	hackmenu.hackpanel.test:SetText(row:GetColumnText(2))
		end
		
		local refresh = left:Add("DButton")
		refresh:SetText("Refresh")
		refresh:SetPaintBackgroundEnabled(true)
		refresh:SetBGColor(Color(220,220,220))
		refresh.DoClick = function(self)
			net.Start("requestnearbyents")
			net.SendToServer()
		end
		refresh:Dock(TOP)

		left:InvalidateChildren()
		right:InvalidateChildren()
	end

	function DisplayHackGame(entdata)
		local panel = hackmenu.hackpanel

		--PrintTable(entdata)

		local hacktype = ""

		if(!panel) then return end --idk

		if(panel.info) then
			panel.info:Remove()
		end
		if(panel.hackp) then
			panel.hackp:Remove()
		end

		local infopanel = panel:Add("DPanel")
		infopanel:SetSize(panel:GetWide(), panel:GetTall()*0.05)
		infopanel:Dock(TOP)
		panel.info = infopanel
		--power ups selection could go on info panel somewhere

		local hackp = panel:Add("DPanel")
		hackp:SetPos(0, panel:GetTall()*0.05)
		hackp:SetSize(panel:GetWide(), panel:GetTall()*0.95)
		hackp:SetBackgroundColor(Color(255, 0,0))
		hackp:Dock(BOTTOM)
		panel.hackp = hackp

		--put the program list somewhere on the infopanel (far left or far right idk)
		--have it be a topdown of only active programs (mebi?)
		--when one gets selected, onuse is called
		--have choice at the top for a nevermind that doesnt do anything and 
		--goes back to the initial text
		--display the list even if theres no programs on the hacktool, but make it
		--unselectable and have no default text
		local sel = infopanel:Add("DComboBox")
		--selc:SetPos(infopanel:GetWide()*0.4, 0)
		sel:SetSize(infopanel:GetWide()*0.2, infopanel:GetTall())
		if(LocalPlayer():getHackTool() and LocalPlayer():getHackTool():getData("programs")) then
			--set up active programs
			local progs = LocalPlayer():getHackTool():getData("programs")
			sel:SetValue("Select Active")

			for k,v in pairs(progs) do
				if(PLUGIN.programlist[k] and PLUGIN.programlist[k].type == "active") then
					sel:AddChoice(k)
				end
			end
			sel.OnSelect = function(self, ind, val)
				if(val == "Select Active") then return end --uh just in case
				PLUGIN.programlist[val].onuse()
				sel:SetValue("Select Active") --reset
			end
		else		
			sel:SetValue("")
			sel:SetEnabled(false)
		end
		

		local labl = infopanel:Add("DLabel")
		labl:SetText("Selected: "..entdata[2])
		labl:SetPos(infopanel:GetWide()*0.2, 0)
		labl:SetContentAlignment(5)
		labl:SetSize(infopanel:GetWide()*0.3, infopanel:GetTall())
		

		local selc = infopanel:Add("DComboBox")
		selc:SetPos(infopanel:GetWide()*0.5, 0)
		selc:SetSize(infopanel:GetWide()*0.3, infopanel:GetTall())
		selc:SetValue("select hack type")
		local diff = 1
		local difss = {}
		if(entdata[6]) then --custom hack base
			for k,v in pairs(entdata[6].hackTypes) do --this should be shared
				if(math.min(v.reallevel or v.level, 3) <= (nut.traits.hasTrait(LocalPlayer(), "tech_hack") or 0)) then
					selc:AddChoice(k)
					difss[k] = v.level
				end
			end
		else
			--this world ent ahs a specific diff level, use that instead
			if(hackleveloverride[entdata[7]]) then
				for k,v in pairs(hackleveloverride[entdata[7]]) do
					if(math.min(istable(v) and v.real or v, 3) <= (nut.traits.hasTrait(LocalPlayer(), "tech_hack") or 0)) then
						selc:AddChoice(k)
						difss[k] = istable(v) and v.level or v
					end
				end
			else
				for k,v in pairs(hacktypes[entdata[5]]) do
					if(math.min(istable(v) and v.real or v, 3) <= (nut.traits.hasTrait(LocalPlayer(), "tech_hack") or 0)) then
						selc:AddChoice(k)
						difss[k] = istable(v) and v.level or v
					end
				end
			end
		end
		if(#selc.Choices == 0) then
			selc:AddChoice("no hack types available")
		end
		selc.OnSelect = function(self, ind, val)
			if(val == "no hack types available") then hacktype = "" diff = 1 return end --uh just in case
			hacktype = val
			diff = difss[val] 
		end

		local conf = infopanel:Add("DButton")
		conf:SetPos(infopanel:GetWide()*0.8, 0)
		conf:SetSize(infopanel:GetWide()*0.2, infopanel:GetTall())
		conf:SetText("Confirm Type")
		conf.DoClick = function(self)
			if(hacktype == "") then return end
			hackmenu.locked = true

			if(panel.hackp) then
				panel.hackp:Remove()
				
				local hackp = panel:Add("DPanel")
				hackp:SetPos(0, panel:GetTall()*0.05)
				hackp:SetSize(panel:GetWide(), panel:GetTall()*0.95)
				hackp:SetBackgroundColor(Color(255, 0,0))
				hackp:Dock(BOTTOM)
				panel.hackp = hackp
			end

			GenerateGame(entdata, hacktype, diff)
		end
	end

	function GenerateGame(entdata, type, diff)
		--custom diff stuff
		if(customdiffs[diff]) then
			diff = customdiffs[diff]()
			if(diff <= 0) then
				--kill it all
				hackmenu:Remove()
			end
		end

		--generate game
		--two games:
		--first one is one that needs to be started manually, and
		--it gives time to work on the second one
		--it can be done a limited number of times but has to be done once
		--second one is time limited (first one gives time)
		--completing it will perform the hack
		--the games picked are randomly picked out of a set of games
		local infopanel = hackmenu.hackpanel.hackp:Add("DPanel")
		infopanel:SetSize(hackmenu.hackpanel.hackp:GetWide(), hackmenu.hackpanel.hackp:GetTall()*0.1)
		infopanel:Dock(TOP)

		hackmenu.hackpanel.hackp.timep = infopanel:Add("DLabel")
		local time = hackmenu.hackpanel.hackp.timep
		time:Dock(FILL)
		time:SetContentAlignment(5)
		time:InvalidateParent(true)
		time:SetText("")

		if(timer.Exists("hacktimer")) then
			timer.Remove("hacktimer")
		end
		timer.Create("hacktimer", 1, 0, function()
			if(!hackmenu or !hackmenu.hackpanel or !hackmenu.hackpanel.hackp) then
				timer.Remove("hacktimer")
				return
			end

			local timen = hackmenu.hackpanel.hackp.time
			if(!timen) then return end --not ready yet

			--program
			if(suspendactive) then return end

			hackmenu.hackpanel.hackp.time = timen - 1 --wasnt working using the local idk why
			if(timen > 0) then
			surface.PlaySound("buttons/blip1.wav")
			end
			time:SetText(hackmenu.hackpanel.hackp.time)

			if(timen <= 0) then
				hackmenu.hackpanel.hackp.fail = true
				print("failed minigame: time out")

				surface.PlaySound("buttons/button10.wav")
				if(hackmenu.hackpanel.hackp.left) then
					hackmenu.hackpanel.hackp.left:OnFail()
				end
				if(hackmenu.hackpanel.hackp.right) then
					hackmenu.hackpanel.hackp.right:OnFail()
				end
				timer.Remove("hacktimer")
				
				if(LocalPlayer():getHackTool() and LocalPlayer():getHackTool():getData("programs")) then
					local progs = LocalPlayer():getHackTool():getData("programs")

					for k,v in pairs(progs) do
						if(PLUGIN.programlist[k] and PLUGIN.programlist[k].onfinish) then
							PLUGIN.programlist[k].onfinish()
						end
					end
				end
				net.Start("hackfail")
				net.WriteInt(entdata[1], 32)
				net.WriteString(type)
				net.SendToServer()
			end
		end)
		
		--since i feel like this might be long, im seperating them up
		GenerateFirst(entdata,type,diff)
		GenerateMain(entdata,type,diff)
	end
	
--wish there was a default table.shuffle thing but this is fine
local function shuffle(tbl)
	local size = #tbl
	for i = size, 1, -1 do
		local rand = math.random(size)
		tbl[i], tbl[rand] = tbl[rand], tbl[i]
	end
	return tbl
end

	--game types:
	--'shadowrun' - keypad simon says-like game, theres a keypad and 
	--a sequence flashes when it starts, after the sequences finishes, 
	--repeat it, gets harder after more plays
	--'cockie clicker' - a single button that adds a little bit of time
	--every time its clicked, can only be clicked so many times at once
	--has an overheat if it goes past a certain amount in the last like
	--3 seconds(?) where it cant be pressed for a certain amount of time
	--first click gives a 5 second start, then it goes lower and lower 
	--fairly quickly until it just stays at like 0.01 or something
	--'whack' - area that a button occasionally appears in, clicking it
	--gives time but skipping it gives a strike and removes time
	--3 strikes disables the minigame
	--
	function GenerateFirst(entdata, type, diff)
		local gty = 1--math.random(1,3) --not sure if best way to do this
		local panel = hackmenu.hackpanel.hackp --lol

		if(panel.left) then
			panel.left:Remove()
		end

		panel.left = panel:Add("DPanel")
		local hack = panel.left
		hack:SetSize(panel:GetWide()*0.3, panel:GetTall())
		hack:Dock(LEFT)

		--shadowrun
		if(gty == 1) then
			local kp = hack:Add("DPanel")
			kp:SetPos(hack:GetWide()*0.15, hack:GetTall()*0.1)--hack:GetTall()*0.9) --middle
			kp:SetSize(hack:GetWide()*0.7, hack:GetTall()*0.5)

			local bot = kp:Add("DButton")
			bot:SetPos(0, kp:GetTall()*0.75)
			bot:SetSize(kp:GetWide(), kp:GetTall()*0.25)
			bot:Dock(BOTTOM)
			bot:SetText("Start (0/9)")
			bot.DoClick = function(self)
				if(panel.fail or panel.comp or hack.start or (hack.times and hack.times > 9)) then return end


				hack.start = true
				hack.times = (hack.times and hack.times+1) or 1
				bot:SetText("Start ("..hack.times.."/9)")
				--probably better way to do this but watever lmao
				if(hack.times and hack.times > 6) then --6 numbers
					hack.comb = {
						math.random(1,9),
						math.random(1,9),
						math.random(1,9),
						math.random(1,9),
						math.random(1,9),
						math.random(1,9),
					}
				elseif(hack.times and hack.times > 3) then --5 numbers
					hack.comb = {
						math.random(1,9),
						math.random(1,9),
						math.random(1,9),
						math.random(1,9),
						math.random(1,9),
					}
				else
					hack.comb = {
						math.random(1,9),
						math.random(1,9),
						math.random(1,9),
						math.random(1,9),
					}
				end

				--flash keypad numbers
				for k,v in pairs(hack.comb) do
					timer.Simple(0.7*(k-1), function()
					kp.grid:GetItems()[v]:Flash(Color(0, 255, 0), 0.5)
					surface.PlaySound("phone/phone_dial_nr"..v..".wav")
					end)
				end

				
				timer.Simple((0.7*#hack.comb)-0.1, function()
				hack.next = hack.comb[1]
				hack.doneamt = 0

				hack.active = true
				end)
			end

			kp.grid = kp:Add("DGrid")
			local grid = kp.grid
			grid:SetSize(kp:GetWide(), kp:GetTall()*0.6)
			grid:SetCols(3)
			grid:SetColWide(grid:GetWide()*0.33)
			grid:SetRowHeight(grid:GetTall()*0.33)

			--make keypad
			for i=1, 9 do
				local but = vgui.Create("DButton")
				but:SetText(i)
				but:SetSize(grid:GetWide()*0.34, grid:GetWide()*0.34)
				grid:AddItem(but)
				but.DoClick = function(self)
					if(!hack.active) then return end
					if(hack.next != i) then --woops wrong one
						--just reset, dont remember penalties ingame
						--will have to see
						hack.active = false
						hack.start = false

						--signal wrong
						self:Flash(Color(255, 0, 0), 0.6)

						return
					end

					hack.doneamt = hack.doneamt + 1
					surface.PlaySound("phone/phone_dial_nr"..i..".wav")

					if(hack.doneamt == #hack.comb) then
						--done
						local multi = (diff == 1 and 1 or diff == 2 and 0.8 or diff == 3 and 0.6 or 0.4)
						if(hack.times == 1 or !panel.time) then
							panel.time = math.Round((LocalPlayer():getHackTool() and (LocalPlayer():getHackTool():getData("hackstart") or LocalPlayer():getHackTool().hackstart) or 11) * (diff == 4 and 0.7 or 1) * multi)
						end
						panel.time = math.Round(panel.time + (LocalPlayer():getHackTool() and (LocalPlayer():getHackTool():getData("hackinc") or LocalPlayer():getHackTool().hackinc) or 10) * multi) --idk?

						hack.active = false
						hack.start = false

						--signal done
						for k,v in pairs(kp.grid:GetItems()) do
							v:Flash(Color(0, 0, 255), 0.2)
						end

						return
					end

					hack.next = hack.comb[hack.doneamt+1] --should get next order
					
					--signal right
					self:Flash(Color(0, 255, 0), 0.6)
				end
				but:SetPaintBackgroundEnabled(true)
				local oldperf = but.PerformLayout
				--u need to apparently idk
				function but:PerformLayout()
					if(oldperf) then
						oldperf(self)
					end

					if(self.color) then
						self:SetBGColor(self.color)
					end
				end
				function but:Flash(color, time)
					self.color = color
					self:PerformLayout()
					timer.Simple(time, function()
						if(!self) then return end
						self.color = Color(255,255,255) --i guess this is the original idk
						self:PerformLayout()
					end)
				end
			end

			grid:InvalidateLayout(true)

			--called on failure
			hack.OnFail = function()
				hack.active = false
				hack.start = false
				
			end
			--called on completion
			hack.OnComp = function()
				hack.active = false
				hack.start = false
			
			end
		elseif(gty == 2) then

		elseif(gty == 3) then
		
		end
	end

	--game types:
	--'shadowrun' - theres a pattern at the top, and multiple selections
	--to choose from, the pattern is hidden but parts of it flash every
	--so often randomly, selecting the pattern that matches the top one
	--wins the game
	--'wired' - set of wires (or something buttons mebi?) that need to be 
	--used in a certain order, getting it wrong removes half the time or 
	--10 seconds (whatevers higher), the rules are generated randomly and 
	--hints are put in a panel next to it
	--
	function GenerateMain(entdata, type, diff)
		local gtype = 1--math.random(1,2)
		local hkdiff = diff
		if(hkdiff > 3) then --cap at 3
			hkdiff = 3
		end
		local panel = hackmenu.hackpanel.hackp --lol

		if(panel.right) then
			panel.right:Remove()
		end

		panel.right = panel:Add("DPanel")
		local hack = panel.right
		hack:SetSize(panel:GetWide()*0.7, panel:GetTall())
		hack:Dock(RIGHT)

		--do this when game is won V
		local function won()
			timer.Remove("hacktimer")
			hackmenu.locked = false
			panel.comp = true

			if(LocalPlayer():getHackTool() and LocalPlayer():getHackTool():getData("programs")) then
				local progs = LocalPlayer():getHackTool():getData("programs")
				
				for k,v in pairs(progs) do
					if(PLUGIN.programlist[k] and PLUGIN.programlist[k].onfinish) then
						PLUGIN.programlist[k].onfinish()
					end
				end
			end

			net.Start("hackent")
			net.WriteInt(entdata[1], 32)
			net.WriteString(type)
			net.SendToServer()
		end
		
		if(gtype == 1) then
			--make sure to restrict actions on buttons here 
			--if panel.time doesnt exist or is 0
			--at top center is combination that flashes parts of it randomly
			hack.comb = {}
			for i=1, 3+hkdiff do
				table.insert(hack.comb, math.random(1,6))
			end

			local top = hack:Add("DPanel")
			top:SetSize(hack:GetWide()*(0.35+(hkdiff*0.1)), hack:GetTall()*0.15)
			top:SetPos(hack:GetWide()/2, hack:GetTall()*0.2)
			top:SetBackgroundColor(Color(120, 120, 120))
			local combut = {}
			for k,v in pairs(hack.comb) do
				local d = top:Add("DButton")
				d:SetSize(top:GetWide()/#hack.comb, top:GetTall())
				d:SetPos(top:GetWide()/#hack.comb*(k-1), 0)
				--d:Dock(TOP)
				d:SetText(v)
				d:SetTextColor(Color(255,255,255,0))
				d:SetEnabled(false)
				table.insert(combut, d)
				function d:Flash(color, time)
					self:SetTextColor(color)
					timer.Simple(time, function()
						if(!self) then return end
						self:SetTextColor(Color(120,120,120,0)) --i guess this is the original idk
					end)
				end
			end
			top:Dock(TOP)
			top:InvalidateLayout()

			timer.Create("shadowtime", 1, 0, function()
				if(!hackmenu or !hackmenu.hackpanel or !hackmenu.hackpanel.hackp) then
					timer.Remove("shadowtime")
					return
				end

				if(hackmenu.hackpanel.hackp.fail) then timer.Remove("shadowtime") return end --not yet
				if(!panel.time or panel.time <= 0) then return end --not yet
	
				if(math.random(1,#hack.comb) <= 2) then
					combut[math.random(1,#combut)]:Flash(Color(120,120,120,255), 0.8)
				end
			end)

			--below in tile layout is set of combinations
			--randomly generated but 1 matches the combination
			local combinations = {}
			for i=1, 11 do
				combinations[i] = {}
				for d=1, 3+hkdiff do
					table.insert(combinations[i], math.random(1,6))
				end
				--in case the combination is the same regen it
				while(table.concat(hack.comb) == table.concat(combinations[i])) do
					combinations[i] = {}
					for d=1, 3+hkdiff do
						table.insert(combinations[i], math.random(1,6))
					end
				end
			end
			combinations[12] = table.Copy(hack.comb)

			shuffle(combinations)

			local p = hack:Add("DScrollPanel")
			p:SetSize(hack:GetWide(), hack:GetTall()*0.7)
			p:Dock(BOTTOM)

			local winbut = {}

			local ii = 1
			for k,v in pairs(combinations) do
				local top = p:Add("DPanel")
				top:SetSize(p:GetWide()*(0.22+(hkdiff*0.1)), p:GetTall()*0.13)
				if(k == 7) then ii = 1 end
				ii = ii + 1
				top:SetPos((k > 6) and p:GetWide()-top:GetWide() or 0, top:GetTall()*(ii-1))--(0.13*(ii-1)))--(p:GetTall()*(0.13*(ii-1))))
				top:SetBackgroundColor(Color(120, 120, 120))
				for k2,v2 in pairs(v) do
					local d = top:Add("DButton")
					d:SetSize(top:GetWide()/#v, top:GetTall())
					d:SetPos(top:GetWide()/#v*(k2-1), 0)
					--d:Dock(TOP)
					d:SetText(v2)
					if(table.concat(v) == table.concat(hack.comb)) then
						table.insert(winbut, d)
					end
					d.DoClick = function(self)
						if(panel.fail or panel.comp or !panel.time or panel.time == 0) then return end

						if(table.concat(v) == table.concat(hack.comb)) then
							for k,v in pairs(winbut) do
								v:Flash(Color(0,255,0,255), 0.5)
							end

							surface.PlaySound("buttons/button14.wav")
							
							won()
							for k,v in pairs(combut) do
								v:SetTextColor(Color(120,120,120,255))
							end
							timer.Remove("shadowtime")
							--win
						else
							--lose (lose time?)
							for k,v in pairs(combut) do
								v:Flash(Color(255,0,0,255), 0.1)
							end

							surface.PlaySound("buttons/button8.wav")

							panel.time = math.max(0, panel.time-5)
						end
					end
					function d:Flash(color, time)
						self:SetTextColor(color)
						timer.Simple(time, function()
							if(!self) then return end
							self:SetTextColor(Color(120,120,120,0)) --i guess this is the original idk
						end)
					end
				end
				
			--called on failure
			hack.OnFail = function()
				
			end
			--called on completion
			hack.OnComp = function()
			
			end
				
			end

		elseif(gtype == 2) then

		end
	end
end
