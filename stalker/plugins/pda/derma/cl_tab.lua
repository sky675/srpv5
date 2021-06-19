-- This file contains the panel that you should inherit from if you are adding
-- a new tab for the PDA.

local PANEL = {}

PANEL.isTab = true

PANEL.tabLabel = "No Label Set"

function PANEL:Init()
	self:Dock(FILL)
	self:SetDrawBackground(false)
	self:SetVisible(false)
end


-- Returns the label of the tab
function PANEL:GetTabLabel()
    return PANEL.tabLabel
end

-- Called when this tab is made visible.
function PANEL:onDisplay()
end

-- Return true if this tab should be shown, false otherwise.
function PANEL:shouldShow()
	return true
end


function PANEL:onHide()
end

vgui.Register("stalkerPdaTab", PANEL, "DScrollPanel")
