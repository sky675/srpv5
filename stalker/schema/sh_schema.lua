SCHEMA.name = "STALKER"
SCHEMA.introName = "STALKER"
SCHEMA.author = "sky"
SCHEMA.desc = ""--"Corporate control in Osaka, Japan."
SCHEMA.descname = "STALKER RP"

function SCHEMA:GetGameDescription()
	return self.descname--"NS - "..self.descname --?
end

nut.util.include("sh_config.lua")
nut.util.include("sh_commands.lua")
--nut.util.include("sh_namelist.lua")
nut.util.includeDir("hooks")

nut.util.include("sh_anorak.lua")

--im assuming this will only precache the models serverside
if(SERVER) then
for k,v in pairs(SCHEMA.cacheModels) do
    util.PrecacheModel(v)
end
else
	function PrecacheConfigModels()
		for k,v in pairs(SCHEMA.cacheModels) do
			util.PrecacheModel(v)
		end
	end
end


for k,v in pairs(SCHEMA.playerModels) do
    nut.anim.setModelClass(v, "player")
end

for k,v in pairs(SCHEMA.cacheSounds) do
    util.PrecacheModel(v)
end

--replace sunrisemodel with the model hands of sunrise
--player_manager.AddValidHands("sunrise", sunrisemodel, 0, "00000000")

for k,v in pairs(SCHEMA.sunriseHands) do
    player_manager.AddValidModel("sunrise", v)
end

--found this on the old wiki, assuming it still works
local function AddDir(dir)
	local files, dirs = file.Find(dir.."/*", "GAME")
	
    for _, fdir in pairs(dirs) do
	    if fdir != ".svn" then
	 	    AddDir(dir.."/"..fdir)
	    end
   	end
	
    for k,v in pairs(files) do
	    resource.AddFile(dir.."/"..v)
    end
end

for k,v in pairs(SCHEMA.fastFiles) do
	resource.AddFile(v)
end

for k,v in pairs(SCHEMA.fastDirs) do
	AddDir(v)
end

if(SERVER) then
	for k,v in pairs(SCHEMA.workshop) do
		resource.AddWorkshop(v)
	end

end
if(CLIENT) then
	function SCHEMA:ConfigureCharacterCreationSteps(panel)
		panel:addStep(vgui.Create("nutSkinStuff"), 99)
	end
end


nut.char.registerVar("skin", {
--	field = "_skin",
	index = 4,
	default = 0,
	noNetworking = true, --it gets set in data so this is fine
	onValidate = function(value, data)
		--[[if(!data.skin) then
			return false, "needSkin"
		end]]
	end,
	onAdjust = function(client, data, value, newData)
		newData.skin = nil
		newData.data = newData.data or {}
		newData.data.skin = value
	end
})

--this is set in skin
nut.char.registerVar("bgs", {
	--field = "_bgs",
	default = {},
	index = 2,
	--noDisplay = true,
	noNetworking = true, --it gets set in data so this is fine
	onValidate = function(value, data)
	end,
	onAdjust = function(client, data, value, newData)
		PrintTable(data or {})
		print("value bg "..tostring(value))
		PrintTable(newData or {})
		newData.bgs = nil
		newData.data = newData.data or {}
		newData.data.groups = value
	end
})
nut.char.registerVar("eyes", {
	--field = "_bgs",
	default = "",
	index = 2,
	--noDisplay = true,
	noNetworking = true, --it gets set in data so this is fine
	onValidate = function(value, data)
	end,
	onAdjust = function(client, data, value, newData)
		PrintTable(data or {})
		print("value eyes "..tostring(value))
		PrintTable(newData or {})
		newData.eyes = nil
		newData.data = newData.data or {}
		newData.data.eyes = value
	end
})
nut.char.registerVar("gss", {
	--field = "_bgs",
	default = {},
	index = 2,
	--noDisplay = true,
	noNetworking = true, --it gets set in data so this is fine
	onValidate = function(value, data)
	end,
	onAdjust = function(client, data, value, newData)
		PrintTable(data or {})
		print("value gss "..tostring(value))
		PrintTable(newData or {})

		newData.gss = nil
		newData.data = newData.data or {}
		newData.data.gs = value
	end
})
nut.char.registerVar("anorak", {
	--field = "_bgs",
	default = {},
	index = 2,
	--noDisplay = true,
	noNetworking = true, --it gets set in data so this is fine
	onValidate = function(value, data)
	end,
	onAdjust = function(client, data, value, newData)

		newData.anorak = nil
		newData.data = newData.data or {}
		newData.data.anorak = value
	end
})


