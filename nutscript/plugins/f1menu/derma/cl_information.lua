local PANEL = {}
	function PANEL:Init()
		if (IsValid(nut.gui.info)) then
			nut.gui.info:Remove()
		end

		nut.gui.info = self

		self:SetSize(ScrW() * 0.6, ScrH() * 0.7)
		self:Center()

		local suppress = hook.Run("CanCreateCharInfo", self)

		if (!suppress or (suppress and !suppress.all)) then
			if (!suppress or !suppress.model) then
				self.model = self:Add("nutModelPanel")
				self.model:SetWide(ScrW() * 0.25)
				self.model:Dock(LEFT)
				self.model:SetFOV(50)
				self.model.enableHook = true
				self.model.copyLocalSequence = true
			end

			if (!suppress or !suppress.info) then
				self.info = self:Add("DPanel")
				self.info:SetWide(ScrW() * 0.4)
				self.info:Dock(RIGHT)
				self.info:SetDrawBackground(false)
				self.info:DockMargin(150, ScrH() * 0.2, 0, 0)
			end

			if (!suppress or !suppress.name) then
				self.name = self.info:Add("DLabel")
				self.name:SetFont("nutHugeFont")
				self.name:SetTall(60)
				self.name:Dock(TOP)
				self.name:SetTextColor(color_white)
				self.name:SetExpensiveShadow(1, Color(0, 0, 0, 150))
			end

			if (!suppress or !suppress.desc) then
				self.desc = self.info:Add("DTextEntry")
				self.desc:Dock(TOP)
				self.desc:SetFont("nutMediumLightFont")
				self.desc:SetTall(28)
			end

			if (!suppress or !suppress.time) then
				self.time = self.info:Add("DLabel")
				self.time:SetFont("nutMediumFont")
				self.time:SetTall(28)
				self.time:Dock(TOP)
				self.time:SetTextColor(color_white)
				self.time:SetExpensiveShadow(1, Color(0, 0, 0, 150))
			end

			if (!suppress or !suppress.money) then
				self.money = self.info:Add("DLabel")
				self.money:Dock(TOP)
				self.money:SetFont("nutMediumFont")
				self.money:SetTextColor(color_white)
				self.money:SetExpensiveShadow(1, Color(0, 0, 0, 150))
				self.money:DockMargin(0, 10, 0, 0)
			end

			if (!suppress or !suppress.faction) then
				self.faction = self.info:Add("DLabel")
				self.faction:Dock(TOP)
				self.faction:SetFont("nutMediumFont")
				self.faction:SetTextColor(color_white)
				self.faction:SetExpensiveShadow(1, Color(0, 0, 0, 150))
				self.faction:DockMargin(0, 10, 0, 0)
			end

			if (!suppress or !suppress.class) then
				local class = nut.class.list[LocalPlayer():getChar():getClass()]
				
				if (class) then
					self.class = self.info:Add("DLabel")
					self.class:Dock(TOP)
					self.class:SetFont("nutMediumFont")
					self.class:SetTextColor(color_white)
					self.class:SetExpensiveShadow(1, Color(0, 0, 0, 150))
					self.class:DockMargin(0, 10, 0, 0)
				end
			end

			hook.Run("CreateCharInfoText", self, suppress)
		end

		hook.Run("CreateCharInfo", self)
	end

	function PANEL:setup()
		local char = LocalPlayer():getChar()
		if (self.desc) then
			self.desc:SetText(char:getDesc():gsub("#", "\226\128\139#"))
			self.desc.OnEnter = function(this, w, h)
				nut.command.send(
					"chardesc",
					(this:GetText():gsub("\226\128\139#", "#"))
				)
			end
		end

		if (self.name) then
			self.name:SetText(LocalPlayer():Name():gsub("#", "\226\128\139#"))
			hook.Add(
				"OnCharVarChanged",
				self,
				function(panel, character, key, oldValue, value)
					if (char ~= character) then return end
					if (key ~= "name") then return end

					self.name:SetText(value:gsub("#", "\226\128\139#"))
				end
			)
		end

		if (self.money) then
			self.money:SetText(L("charMoney", nut.currency.get(char:getMoney())))
		end

		if (self.faction) then
			self.faction:SetText(L("charFaction", L(team.GetName(LocalPlayer():Team()))))
		end

		if (self.time) then
			local format = "%X"--"%A, %d %B %Y %X"
			
			self.time:SetText(L("curTime", os.date(format, nut.date.get())))
			self.time.Think = function(this)
				if ((this.nextTime or 0) < CurTime()) then
					this:SetText(L("curTime", os.date(format, nut.date.get())))
					this.nextTime = CurTime() + 0.5
				end
			end
		end

		if (self.class) then
			local class = nut.class.list[char:getClass()]
			if (class) then
				self.class:SetText(L("charClass", L(class.name)))
			end
		end

		if (self.model) then
			self.model:SetModel(LocalPlayer():GetModel())
			self.model.Entity:SetSkin(LocalPlayer():GetSkin())

			for k, v in ipairs(LocalPlayer():GetBodyGroups()) do
				self.model.Entity:SetBodygroup(v.id, LocalPlayer():GetBodygroup(v.id))
			end

			local ent = self.model.Entity
			if (ent and IsValid(ent)) then
				local mats = LocalPlayer():GetMaterials()
				for k, v in pairs(mats) do
					ent:SetSubMaterial(k - 1, LocalPlayer():GetSubMaterial(k - 1))
				end
				
				local model = LocalPlayer():GetModel()
				if(nut.newchar and nut.newchar.isBM(model)) then

					if(self.model.modelcache and self.model.modelcache != 0) then
						for k,v in pairs(self.model.modelcache) do
							v:Remove()
							self.model.modelcache[k] = nil --srsly it doesnt get removed from the table
						end
					end

					

					local top = ClientsideModel(char:getData("gctop", 
						LocalPlayer():isFemale() and defaultfemtop or 
						defaultmaletop))--, RENDERGROUP_OPAQUE)
					--top:Spawn() --spawn here if needed not sure if needed
					top:SetParent(self.model:GetEntity())
					top:AddEffects(EF_BONEMERGE)
					top:SetNoDraw(true) --it does this so..
					top:SetBodygroup(0, char:getData("gtop", 0))
					top:SetSkin(char:getData("gtopskin", 0))
					
					if(char:getData("gbgs", {})["t"]) then
						for k,v in pairs(char:getData("gbgs", {})["t"]) do
							top:SetBodygroup(k, v)
						end
					end
					if(char:getData("gsub", {})["t"]) then
						local mats1 = top:GetMaterials()
						for k,v in pairs(char:getData("gsub", {})["t"]) do
							local mat
							for k2,v2 in pairs(mats1) do
								if(string.find(v2, k)) then
									mat = k2-1
								end
							end
							if(mat) then
								top:SetSubMaterial(mat, v)
							end
						end
					end
					
					self.model.modelcache = self.model.modelcache or {}
					table.insert(self.model.modelcache, top)

	
					local bot = ClientsideModel(char:getData("gcbot", 
						LocalPlayer():isFemale() and defaultfembot or 
						defaultmalebot))--, RENDERGROUP_OPAQUE)
					--bot:Spawn() --spawn here if needed not sure if needed
					bot:SetParent(self.model:GetEntity())
					bot:AddEffects(EF_BONEMERGE)
					bot:SetNoDraw(true) --it does this so..
					bot:SetBodygroup(0, char:getData("gbot", 0))
					bot:SetSkin(char:getData("gbotskin", 0))
					
					if(char:getData("gbgs", {})["b"]) then
						for k,v in pairs(char:getData("gbgs", {})["b"]) do
							bot:SetBodygroup(k, v)
						end
					end
					if(char:getData("gsub", {})["b"]) then
						local mats1 = bot:GetMaterials()
						for k,v in pairs(char:getData("gsub", {})["b"]) do
							local mat
							for k2,v2 in pairs(mats1) do
								if(string.find(v2, k)) then
									mat = k2-1
								end
							end
							if(mat) then
								top:SetSubMaterial(mat, v)
							end
						end
					end

					self.model.modelcache = self.model.modelcache or {}
					table.insert(self.model.modelcache, bot)
					--PrintTable(self.model.modelcache)
					if(defaultbothidden == -1 or LocalPlayer():getChar():getData("gbot", 0) == -1) then
						bot.nodraw = true
					end
					print("model info test")

					local panel = self
					timer.Create("infomodelup", 2, 0, function()
						if(!IsValid(panel)) then return end
						if(!panel.model.modelcache or panel.model.modelcache == 0) then return end

						print("just wanted to check how often this runs actually e")

						panel.model.modelcache[1]:SetBodygroup(0, char:getData("gtop", 0))
						panel.model.modelcache[1]:SetSkin(char:getData("gtopskin", 0))
						panel.model.modelcache[2]:SetBodygroup(0, char:getData("gbot", 0))
						panel.model.modelcache[2]:SetSkin(char:getData("gbotskin", 0))
						
						--if bot was hidden rehide it
						if(!panel.model.modelcache[2].nodraw and (defaultbothidden == -1 or LocalPlayer():getChar():getData("gbot", 0) == -1)) then
							panel.model.modelcache[2].nodraw = true
						elseif(panel.model.modelcache[2].nodraw and (defaultbothidden != -1 and LocalPlayer():getChar():getData("gbot", 0) != -1)) then
							panel.model.modelcache[2].nodraw = nil
						end
					end)
				end
			end
		end

		hook.Run("OnCharInfoSetup", self)
	end

	function PANEL:Paint(w, h)
	end
vgui.Register("nutCharInfo", PANEL, "EditablePanel")
