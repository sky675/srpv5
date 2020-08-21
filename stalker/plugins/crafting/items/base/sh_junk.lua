ITEM.name = "junk base"
ITEM.desc = "add onto or something idk"
ITEM.model = "models/stalker/item/handhelds/files1.mdl"
ITEM.price = 30
ITEM.flag = "m"
ITEM.category = "Junk"

ITEM.startQuantity = 1

ITEM.isStackable = true
ITEM.canSplit = true
--[[
	ITEM.destroyval = {
		["id"] = 2, --to give
	}
	ITEM.countMax = 99 --max available
ITEM.maxQuantity = 5
]]
function ITEM:getWeight()
	local price = self.weight
	local quan = self:getQuantity() or self.maxQuantity or 1
	
	return price*quan --hm?
end
function ITEM:getPrice()
	local price = self.price
	local quan = self:getQuantity() or self.maxQuantity or 1
	
	return price*quan --hm?
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if(!item.canSplit or !item.isStackable) then return end
		draw.SimpleText(item:getQuantity().."/"..(item.maxQuantity or 1), "DermaDefault", w - 5 , h - 5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

function ITEM:getDesc()
	local desc = self.desc
	if(self:getQuantity()) then
		desc = desc.."\nStack: "..self:getQuantity().."/"..(self.maxQuantity or 1)
	end

	return desc
end

ITEM.functions.dropone = {
	name = "Drop 1",
	tip = "takeTip",
	icon = "icon16/box.png",
	onRun = function(item)
		local client = item.player
		local pos = client:getItemDropPos()
		if(item:getQuantity() == 1) then
			item:removeFromInventory(true)
				:next(function() item:spawn(client) end)
		else
			local quan = item:getQuantity()
			item:setQuantity(quan-1)
			nut.item.spawn(item.uniqueID, pos, function(item, entity)
				if(item.base == "base_junk") then
					item:setQuantity(1)
				end
			end)
		end
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)
	end

}
--copied from the base so i can add it to existing items
--[[ --ill try this later i guess idk if itll work
ITEM.functions.take = {
	--ITEM.functions.take = ITEM.functions.take or {
		tip = "takeTip",
		icon = "icon16/box.png",
		onRun = function(item)
			local inventory = item.player:getChar():getInv()
			-- is inventory exists and not a logical inventory 
			
			if (inventory) then
				if (inventory:hasItem(item.uniqueID)) then
					local items = invetory:getItemsByUniqueID(item.uniqueID)
					local quan = item:getData("count", 1)
					for k,v in pairs(items) do
						local amt = v:getData("count", 0)
						local max = v.countMax

					end
				else
					local status, result = item.player:getChar():getInv():add(item.id)

					if (!status) then
						item.player:notify(result)

						return false
					else
						if (item.data) then -- I don't like it but, meh...
							for k, v in pairs(item.data) do
								item:setData(k, v)
							end
						end
					end
				end
			end
		end,
		onCanRun = function(item)
			return IsValid(item.entity)
		end
	}
]]
--combine function (for ammobox onto magazine)
	--[[
	ITEM.functions.combine = {
		name = "Combine",
		tip = "Equip to active weapon",
		icon = "icon16/wrench.png",
		sound = "interface/inv_properties.ogg",
		onRun = function(item, id)
			local target = nut.item.instances[id]
	
			if(id and target) then
				--ok so (get ammo through item:getData("mag", 0))
				--first find out whats missing from the target magazine
				local tarmax = target.countMax or 1
				local tarmag = target:getData("count", 1)
				local missing = tarmax - tarmag
				
				if(missing == 0) then return false end --full
	
				--use that to determine if the box has enough left
				local itemag = item:getData("count", 1)
				if(itemag <= missing) then
				--if it doesnt, give all the ammo in the box to the mag and remove the box (return true)
				--or leave it if the item isnt an ammobox
					target:setData("count", itemag + tarmag)
						return true
				else
				--if it does, remove the amount of ammo to be taken from the box
				--and fill the magazine to max
					item:setData("count", itemag - missing)
					target:setData("count", tarmag + missing)
				end
	
				return false
			end
		end,
		onCanRun = function(item, id)
			local target = nut.item.instances[id]
			
			if(id and target) then
				if(!IsValid(item.entity) and target.uniqueID == item.uniqueID) then
					return true
				else
					return false
				end
			end
	
			return false
		end
	}]]


	--really you restored quantity but couldnt restore this?
	--this is clearly what someone would want if they wanted to do something
		--with quantity
ITEM.functions.take = {
	tip = "takeTip",
	icon = "icon16/box.png",
	onRun = function(item)
		local client = item.player
		local inventory = client:getChar():getInv()
		local entity = item.entity

		if (client.itemTakeTransaction and client.itemTakeTransactionTimeout > RealTime()) then
			return false
		end

		client.itemTakeTransaction = true 
		client.itemTakeTransactionTimeout = RealTime()

		if (not inventory) then return false end

		local d = deferred.new()

		local name = item.name

		inventory:add(item.uniqueID, item:getQuantity())
			:next(function(res)
				client.itemTakeTransaction = nil

				if (IsValid(entity)) then
					entity.nutIsSafe = true
					entity:Remove()
				end
				item:remove()

				if (not IsValid(client)) then return end
				nut.log.add(client, "itemTake", name, 1)

				d:resolve()
			end)
			:catch(function(err)
				client.itemTakeTransaction = nil

				client:notifyLocalized(err)

				d:reject()
			end)

		return d
	end,
	onCanRun = function(item)
		return IsValid(item.entity)
	end

}

ITEM.onCombine = function(self, target)
	if(self.uniqueID == target.uniqueID) then
		local combined = self:getQuantity() + target:getQuantity()
		
		if(combined > self.maxQuantity) then
			self:setQuantity(self.maxQuantity)
			target:setQuantity(combined - self.maxQuantity)
		else
			target:remove()
			self:setQuantity(combined)
		end

	end
end
--[[ --tried moving to a shared function
ITEM.functions.zdestroy = {
	name = "Deconstruct",
    tip = "deconstruct item for parts",
	icon = "icon16/cup.png",
	isMulti = true,
	multiOptions = {
		{name = "Confirm", data = true},
	},
	onRun = function(item, data)
		if(!data) then return end

        local ply = item.player
		local inv = ply:getChar():getInv()
		local des = item.destroyval or {}

		if(!item.isStackable or item:getQuantity() == 1) then
			--item:remove() --idk if this will work lmao
		else
			item:setQuantity(item:getQuantity()-1)

			for type, v in pairs(des) do
				inv:add(type, v) --this shit had issues before will it work in this situation?
			end
			return false
		end
		
		for type, v in pairs(des) do
			inv:add(type, v) --this shit had issues before will it work in this situation?
		end
    end,
    onCanRun = function(item)
        return (!IsValid(item.entity) and item.destroyval != nil and item:getData("equip") != true)
    end
}]]

function ITEM:onInstanced()
	print("instance junk "..(tostring(self.quantity) or "nothing"))
    if(!self.quantity) then --idkk if thisll work
        self:setQuantity(1)--self.ammoMax or 1) --default max
    end
end