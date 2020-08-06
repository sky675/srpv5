--unsure how to do this?
local PLUGIN = PLUGIN
local PANEL = {}

function PANEL:Init()
	-- being relative.
	local size = 95
	self:SetSize(size, size*1.15)
end

function PANEL:setItem(itemTable, uniqueID)
	self.name = self:Add("DLabel")
	self.name:Dock(TOP)
	self.name:SetText(itemTable.name)
	self.name:SetContentAlignment(5)
	self.name:SetTextColor(color_white)
	self.name:SetFont("nutSmallFont")
	self.name:SetExpensiveShadow(1, Color(0, 0, 0, 200))
	self.name.Paint = function(this, w, h)
		surface.SetDrawColor(0, 0, 0, 75)
		surface.DrawRect(0, 0, w, h)
	end

	self.icon = self:Add(itemTable.render and "nutItemIcon" or "SpawnIcon")
	self.icon:SetZPos(1)
	self.icon:SetSize(self:GetWide(), self:GetWide())
	self.icon:Dock(FILL)
	self.icon:DockMargin(2, 2, 2, 4)
	self.icon:InvalidateLayout(true)
	self.icon:SetModel(itemTable.model, itemTable.skin or 0)

	if(itemTable.render) then
		self.icon:setItemType(itemTable.render.uniqueID)
		self.icon.PaintBehind = function() end
	end


	--self.icon:SetToolTip(itemTable:getDesc() or "")
	self.icon.itemID = true
	self.icon:SetToolTip(
		Format(nut.config.itemFormat,
		itemTable.name, itemTable.desc or "")
	)
	self.icon.DoClick = function(this)
		net.Start("StartCraft")
		net.WriteString(uniqueID)
		net.WriteEntity(self.ent or NULL) --idk
		net.SendToServer()
	end
end

vgui.Register("nutCraftItem", PANEL, "DPanel")

PANEL = {}

--setup appearance
function PANEL:Init()
	self:SetTitle("Crafting")
	self:SetSize(ScrW() * 0.3, ScrH() * 0.5)
	self:Center()
	self:MakePopup()
	self:SetDraggable(true)

	self.scroll = vgui.Create("DScrollPanel", self)
	self.scroll:SetSize(self:GetWide(), self:GetTall()-6)
	self.scroll:Dock(FILL)
	self.scroll:SetPaintBackground(false)
	
	self.category = vgui.Create("DCategoryList", self.scroll)
	self.category:SetSize(self:GetWide(), self:GetTall()-22)
	self.category:Dock(FILL)
	self.category:SetPaintBackgroundEnabled(false)
	self.category:SetPaintBackground(false)
	self.category:SetBGColor(Color(0,0,0,0))
	self.category:InvalidateLayout()

	self.cats = {}
end

function PANEL:addCat(name)
	local main = self.category:Add(name)
	main:Dock(FILL)
	main:SetPaintBackgroundEnabled(false)
	main:SetPaintBackground(false)
	main:SetBGColor(Color(0,0,0,0))
	
	local list = vgui.Create("DIconLayout", main)
	main:SetContents(list)
	main:Dock(TOP)
	self.cats[name] = list

	list:Dock(FILL)
	list:SetSpaceY(5)
	list:SetSpaceX(5)

	self.category:InvalidateLayout(true)
end


--fill the menu up with what player can see, 
--use PLUGIN:getByVisible for table when calling this, bench should be id of workbench
function PANEL:fill(tbl, bench)
	self:SetTitle("Crafting: "..bench or "???")
	for k,v in pairs(tbl) do
		if(!self.cats[v.category or "Default"]) then
			self:addCat(v.category or "Default")
		end
		local val = self.cats[v.category or "Default"]:Add("nutCraftItem")
		
		val:setItem(v, k)
		val.ent = self.ent
	end
end

vgui.Register("nutCrafting", PANEL, "DFrame")