local PLUGIN = PLUGIN
PLUGIN.name = "Trait System"
PLUGIN.author = "sky"
PLUGIN.desc = "traits, inspired by various other trait/skill systems and code but completely made myself"

nut.traits = nut.traits or {}
nut.traits.list = {}--nut.traits.list or {}

nut.util.include("sh_skilltree.lua")

nut.command.add("chargivetechtrait", {
    syntax = "<string name>",
	desc = "use to give the target the trait for techs",
    adminOnly = true,
    onRun = function(client, arguments)
        local target = nut.util.findPlayer(arguments[1])
		if(!target) then return "invalid player" end
		if(nut.traits.hasTrait(target, "crafting_spec")) then
			return "already has tech trait"
		end

		nut.traits.setTrait(target, "crafting_spec", nil, 1)
		nut.traits.addXp(target, "crafting_spec", 5)
		return "ran"
	end
})

function nut.traits.add(uid, tbl)
	if(nut.traits.list[uid] != nil) then print("WARNING there are multiple traits with the uid of "..uid.."!") end
	nut.traits.list[uid] = tbl
end

function nut.traits.hasTrait(ply, uid)
	if(ply.getPlayer) then --char support
		return ply:getTrait(uid)
	end

	if(!ply.getChar or !ply:getChar()) then return false end

	return ply:getChar():getTrait(uid) or false--Data("traits", {})[uid] or false --false better than nil imo
end

--take = true == the trait is removed from the player
function nut.traits.setTrait(ply, uid, take, level)
	if(!ply.getChar or !ply:getChar()) then return end
	if(!nut.traits.list[uid]) then 
		print("hey uh this trait "..uid.." doesnt actually exist") 
		return
	end
	--force woopsie fix
	if(nut.traits.list[uid].max and !level) then
		level = 1
	end
	--local traits = ply:getChar():getTrait()--Data("traits", {})
	if(ply:getChar():getTrait(uid)) then
		print("player already has trait, just letting ya know, if youre taking it or upgrading a level dw about it")
		
	end
	local toadd = nil
	if(level) then
		toadd = level
	else
		toadd = !take and true or nil
	end

	ply:getChar():setTrait(uid, toadd)--Data("traits", traits)
end

function nut.traits.addXp(ply, uid, amt)
	if(!ply.getChar or !ply:getChar()) then return end

	if(!nut.traits.list[uid] or !nut.traits.list[uid].xp) then return end

	local traits = ply:getChar():getTrait()--Data("traits", {})
	if(nut.traits.list[uid].gate and traits[nut.traits.list[uid].gate]) then return end --no xp for u
	local curlevel = traits[uid]
	if(!curlevel or type(curlevel) != "number") then return end

	local xptable = ply:getChar():getData("xp", {})
	local hadxp = xptable[uid]
	local curxp = xptable[uid] or 0
	curxp = math.max(curxp + amt, 0) --dont let it get below 0
	xptable[uid] = curxp

	--level up
	if(nut.traits.list[uid].xp[curlevel] and curxp >= nut.traits.list[uid].xp[curlevel]) then
		xptable[uid] = nil
		--traits[uid] = curlevel+1
		if(PLUGIN.LevelupCheck) then
			local add = PLUGIN:LevelupCheck(uid, curlevel)
			if(add == false or add == nil) then 
				--ya weirdly more sane for me idk
			else
				if(add == true) then add = 1 end
				local lvl = ply:getChar():getData("traitlevelups", {})
				lvl[uid] = (lvl[uid] or 0) + add
				ply:getChar():setData("traitlevelups", lvl)
			end
		end

		ply:getChar():setTrait(uid, curlevel+1)--Data("traits", traits)
		ply:getChar():setData("xp", xptable)
		ply:notify("Your knowledge with "..(nut.traits.list[uid].xpname or nut.traits.list[uid].name).." has increased")
	elseif(nut.traits.list[uid].xp[curlevel]) then --just save the xp
		ply:getChar():setData("xp", xptable)
	elseif(hadxp != nil) then --remove it if theyre max level and have xp for watever reason
		xptable[uid] = nil 
		ply:getChar():setData("xp", xptable)
	end
end




