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


-- hook.Add("CreateCharInfoText", "traits", function(main)
-- 	--info panel is main.info
-- 	--create button here, button should run nut_displaytraits on pressed
-- 	--see where this hook is run for where to dock, etc
-- 	main.traitButton = main.info:Add("DButton")
-- 	main.traitButton:SetText("Traits")
-- 	main.traitButton:Dock(TOP)
-- 	main.traitButton:SetTall(30)
-- 	main.traitButton:SetFont("nutMediumFont")
-- 	main.traitButton:SetTextColor(color_white)
-- 	main.traitButton:SetExpensiveShadow(1, Color(0, 0, 0, 150))
-- 	main.traitButton:DockMargin(0, 10, 0, 0)
-- 	main.traitButton.DoClick = function(self)
-- 		RunConsoleCommand("nut_displaytraits")
-- 	end
-- end)
end