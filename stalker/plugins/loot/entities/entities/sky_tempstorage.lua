local PLUGIN = PLUGIN

ENT.Type = "anim"
ENT.PrintName = "Temp Storage"
ENT.Category = "NutScript"
ENT.Spawnable = false

if (SERVER) then
	function ENT:Initialize()
		if(!util.IsValidModel(self:GetModel())) then
		self:SetModel("models/props_junk/watermelon01.mdl")
		end
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.receivers = {}
		local ent = self
--[[
		timer.Simple(0.01, function()
			if(!ent:getInv() and ent:getNetVar("invname") and !ent:getNetVar("dontcreate")) then
				nut.item.newInv(0, "st"..ent:getNetVar("invname"), function(inventory)
					inventory.vars.isStorage = true
					if (IsValid(storage)) then
						ent:setInventory(inventory)
					end
				end)
			end
		end)
		]]
		timer.Create("tempstorageCheck"..ent:EntIndex(), 1800, 0, function()
			local inv = nut.item.inventories[ent:getNetVar("id")]

			if(inv) then
				if(#inv:getItems() == 0) then 
					ent:Remove()
					return
				end
			end
		end)
		
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
	end

	function ENT:setInventory(inventory)
		if (inventory) then
			self:setNetVar("id", inventory:getID())
			
			--read only
			local idd = inventory:getID()
			---[[
			inventory.onAuthorizeTransfer = function(inv, client, oldInventory, item)
				if (IsValid(client) and IsValid(self) and self.receivers[client]) then
				if(inv:getID() == idd) then--inventory:getID()) then
					return false
				end
				end
			end
			--[[
			inventory.onTransfer = function()
				print("eh?")
			end
			]]
			inventory.getReceiver = function(inventory)
				local receivers = {}

				for k, v in pairs(self.receivers) do
					if (IsValid(k)) then
						receivers[#receivers + 1] = k
					end
				end

				return #receivers > 0 and receivers or nil
			end
			inventory.onCanTransfer = function(inv, client, oldX, oldY, x, y, newInvID)
				return hook.Run("StorageCanTransfer", inv, client, oldX, oldY, x, y, newInvID)
			end

			--spawn random items in inv
			print("come on")
			local realL = {}
			if(PLUGIN.lootTables[self.itemtype]) then
				for k2, v2 in pairs(PLUGIN.lootTables[self.itemtype].loot) do
					for i=1, v2[2] do
						table.insert(realL, v2[1])
					end
				end
			end
			if(#realL == 0) then return end
			print("setup table")
			local nu = math.random(1,6)
			print(nu.." start")
			for i=1, nu do--PLUGIN.maxSceneItems) do
				print(i)
				local it = table.Random(realL)
				if(it == "none") then continue end --dont spawn anything
				print("not none")
	
				local item = nut.item.get(it)
				if(!item) then continue end --invalid item
				print("valid")
				local data = {}
				local durabilityMin, durabilityMax = PLUGIN.lootTables[self.itemtype].durability[1], PLUGIN.lootTables[self.itemtype].durability[2]
				-- random mag amt if ammo, random durability if wep
				if(item.base == "base_mweapons") then
					data["durability"] = math.random(durabilityMin, durabilityMax)
				end
				if(item.base == "base_suit") then
					data["armor"] = {}
					for k,v in pairs(item.armor) do
						data["armor"][k] = v
						data["armor"][k].durability = math.random(durabilityMin, durabilityMax)
					end
				end
				if(item.base == "base_magazines") then
					if(PLUGIN.lootTables[self.itemtype].randomAmmo != 2) then
						if(PLUGIN.lootTables[self.itemtype].randomAmmo == 1) then
							if(!item.ammoBox) then
								data["mag"] = math.random(0, item.ammoMax)
							end
						else
							data["mag"] = math.random((item.ammoBox and 1) or 0, item.ammoMax)
						end
					end
				end
	
				--local x, y = inventory:findEmptySlot(item.width, item.height, true)
				print("looking")
				--if(x and y) then
					local succ, err = inventory:add(it, 1, data)
					if(!succ) then
						print(err)
					end
					print("if no error above, is gud!")
				--end
			end
		end
	end

	function ENT:OnRemove()
		local index = self:getNetVar("id")

		if (!nut.shuttingDown and index) then--!self.nutIsSafe and index) then
			local item = nut.item.inventories[index]

			if (item) then
				nut.item.inventories[index] = nil

				nut.db.query("DELETE FROM nut_items WHERE _invID = "..index)
				nut.db.query("DELETE FROM nut_inventories WHERE _invID = "..index)

				if(timer.Exists("tempstorageCheck"..self:EntIndex())) then
					timer.Remove("tempstorageCheck"..self:EntIndex())
				end

				hook.Run("StorageItemRemoved", self, item)
			end
		end
	end

	local OPEN_TIME = .7
	function ENT:OpenInv(activator)
		local inventory = self:getInv()
		local def = PLUGIN.tempDef[self:GetModel():lower()]

		if (def.onOpen) then
			def.onOpen(self, activator)
		end

		activator:setAction("Opening...", OPEN_TIME, function()
			if (activator:GetPos():Distance(self:GetPos()) <= 100) then
				self.receivers[activator] = true
				activator.nutBagEntity = self
				
				inventory:sync(activator)
				netstream.Start(activator, "invOpen", self, inventory:getID())
				self:EmitSound(def.opensound or "items/ammocrate_open.wav")
			end
		end)
	end

	function ENT:Use(activator)
		local inventory = self:getInv()

		if (inventory and (activator.nutNextOpen or 0) < CurTime()) then
			if (activator:getChar()) then
				local def = PLUGIN.tempDef[self:GetModel():lower()]

				if (self:getNetVar("locked")) then
					self:EmitSound(def.locksound or "doors/default_locked.wav")
				--	if (!self.keypad) then --wtf is this?
						netstream.Start(activator, "invLock", self)
				--	end
				else
					self:OpenInv(activator)
				end
			end

			activator.nutNextOpen = CurTime() + OPEN_TIME * 1.5
		end
	end
else
	ENT.DrawEntityInfo = true

	local COLOR_LOCKED = Color(242, 38, 19)
	local COLOR_UNLOCKED = Color(135, 211, 124)
	local toScreen = FindMetaTable("Vector").ToScreen
	local colorAlpha = ColorAlpha
	local drawText = nut.util.drawText
	local configGet = nut.config.get

	function ENT:onDrawEntityInfo(alpha)
		local locked = self.getNetVar(self, "locked", false)
		local position = toScreen(self.LocalToWorld(self, self.OBBCenter(self)))
		local x, y = position.x, position.y

		y = y - 20
		local tx, ty = nut.util.drawText(locked and "P" or "Q", x, y, colorAlpha(locked and COLOR_LOCKED or COLOR_UNLOCKED, alpha), 1, 1, "nutIconsMedium", alpha * 0.65)
		y = y + ty*.9

		local def = PLUGIN.tempDef[self.GetModel(self):lower()]
		local tx, ty = drawText(def.name or "Storage", x, y, colorAlpha(configGet("color"), alpha), 1, 1, nil, alpha * 0.65)
		if (def) then
			y = y + ty + 1
			drawText(def.desc, x, y, colorAlpha(color_white, alpha), 1, 1, nil, alpha * 0.65)
		end
	end
end

function ENT:getInv()
	return nut.item.inventories[self:getNetVar("id", 0)]
end