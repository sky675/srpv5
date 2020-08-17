--restrict business menu to people with the flags for it
--[[function SCHEMA:BuildBusinessMenu(panel)
	local char = LocalPlayer():getChar()
	if(char:hasFlags("y") or char:hasFlags("m")) then
		return true
	else
		return false
	end
end]]

hook.Add("CanCreateCharInfo", "hideclass", function()
	return {class = true}
end)

local function try_viewmodel(ent)
	return ent == pac.LocalPlayer:GetViewModel() and pac.LocalPlayer or ent
end

--this is apparently only clientside
hook.Add("PAC3RegisterEvents", "raised", function(createEvent, registerEvent)
	local plyMeta = FindMetaTable("Player")
	local events = {
		{
			name = "weapon_raised",
			args = {},
			available = function() return plyMeta.isWepRaised != nil end,
			func = function(self, eventPart, ent)
				ent = try_viewmodel(ent)
				return ent.isWepRaised and ent:isWepRaised() or false
			end
		}
	}

	for k, v in ipairs(events) do
		local available = v.available
		local eventObject = pac.CreateEvent(v.name, v.args)
		eventObject.Think = v.func

		function eventObject:IsAvailable()
			return available()
		end

		pac.RegisterEvent(eventObject)
	end
end)

--this should probably be in s2rp since the item stuff for this is in there but eh
hook.Add("CanOpenBagPanel", "dontopenequip", function(item)
		--thisll work for now, bags will only be through that anyway
	if(item.base == "base_suit" and !item:getData("equip")) then return false end
end)

--same deal
netstream.Hook("closeBag", function(id)
	if(id and nut.gui["inv"..id]) then
		nut.gui["inv"..id]:Remove()
	end
end)


--kinda anticheat
local lastcheck;
local hackCommands = { --may not be relevant anymore, do some 'research' on mpgh for me future me!
	-- GEAR1 Commands
	"gear_printents", "gw_toggle",
	"gw_pos", "gearmenu",
	"gb_reload", "gb_toggle",
	"+gb", "-gb", "gb_menu",
	-- GEAR2 Commands
	"gear2_menu",
	-- AHack Commands
	"ahack_menu",
	-- Sasha Commands
	"sasha_menu",
	-- Misc. Commands
	"showents", "showhxmenu",
	--smeg, prob doesnt work anymore (2015)
	"SmegHack_Menu",
	--random ones found in uc
	"sCheat_menu","lowkey_menu"
}

hook.Add("Think", "SRPThink", function()
	if(!lastcheck) then
		lastcheck = CurTime()
	end

	if(CurTime() - lastcheck > 30) then --lol

		local commands, _ = concommand.GetTable()

		for _, cmd in pairs(hackCommands) do
			if(commands[cmd]) then
				net.Start("BanMeAmHack") 
				net.SendToServer() --dont need anything else :^)
			end
		end

		lastcheck = CurTime()
	end
end)

--get rid of it
--[[hook.Add("CreateHeaderForFac", "nofaction", function()
	return false
end)]]



hook.Add("PlayerBindPress", "DisableZoom", function(ply, bind, pressed)
	if(string.find(bind, "+zoom")) then
		local inv = ply:getChar():getInv()
	--	print("??")
		if(!inv:hasItem("binoculars")) then -- and !ply:getChar():getImplants("implants", "zoom") and !ply:getChar():getImplants("implants", "ce_zoom")) then--Data("implants", {})["zoom"]) then
	--		print("wow ok")
			return true
		end
	end

	if(string.find(bind, "say")) then
		if(string.find(bind:lower(), "/fallover")) then
			return false
		end

		if(string.find(bind:lower(), "/toggleraise")) then
			return false
		end
		
		if(string.find(bind:lower(), "/togglehood")) then
			return false
        end
        
        if(string.find(bind:lower(), "/togglenightvision")) then
            return false
		end
        if(string.find(bind:lower(), "/setnightvision")) then
            return false
		end
		
        if(string.find(bind:lower(), "/hackmenu")) then
            return false
		end
		
        if(string.find(bind:lower(), "/cyberwareuse")) then
            return false
		end
		

        if(string.find(bind:lower(), "/npc")) then
            return false
        end

		--chat.AddText("no :^)") --BANTER
		return true
	end
end)

local modify = {
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
hook.Add("RenderScreenpaceEffects", "whoacoolmetrocolors", function()
	DrawColorModify(modify)
end)

