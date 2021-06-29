local PANEL = {}

local HIGHLIGHT = Color(255, 255, 255, 50)
local flavoritem = {
    ["creating"] = false,
    ["name"] = "",
    ["model"] = "",
    ["desc"] = ""
}


function PANEL:Init()
    self:addLabel("create a flavor item")

    self.createItem = self:Add("DButton")
    self.createItem:Dock(TOP)
    self.createItem:DockMargin(0, 4, 0, 16)
    self.createItem:SetText("+ Create Custom Item")
    self.createItem:SetFont("nutCharButtonFont")
    self.createItem:SetTextColor(color_white)
    self.createItem:SetTall(48)
    self.createItem.Paint = self.paintFlavorButton
    self.createItem.DoClick = function()
        flavoritem["creating"] = !flavoritem["creating"]
        nut.gui.character:clickSound()
        if (flavoritem["creating"]) then
            self.createItem:SetText("- Cancel Custom Item")
        else
            self.createItem:SetText("+ Create Custom Item")
            flavoritem["name"] = ""
            flavoritem["desc"] = ""
            flavoritem["model"] = ""
            self.itemname:SetText("")
            self.itemdesc:SetText("")
            self:setContext("flavoritem", flavoritem)
        end

        self.itemModels:SetVisible(flavoritem["creating"])

        self.itemname:SetVisible(flavoritem["creating"])
        self.itemnameLabel:SetVisible(flavoritem["creating"])
        self.itemnameSubLabel:SetVisible(flavoritem["creating"])

        self.itemdesc:SetVisible(flavoritem["creating"])
        self.itemdescLabel:SetVisible(flavoritem["creating"])
        self.itemdescSubLabel:SetVisible(flavoritem["creating"])


    end

    self.createItem.OnCursorEntered = function()
        self.createItem:SetAlpha(150)
    end

    self.createItem.OnCursorExited = function()
        self.createItem:SetAlpha(255)
    end

    self.itemModels = self:Add("DIconLayout")
    self.itemModels:Dock(TOP)
    self.itemModels:SetSpaceX(4)
	self.itemModels:SetSpaceY(4)
	self.itemModels:SetDrawBackground(false)
	self.itemModels:SetStretchWidth(true)
	self.itemModels:SetStretchHeight(true)
	self.itemModels:StretchToParent(0, 0, 0, 0)


    --item name
	self.itemnameLabel = self:addLabel("item name")
	self.itemnameLabel:SetZPos(0)
    self.itemnameSubLabel = self:addSubLabel("a short, appropriate physical description")
	self.itemnameSubLabel:SetZPos(1)

	self.itemname = self:addFlavorTextEntry("name")
	self.itemname:SetTall(48)
	self.itemname.onTabPressed = function()
		self.itemdesc:RequestFocus()
	end
	self.itemname:SetZPos(2)


    --item description
	self.itemdescLabel = self:addLabel("item description")
	self.itemdescLabel:SetZPos(3)
    self.itemdescSubLabel = self:addSubLabel("A physical description only, containing no meta knowledge")
	self.itemdescSubLabel:SetZPos(4)

	self.itemdesc = self:addFlavorTextEntry("desc")
	self.itemdesc:SetTall(self.itemname:GetTall() * 3)
	self.itemdesc.onTabPressed = function()
		self.itemname:RequestFocus()
	end
	self.itemdesc:SetMultiline(true)
	self.itemdesc:SetZPos(5)

    self.itemModels:SetVisible(false)


    self.itemname:SetVisible(false)
    self.itemnameLabel:SetVisible(false)
    self.itemnameSubLabel:SetVisible(false)

    self.itemdesc:SetVisible(false)
    self.itemdescLabel:SetVisible(false)
    self.itemdescSubLabel:SetVisible(false)


end

function PANEL:addFlavorTextEntry(contextName)
	local entry = self:Add("DTextEntry")
	entry:Dock(TOP)
	entry:SetFont("nutCharButtonFont")
	entry.Paint = self.paintFlavorTextEntry
	entry:DockMargin(0, 4, 0, 16)
	entry.OnValueChange = function(_, value)
		flavoritem[contextName] = string.Trim(value)
	end
	entry.contextName = contextName
	entry.OnKeyCodeTyped = function(name, keyCode)
		if (keyCode == KEY_TAB) then
			entry:onTabPressed()
			return true
		end
	end
	entry:SetUpdateOnType(true)
	return entry
