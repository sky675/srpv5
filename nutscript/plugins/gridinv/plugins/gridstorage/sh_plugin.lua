PLUGIN.name = "Grid Storage"
PLUGIN.author = "Cheesenut"
PLUGIN.desc = "Storage of items inside a grid."

local INV_TYPE_ID = "grid"

STORAGE_DEFINITIONS = STORAGE_DEFINITIONS or {}
STORAGE_DEFINITIONS["models/props_junk/wood_crate001a.mdl"] = {
	name = "Wood Crate",
	desc = "A crate made out of wood.",
	invType = INV_TYPE_ID,
	invData = {
		w = 4,
		h = 4
	}
}
STORAGE_DEFINITIONS["models/props_c17/lockers001a.mdl"] = {
	name = "Locker",
	desc = "A white locker.",
	invType = INV_TYPE_ID,
	invData = {
		w = 4,
		h = 6
	}
}
STORAGE_DEFINITIONS["models/props_wasteland/controlroom_storagecloset001a.mdl"] = {
	name = "Metal Closet",
	desc = "A green storage closet.",
	invType = INV_TYPE_ID,
	invData = {
		w = 5,
		h = 7
	}
}
STORAGE_DEFINITIONS["models/props_wasteland/controlroom_filecabinet002a.mdl"] = {
	name = "File Cabinet",
	desc = "A metal file cabinet.",
	invType = INV_TYPE_ID,
	invData = {
		w = 3,
		h = 6
	}
}
STORAGE_DEFINITIONS["models/props_c17/furniturefridge001a.mdl"] = {
	name = "Refrigerator",
	desc = "A metal box to keep food in",
	invType = INV_TYPE_ID,
	invData = {
		w = 3,
		h = 4
	}
}
STORAGE_DEFINITIONS["models/props_wasteland/kitchen_fridge001a.mdl"] = {
	name = "Large Refrigerator",
	desc = "A large metal box to keep even more food in.",
	invType = INV_TYPE_ID,
	invData = {
		w = 4,
		h = 5
	}
}
STORAGE_DEFINITIONS["models/props_junk/trashbin01a.mdl"] = {
	name = "Trash Bin",
	desc = "A container for junk.",
	invType = INV_TYPE_ID,
	invData = {
		w = 1,
		h = 3
	}
}
STORAGE_DEFINITIONS["models/items/ammocrate_smg1.mdl"] = {
	name = "Ammo Crate",
	desc = "A heavy crate for storing ammunition.",
	invType = INV_TYPE_ID,
	invData = {
		w = 5,
		h = 3
	},
	onOpen = function(entity, activator)
		entity:ResetSequence("Close")

		timer.Create("CloseLid"..entity:EntIndex(), 2, 1, function()
			if (IsValid(entity)) then
				entity:ResetSequence("Open")
			end
		end)
	end
}
STORAGE_DEFINITIONS["models/props_c17/furniturecupboard001a.mdl"] = {
	name = "Cupboard",
	desc = "A wooden cupboard.",
	invType = INV_TYPE_ID,
	invData = {
		w = 3,
		h = 2
	}
}
STORAGE_DEFINITIONS["models/props_c17/furnituredrawer001a.mdl"] = {
	name = "Drawer",
	desc = "A wooden drawer.",
	invType = INV_TYPE_ID,
	invData = {
		w = 3,
		h = 3
	}
}
STORAGE_DEFINITIONS["models/props_c17/furnituredresser001a.mdl"] = {
	name = "Dresser",
	desc = "A wooden wardrobe.",
	invType = INV_TYPE_ID,
	invData = {
		w = 5,
		h = 7
	}
}
STORAGE_DEFINITIONS["models/props_wasteland/controlroom_filecabinet001a.mdl"] = {
	name = "Small File Cabinet",
	desc = "A small metal file cabinet.",
	invType = INV_TYPE_ID,
	invData = {
		w = 2,
		h = 3
	}
}
STORAGE_DEFINITIONS["models/props_c17/suitCase_passenger_physics.mdl"] = {
	name = "Suitcase",
	desc = "A suitcase.",
	invType = INV_TYPE_ID,
	invData = {
		w = 3,
		h = 2
	}
}
STORAGE_DEFINITIONS["models/items/item_item_crate.mdl"] = {
	name = "Supply Crate",
	desc = "A wooden item crate.",
	invType = INV_TYPE_ID,
	invData = {
		w = 2,
		h = 2
	}
}
STORAGE_DEFINITIONS["models/props/cs_militia/footlocker01_closed.mdl"] = {
	name = "Footlocker",
	desc = "A green metal footlocker.",
	invType = INV_TYPE_ID,
	invData = {
		w = 4,
		h = 4
	}
}
STORAGE_DEFINITIONS["models/props/de_prodigy/ammo_can_02.mdl"] = {
	name = "Weapon Crate",
	desc = "A green metal weapon box.",
	invType = INV_TYPE_ID,
	invData = {
		w = 5,
		h = 2
	}
}


