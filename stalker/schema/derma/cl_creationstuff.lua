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
			self:setContext("skin", skins[1])
			panel.model:GetEntity():SetSkin(skins[1])
		else
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
		self:setContext("eyes", num)
		
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
				panel.model:GetEntity():SetBodygroup(curbg, num)
			end
		end
		y = y + 20
	elseif(faction.defaultBGs) then
		local fem = hook.Run("CustomFemaleModel", model, LocalPlayer(), nil, true) or model:find("female") or model:find("metroll/f")

		self:setContext("bgs", fem and faction.defaultBGs.female or faction.defaultBGs.male)
	end

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


end

--use this to reset stuff if it has issues?
function PANEL:onHide()

end


vgui.Register("nutSkinStuff", PANEL, "nutCharacterCreateStep")