netstream.Hook("recieveItemValidation", function(itemTable, validation, msg)
    if !validation then
        nut.util.notify(msg)
    else
        nut.util.notify("Creating object")
        netstream.Start("addcustomitem", itemTable)
    end
end)

local PANEL = {}

function PANEL:Init()
    local self = vgui.Create("DFrame")
    self:SetSize(420,150)
    self:SetTitle("Create Custom Item")
    self:Center()
    self:MakePopup(true)
    self:DockPadding(10, 30, 10, 10)

    self.model = self:Add("DTextEntry")
    self.model:Dock(TOP)
    self.model:DockMargin(0, 0, 0, 10)
    self.model:SetPlaceholderText("path/to/model.mdl")

    self.name = self:Add("DTextEntry")
    self.name:Dock(TOP)
    self.name:DockMargin(0, 0, 0, 10)
    self.name:SetPlaceholderText("Item Name")

    self.desc = self:Add("DTextEntry")
    self.desc:Dock(TOP)
    self.desc:DockMargin(0, 0, 0, 10)
    self.desc:SetPlaceholderText("Item Description")

    self.submit = self:Add("DButton")
    self.submit:SetText("Create")
    self.submit:Dock(TOP)

    self.submit.DoClick = function(panel)
        local itemTable = {
            name = self.name:GetValue(),
            desc = self.desc:GetValue(),
            model = self.model:GetValue()
        }
        PrintTable(itemTable)
        netstream.Start("validatecustomitem", itemTable)
    end

end

vgui.Register("CreateItemMenu", PANEL, "DPanel")