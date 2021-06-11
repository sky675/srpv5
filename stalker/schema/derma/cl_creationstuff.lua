local PANEL = {}

function PANEL:Init()
	self.title = self:addLabel("Appearance Options")
end

function PANEL:onDisplay()
	self:SetSize(ScrW()*0.3, 292)
	local panel = nut.gui.charCreate
	local y = 40
	local faction = nut.faction.indices[self:getContext("faction")]
	local modelinfo = faction.models[self:getContext("model") or 1]
	local model, b, c
	if (istable(modelInfo)) then
		model, b, c = unpack(modelinfo)
	else
		model, b, c = modelinfo, 0, {}
	end
	
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
		--[[ --unused
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
		end]]
	else
		return --???????????
	end
	--removing existing stuff
		if(self.noSkins) then
			self.noSkins:Remove()
		end
		if(self.comboSkins) then
			self.comboSkins:Remove()
		end
		if(self.eyesSkins) then
			self.eyesSkins:Remove()
		end
		if(self.bgpan) then
			self.bgpan:Remove()
		end
		if(self.gspan) then
			self.gspan:Remove()
		end
		if(self.noAnorak) then
			self.noAnorak:Remove()
		end
		if(self.anorakSkins) then
			self.anorakSkins:Remove()
		end
	
	--skin settings
	if(#skins < 2) then
		if(#skins == 1) then
			--panel.payload.data = panel.payload.data or {}
			--panel.payload.data.skin = skins[1] --make sure this shit is set i guess, how much this is called
			self:setContext("skin", skins[1])
			--panel.payload.skin = skins[1]
			panel.model:GetEntity():SetSkin(skins[1])
		else
			--panel.payload.data = panel.payload.data or {}
			--panel.payload.data.skin = 0 --needs to have something
			--panel.payload.skin = 0
			self:setContext("skin", 0)
		end
		local one = self:Add("DLabel")
		self.noSkins = one
		one:SetSize(panel:GetWide()*0.6, 30)
		one:Dock(TOP)
		one:SetText("Your model only has one skin or one allowed skin!")
		
	end	

	if(!IsValid(self.noSkins)) then
	--do a dropdown of all the skins i guess?
	local combo = self:Add("DComboBox")
	self.comboSkins = combo
	combo:SetSize(self:GetWide(), 25)
	combo:SetFont("stalkerTraitLabelFont")
	combo:SetTextColor(color_white)
	combo:SetPos(0, y)
	combo:SetValue("Select Skin")

	combo.Paint = function(combo, w, h)
		nut.util.drawBlur(combo)
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, w, h)
	end

	for k,v in pairs(skins) do
		combo:AddChoice("Skin #"..tostring(v))
	end
	combo.OnSelect = function(pane, index, value)
		local num = tonumber(string.Split(value, "#")[2]) --idk
		--panel.payload.skin = num
		--panel.payload.data = panel.payload.data or {}
		--panel.payload.data.skin = num
		self:setContext("skin", num)
		panel.model:GetEntity():SetSkin(num)
	end
	end

	--eyes
	y = y + 35
	
	local combo = self:Add("DComboBox")
	self.eyesSkins = combo
	combo:SetSize(self:GetWide(), 25)
	combo:SetFont("stalkerTraitLabelFont")
	combo:SetTextColor(color_white)
	combo:SetPos(0, y)
	combo:SetValue("Select Eye Color")

	combo:AddChoice("Eyecolor: Hazel")
	combo:AddChoice("Eyecolor: Blue")
	combo:AddChoice("Eyecolor: Green")
	combo.Paint = function(combo, w, h)
		nut.util.drawBlur(combo)
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawRect(0, 0, w, h)
	end

	combo.OnSelect = function(pane, index, value)
		local num = string.Split(value, ": ")[2]:lower() --idk
		--panel.payload.eyes = num
		--panel.payload.data = panel.payload.data or {}
		--panel.payload.data.eyes = num
		self:setContext("eyes", num)
		--panel.model:GetEntity():SetSubMaterial(num)
		
		local mats = panel.model:GetEntity():GetMaterials()
		local mat = {}
		for k,v in ipairs(mats) do
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
		local bgpan = self:Add("DPanel")
		self.bgpan = bgpan
		bgpan:SetSize(self:GetWide(), 40)
		bgpan:SetPos(x,y)
		bgpan:SetPaintBackground(false)
		for k,v in pairs(bgs) do
			local curbg = panel.model:GetEntity():FindBodygroupByName(k)
			if(curbg == -1) then continue end
			--create dropdown side by side for each one
			local dp = bgpan:Add("DComboBox")
			dp:SetSize(self:GetWide(), 25)
			dp:SetFont("stalkerTraitLabelFont")
			dp:SetTextColor(color_white)
			dp:SetPos(x, 0)
			x = x + panel:GetWide()*0.2 + 12
			--dp:SetValue("Select Bodygroup")
			dp.Paint = function(dp, w, h)
				nut.util.drawBlur(dp)
				surface.SetDrawColor(0, 0, 0, 100)
				surface.DrawRect(0, 0, w, h)
			end
			for k2,v2 in pairs(v) do
				dp:AddChoice(k.." #"..tostring(v2))
			end
			dp:ChooseOptionID(1) --default first
			dp.OnSelect = function(pane, index, value)
				local num = tonumber(string.Split(value, "#")[2]) --idk
				local cur = self:getContext("bgs", {})
				cur[curbg] = num
				self:setContext("bgs", cur)
				--panel.payload.bgs = panel.payload.bgs or {}
				--panel.payload.bgs[curbg] = num
				--panel.payload.data = panel.payload.data or {}
				--panel.payload.data.groups = panel.payload.data.groups or {}
				panel.model:GetEntity():SetBodygroup(curbg, num)
				--panel.payload.data.groups[curbg] = num
			end
		end
		y = y + 20
	elseif(faction.defaultBGs) then
		local fem = hook.Run("CustomFemaleModel", model, LocalPlayer(), nil, true) or model:find("female") or model:find("metroll/f")

		self:setContext("bgs", fem and faction.defaultBGs.female or faction.defaultBGs.male)
	end

	--comment below out and add new thing for chosing anorak color
	--if faction table has a set texture (faction.anorak)
	--dont let them select, otherwise choose from default
	if(faction.hasanorak) then--string.find(model, "sky/stalker")) then
	if(faction.anorak) then
			self:setContext("anorak", faction.anorak)
			
		local one = self:Add("DLabel")
		self.noAnorak = one
		one:SetSize(panel:GetWide()*0.6, 30)
		one:SetPos(5, y)
		one:SetText("Your faction has a default anorak skin.")

		local mats = panel.model:GetEntity().bm.t:GetMaterials()
		local mat
		for k,v in ipairs(mats) do
			if(string.find(v, "anorak_lone")) then
				mat = k-1
				break
			end
		end

		panel.model:GetEntity().bm.t:SetSubMaterial(mat, ANORAKTEXTURES[faction.anorak])
	else
		local combo = self:Add("DComboBox")
		self.anorakSkins = combo
		combo:SetSize(self:GetWide(), 25)
		combo:SetFont("stalkerTraitLabelFont")
		combo:SetTextColor(color_white)
		combo:SetPos(0, y)
		combo:SetValue("Select Anorak Skin")
		combo.Paint = function(combo, w, h)
			nut.util.drawBlur(combo)
			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawRect(0, 0, w, h)
		end

		local defaultanorak = {
			--[1] = "Bandit Black", --bandit black
			[2] = "All Black", --all black
			[3] = "Brown Plaid", --brown plaid
			[4] = "White", --white
			[5] = "Dark Green", --dark green
			[6] = "Flecktarn", --flecktarn
			[7] = "Red Plaid", --red plaid
			[8] = "Tan", --tan?
		}
		
		combo:AddChoice("Default Green")
		for k,v in pairs(defaultanorak) do
			combo:AddChoice(v, k)
		end
	
		combo.OnSelect = function(pane, index, value, data)
			local num = data
			--panel.payload.eyes = num
			--panel.payload.data = panel.payload.data or {}
			--panel.payload.data.eyes = num
			self:setContext("anorak", num)

			local mats = panel.model:GetEntity().bm.t:GetMaterials()
			local mat
			for k,v in ipairs(mats) do
				if(string.find(v, "anorak_lone")) then
					mat = k-1
					break
				end
			end

			if(num) then
			panel.model:GetEntity().bm.t:SetSubMaterial(mat, ANORAKTEXTURES[num])
			else
				panel.model:GetEntity().bm.t:SetSubMaterial(mat)
			end
		end

	end
	y = y + 35

	end


	if(nut.newchar.isBM(model) and SCHEMA.GSCharConfig and !faction.defaultClothing) then
		local fem = hook.Run("CustomFemaleModel", model, LocalPlayer(), nil, true) or model:find("female") or model:find("metroll/f")

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

		local bgpan = self:Add("DPanel")
		self.gspan = bgpan
		bgpan:SetSize(self:GetWide(), 65)
		bgpan:SetPos(x,y)
		bgpan:SetPaintBackground(false)

		local labl = bgpan:Add("DLabel")
		labl:SetSize(self:GetWide()*0.3, 20)
		labl:SetPos(5, 0)--y)
		labl:SetText("Starter Clothing")
		labl:SetTooltip("Disclaimer: Preview may not be 100% accurate (clipping with arms, heads and hooded tops only happen in the previews)")

		y = y + 25

		--top
		local dp = bgpan:Add("DComboBox")
		dp:SetSize(self:GetWide(), 25)
		dp:SetFont("stalkerTraitLabelFont")
		dp:SetTextColor(color_white)
		dp:SetPos(x, 0)
		dp:SetTooltip("Disclaimer: Preview may not be 100% accurate (clipping with arms, heads and hooded tops only happen in the preview)")
		x = x + self:GetWide()*0.2 + 12
		dp.Paint = function(dp, w, h)
			nut.util.drawBlur(dp)
			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawRect(0, 0, w, h)
		end

		for k,v in pairs(topm) do
			dp:AddChoice(v.name, v.data)
		end
		dp:ChooseOptionID(1) --default first
		dp.OnSelect = function(pane, index, value, num)
			--panel.payload.gss = panel.payload.gss or {}
			--panel.payload.gss.top = num.id
			--panel.payload.data = panel.payload.data or {}
			--panel.payload.data.gs = panel.payload.data.gs or {}
			local cur = self:getContext("gss", {})
			cur.top = num.id
			self:setContext("gss", cur)

			if(num.model) then
			panel.model.modelcache[1]:SetModel(num.model)
			else
				panel.model.modelcache[1]:SetModel((fem and "models/sky/torsos/female_citizen1.mdl") or "models/sky/torsos/male_citizen1.mdl")
			end
			panel.model.modelcache[1]:SetBodygroup(0, num.bg)
			panel.model.modelcache[1]:SetSkin(num.skin or 0)

			--panel.payload.data.gs.top = num.id
		end

		--bot
		dp = bgpan:Add("DComboBox")
		dp:SetSize(self:GetWide(), 25)
		dp:SetFont("stalkerTraitLabelFont")
		dp:SetTextColor(color_white)
		dp:SetPos(x, 0)
		dp:SetTooltip("Disclaimer: Preview may not be 100% accurate (clipping with arms, heads and hooded tops only happen in the previews)")
		x = x + self:GetWide()*0.2 + 12
		dp.Paint = function(dp, w, h)
			nut.util.drawBlur(dp)
			surface.SetDrawColor(0, 0, 0, 100)
			surface.DrawRect(0, 0, w, h)
		end
		for k,v in pairs(botm) do
			dp:AddChoice(v.name, v.data)
		end
		dp:ChooseOptionID(1) --default first
		dp.OnSelect = function(pane, index, value, num)
			--panel.payload.gss = panel.payload.gss or {}
			--panel.payload.gss.bot = num.id
			--panel.payload.data = panel.payload.data or {}
			--panel.payload.data.gs = panel.payload.data.gs or {}
			local cur = self:getContext("gss", {})
			cur.bot = num.id
			self:setContext("gss", cur)

			if(num.model) then
			panel.model.modelcache[2]:SetModel(num.model)
			else
			panel.model.modelcache[2]:SetModel((fem and "models/sky/legs/female_citizen1.mdl") or "models/sky/legs/male_citizen1.mdl")
			end
			panel.model.modelcache[2]:SetBodygroup(0, num.bg)
			panel.model.modelcache[2]:SetSkin(num.skin or 0)
			
			--panel.payload.data.gs.bot = num.id
		end
	elseif(nut.newchar.isBM(model) and faction.defaultClothing) then
		if(istable(faction.defaultClothing)) then
			if(!faction.defaultClothing["assign"]) then
				faction.defaultClothing.assign = true
			end

			self:setContext("gss", faction.defaultClothing)
		end
	end
end

--use this to reset stuff if it has issues?
function PANEL:onHide()

end


vgui.Register("nutSkinStuff", PANEL, "nutCharacterCreateStep")