local PANEL = {}
	function PANEL:Init()
		self:SetSize(460, 594)
		self:SetTitle("")--L"shipment")
		self:Center()
		self:MakePopup()

		self.img = self:Add("DImage")
		self.img:Dock(TOP)
		self.img:DockMargin(0, 8, 0, 0)
		self.img:SetKeepAspect(true)
		self.img:SetHeight(234)

		self.scroll = self:Add("DScrollPanel")
		self.scroll:Dock(FILL)

		self.list = self.scroll:Add("DListLayout")
		self.list:Dock(FILL)
	end

	function PANEL:setItems(entity, items)
		self.entity = entity
		self.items = true
		self.itemPanels = {}

		for k, v in SortedPairs(items) do
			local itemTable = nut.item.list[k]

			if (itemTable) then
				local item = self.list:Add("DPanel")
				item:SetTall(36)
				item:Dock(TOP)
				item:DockMargin(4, 4, 4, 0)

				item.icon = item:Add("nutItemIcon")
				item.icon:SetPos(2, 2)
				item.icon:SetSize(32, 32)
				item.icon:setItemType(itemTable.uniqueID)

				item.quantity = item.icon:Add("DLabel")
				item.quantity:SetSize(32, 32)
				item.quantity:SetContentAlignment(3)
				item.quantity:SetTextInset(0, 0)
				item.quantity:SetText(v)
				item.quantity:SetFont("DermaDefaultBold")
				item.quantity:SetExpensiveShadow(1, Color(0, 0, 0, 150))

				item.name = item:Add("DLabel")
				item.name:SetPos(38, 0)
				item.name:SetSize(200, 36)
				item.name:SetFont("nutSmallFont")
				item.name:SetText(L(itemTable.name))
				item.name:SetContentAlignment(4)
				item.name:SetTextColor(color_white)

				item.take = item:Add("DButton")
				item.take:Dock(RIGHT)
				item.take:SetText(L"take")
				item.take:SetWide(64)
				item.take:DockMargin(3, 3, 0, 3)
				item.take.DoClick = function(this)
					netstream.Start("crpUse", k)
				end

				--[[item.drop = item:Add("DButton")
				item.drop:Dock(RIGHT)
				item.drop:SetText(L"drop")
				item.drop:SetWide(48)
				item.drop:DockMargin(3, 3, 0, 3)
				item.drop.DoClick = function(this)
					netstream.Start("shpUse", k, 1)

				end]]

				function item:update()
					items[k] = items[k] - 1
					item.quantity:SetText(items[k])

					if (items[k] <= 0) then
						item:Remove()
						items[k] = nil
					end

					if (table.Count(items) == 0) then
						self:Remove()
					end
				end

				self.itemPanels[k] = item
			end
		end
	end

	function PANEL:Think()
		if (self.items and !IsValid(self.entity)) then
			self:Remove()
		end
	end
	function PANEL:OnRemove()
		if(self.npcClass) then
			netstream.Start("stopcorpseloot", self.entity)
		end
	end
vgui.Register("nutCorpseLoot", PANEL, "DFrame")
