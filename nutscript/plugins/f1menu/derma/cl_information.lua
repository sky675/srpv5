local PANEL = {}
	function PANEL:Init()
		if (IsValid(nut.gui.info)) then
			nut.gui.info:Remove()
		end

		nut.gui.info = self

		surface.PlaySound( "interface/inv_open.ogg" )
		

		local function stalkerGreyBoxButton(id, x, y, icon, tip, callback)
			local unclick = Color(255,255,255, 255)
			local click = Color(143,143,143, 255)

			self[id] = self:Add("DImageButton") 
			self[id]:SetImage("sky/buttons/grey_box.png")
			self[id]:SetPos(invPosX+(x*(invw/invTextureW)), (invPosY+(y*(invh/invTextureH))))
			self[id]:SetSize((28*(invw/invTextureW)), ((27*(invh/invTextureH))))
			self[id]:SetTooltip(tip)

			self[id].label = self:Add("DImage")
			self[id].label:SetImage(icon)
			self[id].label:SetSize((28*(invw/invTextureW)), ((27*(invh/invTextureH))))
			self[id].label:SetImageColor(unclick)
			self[id].label:SetPos(self[id]:GetPos())

			self[id].OnDepressed = function(this)
				this:SetImage("sky/buttons/grey_box_press.png")
				labelXpos, labelYpos = self[id].label:GetPos()
				self[id].label:SetImageColor(click)
				self[id].label:SetPos(labelXpos, labelYpos + ((2*(invh/invTextureH))))

			end

			self[id].OnReleased = function(this)
				surface.PlaySound( "interface/beep.ogg" )
				this:SetImage("sky/buttons/grey_box.png")
				self[id].label:SetImageColor(unclick)
				self[id].label:SetPos(self[id]:GetPos())

				callback()
			end

		end

		


		--[[
		POSITIONING ELEMENTS IN THE INVENTORY
		1)Using the material file, find the coordinates you want it to be at (using the derma coordinate system, starting in upper left) = targX, targY
		2) Equation for converting between this coord in new coord is basically targX * (Scaled Texture X/Original Texture X)
			so in practice:
		3):setPos(invPosX+(targX(invw/invTextureW)), invPosY+(targY(invh/invTextureH)))

		4)now obviously for centering, you just subtract from that half the width and add half the heightof the element your positioning

		I dONT EVEN KNOW IF THE FORMULA ABOVE IS EVEN RIGHT I WROTE THAT AND THEN SPENT THE NEXT 8 HOURS WONDERING WHY IT DIDNT WORK BUT NOW IT
		WORKS IDK FUCK nutModelPanel ME AND ALL MY HOMIES HATE NUTMODELPANEL 
		
		leaving this here because i or you might need it in the future maybe

		edit like a week later: j ask me if ur confused lmao i dont think its that complicated really that it needs a big paragraph
		]]
		
		self:SetSize(ScrW(), ScrH())
	
		local suppress = hook.Run("CanCreateCharInfo", self)
		if (!suppress or (suppress and !suppress.all)) then
			if (!suppress or !suppress.model) then --player model


				self.model = self:Add("nutModelPanel")

				self.model:SetSize((316*(invw/invTextureW)), ((371*(invh/invTextureH))))
				self.model:SetPos(invPosX+(14*(invw/invTextureW)), 0)

				self.model:SetFOV(50)
				self.model.enableHook = true
				self.model.copyLocalSequence = true


			end

			if (!suppress or !suppress.info) then --contaning everything but player model
				self.info = self:Add("DPanel")
				self.info:SetWide(ScrW() * 0.4)
				self.info:Dock(RIGHT)
				self.info:SetDrawBackground(false)
				self.info:DockMargin(150, ScrH() * 0.2, 0, 0)
				

			end

			if (!suppress or !suppress.name) then --character name
				self.nameTopLine = self:Add("DLabel")
				self.nameBotLine = self:Add("DLabel")

				local nameFont = "nutScaledInvenMed"
				local nameColor = Color(153, 143, 127)

				self.nameTopLine:SetFont(nameFont)
				self.nameTopLine:SetTextColor(nameColor)
				self.nameBotLine:SetFont(nameFont)
				self.nameBotLine:SetTextColor(nameColor)

			end

			if (!suppress or !suppress.desc) then --player physical description
				self.desc = self:Add("DTextEntry")
				self.desc:SetFont("nutScaledInvenLight")
				self.desc:SetTextColor(Color(255,255,255,150))
				self.desc:SetEditable(false)

				self.desc:SetDrawBackground(false)
				self.desc:SetDrawBorder(false)
				self.desc:SetMultiline(true)

				self.desc:SetSize((300*(invw/invTextureW)), ((128*(invh/invTextureH))))
				self.desc:SetPos(invPosX+(19*(invw/invTextureW)), (invPosY+(396*(invh/invTextureH))))
				

			end

			if (!suppress or !suppress.buttons) then --buttons of ui (description button/traits button)

				local char = LocalPlayer():getChar()

				--DESCRIPTION BUTTON 
				stalkerGreyButton("descButton", 77, 556, "Description", 
					function()
						--stalkerStringRequest(strPrompt, strDefaultText, fnEnter, fnCancel, strButtonText, strButtonCancelText)
						stalkerStringRequest(
							"Set your characters physical description:",
							(char:getDesc():gsub("#", "\226\128\139#")),
							function(text)
								nut.command.send(
								"chardesc",
								((text:gsub("\226\128\139#", "#")):gsub("[\r\n]", " ", x))
								)
		
								local minLength = nut.config.get("minDescLen", 16)
		
								if (!text or #text:gsub("%s", "") < minLength) then
									return
								end
		
								self.desc:SetText((text:gsub("\226\128\139#", "#")):gsub("[\r\n]", " ", x))
								
							end,
							function(text) end,
							"Change")
					end,
				true,
				self)

				--TRAITS BUTTON (id, x, y, label, callback, autoScale, parent)
				stalkerGreyButton("traitsButton", 189, 556, "Traits",
				function()
					RunConsoleCommand("nut_displaytraits")
				end,
				true,
				self)

			end

			if (!suppress or !suppress.time) then --time of day duh
				self.time = self:Add("DLabel")
				self.time:SetFont("nutScaledInvenMed")
				self.time:SetTextColor(color_white)

			end
			if (!suppress or !suppress.money) then --money rubles
				self.money = self:Add("DLabel")
				self.money:SetFont("nutScaledBrokenMed")
				self.money:SetTextColor( Color(255,255,255,150) )
			end

			if (!suppress or !suppress.weight) then --weight display under inv
				self.weight = self:Add("DLabel")
				self.weight:SetFont("nutScaledInvenMedLight")
				self.weight:SetTextColor(Color(153, 143, 127))

			end

			if (!suppress or !suppress.faction) then --faction name
				self.faction = self:Add("DLabel")
				self.faction:SetFont("nutScaledInvenLightButMediumer")
				self.faction:SetTextColor(Color(74, 77, 77))

			end

			if (!suppress or !suppress.class) then --player class
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

			if (!suppress or !suppress.pages) then --other pages
				PAGE_TABS = {

					["chars"] = 
						{icon="sky/buttons/icon/char_menu.png",
						tip = "Characters",
						order = 20,
						func = function()
							if (IsValid(nut.gui.menu)) then
								nut.gui.menu:Remove()
							end
							vgui.Create("nutCharacter")
						end
						},
					["rules"] =
						{icon="sky/buttons/icon/rules.png",
						tip = "Rules",
						order = 40,
						func = function()
							print("lmao dont be an ass")
						end
						},
					["help"] =
						{icon="sky/buttons/icon/help.png",
						tip = "Help",
						order = 50,
						func = function()
							print("do your best <3")
						end
					}
				}
				if (LocalPlayer():IsSuperAdmin()) then
					PAGE_TABS["config"] =
						{icon="sky/buttons/icon/config.png",
						tip = "Config",
						order = 30,
						func = function()
							if (!LocalPlayer():IsSuperAdmin()) then return end
							if (IsValid(nut.gui.info)) then
								nut.gui.info:Remove()
							end
							
							local panel = nut.gui.menu.panel
							panel:Clear()
							panel:AlphaTo(255, 0.5, 0.1)

							local scroll = panel:Add("DScrollPanel")
							scroll:Dock(FILL)
							
							hook.Run("CreateConfigPanel", panel)
			
							local properties = scroll:Add("DProperties")
							properties:SetSize(panel:GetSize())
			
							nut.gui.properties = properties
			
							-- We're about to store the categories in this buffer.
							local buffer = {}
			
							for k, v in pairs(nut.config.stored) do
								-- Get the category name.
								local index = v.data and v.data.category or "misc"
			
								-- Insert the config into the category list.
								buffer[index] = buffer[index] or {}
								buffer[index][k] = v
							end
			
							-- Loop through the categories in alphabetical order.
							for category, configs in SortedPairs(buffer) do
								category = L(category)
			
								-- Ditto, except we're looping through configs.
								for k, v in SortedPairs(configs) do
									-- Determine which type of panel to create.
									local form = v.data and v.data.form
									local value = nut.config.stored[k].default
			
									if (!form) then
										local formType = type(value)
			
										if (formType == "number") then
											form = "Int"
											value = tonumber(nut.config.get(k)) or value
										elseif (formType == "boolean") then
											form = "Boolean"
											value = util.tobool(nut.config.get(k))
										else
											form = "Generic"
											value = nut.config.get(k) or value
										end
									end
			
									-- VectorColor currently only exists for DProperties.
									if (form == "Generic" and type(value) == "table" and value.r and value.g and value.b) then
										-- Convert the color to a vector.
										value = Vector(value.r / 255, value.g / 255, value.b / 255)
										form = "VectorColor"
									end
			
									local delay = 1
			
									if (form == "Boolean") then
										delay = 0
									end
			
									-- Add a new row for the config to the properties.
									local row = properties:CreateRow(category, tostring(k))
									row:Setup(form, v.data and v.data.data or {})
									row:SetValue(value)
									row:SetTooltip(v.desc)
									row.DataChanged = function(this, value)
										timer.Create("nutCfgSend"..k, delay, 1, function()
											if (IsValid(row)) then
												if (form == "VectorColor") then
													local vector = Vector(value)
			
													value = Color(math.floor(vector.x * 255), math.floor(vector.y * 255), math.floor(vector.z * 255))
												elseif (form == "Int" or form == "Float") then
													value = tonumber(value)
			
													if (form == "Int") then
														value = math.Round(value)
													end
												elseif (form == "Boolean") then
													value = util.tobool(value)
												end
			
												netstream.Start("cfgSet", k, value)
											end
										end)
									end
								end
							end

						end
						}
				end

				if (LocalPlayer():getChar():hasFlags("y")) then
					PAGE_TABS["business"] =
					{icon="sky/buttons/icon/shop.png",
					tip = "Business",
					order = 10,
					func = function()
						if (hook.Run("BuildBusinessMenu", panel) != false) then
							if (IsValid(nut.gui.info)) then
								nut.gui.info:Remove()
							end
							  
							local panel = nut.gui.menu.panel
							panel:Clear()
							panel:AlphaTo(255, 0.5, 0.1)
							panel:Add("nutBusiness")
						end
					end
					}
				end
				
				table.SortByMember(PAGE_TABS, "order", true)

				local barX = 40
				local barY = 736
				local i = 1
				local pages = table.Count(PAGE_TABS)
				local fbuttonX = 50
				local n = pages
				local l = 323-88
				local gap = (l/(n-1))
				for k,v in pairs(PAGE_TABS) do
					fbuttonX = ((i*gap))-gap + barX
					stalkerGreyBoxButton(k, fbuttonX, barY, v.icon, v.tip, v.func)	

					i = i + 1

				end
			end

			hook.Run("CreateCharInfoText", self, suppress)
		end

		hook.Run("CreateCharInfo", self)
	end

	function PANEL:setup(panelParent)
		local char = LocalPlayer():getChar()

		--DESC
		if (self.desc) then
			self.desc:SetText(char:getDesc():gsub("#", "\226\128\139#")) --zero width space :hmmm:

		end

		--NAME SET TEXT
		if (self.nameBotLine or self.nameTopLine) then
			
			local charName = (LocalPlayer():Name():gsub("#", "\226\128\139#"))

			-- local namePart1 = charName:sub(1,12)--.."\n"..charName:sub(16+1)
			-- print(namePart1)
			-- local namePart2 = charName:sub(13)
			-- print(namePart2)

			print("Max name width: " .. (165*(invw/invTextureW)))
			local wrappedName = nut.util.wrapText(charName, (120*(invw/invTextureW)), "nutScaledInvenMed")
			local firstPart = wrappedName[1]


			if (wrappedName[2] and #wrappedName[2] > 0) then
				local secondPart = wrappedName[2]:sub(1, #wrappedName[2]) .. "..."
				self.nameTopLine:SetText(firstPart)
				self.nameBotLine:SetText(secondPart)
			else
				self.nameBotLine:SetText(firstPart)
				self.nameTopLine:SetText("")
			end

			--add \n after 16th character
			--charNameFixWrapAndCut = (charName:sub(1,16).."\n"..charName:sub(16+1)):sub(1,29) .. "..."
			--replace everything after 29th character with "..."

			self.nameBotLine:SizeToContents()
			self.nameTopLine:SizeToContents()

			self.nameBotLine:SetPos(invPosX+(355*(invw/invTextureW)), (invPosY+(55*(invh/invTextureH))) - 30*(ScrH()/768)) --this last bit is size from loadfonts
			self.nameTopLine:SetPos(invPosX+(355*(invw/invTextureW)), (invPosY+(55*(invh/invTextureH))) - 45*(ScrH()/768))
			
			hook.Add(
				"OnCharVarChanged",
				self,
				function(panel, character, key, oldValue, value)
					if (char ~= character) then return end
					if (key ~= "name") then return end

				end
			)
			
		end

		--Money
		if (self.money) then
			self.money:SetText(nut.currency.get(char:getMoney()))
			self.money:SizeToContents()

			moneyWidthX, moneyWidthY = self.money:GetSize()
			self.money:SetPos(invPosX+((542)*(invw/invTextureW)-(self.money:GetWide())), (invPosY+(95*(invh/invTextureH))) - 25*(ScrH()/768)) --money pos --justify left to 530


		end

		--weight label
		local inventory = LocalPlayer():getChar():getInv()
		if (self.weight) then
			self.weight:SetText("Weight: " .. inventory:getWeight() .. " kg (max " .. inventory:getMaxWeight() .. " kg)")
			self.weight:SizeToContents()

			self.weight:SetPos(invPosX+((670)*(invw/invTextureW)-(self.weight:GetWide())), (invPosY+(710*(invh/invTextureH)))) --money pos --justify left to 530
		end

		--FACTION SET TEXT
		if (self.faction) then
			self.faction:SetText(L(team.GetName(LocalPlayer():Team())))
			self.faction:SizeToContents()
			self.faction:SetPos(invPosX+(360*(invw/invTextureW)), (invPosY+(60*(invh/invTextureH))) - 15*(ScrH()/768))
		end

		--TIME
		if (self.time) then
			local format = "%X"--"%A, %d %B %Y %X"
			
			self.time:SetText(os.date(format, nut.date.get()))
			self.time:SizeToContents()
			self.time:SetPos(invPosX+(172*(invw/invTextureW)) - ((self.time:GetWide())*0.5), (invPosY+(375*(invh/invTextureH))) - 20*(ScrH()/768))
			self.time.Think = function(this)
				if ((this.nextTime or 0) < CurTime()) then
					this:SetText(os.date(format, nut.date.get()))
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
					--print("model info test")

					local panel = self 
					timer.Create("infomodelup", 2, 0, function()
						if(!IsValid(panel)) then return end
						if(!panel.model.modelcache or #panel.model.modelcache == 0) then return end


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
		
		if (self.quickInventoryPanel) then
			self.quickInventoryPanel:Remove()
		end

		

		if (inventory) then
			if (SOUND_INVENTORY_OPEN) then
				LocalPlayer():EmitSound(unpack(SOUND_INVENTORY_OPEN))
			end

			
			self.quickInventoryPanel = inventory:show(panelParent)
			self.quickInventoryPanel.Paint = function() end
			self.quickInventoryPanel:SetPos(invPosX+(360*(invw/invTextureW)), (invPosY+(112*(invh/invTextureH))))
			self.quickInventoryPanel:MoveToFront()

			hook.Add("PostRenderVGUI", self.quickInventoryPanel, function()
				hook.Run("PostDrawInventory", self.quickInventoryPanel)
			end)
			
		end

		hook.Run("OnCharInfoSetup", self)


		
	end

	function PANEL:Paint(w, h)
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(Material("sky/srp_inv.png"))
		surface.DrawTexturedRect(invPosX, invPosY,invw, invh)
		
	end

	function PANEL:OnRemove() self.quickInventoryPanel:Remove() 
		surface.PlaySound( "interface/inv_close.ogg" )
	end

vgui.Register("nutCharInfo", PANEL, "EditablePanel")
