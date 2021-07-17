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
STORAGE_DEFINITIONS["models/props/CS_militia/footlocker01_closed.mdl"] = {
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
STORAGE_DEFINITIONS["models/props_borealis/bluebarrel001.mdl"] = {
	name = "Barrel Cache",
	desc = "A blue barrel.",
	invType = INV_TYPE_ID,
	invData = {
		w = 3,
		h = 4
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
		
		--self.storageInventoryPanel:SetPaintBackground(true)

		--self.storageInventoryPanel.Paint = function() end
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
		
		local NSuiHeight = (math.ceil(((300*(invw/invTextureW))/7)) + (7*(invw/invTextureW))) * sh

		

		if sh < 7 then
			sh = sh+1
		end

		local SRuiHeight = ((52*(invh/invTextureH))*sh)
		local uiMidOffset = math.floor((SRuiHeight - NSuiHeight)*0.5)

		--print("NSuiHeight: " .. NSuiHeight) 
		--print("SRuiHeight: " .. SRuiHeight) 
		--print("uiMidOffset: " .. uiMidOffset) 


		local totalsW = (80*(invw/invTextureW) + ((52*(invw/invTextureW))*(sw-2)) + (85*(invw/invTextureW)))
		local totalsH = ((52*(invw/invTextureW))*(sh))

		local totalInvenW = self.storageInventoryPanel:GetWide()
		local totalInvenH = self.storageInventoryPanel:GetTall()
		local difX = (totalsW - totalInvenW)*0.5
		local difY = (totalsH - totalInvenH)*0.5

		

		self.storageInventoryPanel:SetPos(((ScrW() - invw))-(totalsW), (ScrH()*0.5)-((totalsH*0.5)))
		--print("storage pos: " .. self.storageInventoryPanel:GetX() .. ", " .. self.storageInventoryPanel:GetY())

		if (self:IsKeyboardInputEnabled()) then
			--print("Ok you can do funny keyboard")
		end
		
		function self:OnKeyCodePressed(key)
			--print("f1 pressed cool cool")
			-- F1 Close
			local keypress = KEY_F1
			local bind = input.LookupBinding("gm_showhelp")
			if(bind != nil and bind != "no value") then
				keypress = input.GetKeyCode(bind)
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

			local iw, ih = 611, 382
			local w, h = self.storageInventoryPanel:GetWide(), self.storageInventoryPanel:GetTall()
			local sx, sy = self.storageInventoryPanel:GetX(), self.storageInventoryPanel:GetY()
			local iratio = w/iw
			local titlePos = 38 * iratio
			sx = sx - 2
			--nut.util.drawBlur(panel, 10)
	
			--surface.SetDrawColor(45, 45, 45, 200)
			--surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())
	
			--surface.SetDrawColor(nut.config.get("color"))
			--surface.DrawRect(0, 0, panel:GetWide(), 24)
			surface.SetDrawColor(255,255,255,255)
			local old = DisableClipping( true )
			surface.SetMaterial(Material('sky/panel_bg.png'))
			surface.DrawTexturedRect(sx + 0, -5 + sy, w, h+5)
			
			--surface.SetDrawColor(Color(107, 85, 66))
			--surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall(), 2)
			--top/bottom
			surface.SetMaterial(Material('sky/tp/tops.png'))
			surface.DrawTexturedRect(sx + 0, -5 + sy, w, 4)
			surface.DrawTexturedRectRotated(w*0.5 + sx, h-2 + sy, w, 4, 180)
			
	
			--left/right caps
			 surface.SetMaterial(Material('sky/tp/lcap.png'))
			surface.DrawTexturedRect(sx + 0, 0 + sy, 4, h)
			surface.DrawTexturedRectRotated(w-2 + sx, h*0.5 + sy, 4, h, 180)
			DisableClipping( old )

		end
		

		-- function self:Paint(w, h)



		-- 	local startX, startY = self.storageInventoryPanel:GetPos()
		-- 	startX = math.floor(startX - 30*(invw/invTextureW))
		-- 	--startY = math.floor(startY + 37*(invw/invTextureW))

		-- 	local curX, curY = 0,0

		-- 	local path = "sky/storages/"
		-- 	local storText = "error"

		-- 	local stw, sth = 0,0
		-- 	local row = 0
		-- 	local column = 0
		-- 	local hAdjust = 0


		-- 	for row=1,sh,row+1 do
		-- 		if row == 1 then
		-- 			curY = math.floor(startY - uiMidOffset)
		-- 		end
		-- 		for column=1,sw+2,column+1 do
		-- 			local debugChecker = false  
		-- 			if debugChecker then
		-- 				if row % 2 != 0 then
		-- 					if column % 2 == 0 then
		-- 						surface.SetDrawColor(255,0,0,255)
		-- 					else
		-- 						surface.SetDrawColor(0,255,0,255)
		-- 					end	
		-- 				else
		-- 					if column % 2 == 0 then
		-- 						surface.SetDrawColor(0,255,0,255)
		-- 					else
		-- 						surface.SetDrawColor(255,0,0,255)
		-- 					end		
		-- 				end
		-- 			else
		-- 				surface.SetDrawColor(255,255,255,255)
		-- 			end

		-- 			if column == 1 then
		-- 				curX = startX
		-- 			end

		-- 			if column == 1 then
		-- 				if row == 1 then
		-- 					storText = "top_l_cap.png"
		-- 					stw, sth = 30, 52
		-- 				elseif row == sh then
		-- 					storText = "bot_l_cap.png"
		-- 					stw, sth = 30, 52
		-- 				elseif row == sh-1 then
		-- 					storText = "3_l_cap.png"
		-- 					stw, sth = 30, 52
		-- 				else
		-- 					storText = "2_l_cap.png"
		-- 					stw, sth = 30, 52
		-- 				end
		-- 			elseif column == sw+2 then
		-- 				if row == 1 then
		-- 					storText = "top_r_cap.png"
		-- 					stw, sth = 30, 52
		-- 				elseif row == sh then
		-- 					storText = "bot_r_cap.png"
		-- 					stw, sth = 18, 52
		-- 				elseif row == sh-1 then
		-- 					storText = "3_r_cap.png"
		-- 					stw, sth = 30, 52
		-- 				else
		-- 					storText = "2_r_cap.png"
		-- 					stw, sth = 30, 52
		-- 				end
		-- 			else
		-- 				if row==1 then
		-- 					storText = "top_"..column..".png"
		-- 					stw, sth = 45, 52
		-- 				elseif row==sh then
		-- 					storText = "bot_"..column..".png"
		-- 					stw, sth = 45, 52

		-- 				else
		-- 					storText = "3_"..column..".png"
		-- 					stw, sth = 45, 52
		-- 				end
		-- 			end


		-- 			finText = path..storText

		-- 			--surface.SetDrawColor(255,255,255,255)
		-- 			surface.SetMaterial(Material(finText))

		-- 			--print("totalsW = " .. totalsW .. " | totalInvenW = " .. totalInvenW)

		-- 			scaleW, scaleH = stw*(invw/invTextureW), sth*(invh/invTextureH)

					
		-- 			-- if row==sh then
		-- 			-- 	surface.DrawTexturedRect(curX+(13*invw/invTextureW), curY, scaleW, scaleH)
		-- 			-- else
		-- 			-- 	surface.DrawTexturedRect(curX, curY, scaleW, scaleH)
		-- 			-- end
		-- 			surface.DrawTexturedRect(curX, curY, scaleW, scaleH)
					
		-- 			curX = math.floor(curX+scaleW)

		-- 			--print("Drawing: " .. finText .. "| curX, curY = " .. curX .. ", " .. curY .. "row = "..row.." column = "..column)
		-- 			--print("Total Storage UI Width: " .. totalsW)

		-- 			--(invw/invTextureW)
		-- 			--(invh/invTextureH)
		-- 		end
		-- 		curY = math.floor(curY+scaleH)
		-- 	end
					

        -- end



			hook.Run("OnCreateStoragePanel", localInvPanel, storageInv, storage)
			
			--self.OnRemove = exitStorageOnRemove
			--storageInv.OnRemove = exitStorageOnRemove
	end

end
