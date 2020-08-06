local PLUGIN = PLUGIN

local defaultTraits = {
	--	["craftorsomethingidk"] = 1,
	--	["basesomethingidk"] = true,
}

nut.config.add("traitPoints", 4, "Starting trait points.", nil, {
	form = "Int",
	data = {min = 1, max = 100},
	category = "Characters"
})
nut.config.add("negTraits", 3, "The amount of negative traits that can be chosen at once in char creation.", nil, {
	form = "Int",
	data = {min = 1, max = 10},
	category = "Characters"
})
nut.config.add("langTraits", 2, "The normal amount of language traits that can be chosen at once in char creation.", nil, {
	form = "Int",
	data = {min = 1, max = 10},
	category = "Characters"
})

nut.char.registerVar("traits", {
	index = 5,
	default = {},
	--noNetworking = true, --it gets set in data so this is fine
	--******* SO I DONT GET CONFUSED AGAIN 
	--[[


		THIS DOES NOT RUN, ITS IN DERMA NOW
		THIS DOES NOT RUN, ITS IN DERMA NOW
		THIS DOES NOT RUN, ITS IN DERMA NOW
		THIS DOES NOT RUN, ITS IN DERMA NOW
		THIS DOES NOT RUN, ITS IN DERMA NOW

	]]
	onDisplay = function(panel, y)
		local main = panel:Add("DPanel")
		main:SetSize(panel:GetWide(), 292)
		main:SetPos(0, y)
		main:SetBackgroundColor(Color(255,255,255,0))
		main.cost = 0
		main.negtraits = 0
		main.langtraits = 1
		
		--needs to be up here
		--below this a label to display trait points left
		local lab = main:Add("DLabel")
		lab:Dock(BOTTOM)
		lab:SetHeight(32)
		lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")


		local posscroll = main:Add("DScrollPanel")
		posscroll:SetSize(main:GetWide()/2, 292)

		--posscroll:Dock(LEFT)
		local negscroll = main:Add("DScrollPanel")
		negscroll:SetSize(main:GetWide()/2, 292)
		negscroll:SetPos(main:GetWide()/2, 0)
		--negscroll:Dock(RIGHT)

		posscroll:InvalidateLayout(true)
		negscroll:InvalidateLayout(true)

		local poscat = posscroll:GetCanvas():Add("DCategoryList")
		poscat:SetSize(main:GetWide()/2, 260)
		poscat:Dock(FILL)
		poscat:DockMargin( 0, 0, 0, 0 )
		poscat.cats = {}

		local negcat = negscroll:GetCanvas():Add("DCategoryList")
		negcat:SetSize(main:GetWide()/2, 260)
		negcat:SetPos(main:GetWide()/2, 0)
		negcat:Dock(FILL)
		negcat.cats = {}
		negcat:DockMargin( 0, 0, 0, 0 )


		local buttons = {}

		--this probably could be done better but whatever i guess
		for k,v in pairs(nut.traits.list) do
			if(v.hide) then continue end
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
						panel.payload.traits = panel.payload.traits or {}
						panel.payload.data = panel.payload.data or {}
						panel.payload.data.traits = panel.payload.data.traits or {}
						print(main.langtraits.." now")
						if(buttons[k].picked) then
							if(main.cost-v.cost > nut.config.get("traitPoints")) then
								return
							end
							print("removal? "..(main.langtraits-1).." "..nut.config.get("langTraits"))
							if(v.category == "Languages" and main.langtraits-1 > nut.config.get("langTraits")) then
								return
							end

							main.cost = main.cost - v.cost
							if(v.category == "Languages") then
								main.langtraits = main.langtraits - 1
							end
							if(k == "big_trilingual") then --remove one if nonenglish is chosen
								--main.langtraits = main.langtraits - 1
								if(main.lastchoselang) then
									panel.payload.traits[main.lastchoselang] = nil
									panel.payload.data.traits[main.lastchoselang] = nil
									buttons[main.lastchoselang].picked = nil
									buttons[main.lastchoselang]:SetBGColor(Color(255,255,255))
									buttons[main.lastchoselang]:SetTextColor(Color( 140, 140, 140, 255 ))
									main.lastchoselang = nil
								else
									main.langtraits = main.langtraits + 1
								end
							end
							lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
							panel.payload.traits[k] = nil
							panel.payload.data.traits[k] = nil
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

							main.cost = main.cost + v.cost
							if(v.category == "Languages") then
								main.langtraits = main.langtraits + 1
								main.lastchoselang = k
							end
							if(k == "big_trilingual") then --remove one if nonenglish is chosen
								main.langtraits = main.langtraits - 1
							end
							lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
							panel.payload.traits[k] = true
							panel.payload.data.traits[k] = true
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
							panel.payload.traits = panel.payload.traits or {}
							panel.payload.data = panel.payload.data or {}
							panel.payload.data.traits = panel.payload.data.traits or {}
							if(buttons[k.."_"..i].picked) then
								if(main.cost-v.cost[i] > nut.config.get("traitPoints")) then
									return
								end

								main.cost = main.cost - v.cost[i]
								lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
								panel.payload.data.traits[k] = nil
								panel.payload.traits[k] = nil
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

								main.cost = main.cost + v.cost[i]
								lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
								panel.payload.traits[k] = i
								panel.payload.data.traits[k] = i
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
						panel.payload.traits = panel.payload.traits or {}
						panel.payload.data = panel.payload.data or {}
						panel.payload.data.traits = panel.payload.data.traits or {}
						if(buttons[k].picked) then
							if(main.cost-v.cost > nut.config.get("traitPoints")) then
								return
							end
							if(main.negtraits-1 > nut.config.get("negTraits")) then
								return
							end

							main.cost = main.cost - v.cost
							main.negtraits = main.negtraits - 1
							if(k == "big_nonenglish") then --add one if nonenglish was unpicked
								main.langtraits = main.langtraits + 1
							end
							lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
							panel.payload.traits[k] = nil
							panel.payload.data.traits[k] = nil
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

							main.cost = main.cost + v.cost
							main.negtraits = main.negtraits + 1
							if(k == "big_nonenglish") then --remove one if nonenglish is chosen
								main.langtraits = main.langtraits - 1
							end
							lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
							panel.payload.traits[k] = true
							panel.payload.data.traits[k] = true
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
							panel.payload.traits = panel.payload.traits or {}
							panel.payload.data = panel.payload.data or {}
							panel.payload.data.traits = panel.payload.data.traits or {}
							if(buttons[k.."_"..i].picked) then
								if(main.cost-v.cost[i] > nut.config.get("traitPoints")) then
									return
								end
								--not adding the negative trait stuff here becuz there will never be a level negative trait

								main.cost = main.cost - v.cost[i]
								lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
								panel.payload.traits[k] = nil
								panel.payload.data.traits[k] = nil
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

								main.cost = main.cost + v.cost[i]
								lab:SetText("You have "..nut.config.get("traitPoints")-main.cost.." trait points, "..nut.config.get("negTraits")-main.negtraits.." negative trait choices, and "..nut.config.get("langTraits")-main.langtraits.." language trait choices remaining")
								panel.payload.traits[k] = i
								panel.payload.data.traits[k] = i
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

		poscat:InvalidateLayout(true)
		negcat:InvalidateLayout(true)

	end,
	onValidate = function(value, data)
		--it verifies when selecting traits so theoretically it should never go under
	end,
	onAdjust = function(client, data, value, newData)
		newData.traits = nil
		newData.data = newData.data or {}
		--local temp = table.Copy(defaultTraits)
		--table.Merge(temp, value)
		newData.trait = value
	end
})

