--restrict business menu to people with the flags for it
--[[function SCHEMA:BuildBusinessMenu(panel)
	local char = LocalPlayer():getChar()
	if(char:hasFlags("y") or char:hasFlags("m")) then
		return true
	else
		return false
	end
end]]
--[[
function SCHEMA:SetupQuickMenu(menu)
	if(NUT_CVAR_HEADBOOB) then
		local buttonItem = menu:addCheck("Toggle Headbob", function(panel, state)
			if(state) then
				RunConsoleCommand("nut_headbob", "1")
			else
				RunConsoleCommand("nut_headbob", "0")
			end
		end, NUT_CVAR_HEADBOOB:GetBool())

		menu:addSpacer()
	end
end
]]
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

hook.Add("BuildHelpMenu", "idkrulesiguess", function(tabs)
	--i gotta use /**/ becuz of the [[]]s, reset later idk?
	/*tabs["rules"] = function(node)
		local name = LocalPlayer():steamName()
		local body = [[<h2>Hello, ]]..name..[[!</h2>
<div style="word-wrap: break-word">
<p>Welcome to OASIS! Here are some basic rules to be followed. (these can also be found on the discord)</p>
<p>Note: These are subject to change and additional rules can be made at any time.</p>
<p>Remember to follow basic RP rules like no metagaming, powergaming, etc.</p>
<ol>
<li>If you find a bug or something that doesn't seem intentional with how something works, tell me (sky)! If anyone finds an exploitable bug and I find them abusing it, they will be permabanned immediately.</li>
<li>Don't be an asshole. Having a mean shitty character is fine but please try to be respectful OOC. :)</li>
<li>Adding into the above rule, respect people's whatever (gender, sexual orientation, etc) even if you don't "agree" with it. Any kind of racism, homophobia, transphobia or any other kind of bigotry will result in a ban, including "jokes" about it. basically just fucking respect other people please theyre humans too.</li>
<li>IC trolling is fine (blocking passageways for a toll or whatever), but OOC trolling (related to 2 and 3 mainly but also just in general) is not</li>
<li>PAC is allowed to use for free but you must follow these two guidelines regarding it:</li>
</ol>
<ul>
<li>No exploity/hacky PACs of course.</li>
<li>Replacing face and hair textures with submaterials is fine but please don't replace eye textures or headgear textures, it can mess with the script. If you want custom textured masks, headgear or whatever, just tell me. It won't be an issue to create a custom item if you have a material for it.</li>
</ul></div>
<p>I hope you enjoy OASIS as much as I did making it :)</p>]]
--note if more rules are made, u can do <ol start=6> to keep in line with the other numbers
		return body
	end*/
end)

--[[hook.Add("InitPostEntity", "killfeeddisable", function()
	RunConsoleCommand("hud_deathnotice_time", "0") --i think this already gets disabled but watever
end)]]

--kinda anticheat
local lastcheck;
local hackCommands = { --may not be relevant anymore, do some 'research' on mpgh for me future me!
	// GEAR1 Commands
	"gear_printents", "gw_toggle",
	"gw_pos", "gearmenu",
	"gb_reload", "gb_toggle",
	"+gb", "-gb", "gb_menu",
	// GEAR2 Commands
	"gear2_menu",
	// AHack Commands
	"ahack_menu",
	// Sasha Commands
	"sasha_menu",
	// Misc. Commands
	"showents", "showhxmenu"
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

