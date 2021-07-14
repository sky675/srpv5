local PLUGIN = PLUGIN


if (SERVER) then
	function PLUGIN:ns1SetupInventorySearch(client, target)
		local inventory = target:getChar():getInv(client, target)

		-- Permit the player to move items from their inventory to the target's inventory.
		inventory.oldOnAuthorizeTransfer = inventory.onAuthorizeTransfer
		inventory.onAuthorizeTransfer = function(inventory, client2, oldInventory, item)
			if (IsValid(client2) and client2 == client) then
				return true
			end

			return false
		end
		inventory:sync(client)
		inventory.oldGetReceiver = inventory.getReceiver
		inventory.getReceiver = function(inventory)
			return {client, target}
		end
		inventory.onCheckAccess = function(inventory, client2)
			if (client2 == client) then
				return true
			end
		end

		-- Permit the player to move items from the target's inventory back into their inventory.
		local inventory2 = client:getChar():getInv()
		inventory2.oldOnAuthorizeTransfer = inventory2.onAuthorizeTransfer
		inventory2.onAuthorizeTransfer = function(inventory3, client2, oldInventory, item)
			if (oldInventory == inventory) then
				return true
			end

			return inventory2.oldOnAuthorizeTransfer(inventory3, client2, oldInventory, item)
		end
	end

	function PLUGIN:ns1RemoveInventorySearchPermissions(client, target)
		local inventory = target:getChar():getInv()
		inventory.onAuthorizeTransfer = inventory.oldOnAuthorizeTransfer
		inventory.oldOnAuthorizeTransfer = nil
		inventory.getReceiver = inventory.oldGetReceiver
		inventory.oldGetReceiver = nil
		inventory.onCheckAccess = nil
			
		local inventory2 = client:getChar():getInv()
		inventory2.onAuthorizeTransfer = inventory2.oldOnAuthorizeTransfer
		inventory2.oldOnAuthorizeTransfer = nil
	end

	function PLUGIN:ns2SetupInventorySearch(client, target)
		local function searcherCanAccess(inventory, action, context)
			if (context.client == client) then
				return true
			end
		end

		target:getChar():getInv():addAccessRule(searcherCanAccess)
		target.nutSearchAccessRule = searcherCanAccess

		target:getChar():getInv():sync(client)
	end

	function PLUGIN:ns2RemoveInventorySearchPermissions(client, target)
		local rule = target.nutSearchAccessRule
		if (rule) then
			target:getChar():getInv():removeAccessRule(rule)
		end
	end

	function PLUGIN:searchPlayer(client, target)
		if (IsValid(target:getNetVar("searcher")) or IsValid(client.nutSearchTarget)) then
			client:notifyLocalizedL("This person is already being searched.", 2)
			return false
		end

		if (!target:getChar() or !target:getChar():getInv()) then
			client:notifyLocalized("invalidPly")
			return false
		end

		nut.log.addRaw("client "..client:steamName().." ("..client:SteamID()..") started searching "..target:steamName().." ("..target:SteamID()..")")

		if (nut.version) then
			self:ns2SetupInventorySearch(client, target)
		else
			self:ns1SetupInventorySearch(client, target)
		end

		-- Show the inventory menu to the searcher.
		netstream.Start(client, "searchPly", target, target:getChar():getInv():getID())

		client.nutSearchTarget = target
		target:setNetVar("searcher", client)

		return true
	end

	function PLUGIN:CanPlayerInteractItem(client, action, item)
		if (IsValid(client:getNetVar("searcher"))) then
			return false
		end
	end

	function PLUGIN:stopSearching(client)
		local target = client.nutSearchTarget

		if (IsValid(target) and target:getNetVar("searcher") == client) then
			if (nut.version) then
				PLUGIN:ns2RemoveInventorySearchPermissions(client, target)
			else
				PLUGIN:ns1RemoveInventorySearchPermissions(client, target)
			end

			target:setNetVar("searcher", nil)
			client.nutSearchTarget = nil

			netstream.Start(client, "searchExit")
		end
	end

	netstream.Hook("searchExit", function(client)
		PLUGIN:stopSearching(client)
	end)