if(CLIENT) then
	function PLUGIN:ConfigureCharacterCreationSteps(panel)
		panel:addStep(vgui.Create("nutTraitStuff"), 99)
	end

	--hopefully thisll work?
concommand.Add("nut_displaytraits", function()
	if(LocalPlayer() and LocalPlayer().getChar and LocalPlayer():getChar()) then
		DisplayTraitsMenu(LocalPlayer():getChar())
	end
end, nil, "displays the in-game traits panel, requires you to be on a char to use")

local transtype = {
	["pos"] = "Positive",
	["neg"] = "Negative",
}

function DisplayTraitsMenu(char)
	local base = vgui.Create("DFrame")
	base:SetSize(ScrW()/3, ScrH()/2)
	base:SetTitle("Traits for "..char:getName())
	base:SetDraggable(true)
	base:MakePopup()
	base:Center()

	local trsc = base:Add("DScrollPanel")
	trsc:SetSize(base:GetWide(), base:GetTall())
	trsc:Dock(FILL)
	trsc:InvalidateLayout(true)

	local trlist = trsc:GetCanvas():Add("DListView")
	trlist:SetSize(base:GetWide(), base:GetTall())
	trlist:Dock(FILL)
	trlist:SetSortable(true) --not sure if this is on already
	trlist:AddColumn("Name")
	trlist:AddColumn("Category")
	trlist:AddColumn("Description")
	trlist:AddColumn("Type")
	trlist:AddColumn("XP")

	local traits = char:getTrait()--Data("traits", {})
	local xp = char:getData("xp", {})

	for k,v in pairs(nut.traits.list) do
		if(traits[k]) then
			--create it
			local xpt = "N/A"
			if(v.xp and v.xp[traits[k]]) then
				xpt = tostring(xp[k] or 0).."/"..v.xp[traits[k]]
			end
			local button
			local pts
			if(char:getData("traitlevelups",{})[k]) then
				button = vgui.Create("DButton")
				pts = char:getData("traitlevelups", {})[k]
			end

			local li = trlist:AddLine(v.getName and v.getName(char) or v.name, v.category, v.desc, transtype[v.type] or "Special", button or xpt)
			li:SetTooltip(v.desc)
			if(button) then
				button:Dock(RIGHT)
				button:SetWide(data:ColumnWidth(5))
				button:SetText("Pick ("..pts.." pts) - XP:"..xpt)
				button.DoClick = function()
					local res = PLUGIN:GetSkillChoiceForSkill(k)
					if(res) then
						local function dermaadd(text)
							if(!text) then return end
							netstream.Start("LevelupSkill", k, text)
							base:Remove()
						end
						Derma_Query("Get a new skill with points attained from leveling up this skill.",
							"Gain New Skill ("..pts.." points available)",
							res[1] and res[1].name, dermaadd(res[1] and res[1].id),
							res[2] and res[2].name, dermaadd(res[2] and res[2].id),
							res[3] and res[3].name, dermaadd(res[3] and res[3].id),
							res[4] and res[4].name, dermaadd(res[4] and res[4].id)
							)
					else
						nut.util.notify("uh this button actually shouldnt be here? no picks available for this trait id")
					end
				end
			end
		end
	end

	trlist:InvalidateLayout(true)
end


hook.Add("CreateCharInfoText", "traits", function(main)
	--info panel is main.info
	--create button here, button should run nut_displaytraits on pressed
	--see where this hook is run for where to dock, etc
	main.traitButton = main.info:Add("DButton")
	main.traitButton:SetText("Traits")
	main.traitButton:Dock(TOP)
	main.traitButton:SetTall(30)
	main.traitButton:SetFont("nutMediumFont")
	main.traitButton:SetTextColor(color_white)
	main.traitButton:SetExpensiveShadow(1, Color(0, 0, 0, 150))
	main.traitButton:DockMargin(0, 10, 0, 0)
	main.traitButton.DoClick = function(self)
		RunConsoleCommand("nut_displaytraits")
	end
end)
end