if (CLIENT) then


	function PLUGIN:StorageOpen(storage)
		
		self = vgui.Create( "EditablePanel" )
		self:SetSize(ScrW(), ScrH())
		self.noAnchor = CurTime() + .4
		self.anchorMode = true
		self:SetPopupStayAtBack(true)
		self:MakePopup()

		local storageInv = storage:getInv()
		if (not storageInv) then
			return nutStorageBase:exitStorage()
		end
		self.storageInventoryPanel = storageInv:show()
		--self.storageInventoryPanel:SetPos(invPosX-(self.storageInventoryPanel:GetWide())-70, ScrH()*0.5-(self.storageInventoryPanel:GetTall()*0.5))
		--self.storageInventoryPanel:SetPos(0,0)
		self.storageInventoryPanel.Paint = function() end
		self.storageInventoryPanel:SetPopupStayAtBack(true)

		
		self.info = vgui.Create("nutCharInfo", self)
		self.info:setup(self, true)
		self.info.quickInventoryPanel:RequestFocus()

		-- Number of pixels between the local inventory and storage inventory.
		local PADDING = 40

		if (
			not IsValid(storage) or
			storage:getStorageInfo().invType ~= INV_TYPE_ID
		) then
			return
		end

		sw = storage:getStorageInfo().invData.w
		sh = storage:getStorageInfo().invData.h


		local totalsW = (80*(invw/invTextureW) + ((52*(invw/invTextureW))*(sw-2)) + (85*(invw/invTextureW)))
		local totalsH = (72*(invw/invTextureW) + ((52*(invw/invTextureW))*(sh-2)) + (92*(invw/invTextureW)))

		local totalInvenW = self.storageInventoryPanel:GetWide()
		local totalInvenH = self.storageInventoryPanel:GetTall()
		local difX = (totalsW - totalInvenW)*0.5
		local difY = (totalsH - totalInvenH)*0.5

		

		self.storageInventoryPanel:SetPos(((ScrW() - invw))-(totalsW), (ScrH()*0.5)-((totalsH*0.5)))
		print("storage pos: " .. self.storageInventoryPanel:GetX() .. ", " .. self.storageInventoryPanel:GetY())

		if (self:IsKeyboardInputEnabled()) then
			--print("Ok you can do funny keyboard")
		end
		
		function self:OnKeyCodePressed(key)
			--print("f1 pressed cool cool")
			-- F1 Close
			local keypress = KEY_F1
			if(input.LookupBinding("gm_showhelp") != "no value") then
				keypress = input.GetKeyCode(input.LookupBinding("gm_showhelp"))
			end
	
			if (key == keypress) then
				--print("ok i close now")
				nutStorageBase:exitStorage()

				self.storageInventoryPanel:Remove()
				self.info:Remove()
				self:Remove()
			end
		end

		function self:Paint(w, h)



			local startX, startY = self.storageInventoryPanel:GetPos()
			startX = startX - difX
			startY = startY - difY

			local curX, curY = 0,0

			local path = "sky/storages/"
			local storText = "error"

			local stw, sth = 0,0
			local row = 0
			local column = 0

			for row=1,sh,row+1 do
				if row == 1 then
					curY = startY
				end
				for column=1,sw,column+1 do
					--Corners
					if column == 1 then
						curX = startX
					end
					if row==1 and column==1 then
						storText = "top_l.png"
						stw, sth = 80, 72
					elseif row==sh and column==1 then
						storText = "bot_l.png"
						stw, sth = 80, 92
					elseif row==1 and column==sw then
						storText = "top_r.png"
						stw, sth = 85, 72
					elseif row==sh and column==sw then
						storText = "bot_r.png"
						stw, sth = 73, 92
					elseif row==1 then
						storText = "top_"..column..".png"
						stw, sth = 52, 72
					elseif row==sh then
						storText = "bot_"..column..".png"
						stw, sth = 52, 92
					elseif column==1 and row==sh-1 then
						storText = "3_l.png"
						stw, sth = 80, 52
					elseif column==sw and row==sh-1 then
						storText = "3_r.png"
						stw, sth = 85, 52
					elseif column==1 then
						storText = "2_l.png"
						stw, sth = 80, 52
					elseif column==sw then
						storText = "2_r.png"
						stw, sth = 85, 52
					else
						storText = "3_"..column..".png"
						stw, sth = 52, 52
					end

					finText = path..storText

					surface.SetDrawColor(255,255,255,255)
					surface.SetMaterial(Material(finText))

					--print("totalsW = " .. totalsW .. " | totalInvenW = " .. totalInvenW)

					scaleW, scaleH = stw*(invw/invTextureW), sth*(invh/invTextureH)

					
					-- if row==sh then
					-- 	surface.DrawTexturedRect(curX+(13*invw/invTextureW), curY, scaleW, scaleH)
					-- else
					-- 	surface.DrawTexturedRect(curX, curY, scaleW, scaleH)
					-- end
					surface.DrawTexturedRect(curX, curY, scaleW, scaleH)
					
					curX = math.floor(curX+scaleW)

					if sw == 1 then
						if row == 1 then
							storText = "top_r_cap.png"
							stw, sth = 30, 72
						elseif row == sh then
							storText = "bot_r_cap.png"
							stw, sth = 18, 92
						elseif row == sh-1 then
							storText = "3_r_cap.png"
							stw, sth = 30, 52
						else
							storText = "2_r_cap.png"
							stw, sth = 30, 52
						end
						finText = path..storText
						surface.SetMaterial(Material(finText))
						scaleW, scaleH = stw*(invw/invTextureW), sth*(invh/invTextureH)
						surface.DrawTexturedRect(curX-1, curY-1, scaleW, scaleH)
					end
					--print("Drawing: " .. finText .. "| curX, curY = " .. curX .. ", " .. curY .. "row = "..row.." column = "..column)
					--print("Total Storage UI Width: " .. totalsW)

					--(invw/invTextureW)
					--(invh/invTextureH)
				end
				curY = math.floor(curY+scaleH)
			end
					

        end



			hook.Run("OnCreateStoragePanel", localInvPanel, storageInv, storage)
			
			--self.OnRemove = exitStorageOnRemove
			--storageInv.OnRemove = exitStorageOnRemove
	end

end
