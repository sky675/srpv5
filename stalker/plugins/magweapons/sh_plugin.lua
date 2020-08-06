local PLUGIN = PLUGIN
PLUGIN.name = "mag-based weaponry"
PLUGIN.author = "sky"
PLUGIN.desc = "weapons that use magazines + more"

nut.util.include("sh_config.lua")
nut.util.include("sh_batch.lua")

function PLUGIN:InitializedItems()
    --do
        for id, data in pairs(PLUGIN.attList) do
            local ITEM = nut.item.register(id, "base_attachments", nil, nil, true)
            ITEM.name = data.name
            ITEM.desc = data.desc
            ITEM.price = data.price or 0
            ITEM.model = data.model
            ITEM.width = data.width
			ITEM.height = data.height
			ITEM.weight = data.weight
			ITEM.flag = data.flag
            ITEM.cat = data.cat
			ITEM.attID = data.attID
			if(data.iconCam) then --prob wont be used for anything else so
				ITEM.exRender = true
				ITEM.iconCam = data.iconCam
			end
			ITEM.specialAtt = data.specialAtt
			if(data.destroyval) then
				ITEM.destroyval = data.destroyval --in case i wanna add more
				ITEM = EZADDDESTROYFUNC(ITEM)
			end
        end
        for id, data in pairs(PLUGIN.magList) do
            local ITEM = nut.item.register(id, "base_magazines", nil, nil, true)
            ITEM.name = data.name
            ITEM.desc = data.desc
            ITEM.price = data.price or 0
            ITEM.model = data.model
            ITEM.width = data.width
            ITEM.height = data.height
            ITEM.weight = data.weight
			ITEM.flag = data.flag
			ITEM.dontfill = data.dontfill
            ITEM.baseWeight = data.baseWeight or nil --this might be redundant but just in case
            ITEM.ammoBox = data.ammoBox --ammoBox makes empty items be removed
            ITEM.ammoType = data.ammoType --the ammo type to give
            ITEM.ammoMax = data.ammoMax --max ammo
			ITEM.otherMagTypes = data.otherMagTypes --it should be ok if this is nil
            ITEM.specammo = data.specammo --default ammo type (for ammo boxes)
			if(data.iconCam) then --prob wont be used for anything else so
				ITEM.exRender = true
				ITEM.iconCam = data.iconCam
			end
        end
        for id, data in pairs(PLUGIN.wepList) do
            local ITEM = nut.item.register(id, "base_mweapons", nil, nil, true)
            ITEM.name = data.name
            ITEM.desc = data.desc
            ITEM.price = data.price or 0
            ITEM.model = data.model
            ITEM.width = data.width
            ITEM.height = data.height
            ITEM.weight = data.weight
			ITEM.category = data.category
			ITEM.class = data.class
			ITEM.type = data.type
			ITEM.flag = data.flag
            ITEM.weaponCategory = data.weaponCategory
			ITEM.disableChamber = data.disableChamber or false
			ITEM.magType = data.magType
			ITEM.otherMagTypes = data.otherMagTypes --it should be ok if this is nil
			ITEM.convMagNames = data.convMagNames
			ITEM.convMagTypes = data.convMagTypes
			ITEM.defaultMods = data.defaultMods
			ITEM.defaultAmmo = data.defaultAmmo
			ITEM.cantDetach = data.cantDetach
			if(data.iconCam) then --prob wont be used for anything else so
				ITEM.exRender = true
				ITEM.iconCam = data.iconCam
			end
			ITEM.biolock = data.biolock
			ITEM.cantBeUnloaded = data.cantBeUnloaded
			ITEM.noBusiness = data.noBusiness
			ITEM.expand = data.expand
			
			if(data.destroyval) then
				ITEM.destroyval = data.destroyval --in case i wanna add more
				ITEM = EZADDDESTROYFUNC(ITEM)
			end

        end
    --end
end