nut.chat.register("mel", {
	desc = "/me but in yelling range",
    format = "**%s %s",
	onGetColor = function(speaker, text)
		local color = nut.chat.classes.ic.onGetColor(speaker, text)

		-- Make the whisper chat slightly brighter than IC chat.
		return Color(color.r + 35, color.g + 35, color.b + 35)
	end,
    onCanHear = nut.config.get("chatRange", 280) * 2,
    prefix = {"/mel", "/actionl"},
    font = "nutChatFontItalics",
    filter = "actions",
    deadCanChat = true
})

nut.chat.register("me's", {
	desc = "/me but begins with Name's",
	format = "**%s's %s",
	onGetColor = function(speaker, text)
		return nut.chat.classes.ic.onGetColor(speaker, text)
	end,
	onCanHear = nut.config.get("chatRange", 280),
	prefix = {"/me's"},
    font = "nutChatFontItalics",
    filter = "actions",
    deadCanChat = true
})

nut.chat.register("mes", {
	desc = "/me but in whisper range",
    format = "**%s %s",
	onGetColor = function(speaker, text)
		local color = nut.chat.classes.ic.onGetColor(speaker, text)

		-- Make the whisper chat slightly darker than IC chat.
		return Color(color.r - 35, color.g - 35, color.b - 35)
	end,
    onCanHear = nut.config.get("chatRange", 280) * 0.25,
    prefix = {"/mes", "/actions"},
    font = "nutChatFontItalics",
    filter = "actions",
    deadCanChat = true
})

nut.chat.register("itl", {
	desc = "/it but in yelling range",
	onChatAdd = function(speaker, text)
		local color = nut.config.get("chatColor")
		chat.AddText(Color(color.r + 35, color.g +35, color.b+35), "**"..text)
	end,
	onCanHear = nut.config.get("chatRange", 280) * 2,
	prefix = {"/itl"},
	font = "nutChatFontItalics",
	filter = "actions",
	deadCanChat = true
})

nut.chat.register("its", {
	desc = "/it but in whisper range",
	onChatAdd = function(speaker, text)
		local color = nut.config.get("chatColor")
		chat.AddText(Color(color.r - 35, color.g -35, color.b-35), "**"..text)
	end,
	onCanHear = nut.config.get("chatRange", 280) * 0.25,
	prefix = {"/its"},
	font = "nutChatFontItalics",
	filter = "actions",
	deadCanChat = true
})

--petrCcn
nut.flag.add("0", "Access to general goods.")
nut.flag.add("1", "Access to tier 1 weapons, armor, ammo.")
nut.flag.add("2", "Access to tier 2 weapons, armor, ammo.")
nut.flag.add("3", "Access to tier 3 weapons, armor, ammo.")
nut.flag.add("4", "Access to tier 4 weapons, armor, ammo.")
nut.flag.add("5", "Access to tier 5 weapons, armor, ammo.")
nut.flag.add("6", "Access to basic medical goods. (ecologist flag has more advanced ones)")

nut.flag.add("j", "Access to tier 1 attachments.")
nut.flag.add("k", "Access to tier 2 attachments.")
nut.flag.add("l", "Access to tier 3 attachments.")
nut.flag.add("b", "Access to tier 4 attachments.")
nut.flag.add("s", "Access to tier 5 attachments.")

nut.flag.add("J", "Access to junk and crafting component items.")
nut.flag.add("U", "Access to repair items.")
nut.flag.add("N", "Access to tech items.")

nut.flag.add("f", "Access to low-tier Freedom armor.")
nut.flag.add("F", "Access to high-tier Freedom armor.")

nut.flag.add("d", "Access to low-tier Duty armor.")
nut.flag.add("D", "Access to high-tier Duty armor.")

nut.flag.add("E", "Access to Ecologist armor and scientific goods.")
nut.flag.add("M", "Access to Military armor.")
nut.flag.add("O", "Access to Monolith armor.")

nut.flag.add("y", "Access to the business menu.")

nut.flag.add("m", "Access to special trader goods/admin goods. Don't freely give this out.")
--nut.flag.add("U", "Access to tech abilities (not even sure if this still in use anywhere, im keeping it tho).")

nut.currency.set("₽", "ruble", "rubles")