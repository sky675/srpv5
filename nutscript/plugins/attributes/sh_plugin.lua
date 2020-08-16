PLUGIN.name = "Attributes"
PLUGIN.author = "Cheesenut"
PLUGIN.desc = "Adds attributes for characters."

nut.util.include("sh_commands.lua")

nut.config.add(
	"maxAttribs",
	30,
	"The total maximum amount of attribute points allowed.",
	nil,
	{
		data = {min = 1, max = 250},
		category = "characters"
	}
)



nut.char.registerVar("attribs", {
	field = "_attribs",
	default = {},
	isLocal = true,
	index = 4,
	onValidate = function(value, data, client)
		if (value != nil) then
			if (type(value) == "table") then
				local count = 0

				for k, v in pairs(value) do
					count = count + v
				end

				local points = hook.Run("GetStartAttribPoints", client, count)
					or nut.config.get("maxAttribs", 30)
				if (count > points) then
					return false, "unknownError"
				end
			else
				return false, "unknownError"
			end
		end
	end,
	shouldDisplay = function(panel) return table.Count(nut.attribs.list) > 0 end
})



if (SERVER) then
	function PLUGIN:PostPlayerLoadout(client)
		nut.attribs.setup(client)
	end

	function PLUGIN:OnCharAttribBoosted(client, character, attribID)
		local attribute = nut.attribs.list[attribID]
		if (attribute and isfunction(attribute.onSetup)) then
			attribute:onSetup(client, character:getAttrib(attribID, 0))
		end
	end
else --client

	function PLUGIN:CreateCharInfoText(panel, suppress)
		if (suppress and suppress.attrib) then return end
		--panel.attribName = panel.info:Add("DLabel")
		--panel.attribName:Dock(TOP)
		--panel.attribName:SetFont("nutMediumFont")
		--panel.attribName:SetTextColor(color_white)
		--panel.attribName:SetExpensiveShadow(1, Color(0, 0, 0, 150))
		--panel.attribName:DockMargin(0, 10, 0, 0)
		--panel.attribName:SetText(L"attribs")
		panel.attribs = panel:Add("DScrollPanel")

		--panel.attribs:Dock(FILL)
		--panel.attribs:DockMargin(0, 10, 0, 0)

		-- panel.attribs:SetPos(invPosX+(15*(invw/invTextureW)), (invPosY+(600*((invh/invTextureH)))))	
		-- atribPosX, atribPosY = panel.attribs:GetPos()
		-- print("Attributes pos: " .. " x:" .. atribPosX .. " y:" .. atribPosY)
		-- atribSizeX, atribSizeY = invPosX+(15*(invw/invTextureW)), (invPosY+(600*((invh/invTextureH))))
		-- print("Attributes desired size: " .. " x:" .. atribSizeX .. " y:" .. atribSizeY)
		-- print("Attributes actual size: " .. " x:" .. panel.attribs:GetWide() .. " y:" .. panel.attribs:GetTall())
	end

	function PLUGIN:OnCharInfoSetup(panel)
		if (not IsValid(panel.attribs)) then return end
		local char = LocalPlayer():getChar()
		local boost = char:getBoosts()
		local barNum = 1
		local yOffset = 0
		for k, v in SortedPairsByMemberValue(nut.attribs.list, "name") do
			
			local attribBoost = 0
			if (boost[k]) then
				for _, bValue in pairs(boost[k]) do
					attribBoost = attribBoost + bValue
				end
			end

			
			local bar = panel:Add("nutAttribBar")
			bar:SetWide(314*(invw/invTextureW))
			bar:SetTall(20*(invh/invTextureW))
			bar:SetPos(invPosX+(15*(invw/invTextureW)), (invPosY+(610+yOffset)*((invh/invTextureH))))--)) --(600+(30*barNum
			yOffset = yOffset + 30
			atribPosX, atribPosY = bar:GetPos()
			--print("Pos for Bar #" .. barNum .. ": x=" .. atribPosX .. ", y=" .. atribPosY)
			barNum = barNum + 1 --ok cool... just learned lua doesnt have unary increment operators :)
			

			local atribWide = bar:GetWide()
			--print("Attributes desired wide: " .. " x:" .. (200*(invw/invTextureW)))
			--print("Attributes actual wide: " .. " x:" .. atribWide)

			--bar:Dock(TOP)
			--bar:DockMargin(0, 0, 0, 3)

			local attribValue = char:getAttrib(k, 0)
			if (attribBoost) then
				bar:setValue(attribValue - attribBoost or 0)
			else
				bar:setValue(attribValue)
			end

			local maximum = v.maxValue or nut.config.get("maxAttribs", 30)
			bar:setMax(maximum)
			bar:setReadOnly()
			bar:setText(
				Format(
					"%s [%.1f/%.1f] (%.1f",
					L(v.name),
					attribValue,
					maximum,
					attribValue/maximum*100
				)
				.."%)"
			)

			if (attribBoost) then
				bar:setBoost(attribBoost)
			end
		end

		
	end

	function PLUGIN:ConfigureCharacterCreationSteps(panel)
		panel:addStep(vgui.Create("nutCharacterAttribs"), 99)
	end
end