else

	function PLUGIN:CanPlayerViewInventory()
		if (IsValid(LocalPlayer():getNetVar("searcher"))) then
			return false
		end
	end

	--STARTING ACTUAL VISUAL STUFF OPENING OK
	if (nut.version) then
		netstream.Hook("searchPly", function(target, id)
			self = vgui.Create( "EditablePanel" )
			self:SetSize(ScrW(), ScrH())
			self.noAnchor = CurTime() + .4
			self.anchorMode = true
			self:SetPopupStayAtBack(true)
			self:MakePopup()
	
			local targetInv = nut.inventory.instances[id]
			if (not targetInv) then
				self:Remove()
			end

			self.targetInvPanel = targetInv:show()

			self.targetInvPanel:SetPos(invPosX-(self.targetInvPanel:GetWide()), ScrH()*0.5-(self.targetInvPanel:GetTall()*0.5))
			self.targetInvPanel.Paint = function() end
			self.targetInvPanel:SetPopupStayAtBack(true)
	
			
			self.info = vgui.Create("nutCharInfo", self)
			self.info:setup(self)
			self.info.quickInventoryPanel:RequestFocus()
	
			function self:OnKeyCodePressed(key)
				--print("f1 pressed cool cool")
				-- F1 Close
				local keypress = KEY_F1
				if(input.LookupBinding("gm_showhelp") != "no value") then
					keypress = input.GetKeyCode(input.LookupBinding("gm_showhelp"))
				end
		
				if (key == keypress) then
					print("ok i close now")
					netstream.Start("searchExit")
					self.info:Remove()
					self.targetInvPanel:Remove()
					self:Remove()
				end
			end




			--targetInvPanel:ShowCloseButton(true)
			--targetInvPanel:SetTitle(target:Name())

			self.targetInvPanel:SetPos(invPosX-(self.targetInvPanel:GetWide()), ScrH()*0.5-(self.targetInvPanel:GetTall()*0.5))

			function self:Paint(w, h)

				local iw, ih = 611, 382
				local w, h = self.targetInvPanel:GetWide(), self.targetInvPanel:GetTall()
				local sx, sy = self.targetInvPanel:GetX(), self.targetInvPanel:GetY()
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
	
		end)
	else

		netstream.Hook("searchPly", function(target, index)
			local inventory = nut.item.inventories[index]

			if (!inventory) then
				return netstream.Start("searchExit")
			end

			--start info panel
			self = vgui.Create( "EditablePanel" )
			self:SetSize(ScrW(), ScrH())
			self.noAnchor = CurTime() + .4
			self.anchorMode = true
			self:SetPopupStayAtBack(true)
			self:MakePopup()
	
			self.searchInv = vgui.Create("nutInventory")

			self.searchInv:setInventory(inventory)
			self.searchInv:SetPos(invPosX-(self.searchInv:GetWide()), ScrH()*0.5-(self.searchInv:GetTall()*0.5))
			self.searchInv.Paint = function() end
			self.searchInv:SetPopupStayAtBack(true)
	
			self.info = vgui.Create("nutCharInfo", self)
			self.info:setup(self)
			self.info.quickInventoryPanel:RequestFocus()
			--end info panel
			
			function self:OnKeyCodePressed(key)
				--print("f1 pressed cool cool")
				-- F1 Close
				local keypress = KEY_F1
				if(input.LookupBinding("gm_showhelp") != "no value") then
					keypress = input.GetKeyCode(input.LookupBinding("gm_showhelp"))
				end
		
				if (key == keypress) then
					print("ok i close now")
					PLUGIN:stopSearching(client)
					self.info:Remove()
					self.targetInvPanel:Remove()
					self:Remove()
					
				end
			end
	
			--panel:ShowCloseButton(true)
			--panel:SetTitle(target:Name())
			-- HOW TO CLOSE DUH: netstream.Start("searchExit")
		end)
	end


	netstream.Hook("searchExit", function()

	end)
end

nut.command.add("charsearch", {
	desc = "Search a tied character.",
	onRun = function(client, arguments)
        if(client:getNetVar("neardeath")) then return end
        if(client:getNetVar("restricted")) then return "You cannot do this while tied!" end

		if(client:IsAdmin() and arguments[1]) then
			local targ = nut.command.findPlayer(client, arguments[1])
			if(IsValid(targ)) then
				client:notify("remember there are desyncs when a player is being searched!")
				PLUGIN:searchPlayer(client, targ)
			end
			return
		end

		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector()*96
			data.filter = client
		local target = util.TraceLine(data).Entity
		
		--this should allow tying of ragdolled ppl
		if(IsValid(target) and target:GetClass() == "prop_ragdoll" and IsValid(target:getNetVar("player"))) then
			target = target:getNetVar("player")
		end

		if (not client:getChar() or not client:getChar():getInv()) then
			return false
		end

		if (not IsValid(target) or not target:IsPlayer()) then
			return false, "@invalidPly"
		end

		if (target:getNetVar("restricted")) then
			PLUGIN:searchPlayer(client, target)
		else
			return false, "@This player must be tied"
		end
	end
})