end


function PANEL:onDisplay()
    flavoritem["creating"] = false
    self.itemname:SetText("")

    self.itemdesc:SetText("")

    -- Requesting focus same frame causes issues with docking.
    self.itemname:RequestFocus()


    local oldChildren = self.itemModels:GetChildren()
	self.itemModels:InvalidateLayout(true)

	local faction = nut.faction.indices[self:getContext("faction")]
	if (not faction) then return end

	local function paintIcon(icon, w, h)
		self:paintIcon(icon, w, h)
	end

    local x = 1
	for k, v in pairs(FLAVOR_MODELS) do
		local icon = self.itemModels:Add("SpawnIcon")
		icon:SetTooltip(v.name)
		icon:SetSize(64, 64)
		icon:InvalidateLayout(true)
		icon.DoClick = function(icon)
			self:onModelSelected(icon)
		end
		icon.PaintOver = paintIcon
        icon:SetModel(k)
        icon.model = k

		icon.index = x
        x = x + 1
	end
    x = 0

	self.itemModels:Layout()
	self.itemModels:InvalidateLayout()
	for _, child in pairs(oldChildren) do
		child:Remove()
	end
end

function PANEL:paintIcon(icon, w, h)
	if (flavoritem["model"] ~= icon.model) then return end
	local color = nut.config.get("color", color_white)

	surface.SetDrawColor(color.r, color.g, color.b, 200)

	local i2
	for i = 1, 3 do
		i2 = i * 2
		surface.DrawOutlinedRect(i, i, w - i2, h - i2)
	end
end

-- self refers to the text entry
function PANEL:paintFlavorTextEntry(w, h)
	nut.util.drawBlur(self)
	surface.SetDrawColor(0, 0, 0, 100)
	surface.DrawRect(0, 0, w, h)
	self:DrawTextEntryText(color_white, HIGHLIGHT, HIGHLIGHT)
end

function PANEL:paintFlavorButton(w, h)
	nut.util.drawBlur(self)
	surface.SetDrawColor(0, 0, 0, 100)
	surface.DrawRect(0, 0, w, h)
    --draw.DrawText(self:GetText(), "nutCharButtonFont", self:GetWide() * 0.5, self:GetTall() * 0.5, color_white, TEXT_ALIGN_CENTER)
end


function PANEL:onModelSelected(icon, noSound)
	flavoritem["model"] = icon.model or 1
	if (not noSound) then
		nut.gui.character:clickSound()
	end
	--[[if(nut.gui.charCreate.reloadSkins) then
		nut.gui.charCreate.reloadSkins()
	end]]
end


-- Returns whether or not the input for this form is valid. You should override
-- this if you need custom validation.

function PANEL:validate()
    self:setContext("flavoritem", flavoritem)
    if (flavoritem["creating"] and (flavoritem["name"] == nil or string.len(flavoritem["name"]) < 5)) then
        return false, "The item name must be longer than 5 characters."
    elseif (flavoritem["creating"] and (flavoritem["desc"] == nil or string.len(flavoritem["desc"]) < 15)) then
        return false, "The item description must be longer than 15 characters."
    elseif (flavoritem["creating"] and (flavoritem["model"] == "" or flavoritem["model"] == nil)) then
        return false, "You must pick a model for your custom item."
    else
	    return true
    end
end


function PANEL:shouldSkip()
	local factionFlavor = nut.faction.indices[self:getContext("faction")].noflavoritem
	if factionFlavor then
		flavoritem.creating = false
		self:setContext("flavoritem", flavoritem)
		return true 
	else
		return false
	end
end

-- Called if this step has been skipped over.
function PANEL:onSkip()
end


function PANEL:onHide()
end

vgui.Register("nutCharacterFlavorItem", PANEL, "nutCharacterCreateStep")
