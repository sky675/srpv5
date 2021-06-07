--unsure how to do this?
local PLUGIN = PLUGIN
local PANEL = {}

function PANEL:Init()
	-- being relative.
	local size = 95
	self:SetSize(size, size*1.15)
end

local function getRepDesc(tbl)
	local str = (tbl.desc or "").."\n"

	if(tbl.traits) then
		local traits = {}
		for k,v in pairs(tbl.traits) do
			local trbl = nut.traits.list[k]
			if(v == true) then
				traits[#traits+1] = trbl.name
			else
				traits[#traits+1] = trbl.name.." Level "..tostring(v)
			end
		end
		str = str.."\nTrait Requirements: "..table.concat(traits, ", ")
	end

	if(tbl.requirements) then
		local traits = {}
		for k,v in pairs(tbl.requirements) do
			local trbl = nut.item.get(k)
			if(v == true) then
				traits[#traits+1] = trbl.name
			else
				traits[#traits+1] = tostring(v).."x "..trbl.name
			end
		end
		str = str.."\nItem Requirements: "..table.concat(traits, ", ")
	end

	if(tbl.ingredients) then
		local traits = {}
		if(tbl.customIng) then
			traits[1] = tbl.customIng
		end
		for k,v in pairs(tbl.ingredients) do
			local trbl = nut.item.get(k)
			if(v == true) then
				traits[#traits+1] = (trbl and trbl.name or k.."(invalid item)")
			else
				traits[#traits+1] = tostring(v).."x "..(trbl and trbl.name or k.."(invalid item)")
			end
		end
		str = str.."\nIngredients: "..table.concat(traits, ", ")
	elseif(tbl.customIng) then
		str = str.."\nIngredients: "..tbl.customIng
	end

	if(tbl.result) then
		local traits = {}
		if(tbl.customRes) then
			traits[1] = tbl.customRes
		end
		if(isstring(tbl.result)) then
			local trbl = nut.item.get(tbl.result)
			traits[#traits+1] = (trbl and trbl.name or tbl.result.."(invalid item)")
		else
			for k,v in pairs(tbl.result) do
				local trbl = nut.item.get(k)
				if(v == true) then
					traits[#traits+1] = (trbl and trbl.name or k.."(invalid item)")
				else
					traits[#traits+1] = tostring(v).."x "..(trbl and trbl.name or k.."(invalid item)")
				end
			end
		end
		str = str.."\nResult: "..table.concat(traits, ", ")
	elseif(tbl.customRes) then
		str = str.."\nResult: "..tbl.customRes
	end

	return str
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
		if(itemTable.render.icon) then
			self.icon:forceIcon(Material(itemTable.render.icon))
		else
			self.icon:setItemType(itemTable.render.uniqueID)
			self.icon.PaintBehind = function() end
		end
	end


	--self.icon:SetToolTip(itemTable:getDesc() or "")
	self.icon.itemID = true
	self.icon:SetToolTip(
		Format(nut.config.itemFormat,
		itemTable.name, getRepDesc(itemTable) or "")
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

	--self.scroll = vgui.Create("DScrollPanel", self)
	--self.scroll:SetSize(self:GetWide(), self:GetTall()-6)
	--self.scroll:Dock(FILL)
	--self.scroll:SetPaintBackground(false)
	
	self.category = vgui.Create("DCategoryList", self)--.scroll)
	self.category:SetSize(self:GetWide(), self:GetTall()-6)--22)
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
	main:DockPadding(10, 0, 10, 10)

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