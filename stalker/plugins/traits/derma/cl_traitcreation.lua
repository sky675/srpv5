local PANEL = {}

function PANEL:Init()
--	self:Dock(FILL)
	self:SetBackgroundColor(Color(255,255,255,255))
	--self:SetDrawBackground(false)

	print("initial wh ", self:GetWide(), self:GetTall())

	self.posscroll = self:Add("DCategoryList")--DScrollPanel")
	local posscroll = self.posscroll
	--posscroll:SetSize(self:GetWide()/2, 262)
	posscroll:Dock(LEFT)

	self.negscroll = self:Add("DCategoryList")--DScrollPanel")
	local negscroll = self.negscroll
--	negscroll:SetSize(self:GetWide()/2, 262)
--	negscroll:SetPos(self:GetWide()/2, 0)
	negscroll:Dock(RIGHT)
	
	self.notiftext = self:Add("DLabel")
	self.notiftext:Dock(BOTTOM)
	self.notiftext:SetHeight(32) --self:addLabel("")
end

function PANEL:onDisplay()
	traitmain = self
	--self:SetSize(ScrW()*0.3, 322)--292)
	local panel = self

	print("display wh ", self:GetWide(), self:GetTall())
	
	local main = self
	timer.Simple(0, function()
	--[[local main = panel:Add("DPanel")
	traitpanel = main

	main:SetSize(panel:GetWide(), 326)--292)
	main:SetPos(0, y)
	main:SetBackgroundColor(Color(255,255,255,0))]]
	self.cost = 0--main.cost = 0
	self.negtraits = 0 --main.negtraits = 0
	self.langtraits = 1 --main.langtraits = 1
	
	--needs to be up here
	--below this a label to display trait points left
	local lab = self.notiftext--main:Add("DLabel")
	--[[lab:Dock(BOTTOM)
	lab:SetHeight(32)]]
	lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining. If it's not visible, you can do it later via /dotraits.")

	local posscroll = self.posscroll --main:Add("DScrollPanel")
	--[[posscroll:SetSize(main:GetWide()/2, 292)

	posscroll:Dock(LEFT)]]
	posscroll:SetSize(self:GetWide()/2, 262)
	
	local negscroll = self.negscroll --main:Add("DScrollPanel")
	--[[negscroll:SetSize(main:GetWide()/2, 292)
	negscroll:SetPos(main:GetWide()/2, 0)
	negscroll:Dock(RIGHT)]]
	negscroll:SetSize(self:GetWide()/2, 262)
	negscroll:SetPos(self:GetWide()/2, 0)

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


	local buttons = {}

	--this probably could be done better but whatever i guess
	for k,v in pairs(nut.traits.list) do
		if(v.hide) then continue end
		if(v.faction and !v.faction[self:getContext("faction")]) then continue end
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
						--should untoggle that too
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
								local tr = panel:getContext("traits", {})
								tr[main.lastchoselang] = nil
								panel:setContext("traits", tr)
								--panel.payload.traits[main.lastchoselang] = nil
								--panel.payload.data.traits[main.lastchoselang] = nil
								buttons[main.lastchoselang].picked = nil
								buttons[main.lastchoselang]:SetBGColor(Color(255,255,255))
								buttons[main.lastchoselang]:SetTextColor(Color( 140, 140, 140, 255 ))
								main.lastchoselang = nil
							else
								main.langtraits = main.langtraits + 1
							end
						end
						lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
						--panel.payload.traits[k] = nil
						--panel.payload.data.traits[k] = nil
						local tr = panel:getContext("traits", {})
						tr[k] = nil
						panel:setContext("traits", tr)

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
							buttons[v.require].required[k.."_"..i] = buttons[k.."_"..i]
						end

						main.cost = main.cost + v.cost
						if(v.category == "Languages") then
							main.langtraits = main.langtraits + 1
							main.lastchoselang = k
						end
						if(k == "big_trilingual") then --remove one if nonenglish is chosen
							main.langtraits = main.langtraits - 1
						end
						lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
						--panel.payload.traits[k] = true
						--panel.payload.data.traits[k] = true
						local tr = panel:getContext("traits", {})
						tr[k] = true
						panel:setContext("traits", tr)

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
						if(v.require and (!buttons[v.require] or !buttons[v.require].picked)) then return end

						--panel.payload.traits = panel.payload.traits or {}
						--panel.payload.data = panel.payload.data or {}
						--panel.payload.data.traits = panel.payload.data.traits or {}
						if(buttons[k.."_"..i].picked) then
							if(main.cost-v.cost[i] > nut.config.get("traitPoints")) then
								return
							end
							--should untoggle that too
							if(buttons[k.."_"..i].required) then
								print("wtf is this ", buttons[k.."_"..i].required)
								buttons[k.."_"..i].required:DoClick()
							end

							main.cost = main.cost - v.cost[i]
							lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
							--panel.payload.data.traits[k] = nil
							--panel.payload.traits[k] = nil
							local tr = panel:getContext("traits", {})
							tr[k] = nil
							panel:setContext("traits", tr)

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
								buttons[v.require].required[k.."_"..i] = buttons[k.."_"..i]
							end
	

							main.cost = main.cost + v.cost[i]
							lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
							--panel.payload.traits[k] = i
							--panel.payload.data.traits[k] = i
							local tr = panel:getContext("traits", {})
							tr[k] = i
							panel:setContext("traits", tr)

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
					if(v.require and (!buttons[v.require] or !buttons[v.require].picked)) then return end
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
						--should untoggle that too
						if(buttons[k].required) then
							buttons[k].required:DoClick()
						end

						main.cost = main.cost - v.cost
						main.negtraits = main.negtraits - 1
						if(k == "big_nonenglish") then --add one if nonenglish was unpicked
							main.langtraits = main.langtraits + 1
						end
						lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
						--panel.payload.traits[k] = nil
						--panel.payload.data.traits[k] = nil
						local tr = panel:getContext("traits", {})
						tr[k] = nil
						panel:setContext("traits", tr)

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
						if(main.negtraits+1 > nut.config.get("negTraits")) then
							return
						end

						if(v.require) then
							buttons[v.require].required = buttons[v.require].required or {}
							buttons[v.require].required[k] = buttons[k]
						end

						main.cost = main.cost + v.cost
						main.negtraits = main.negtraits + 1
						if(k == "big_nonenglish") then --remove one if nonenglish is chosen
							main.langtraits = main.langtraits - 1
						end
						lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
						--panel.payload.traits[k] = true
						--panel.payload.data.traits[k] = true
						local tr = panel:getContext("traits", {})
						tr[k] = true
						panel:setContext("traits", tr)

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
							--not adding the negative trait stuff here becuz there will never be a level negative trait
							--should untoggle that too
							if(buttons[k.."_"..i].required) then
								buttons[k.."_"..i].required:DoClick()
							end

							main.cost = main.cost - v.cost[i]
							lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
							--panel.payload.traits[k] = nil
							--panel.payload.data.traits[k] = nil
							local tr = panel:getContext("traits", {})
							tr[k] = nil
							panel:setContext("traits", tr)

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
								buttons[v.require].required[k.."_"..i] = buttons[k.."_"..i]
							end
	
							main.cost = main.cost + v.cost[i]
							lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
							--panel.payload.traits[k] = i
							--panel.payload.data.traits[k] = i
							local tr = panel:getContext("traits", {})
							tr[k] = i
							panel:setContext("traits", tr)

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

	end)
end


vgui.Register("nutTraitStuff", PANEL, "nutCharacterCreateStep")