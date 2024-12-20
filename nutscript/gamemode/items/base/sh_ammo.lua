ITEM.name = "Ammo Base"
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.isStackable = true
ITEM.maxQuantity = 45
ITEM.ammo = "pistol" -- type of the ammo
ITEM.desc = "A Box that contains %s of Pistol Ammo"
ITEM.category = "Ammunition"

function ITEM:getDesc()
	return Format(self.ammoDesc or self.desc, self:getQuantity())
end
function ITEM:getPrice()
	local per = self.price/self.maxQuantity
	return per*(self:getQuantity() or self.maxQuantity or 1)
end

function ITEM:paintOver(item, w, h)
	local quantity = item:getQuantity()
	
	draw.SimpleText(quantity.."/"..item.maxQuantity, "DermaDefault", w - 5 , h - 5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
end

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

local loadAmount = {
	5,
	10,
	30,
	45,
	90,
	150,
	300
}
if(SERVER) then
	netstream.Hook("ammoLoad", function(ply, id, amount)
		local item = nut.item.instances[id]
		if (item and amount <= item:getQuantity()) then
			if (amount > 0) then
				item:addQuantity(-amount)
	
				ply:GiveAmmo(amount, item.ammo)
				ply:EmitSound(item.useSound or "items/ammo_pickup.wav", 110)
			elseif (amount == 0) then
				ply:GiveAmmo(item:getQuantity(), item.ammo)
				ply:EmitSound(item.useSound or "items/ammo_pickup.wav", 110)
				item:remove()
				return
			end
			if(item:getQuantity() <= 0) then
				item:remove()
			end
		end
	end)
end

ITEM.functions.use = { -- sorry, for name order.
	name = "Load",
	tip = "useTip",
	icon = "icon16/add.png",
    isMulti = true,
    multiOptions = function(item, client)
        local options = {}

		table.insert(options, {
            name = L("ammoLoadAll"),
            data = 0,
        })
		for _, amount in pairs(loadAmount) do
			if (amount <= item:getQuantity()) then
				table.insert(options, {
					name = L("ammoLoadAmount", amount),
					data = amount,
				})
			end
		end
		table.insert(options, {
            name = L("ammoLoadCustom"),
            data = -1,
        })

        return options
	end,
	onClick = function(item, data)
		if (data == -1) then
			Derma_StringRequest("Ammo Load", "Enter the ammo to load", "0", function(text)
				local num = tonumber(text)
				if(num) then
					netstream.Start("ammoLoad", item.id, num)
				end
			end)
			return false
		end
	end,
	onRun = function(item, data)
		data = data or 0

		if (data > 0) then
			local num = tonumber(data)
			item:addQuantity(-num)

			item.player:GiveAmmo(num, item.ammo)
			item.player:EmitSound(item.useSound or "items/ammo_pickup.wav", 110)
		elseif (data == 0) then
			item.player:GiveAmmo(item:getQuantity(), item.ammo)
			item.player:EmitSound(item.useSound or "items/ammo_pickup.wav", 110)
			return true
		end
		return item:getQuantity() <= 0
	end,
	onCanRun = function(item) 
		return !IsValid(item.entity)
	end
}

function ITEM:onInstanced()
	if(self.defQuantity) then
		self:setQuantity(self.defQuantity)
	end
end