--remember arg to access the ... stuff, its a table
function nut.traits.getMod(ply, type, ...)
	local arg = { ... }
	if(!ply or !ply:getChar()) then return end
	
	if(type == "hunger") then
			local val = 1
		if(nut.traits.hasTrait(ply, "gen_hunginc")) then
			val = val * nut.traits.list["gen_hunginc"].modify.inc
		end
		if(nut.traits.hasTrait(ply, "gen_hungdec")) then
			val = val * nut.traits.list["gen_hungdec"].modify.inc
		end
		return val
	end
	if(type == "thirst") then
		local val = 1
		if(nut.traits.hasTrait(ply, "gen_thirinc")) then
			val = val * nut.traits.list["gen_thirinc"].modify.inc
		end
		if(nut.traits.hasTrait(ply, "gen_thirdec")) then
			val = val * nut.traits.list["gen_thirdec"].modify.inc
		end
		return val
	end
	if(type == "heal") then
		local target, amount, seconds = unpack(arg)
		
		if(nut.traits.hasTrait(ply, "gen_healdec")) then
			amount = amount * nut.traits.list["gen_healdec"].modify.inc
		end
		
		local l = nut.traits.hasTrait(ply, "tech_med") or 0
		if(l == 1) then l = 2.5 end
		if(l == 0) then l = 3 end
		seconds = amount * (l+0.5)

		return amount, seconds
	end
	--small change to heal for selfheal
	if(type == "healtime") then
		local target, amount, seconds = unpack(arg)
		
		if(nut.traits.hasTrait(ply, "gen_healdec")) then
			amount = amount * (nut.traits.list["gen_healdec"].modify.inc + 1)
		end

		return amount, seconds
	end
	--multiplier that multiplies curbleed*multiplier, higher = less bleed
	if(type == "bleed") then
		local curbleed, multiplier = unpack(arg)
		local multi = 1
		
		if(nut.traits.hasTrait(ply, "gen_bleeddec")) then
			multi = multi * nut.traits.list["gen_bleeddec"].modify.inc
		end
		if(nut.traits.hasTrait(ply, "gen_bleedinc")) then
			multi = multi * nut.traits.list["gen_bleedinc"].modify.inc
		end

		return multi
	end
	--applied when getting bleed, mindmg is the minimum dmg to proc it, 
	--max change is max random number, 
	--chancethresh is if random number is higher than this, itll bleed
	--normal versions of those numbers are = 19, 100, 60
	--dont think theyll change at this point
	if(type == "minbleed") then
		local mindmg, maxchance, chancethresh

		--[[if(ply:getChar():getImplants("implants", "specialmep")) then
			mindmg = 57
			chancethresh = 99
		end]]
		
		if(nut.traits.hasTrait(ply, "gen_bleeddec")) then
			mindmg = 26
			chancethresh = 95
		end
		if(nut.traits.hasTrait(ply, "gen_bleedinc")) then
			mindmg = 13
			chancethresh = 50
		end

		return mindmg, maxchance, chancethresh
	end
	--time for actions
	if(type == "actiontime") then
		local amount = 1
		
		if(nut.traits.hasTrait(ply, "gen_clumsy")) then
			amount = amount * nut.traits.list["gen_clumsy"].modify.inc
		end
		if(nut.traits.hasTrait(ply, "big_alcohol")) then
			amount = amount * (((ply:getChar():getData("alcoh", 0)*0.4)^2)+1)
		end
		if(ply:getChar():getVar("alcoh", 0) != 0) then
		amount = amount * (((ply:getChar():getVar("alcoh", 0)*0.2)^3)+1)
		end

		return amount
	end --wepreloadeff

	--depot
	if(type == "depotuse") then
		if(nut.traits.hasTrait(ply, "gen_depotchance")) then
			local chn = nut.traits.list["gen_depotchance"].modify

			if(math.random(chn.total) <= chn.inc) then
				return true
			end
		end

		return false
	end

	if(type == "jobmoney") then
		local money = unpack(arg)

		if(nut.traits.hasTrait(ply, "gen_jobinc")) then
			money = money * nut.traits.list["gen_jobinc"].modify.inc
		end
		if(nut.traits.hasTrait(ply, "gen_jobdec")) then
			money = money * nut.traits.list["gen_jobdec"].modify.inc
		end

		return money
	end
	
	if(type == "cc") then
		local money = unpack(arg)

		if(nut.traits.hasTrait(ply, "gen_anticc")) then
			money = nut.traits.list["gen_anticc"].modify.inc
		end
		if(nut.traits.hasTrait(ply, "gen_cc")) then
			money = nut.traits.list["gen_cc"].modify.inc
		end

		return money
	end
	if(type == "stamcc") then
		local money = unpack(arg)

		if(nut.traits.hasTrait(ply, "gen_anticc")) then
			money = nut.traits.list["gen_anticc"].modify.st
		end
		if(nut.traits.hasTrait(ply, "gen_cc")) then
			money = nut.traits.list["gen_cc"].modify.st
		end

		return money
	end

	if(type == "wepreloadeff") then
		local amount = 1
		
		if(nut.traits.hasTrait(ply, "gen_clumsy")) then
			amount = amount * nut.traits.list["gen_clumsy"].modify.inc
		end
		if(nut.traits.hasTrait(ply, "big_alcohol")) then
			amount = amount * (1/(((ply:getChar():getData("alcoh", 0)*0.2)^3)+1))
		end
		if(ply:getChar():getVar("alcoh", 0) != 0) then
		amount = amount * (1/(((ply:getChar():getVar("alcoh", 0)*0.2)^3)+1))
		end
		if(nut.traits.hasTrait(ply, "gen_badwep")) then
			amount = amount * nut.traits.list["gen_badwep"].modify.incd
		end

		if(arg and #arg != 0) then --hardcoding becuz idk, this check not rly needed tbh
			local class = unpack(arg)
			if(class == "pistol" and nut.traits.hasTrait(ply, "wepspec_pistol")) then
				amount = amount * 1.1
			end
			if(class == "smg" and nut.traits.hasTrait(ply, "wepspec_smg")) then
				amount = amount * 1.1
			end
			if(class == "shotgun" and nut.traits.hasTrait(ply, "wepspec_shotgun")) then
				amount = amount * 1.1
			end
			if(class == "ar" and nut.traits.hasTrait(ply, "wepspec_ar")) then
				amount = amount * 1.1
			end
			if(class == "sniper" and nut.traits.hasTrait(ply, "wepspec_sniper")) then
				amount = amount * 1.1
			end
		end

		return amount
	end 
	if(type == "wepreceff") then
		local amount = 1
		
		if(nut.traits.hasTrait(ply, "big_alcohol")) then
			amount = amount * (((ply:getChar():getData("alcoh", 0)*0.3)^4)+1)
		end
		if(ply:getChar():getVar("alcoh", 0) != 0) then
		amount = amount * (((ply:getChar():getVar("alcoh", 0)*0.2)^3)+1)
		end
		if(nut.traits.hasTrait(ply, "gen_badwep")) then
			amount = amount * nut.traits.list["gen_badwep"].modify.inc
		end

		if(arg and #arg != 0) then --hardcoding becuz idk, this check not rly needed tbh
			local class = unpack(arg)
			if(class == "pistol" and nut.traits.hasTrait(ply, "wepspec_pistol")) then
				amount = amount * 0.77
			end
			if(class == "smg" and nut.traits.hasTrait(ply, "wepspec_smg")) then
				amount = amount * 0.84
			end
			if(class == "shotgun" and nut.traits.hasTrait(ply, "wepspec_shotgun")) then
				amount = amount * 0.85
			end
			if(class == "ar" and nut.traits.hasTrait(ply, "wepspec_ar")) then
				amount = amount * 0.85
			end
			if(class == "sniper" and nut.traits.hasTrait(ply, "wepspec_sniper")) then
				amount = amount * 0.88
			end
		end
		local char = ply:getChar()
		local hunger = char:GetHunger()
		if(hunger < LOW_HUNGER_THRESHOLD) then
			if(hunger >= 40) then --stage 1
				amount = amount * 1.15
			elseif(hunger >= 25) then --stage 2
				amount = amount * 1.25
			else --stage 3
				amount = amount * 1.5
			end
		end

		return amount
	end 
	if(type == "wepspreff") then
		local amount = 1
		
		if(nut.traits.hasTrait(ply, "big_alcohol")) then
			amount = amount * (((ply:getChar():getData("alcoh", 0)*0.3)^3)+1)
		end
		if(ply:getChar():getVar("alcoh", 0) != 0) then
		amount = amount * (((ply:getChar():getVar("alcoh", 0)*0.2)^3)+1)
		end
		if(nut.traits.hasTrait(ply, "gen_badwep")) then
			amount = amount * nut.traits.list["gen_badwep"].modify.inc
		end
		
		if(arg and #arg != 0) then --hardcoding becuz idk, this check not rly needed tbh
			local class = unpack(arg)
			if(class == "pistol" and nut.traits.hasTrait(ply, "wepspec_pistol")) then
				amount = amount * 0.83
			end
			if(class == "smg" and nut.traits.hasTrait(ply, "wepspec_smg")) then
				amount = amount * 0.88
			end
			if(class == "shotgun" and nut.traits.hasTrait(ply, "wepspec_shotgun")) then
				amount = amount * 0.88
			end
			if(class == "ar" and nut.traits.hasTrait(ply, "wepspec_ar")) then
				amount = amount * 0.9
			end
			if(class == "sniper" and nut.traits.hasTrait(ply, "wepspec_sniper")) then
				amount = amount * 0.95
			end
		end

		local char = ply:getChar()
		local hunger = char:GetHunger()
		if(hunger < LOW_HUNGER_THRESHOLD) then
			if(hunger >= 40) then --stage 1
				amount = amount * 1.125
			elseif(hunger >= 25) then --stage 2
				amount = amount * 1.2
			else --stage 3
				amount = amount * 1.4
			end
		end

		return amount
	end 
	if(type == "wepireff") then
		local amount = 1
		
		if(nut.traits.hasTrait(ply, "big_alcohol")) then
			amount = amount * (((ply:getChar():getData("alcoh", 0)*0.2)^3)+1)
		end
		if(ply:getChar():getVar("alcoh", 0) != 0) then
			amount = amount * (((ply:getChar():getVar("alcoh", 0)*0.2)^3)+1)
		end
		if(nut.traits.hasTrait(ply, "gen_badwep")) then
			amount = amount * nut.traits.list["gen_badwep"].modify.inc
		end

		if(arg and #arg != 0) then --hardcoding becuz idk, this check not rly needed tbh
			local class = unpack(arg)
			if(class == "pistol" and nut.traits.hasTrait(ply, "wepspec_pistol")) then
				amount = amount * 0.8
			end
			if(class == "smg" and nut.traits.hasTrait(ply, "wepspec_smg")) then
				amount = amount * 0.9
			end
			if(class == "shotgun" and nut.traits.hasTrait(ply, "wepspec_shotgun")) then
				amount = amount * 0.9
			end
			if(class == "ar" and nut.traits.hasTrait(ply, "wepspec_ar")) then
				amount = amount * 0.9
			end
			if(class == "sniper" and nut.traits.hasTrait(ply, "wepspec_sniper")) then
				amount = amount * 0.92
			end
		end

		return amount
	end 
	if(type == "wepdmgeff") then --very slight dmg buff
		local class = unpack(arg)
		local amount = 1

		if(class == "pistol" and nut.traits.hasTrait(ply, "wepspec_pistol")) then
			amount = amount * 1.2
		end
		if(class == "smg" and nut.traits.hasTrait(ply, "wepspec_smg")) then
			amount = amount * 1.15
		end
		if(class == "shotgun" and nut.traits.hasTrait(ply, "wepspec_shotgun")) then
			amount = amount * 1.1
		end
		if(class == "ar" and nut.traits.hasTrait(ply, "wepspec_ar")) then
			amount = amount * 1.1
		end
		if(class == "sniper" and nut.traits.hasTrait(ply, "wepspec_sniper")) then
			amount = amount * 1.1
		end

		return amount
	end
	if(type == "wepireceff") then --iron recoil multi
		local amount = 1
		
		local class = unpack(arg)
		if(class == "pistol" and nut.traits.hasTrait(ply, "wepspec_pistol")) then
			amount = amount * 0.75
		end
		if(class == "smg" and nut.traits.hasTrait(ply, "wepspec_smg")) then
			amount = amount * 0.8
		end
		if(class == "shotgun" and nut.traits.hasTrait(ply, "wepspec_shotgun")) then
			amount = amount * 0.9
		end
		if(class == "ar" and nut.traits.hasTrait(ply, "wepspec_ar")) then
			amount = amount * 0.9
		end
		if(class == "sniper" and nut.traits.hasTrait(ply, "wepspec_sniper")) then
			amount = amount * 0.9
		end

		local char = ply:getChar()
		local hunger = char:GetHunger()
		if(hunger < LOW_HUNGER_THRESHOLD) then
			if(hunger >= 40) then --stage 1
				amount = amount * 1.1
			elseif(hunger >= 25) then --stage 2
				amount = amount * 1.2
			else --stage 3
				amount = amount * 1.5
			end
		end

		return amount
	end 
end

function PLUGIN:OnCharCreated(client, char)
	local traits = char:getTrait()--Data("traits", {})

	for k,v in pairs(nut.traits.list) do
		if(traits[k] and v.onCreate) then
			v.onCreate(client, char)
		end
	end
end

function PLUGIN:PlayerLoadedChar(client, newchar, char)
	if(char) then
		local traits = char:getTrait()--Data("traits", {})
	
		for k,v in pairs(nut.traits.list) do
			if(traits[k] and v.onSwitch) then
				v.onSwitch(client, char)
			end
		end
		
	end
	
		--ill do it here, migrating to new system
		if(SERVER) then
			if(newchar and newchar:getData("traits") and !newchar:getData("traitmigrate")) then
				nut.log.addRaw("doing migration on traits for "..client:Name())
				client:notify("detected you had data-based traits, changed them to charvar-based, if anything traits-related isnt working correctly, try switching to another char and back")
				newchar:setData("traitmigrate", true)
	
				local imps = newchar:getData("traits") --ok, first get them
				newchar:setData("traits") --now get rid of them
	
				--newchar:setTrait(imps) --move it to this
				for k,v in pairs(imps) do
					newchar:setTrait(k, v)
				end
	
			end
		end
end

function PLUGIN:PostPlayerLoadout(client)
	local char = client:getChar()
	local traits = char:getTrait()--Data("traits", {})

	for k,v in pairs(nut.traits.list) do
		if(traits[k] and v.onLoad) then
			v.onLoad(client, char)
		end
	end
end

nut.chat.register("traitthink", {
	font = "nutChatFontItalics",
    onCanHear = function(speaker, listener)
        return speaker == listener
    end,
    onChatAdd = function(speaker, text, anonymous)
		chat.AddText(nut.config.get("chatColor"), text)
    end,
    filter = "actions"
})

nut.command.add("checkalcohlevel", {
	desc = "Check your character's current alcoholic level. If you have the trait it will return the perma level, if you dont it will return the temp level.",
    onRun = function(ply, arguments)

		local cur = ply:getChar():getData("alcoh", 0)
		if(cur == 0) then
			cur = ply:getChar():getVar("alcoh", 0)
		end

        return "Alcoholic Level: "..cur
	end
})

if(SERVER) then
function PLUGIN:PlayerFootstep(ply, pos, foot, sound, volume, rf)
	if(ply:getChar()) then
		local traits = ply:getChar():getTrait()--Data("traits", {})

		if(ply:Crouching()) then
		if(traits["gen_catlike"]) then
			ply:EmitSound(sound, 75, math.random(98,102), volume*0.1)
		else
			ply:EmitSound(sound, 75, math.random(98,102), volume*0.8)
		end
		return true
		end
	end
end


	--add stuff to table
	hook.Add("OnLoadTables", "traitadd", function()
		if(cookie.GetNumber("traitmigrate") == nil) then
			cookie.Set("traitmigrate", 1)
		if(nut.db.object) then
			nut.db.query([[
ALTER TABLE `nut_characters` 
	ADD `_traits` VARCHAR(1024) NOT NULL COLLATE `utf8mb4_general_ci`;]])
		else
			nut.db.query([[
ALTER TABLE nut_characters ADD COLUMN _traits varchar;]])
		end
		end
	end)
end

nut.char.registerVar("trait", {
	default = {},
	isLocal = true,
	noDisplay = true,
	field = "_traits",
	onSet = function(character, key, value, noReplication, receiver)
		local data = character:getTrait()
		local client = character:getPlayer()

		--[[if(type(key) == "table") then
			data = key
		else]]

			data[key] = value
		--end

		if (!noReplication and IsValid(client)) then
			netstream.Start(receiver or client, "charTraits", character:getID(), key, value)
		end

		character.vars.trait = data
	end,
	onGet = function(character, key, default)
		local data = character.vars.trait or {}

		if (key) then
			if (!data) then
				return default
			end

			local value = data[key]

			return value == nil and default or value
		else
			return default or data
		end
	end
})


if(CLIENT) then
	netstream.Hook("charTraits", function(id, key, value)
		local character = nut.char.loaded[id]
		
		if (character) then
			character.vars.trait = character.vars.trait or {}
			character:getTrait()[key] = value
		end
	end)


	local chatcooldown = chatcooldown or false
	netstream.Hook("fakechatmessage", function(text)
		if(!chatcooldown) then
			chat.AddText(text)
			chatcooldown = true
			timer.Simple(3, function()
				chatcooldown = false
			end)
		end
	end)
end

nut.util.include("sh_config.lua")
nut.util.include("sh_languages.lua")
nut.util.include("sh_creation.lua")
nut.util.include("sh_skillbooks.lua")

nut.command.add("dotraits", {
	desc = "If the traits menu doesn't appear during char creation (this only seems to happen when being on a char and creating a new one), you can bring up the dialog using this command.",
	onRun = function(client)
		if(client:getChar() and table.IsEmpty(client:getChar():getTrait() or {})) then --just in case
			netstream.Start(client, "broketraitsetup")
			return
		end
		return "You have traits already."
	end
})

if(CLIENT) then
	netstream.Hook("broketraitsetup", function()
		if(!IsValid(broktraitspanel)) then
			broketraitsetup()
		end
	end)

	function sendbroketraits(tbl)
		netstream.Start("broketraitadd", tbl)
		
		local character = LocalPlayer():getChar()
		character.vars.trait = tbl
		
	end

	function broketraitsetup()
		local base = vgui.Create("DFrame")
		base:SetSize(ScrW()/3, ScrH()/3)
		base:SetTitle("Trait Setup")
		base:SetDraggable(true)
		base:MakePopup()
		base:Center()
		broktraitspanel = base
		local self = base
		local main = base

		local traitstbl = {}

		self.cost = 0--main.cost = 0
		self.negtraits = 0 --main.negtraits = 0
		self.langtraits = 1 --main.langtraits = 1
		
		--needs to be up here
		--below this a label to display trait points left
		local lab = self:Add("DLabel")
		lab:Dock(BOTTOM)
		lab:SetHeight(32)
		lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining. You can click this to submit your traits.")
		lab:SetMouseInputEnabled(true) 
		function lab:DoClick()
			nut.util.notify("You have submitted your traits and should have them now!")
			sendbroketraits(traitstbl)
			base:Remove()
		end
	
		local posscroll = self:Add("DCategoryList")
		posscroll:SetWidth(main:GetWide()/2)--, 292)
	
		posscroll:Dock(LEFT)
		
		local negscroll = main:Add("DCategoryList")
		negscroll:SetWidth(main:GetWide()/2.1)--, 292)
		negscroll:SetPos(main:GetWide()/2.1, 0)
		negscroll:Dock(RIGHT)
	
		posscroll:Clear()
		negscroll:Clear()
	
		posscroll:InvalidateLayout(true)
		negscroll:InvalidateLayout(true)
	
		local poscat = posscroll--[[:GetCanvas():Add("DCategoryList")
		--poscat:SetSize(main:GetWide()/2, 260)
		poscat:Dock(FILL)
		poscat:DockMargin( 0, 0, 0, 0 )]]
		poscat.cats = {}
		poscat:SetZPos(1)
	
		local negcat = negscroll--[[:GetCanvas():Add("DCategoryList")
		--negcat:SetSize(main:GetWide()/2, 260)
		--negcat:SetPos(main:GetWide()/2, 0)
		negcat:Dock(FILL)
		negcat:DockMargin( 0, 0, 0, 0 )]]
		negcat.cats = {}
		negcat:SetZPos(2)

		local faction = LocalPlayer():getChar():getFaction()
	
	
		local buttons = {}
	
		--this probably could be done better but whatever i guess
		for k,v in pairs(nut.traits.list) do
			if(v.hide) then continue end
			if(v.faction and !v.faction[faction]) then continue end
			if(v.type == "pos") then --add to poscat
				if(!poscat.cats[v.category]) then --add the category if it doesnt exist
					poscat.cats[v.category] = poscat:Add(v.category)
				end
	
				if(!v.max) then
					buttons[k] = poscat.cats[v.category]:Add(v.name.." | "..v.cost.." cost")
					buttons[k]:Dock(TOP)
					buttons[k]:SetPaintBackgroundEnabled(true)
					buttons[k]:SetBGColor(Color(255,255,255))
					buttons[k]:SetTooltip(v.desc)
					buttons[k].DoClick = function(self)
						if(v.require and (!buttons[v.require] or !buttons[v.require].picked)) then return end
						--panel.payload.traits = panel.payload.traits or {}
						--panel.payload.data = panel.payload.data or {}
						--panel.payload.data.traits = panel.payload.data.traits or {}
						print(main.langtraits.." now")
						if(buttons[k].picked) then
							if(main.cost-v.cost > nut.config.get("traitPoints")) then
								return
							end
							print("removal? "..(main.langtraits-1).." "..nut.config.get("langTraits"))
							if(v.category == "Languages" and main.langtraits-1 > nut.config.get("langTraits")) then
								return
							end
							if(buttons[k].required) then
								for _,boot in pairs(buttons[k].required) do
									boot:DoClick()
								end
							end
	
							main.cost = main.cost - v.cost
							if(v.category == "Languages") then
								main.langtraits = main.langtraits - 1
							end
							if(k == "big_trilingual") then --remove one if nonenglish is chosen
								--main.langtraits = main.langtraits - 1
								if(main.lastchoselang) then
									traitstbl[main.lastchoselang] = nil
									
									buttons[main.lastchoselang].picked = nil
									buttons[main.lastchoselang]:SetBGColor(Color(255,255,255))
									buttons[main.lastchoselang]:SetTextColor(Color( 140, 140, 140, 255 ))
									main.lastchoselang = nil
								else
									main.langtraits = main.langtraits + 1
								end
							end
							lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining. You can click this to submit your traits.")
							--panel.payload.traits[k] = nil
							--panel.payload.data.traits[k] = nil
							--local tr = panel:getContext("traits", {})
							traitstbl[k] = nil
							--panel:setContext("traits", tr)
	
							buttons[k].picked = nil
							buttons[k]:SetBGColor(Color(255,255,255))
							buttons[k]:SetTextColor(Color( 140, 140, 140, 255 ))
							
							if(v.conflicting) then
								for k2,v2 in pairs(v.conflicting) do
									if(buttons[v2]) then
										buttons[v2]:SetDisabled(false)
									end
								end
							end
						else
							--if cost gets over the config, stop
							if(main.cost+v.cost > nut.config.get("traitPoints")) then
								return
							end
							if(v.category == "Languages" and main.langtraits+1 > nut.config.get("langTraits")) then
								return
							end
							if(v.require) then
								buttons[v.require].required = buttons[v.require].required or {}
								buttons[v.require].required[k] = buttons[k]
							end
	
							main.cost = main.cost + v.cost
							if(v.category == "Languages") then
								main.langtraits = main.langtraits + 1
								main.lastchoselang = k
							end
							if(k == "big_trilingual") then --remove one if nonenglish is chosen
								main.langtraits = main.langtraits - 1
							end
							lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining. You can click this to submit your traits.")
							--panel.payload.traits[k] = true
							--panel.payload.data.traits[k] = true
							--local tr = panel:getContext("traits", {})
							traitstbl[k] = true
							--panel:setContext("traits", tr)
	
							buttons[k].picked = true
							buttons[k]:SetBGColor(Color(100,100,255))
	
							if(v.conflicting) then
								for k2,v2 in pairs(v.conflicting) do
									if(buttons[v2]) then
										buttons[v2]:SetDisabled(true)
									end
								end
							end
						end
						print(main.langtraits.." after")
					end
				elseif(v.creationMax != 0) then --level traits
					for i=1, v.creationMax do
						buttons[k.."_"..i] = poscat.cats[v.category]:Add(v.name.." - Level "..i.." | "..v.cost[i].." cost")
						buttons[k.."_"..i]:Dock(TOP)
						buttons[k.."_"..i]:SetPaintBackgroundEnabled(true)
						buttons[k.."_"..i]:SetBGColor(Color(255,255,255))
						buttons[k.."_"..i]:SetTooltip(v.desc)
	
						buttons[k.."_"..i].DoClick = function(self)
							--panel.payload.traits = panel.payload.traits or {}
							--panel.payload.data = panel.payload.data or {}
							--panel.payload.data.traits = panel.payload.data.traits or {}
							if(buttons[k.."_"..i].picked) then
								if(main.cost-v.cost[i] > nut.config.get("traitPoints")) then
									return
								end
								
								if(buttons[k.."_"..i].required) then
									for _,boot in pairs(buttons[k.."_"..i].required) do
										boot:DoClick()
									end
								end
	
								main.cost = main.cost - v.cost[i]
								lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining. You can click this to submit your traits.")
								--panel.payload.data.traits[k] = nil
								--panel.payload.traits[k] = nil
								--local tr = panel:getContext("traits", {})
								traitstbl[k] = nil
								--panel:setContext("traits", tr)
	
								buttons[k.."_"..i].picked = nil
								buttons[k.."_"..i]:SetBGColor(Color(255,255,255))
								buttons[k.."_"..i]:SetTextColor(Color( 140, 140, 140, 255 ))
	
								if(v.conflicting) then
									for k2,v2 in pairs(v.conflicting) do
										if(buttons[v2]) then
											buttons[v2]:SetDisabled(false)
										end
									end
								end
								for w=1, v.creationMax do
									if(w == i) then continue end
									if(buttons[k.."_"..w]) then
										buttons[k.."_"..w]:SetDisabled(false)
									end
								end
							else
								if(v.require and (!buttons[v.require] or !buttons[v.require].picked)) then return end
								if(main.cost+v.cost[i] > nut.config.get("traitPoints")) then
									return
								end
								
								if(v.require) then
									buttons[v.require].required = buttons[v.require].required or {}
									buttons[v.require].required[k.."_"..i] = buttons[k.."_"..i]

								end
	
								main.cost = main.cost + v.cost[i]
								lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining. You can click this to submit your traits.")
								--panel.payload.traits[k] = i
								--panel.payload.data.traits[k] = i
								--local tr = panel:getContext("traits", {})
								traitstbl[k] = i
								--panel:setContext("traits", tr)
	
								buttons[k.."_"..i].picked = true
								buttons[k.."_"..i]:SetBGColor(Color(100,100,255))
	
								if(v.conflicting) then
									for k2,v2 in pairs(v.conflicting) do
										if(buttons[v2]) then
											buttons[v2]:SetDisabled(true)
										end
									end
								end
								for w=1, v.creationMax do
									if(w == i) then continue end
									if(buttons[k.."_"..w]) then
										buttons[k.."_"..w]:SetDisabled(true)
									end
								end
							end
						end
					end
				end
			elseif(v.type == "neg") then --add to negcat
				if(!negcat.cats[v.category]) then --add the category if it doesnt exist
					negcat.cats[v.category] = negcat:Add(v.category)
				end
	
				if(!v.max and v.cost) then
					buttons[k] = negcat.cats[v.category]:Add(v.name.." | "..v.cost.." cost")
					buttons[k]:Dock(TOP)
					buttons[k]:SetPaintBackgroundEnabled(true)
					buttons[k]:SetBGColor(Color(255,255,255))
					buttons[k]:SetTooltip(v.desc)
					buttons[k].DoClick = function(self)
						--panel.payload.traits = panel.payload.traits or {}
						--panel.payload.data = panel.payload.data or {}
						--panel.payload.data.traits = panel.payload.data.traits or {}
						if(buttons[k].picked) then
							if(main.cost-v.cost > nut.config.get("traitPoints")) then
								return
							end
							if(main.negtraits-1 > nut.config.get("negTraits")) then
								return
							end
							if(buttons[k].required) then
								for _,boot in pairs(buttons[k].required) do
									boot:DoClick()
								end
							end
	
							main.cost = main.cost - v.cost
							main.negtraits = main.negtraits - 1
							if(k == "big_nonenglish") then --add one if nonenglish was unpicked
								main.langtraits = main.langtraits + 1
							end
							lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
							--panel.payload.traits[k] = nil
							--panel.payload.data.traits[k] = nil
							--local tr = panel:getContext("traits", {})
							traitstbl[k] = nil
							--panel:setContext("traits", tr)
	
							buttons[k].picked = nil
							buttons[k]:SetBGColor(Color(255,255,255))
							buttons[k]:SetTextColor(Color( 140, 140, 140, 255 ))
							
							if(v.conflicting) then
								for k2,v2 in pairs(v.conflicting) do
									if(buttons[v2]) then
										buttons[v2]:SetDisabled(false)
									end
								end
							end
						else
							if(v.require and (!buttons[v.require] or !buttons[v.require].picked)) then return end
							--if cost gets over the config, stop
							if(main.cost+v.cost > nut.config.get("traitPoints")) then
								return
							end
							if(main.negtraits+1 > nut.config.get("negTraits")) then
								return
							end
							if(v.require) then
								buttons[v.require].required = buttons[v.require].required or {}
								buttons[v.require].required[k.."_"..i] = buttons[k.."_"..i]
							end
	
							main.cost = main.cost + v.cost
							main.negtraits = main.negtraits + 1
							if(k == "big_nonenglish") then --remove one if nonenglish is chosen
								main.langtraits = main.langtraits - 1
							end
							lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
							--panel.payload.traits[k] = true
							--panel.payload.data.traits[k] = true
							--local tr = panel:getContext("traits", {})
							traitstbl[k] = true
							--panel:setContext("traits", tr)
	
							buttons[k].picked = true
							buttons[k]:SetBGColor(Color(100,100,255))
	
							if(v.conflicting) then
								for k2,v2 in pairs(v.conflicting) do
									if(buttons[v2]) then
										buttons[v2]:SetDisabled(true)
									end
								end
							end
						end
					end
				elseif(v.creationMax != 0) then --level traits
					for i=1, v.creationMax do
						buttons[k.."_"..i] = negcat.cats[v.category]:Add(v.name.." - Level "..i.." | "..v.cost[i].." cost")
	
						buttons[k.."_"..i]:Dock(TOP)
						buttons[k.."_"..i]:SetPaintBackgroundEnabled(true)
						buttons[k.."_"..i]:SetBGColor(Color(255,255,255))
						buttons[k.."_"..i]:SetTooltip(v.desc)
						buttons[k.."_"..i].DoClick = function(self)
							if(v.require and (!buttons[v.require] or !buttons[v.require].picked)) then return end
							--panel.payload.traits = panel.payload.traits or {}
							--panel.payload.data = panel.payload.data or {}
							--panel.payload.data.traits = panel.payload.data.traits or {}
							if(buttons[k.."_"..i].picked) then
								if(main.cost-v.cost[i] > nut.config.get("traitPoints")) then
									return
								end
								if(buttons[k.."_"..i].required) then
									for _,boot in pairs(buttons[k.."_"..i].required) do
										boot:DoClick()
									end
								end
								--not adding the negative trait stuff here becuz there will never be a level negative trait
	
								main.cost = main.cost - v.cost[i]
								lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
								--panel.payload.traits[k] = nil
								--panel.payload.data.traits[k] = nil
								--local tr = panel:getContext("traits", {})
								traitstbl[k] = nil
								--panel:setContext("traits", tr)
	
								buttons[k.."_"..i].picked = nil
								buttons[k.."_"..i]:SetBGColor(Color(255,255,255))
								buttons[k.."_"..i]:SetTextColor(Color( 140, 140, 140, 255 ))
								
								if(v.conflicting) then
									for k2,v2 in pairs(v.conflicting) do
										if(buttons[v2]) then
											buttons[v2]:SetDisabled(false)
										end
									end
								end
								for w=1, v.creationMax do
									if(w == i) then continue end
									if(buttons[k.."_"..w]) then
										buttons[k.."_"..w]:SetDisabled(false)
									end
								end
							else
								if(main.cost+v.cost[i] > nut.config.get("traitPoints")) then
									return
								end
								if(v.require) then
									buttons[v.require].required = buttons[v.require].required or {}
									buttons[v.require].required[k] = buttons[k]
								end
	
								main.cost = main.cost + v.cost[i]
								lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
								--panel.payload.traits[k] = i
								--panel.payload.data.traits[k] = i
								--local tr = panel:getContext("traits", {})
								traitstbl[k] = i
								--panel:setContext("traits", tr)
	
								buttons[k.."_"..i].picked = true
								buttons[k.."_"..i]:SetBGColor(Color(100,100,255))
	
								if(v.conflicting) then
									for k2,v2 in pairs(v.conflicting) do
										if(buttons[v2]) then
											buttons[v2]:SetDisabled(true)
										end
									end
								end
								for w=1, v.creationMax do
									if(w == i) then continue end
									if(buttons[k.."_"..w]) then
										buttons[k.."_"..w]:SetDisabled(true)
									end
								end
							end
						end
					end
				end
			
			end
		end
	
		poscat:InvalidateLayout()--true)
		negcat:InvalidateLayout()--true)
	end
else
	netstream.Hook("broketraitadd", function(client, tbl)
		local char = client:getChar()
		if(char) then
			char.vars.trait = tbl
		else return
		end
		
		for k,v in pairs(nut.traits.list) do
			if(tbl[k] and v.onCreate) then
				v.onCreate(client, char)
			end
			if(tbl[k] and v.onLoad) then
				v.onLoad(client, char)
			end
		end
	end)
end