if(SERVER) then
	--[[
	hook.Add("OnCharFallover", "redoatts", function(ply, _, bool)
		print("helloooooooooo")
		if(bool == true) then return end

		print("hi hello?")
		timer.Simple(2, function()
		local inv = ply:getChar():getInv()
		for k,v in pairs(inv:getItems()) do
			if(v.base == "base_mweapons") then
				v:doAttach()
			end
		end
		end)
	end)
]]
	util.AddNetworkString("reqrepwep")
	util.AddNetworkString("giverepwep")
	util.AddNetworkString("setrepwep")
	net.Receive("setrepwep", function(len, ply)
		local id = net.ReadInt(32)

		local item = nut.item.instances[id]
		if(!item) then 
			print("woah wtf?")
			return
		end
		local dura = item:getData("durability", 100)

		--set pay up and remove from inv
		local data = ply:getChar():getData("repairlist", {})
		if(table.Count(data) == 1) then --increase for dono? idk
			ply:notify("The current max amount of weapons you can have is 1.")
			return
		end
		local pay = math.Round((1-(dura/100)^2)*100000) 
		if(!ply:getChar():hasMoney(pay)) then
			ply:notify("You don't have enough in your active credstick for this!")
			return
		end
		ply:getChar():takeMoney(pay)

		local time = math.Round((1-(dura/100)^1.5)*14400)

		data[item.id] = {["name"] = item:getName(), ["time"] = os.time()+time}
		ply:getChar():setData("repairlist", data)

		item:transfer(0, nil, nil, nil, nil, true) --move it into logical
	end)
	net.Receive("giverepwep", function(len, ply)
		local id = net.ReadInt(32)

		--check if they can actually receive pay (active credstick)
		local data = ply:getChar():getData("repairlist", {})
		if(data[id]) then --they have the id
			local item = nut.item.instances[id]
			if(!item) then
				ply:notify("uh your wep seems to be gone, tell sky")
				return
			end

			item:setData("durability", 100)
			local succ, err = item:transfer(ply:getChar():getInv():getID())

			if(!succ) then
				ply:notify(err)
				return
			end

			data[id] = nil
			ply:getChar():setData("repairlist", data)
			ply:notify("You retrieve your "..item.name.." from the machine.")
		end

	end)

	--overriding
	local playerMeta = FindMetaTable("Player")

	function playerMeta:setRagdolled(state, time, getUpGrace)
		getUpGrace = getUpGrace or time or 5
	
		if (state) then
			if (IsValid(self.nutRagdoll)) then
				self.nutRagdoll:Remove()
			end
	
			local entity = self:createRagdoll()
			entity:setNetVar("player", self)
			entity:CallOnRemove("fixer", function()
				if (IsValid(self)) then
					self:setLocalVar("blur", nil)
					self:setLocalVar("ragdoll", nil)
	
					if (!entity.nutNoReset) then
						self:SetPos(entity:GetPos())
					end
	
					self:SetNoDraw(false)
					self:SetNotSolid(false)
					self:Freeze(false)
					self:SetMoveType(MOVETYPE_WALK)
					self:SetLocalVelocity(
						IsValid(entity)
						and entity.nutLastVelocity
						or vector_origin
					)
				end
	
				if (IsValid(self) and !entity.nutIgnoreDelete) then
					if (entity.nutWeapons) then
						for k, v in ipairs(entity.nutWeapons) do
							--replacing here becuz its easier this way
							local wep = self:Give(v.class, true)
							if(v.item) then
								wep.nutItem = nut.item.instances[v.item]
								--because oncharfallover doesnt call if it gets up normally
								if(wep.nutItem and wep.nutItem.base == "base_mweapons") then
									wep.nutItem:doAttach(wep)
								end
							end
							if(v.ammo) then
								wep:SetClip1(v.ammo)
							end
							--[[ --old code
							self:Give(v)
							if (entity.nutAmmo) then
								for k2, v2 in ipairs(entity.nutAmmo) do
									if v == v2[1] then
										self:SetAmmo(v2[2], tostring(k2))
									end
								end
							end]]
						end
						--[[for k, v in ipairs(self:GetWeapons()) do
							v:SetClip1(0)
						end]]
					end
	
					if (self:isStuck()) then
						entity:DropToFloor()
						self:SetPos(entity:GetPos() + Vector(0, 0, 16))
	
						local positions = nut.util.findEmptySpace(
							self,
							{entity, self}
						)
						for k, v in ipairs(positions) do
							self:SetPos(v)
	
							if (!self:isStuck()) then
								return
							end
						end
					end
				end
			end)
	
			self:setLocalVar("blur", 25)
			self.nutRagdoll = entity
	
			entity.nutWeapons = {}
			entity.nutAmmo = {}
			entity.nutPlayer = self
	
			if (getUpGrace) then
				entity.nutGrace = CurTime() + getUpGrace
			end
	
			if (time and time > 0) then
				entity.nutStart = CurTime()
				entity.nutFinish = entity.nutStart + time
	
				self:setAction(
					"@wakingUp",
					nil, nil,
					entity.nutStart, entity.nutFinish
				)
			end
	
			for k, v in ipairs(self:GetWeapons()) do
				--i finally got it fixed i like mine better ok
				local clip = v:Clip1()
				--print(tostring(v), clip)
				entity.nutWeapons[#entity.nutWeapons + 1] = {class = v:GetClass(), item = ((v.nutItem and v.nutItem:getID()) or nil), ammo = clip}
				--[[entity.nutWeapons[#entity.nutWeapons + 1] = v:GetClass()
				local clip = v:Clip1()
				local reserve = self:GetAmmoCount(v:GetPrimaryAmmoType())
				local ammo = clip + reserve
				entity.nutAmmo[v:GetPrimaryAmmoType()] = {v:GetClass(), ammo}]]
			end
	
			self:GodDisable()
			self:StripWeapons()
			self:Freeze(true)
			self:SetNoDraw(true)
			self:SetNotSolid(true)
			self:SetMoveType(MOVETYPE_NONE)
	
			if (time) then
				local time2 = time
				local uniqueID = "nutUnRagdoll"..self:SteamID()
	
				timer.Create(uniqueID, 0.33, 0, function()
					if (IsValid(entity) and IsValid(self)) then
						local velocity = entity:GetVelocity()
						entity.nutLastVelocity = velocity
	
						self:SetPos(entity:GetPos())
	
						if (velocity:Length2D() >= 8) then
							if (!entity.nutPausing) then
								self:setAction()
								entity.nutPausing = true
							end
	
							return
						elseif (entity.nutPausing) then
							self:setAction("@wakingUp", time)
							entity.nutPausing = false
						end
	
						time = time - 0.33
	
						if (time <= 0) then
							entity:Remove()
						end
					else
						timer.Remove(uniqueID)
					end
				end)
			end
	
			self:setLocalVar("ragdoll", entity:EntIndex())
			hook.Run("OnCharFallover", self, entity, true)
		elseif (IsValid(self.nutRagdoll)) then
			self.nutRagdoll:Remove()
	
			hook.Run("OnCharFallover", self, entity, false)
		end
	end

else
	hook.Add("InterceptClickItemIcon", "inspecticon", function(panel, icon, code)
		if(code == MOUSE_MIDDLE) then --mmb inspect functionality
			local item = icon.itemTable
			if(!item) then return end

			if(item.inspectAction) then
				if(!item.canInspect or item:canInspect()) then
					item:inspectAction()

					return true
				end
			end
		end
	end)

	netstream.Hook("updateitem", function(id, field, val)
		if(nut.item.instances[id]) then
			nut.item.instances[id][field] = val
		end
	end)
	--clientside hook
	hook.Add("ItemInitialized", function(item)
		if(item:getData("height")) then
			item.height = item:getData("height")
		end
		if(item:getData("width")) then
			item.width = item:getData("width")
		end
	end)

	net.Receive("reqrepwep", function()
		getRepUI()
	end)

	replist = nil

	function getRepUI()
		replist = vgui.Create("DFrame")
		local base = replist
		base:SetSize(ScrW()/1.5, ScrH()/1.5)
		base:SetTitle("Repair Interface - One at a time!")
		base:SetDraggable(true)
		base:MakePopup()
		base:SetKeyboardInputEnabled(false)
		base:Center()
		base:DockPadding(0, 25, 0, 0)

		getRepairList(base)
	end

	function getRepairList(self)
		if(self.data) then
			self.data:Remove()
		end

		self.data = self:Add("DListView")
		local data = self.data
		data:Dock(FILL)
		data:SetWide(self:GetWide())
		data:DockMargin(0, 0, 0, 0)
		--probably will be changed
		--data:SetSortable(false)
		data:AddColumn("Name")
		data:AddColumn("Cost")
		data:AddColumn("Seconds Remaining")
		data:AddColumn("Request Button") --this can be a button

		local pay = LocalPlayer():getChar():getData("repairlist", {})

		for k,v in pairs(pay) do
			--creation: data:AddLine(name, minpay, curtime paybutton) --with paybutton being an actual button
			local button = vgui.Create("DButton")
			print(v.time, os.ServerTime(), v.time-os.ServerTime())
			local line = data:AddLine(v.name, "N/A", math.Round(math.max(0, v.time-os.ServerTime())), button)
			--line:SetTooltip(v.desc)
			button:Dock(RIGHT)
			button:SetWide(data:ColumnWidth(4))
			button:SetText("Request Weapon")
			if(v.time > os.ServerTime()) then
				button:SetEnabled(false)
			end
			button.DoClick = function()
				net.Start("giverepwep")
				net.WriteInt(k, 32)
				net.SendToServer()
				timer.Simple(0.15, function() getRepairList(self) end)
			end
		end

		local inv = LocalPlayer():getChar():getInv()
		local torepitems = {}
		for k,v in pairs(inv:getItems()) do
			if(v.base == "base_mweapons" and v:getData("equip") != true) then
				local dura = v:getData("durability", 100)
				if(dura == 100) then continue end
				--doing it twice is bad but watev
				local price = math.Round((1-(dura/100)^2)*100000) --100000 is the base price
				local time = math.Round((1-(dura/100)^1.5)*14400)
				local button = vgui.Create("DButton")
				local line = data:AddLine(v.name, price, time, button)
				line.listing = true
				button:Dock(RIGHT)
				button:SetWide(data:ColumnWidth(4))
				button:SetText("Send Weapon")
				--if(v.time > os.ServerTime()) then
					button:SetEnabled(true)
				--end
				button.DoClick = function()
					net.Start("setrepwep")
					net.WriteInt(v.id, 32)
					net.SendToServer()
					timer.Simple(0.15, function() getRepairList(self) end)
				end
			end
		end

		timer.Create("replist", 1, 0, function()
			if(!IsValid(payd) or !replist.data) then timer.Remove("replist") return end

			for k,v in pairs(replist.data:GetLines()) do
				if(!v.listing and v:GetColumnText(3) > 0) then
					v:SetColumnText(3, v:GetColumnText(3)-1)
				else
					v:GetColumnText(4):SetEnabled(true)
				end
			end
		end)


	end

end