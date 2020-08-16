SCHEMA.name = "STALKER"
SCHEMA.introName = "STALKER"
SCHEMA.author = "sky"
SCHEMA.desc = ""--"Corporate control in Osaka, Japan."
SCHEMA.descname = "STALKER RP"

function SCHEMA:GetGameDescription()
	return "NS - "..self.descname --?
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
	onDisplay = function(pan, ye)
		local ya = ye
		pan.reloadSkins = function(panel)
		local y = ya
		local faction = nut.faction.indices[panel.faction]
		local model = panel.model:GetModel() or ""
		local skins = {}
		local bgs = {}
		if(faction) then
			if(faction.skins and faction.skins[model]) then
			for k,v in pairs(faction.skins[model]) do
				if(type(v) == "table") then
					for i=v[1], v[2] do
						table.insert(skins, i)
					end
					if(#faction.skins == 1) then
						break
					end
				else
					table.insert(skins, i)
				end
			end
			end
			if(faction.bodyGroups and faction.bodyGroups[model]) then
				for k,v in pairs(faction.bodyGroups[model]) do
					bgs[k] = {}
					for l,m in pairs(v) do
						if(type(m) == "table") then
							for i=m[1], m[2] do
								table.insert(bgs[k], i)
							end
							if(#v == 1) then
								break
							end
						else
							table.insert(bgs[k], m)
						end
					end
				end
			end
			if(nut.newchar.isBM(model)) then
				local fem = hook.Run("CustomFemaleModel", model, LocalPlayer()) or model:find("female") or model:find("metroll/f")

				if(panel.model.modelcache and panel.model.modelcache != 0) then
					for k,v in pairs(panel.model.modelcache) do
						v:Remove()
						panel.model.modelcache[k] = nil --srsly it doesnt get removed from the table
					end
				end

				local top = ClientsideModel((fem and "models/sky/torsos/female_civ1.mdl") or "models/sky/torsos/male_civ1.mdl")--, RENDERGROUP_OPAQUE)
				--top:Spawn() --spawn here if needed not sure if needed
				top:SetParent(panel.model:GetEntity())
				top:AddEffects(EF_BONEMERGE)
				top:SetNoDraw(true) --it does this so..
				panel.model.modelcache = panel.model.modelcache or {}
				table.insert(panel.model.modelcache, top)

				local bot = ClientsideModel((fem and "models/sky/legs/female_civ1.mdl") or "models/sky/legs/male_civ1.mdl")--, RENDERGROUP_OPAQUE)
				--bot:Spawn() --spawn here if needed not sure if needed
				bot:SetParent(panel.model:GetEntity())
				bot:AddEffects(EF_BONEMERGE)
				bot:SetNoDraw(true) --it does this so..
				panel.model.modelcache = panel.model.modelcache or {}
				table.insert(panel.model.modelcache, bot)
				--PrintTable(panel.model.modelcache)
			end
		else
			return --???????????
		end
		--removing existing stuff
			if(panel.noSkins) then
				panel.noSkins:Remove()
			end
			if(panel.comboSkins) then
				panel.comboSkins:Remove()
			end
			if(panel.eyesSkins) then
				panel.eyesSkins:Remove()
			end
			if(panel.bgpan) then
				panel.bgpan:Remove()
			end
			if(panel.gspan) then
				panel.gspan:Remove()
			end
		
		--skin settings
		if(#skins < 2) then
			if(#skins == 1) then
				panel.payload.data = panel.payload.data or {}
				panel.payload.data.skin = skins[1] --make sure this shit is set i guess, how much this is called
				
				panel.payload.skin = skins[1]
				panel.model:GetEntity():SetSkin(skins[1])
			else
				panel.payload.data = panel.payload.data or {}
				panel.payload.data.skin = 0 --needs to have something
				panel.payload.skin = 0
				
			end
			local one = panel:Add("DLabel")
			panel.noSkins = one
			one:SetSize(panel:GetWide()*0.6, 30)
			one:SetPos(5, y)
			one:SetText("Your model has one skin or one allowed skin!")
			
		end	

		if(!IsValid(panel.noSkins)) then
		--do a dropdown of all the skins i guess?
		local combo = panel:Add("DComboBox")
		panel.comboSkins = combo
		combo:SetSize(panel:GetWide()*0.2, 25)
		combo:SetPos(0, y)
		combo:SetValue("Select Skin")

		for k,v in pairs(skins) do
			combo:AddChoice("Skin #"..tostring(v))
		end
		combo.OnSelect = function(pane, index, value)
			local num = tonumber(string.Split(value, "#")[2]) --idk
			panel.payload.skin = num
			panel.payload.data = panel.payload.data or {}
			panel.payload.data.skin = num
			panel.model:GetEntity():SetSkin(num)
		end
		end

		--eyes
		y = y + 35
		
		local combo = panel:Add("DComboBox")
		panel.eyesSkins = combo
		combo:SetSize(panel:GetWide()*0.2, 25)
		combo:SetPos(0, y)
		combo:SetValue("Select Eye Color")

		combo:AddChoice("Eyecolor: Hazel")
		combo:AddChoice("Eyecolor: Blue")
		combo:AddChoice("Eyecolor: Green")

		combo.OnSelect = function(pane, index, value)
			local num = string.Split(value, ": ")[2]:lower() --idk
			--panel.payload.skin = num
			panel.payload.eyes = num
			panel.payload.data = panel.payload.data or {}
			panel.payload.data.eyes = num
			--panel.model:GetEntity():SetSubMaterial(num)
			
			local mats = panel.model:GetEntity():GetMaterials()
			local mat = {}
			for k,v in pairs(mats) do
				if(string.find(v, "eyeball_l")) then
					mat[#mat+1] = {mat = k-1, type = "l"}
				end
				if(string.find(v, "eyeball_r")) then
					mat[#mat+1] = {mat = k-1, type = "r"}
				end
			end

			if(num == "blue") then
				for k,v in pairs(mat) do
					panel.model:GetEntity():SetSubMaterial(v.mat, v.type == "l" and "models/bloo_ltcom_zel/citizens/eyeball_l_blue" or "models/bloo_ltcom_zel/citizens/eyeball_r_blue")
				end
			elseif(num == "green") then
				for k,v in pairs(mat) do
					panel.model:GetEntity():SetSubMaterial(v.mat, v.type == "l" and "models/bloo_ltcom_zel/citizens/eyeball_l_green" or "models/bloo_ltcom_zel/citizens/eyeball_r_green")
				end
			else
				for k,v in pairs(mat) do
					panel.model:GetEntity():SetSubMaterial(v.mat)
				end
			end
		end


		--bodygroups
		y = y + 35
		local x = 0
		
		if(table.Count(bgs) != 0) then
			--make invis panel and parent dropdowns made below to it
			local bgpan = panel:Add("DPanel")
			panel.bgpan = bgpan
			bgpan:SetSize(panel:GetWide(), 40)
			bgpan:SetPos(x,y)
			bgpan:SetPaintBackground(false)
			for k,v in pairs(bgs) do
				local curbg = panel.model:GetEntity():FindBodygroupByName(k)
				if(curbg == -1) then continue end
				--create dropdown side by side for each one
				local dp = bgpan:Add("DComboBox")
				dp:SetSize(panel:GetWide()*0.2, 25)
				dp:SetPos(x, 0)
				x = x + panel:GetWide()*0.2 + 12
				--dp:SetValue("Select Bodygroup")
				for k2,v2 in pairs(v) do
					dp:AddChoice(k.." #"..tostring(v2))
				end
				dp:ChooseOptionID(1) --default first
				dp.OnSelect = function(pane, index, value)
					local num = tonumber(string.Split(value, "#")[2]) --idk
					panel.payload.bgs = panel.payload.bgs or {}
					panel.payload.bgs[curbg] = num
					panel.payload.data = panel.payload.data or {}
					panel.payload.data.groups = panel.payload.data.groups or {}
					panel.model:GetEntity():SetBodygroup(curbg, num)
					panel.payload.data.groups[curbg] = num
				end
			end
			y = y + 20
		end

		if(nut.newchar.isBM(model) and SCHEMA.GSCharConfig) then
			local fem = hook.Run("CustomFemaleModel", model, LocalPlayer()) or model:find("female") or model:find("metroll/f")

			local curt = 0
			local curb = 0
			local x = 0
			local topm
			local botm

			if(fem) then
				topm = SCHEMA.GSCharConfig.fem.top
				botm = SCHEMA.GSCharConfig.fem.bot
			else
				topm = SCHEMA.GSCharConfig.male.top
				botm = SCHEMA.GSCharConfig.male.bot
			end

			local bgpan = panel:Add("DPanel")
			panel.gspan = bgpan
			bgpan:SetSize(panel:GetWide(), 65)
			bgpan:SetPos(x,y)
			bgpan:SetPaintBackground(false)

			local labl = bgpan:Add("DLabel")
			labl:SetSize(panel:GetWide()*0.3, 20)
			labl:SetPos(5, 0)--y)
			labl:SetText("Starter Clothing")
			labl:SetTooltip("Disclaimer: Preview may not be 100% accurate (clipping with arms, heads and hooded tops only happen in the previews)")

			y = y + 25

			--top
			local dp = bgpan:Add("DComboBox")
			dp:SetSize(panel:GetWide()*0.2, 25)
			dp:SetPos(x, 0)
			dp:SetTooltip("Disclaimer: Preview may not be 100% accurate (clipping with arms, heads and hooded tops only happen in the preview)")
			x = x + panel:GetWide()*0.2 + 12

			for k,v in pairs(topm) do
				dp:AddChoice(v.name, v.data)
			end
			dp:ChooseOptionID(1) --default first
			dp.OnSelect = function(pane, index, value, num)
				panel.payload.gss = panel.payload.gss or {}
				panel.payload.gss.top = num.id
				panel.payload.data = panel.payload.data or {}
				panel.payload.data.gs = panel.payload.data.gs or {}
				if(num.model) then
				panel.model.modelcache[1]:SetModel(num.model)
				else
					panel.model.modelcache[1]:SetModel((fem and "models/sky/torsos/female_civ1.mdl") or "models/sky/torsos/male_civ1.mdl")
				end
				panel.model.modelcache[1]:SetBodygroup(0, num.bg)
				panel.model.modelcache[1]:SetSkin(num.skin or 0)

				panel.payload.data.gs.top = num.id
			end

			--bot
			dp = bgpan:Add("DComboBox")
			dp:SetSize(panel:GetWide()*0.2, 25)
			dp:SetPos(x, 0)
			dp:SetTooltip("Disclaimer: Preview may not be 100% accurate (clipping with arms, heads and hooded tops only happen in the previews)")
			x = x + panel:GetWide()*0.2 + 12

			for k,v in pairs(botm) do
				dp:AddChoice(v.name, v.data)
			end
			dp:ChooseOptionID(1) --default first
			dp.OnSelect = function(pane, index, value, num)
				panel.payload.gss = panel.payload.gss or {}
				panel.payload.gss.bot = num.id
				panel.payload.data = panel.payload.data or {}
				panel.payload.data.gs = panel.payload.data.gs or {}
				if(num.model) then
				panel.model.modelcache[2]:SetModel(num.model)
			else
				panel.model.modelcache[2]:SetModel((fem and "models/sky/legs/female_civ1.mdl") or "models/sky/legs/male_civ1.mdl")
				end
				panel.model.modelcache[2]:SetBodygroup(0, num.bg)
				panel.model.modelcache[2]:SetSkin(num.skin or 0)
				
				panel.payload.data.gs.bot = num.id
			end
		end

		

		end--end of reloadSkins

		local dum = pan:Add("DPanel")
		dum:SetPos(0, y)
		dum:SetSize(0, 140)
		timer.Simple(0.1, function()
			dum:Remove() --remove the dummy item
		end)
		pan:reloadSkins(pan)
		return dum
	end,
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

nut.currency.set("", "RU", "RU")