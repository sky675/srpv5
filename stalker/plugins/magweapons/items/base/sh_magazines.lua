ITEM.name = "Magazine"
ITEM.desc = "A weapon magazine."
ITEM.category = "Ammunition"
ITEM.model = "models/weapons/w_pistol.mdl"

function ITEM:getDesc()
	local str = self.desc
    local ammo = tostring(self:getData("mag", 0))

	str = str..(str != "" and "\n" or "")..ammo.." out of "..tostring(self.ammoMax or 1).." rounds."
	
	if(self:getData("type")) then
		str = str.."\nSpecial Type: "..self:getData("type").."."
	end

    return str
end

function ITEM:getWeight()
	--the full weight-the base weight, divided by max ammo, to find the weight per ammo
    local weightrem = (self.weight-(self.baseWeight or 0.06))/self.ammoMax
	--then remove missing ammo from the weight
    return math.Round(self.weight - (weightrem*(self.ammoMax-self:getData("mag", 0))), 2)
end

function ITEM:calcPrice(origprice)
	local price = origprice

	local mag = self:getData("mag")
	if(mag) then
		if(self.ammoBox) then
			--less ammo = less price
			price = price * (mag/self.ammoMax)
		else
			--more ammo = add onto price
			price = price + ((mag/self.ammoMax)*(price*1.5))
		end
	end

	return price
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		draw.SimpleText(item:getData("mag", 0).."/"..item.ammoMax, "DermaDefault", w - 5, h - 5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

--required on item:
--[[
ITEM.ammoBox = false --ammobox makes empty items be removed
ITEM.ammoType = "ammo_type"
ITEM.ammoMax = 15
]]

--update the active weapons mag count, 
--we dont really have an easy way of telling if the active weapon magtype is this or not
--if its not, its fine anyway becuz itll get adjusted when they deploy that wep again
ITEM:hook("drop", function(item)
	if(item.player) then --just in case lol
		netstream.Start(item.player, "DoMagCount")
	end
end)
ITEM:hook("take", function(item)
	if(item.player) then --just in case lol
		netstream.Start(item.player, "DoMagCount")
	end
end)

--change ammo type function

	ITEM.functions.zChangeMag = {
		name = "Change Special Ammo",
		tip = "unload",
		icon = "icon16/tick.png",
		sound = "interface/inv_properties.ogg",
		isMulti = true,
		multiOptions = function(item, ply)
			local options = {}
			for k,v in pairs(item.otherMagTypes) do
				table.insert(options, {
					name = v,
					--sound = "",
					data = k
				})
			end
			return options
		end,
		onRun = function(item, sub)
			if(sub == "default") then
				item:setData("type")
			else
				item:setData("type", sub)
			end
			netstream.Start(item.player, "DoMagCount")
	
			return false
		end,
		onCanRun = function(item, sub)
			return (!IsValid(item.entity) and item:getData("mag", 0) == 0 and (item.otherMagTypes != nil and table.Count(item.otherMagTypes) != 0))
		end
	}

function ITEM:onCombineTo(target)
	if(target.base != "base_magazines" or (target.ammoType and target.ammoType != self.ammoType) or target:getData("type") != self:getData("type")) then return end
		
	local ply = self.player
	local item = self

            --ok so (get ammo through item:getData("mag", 0))
            --first find out whats missing from the target magazine
            local tarmax = target.ammoMax
            local tarmag = target:getData("mag", 0)
            local missing = tarmax - tarmag
            
            if(missing == 0) then return end --full


            --use that to determine if the box has enough left
            local itemag = item:getData("mag", 0)
            if(itemag <= missing) then
            --if it doesnt, give all the ammo in the box to the mag and remove the box (return true)
            --or leave it if the item isnt an ammobox
                target:setData("mag", itemag + tarmag)
                if(item.ammoBox) then
					netstream.Start(item.player, "DoMagCount") --these are to update the hud on the actual gun

                    item:remove()
                else
                    item:setData("mag", 0)
				
					netstream.Start(item.player, "DoMagCount")
                end
            else
            --if it does, remove the amount of ammo to be taken from the box
            --and fill the magazine to max
                item:setData("mag", itemag - missing)
				target:setData("mag", tarmag + missing)
				
				netstream.Start(item.player, "DoMagCount")
			end
			

end

--combine function (for ammobox onto magazine)
--[[ITEM.functions.--combine = {
    name = "Combine",
    tip = "Equip to active weapon",
	icon = "icon16/wrench.png",
	sound = "interface/inv_properties.ogg",
    onRun = function(item, id)
        local target = nut.item.instances[id]

        if(id and target) then
            --ok so (get ammo through item:getData("mag", 0))
            --first find out whats missing from the target magazine
            local tarmax = target.ammoMax
            local tarmag = target:getData("mag", 0)
            local missing = tarmax - tarmag
            
            if(missing == 0) then return false end --full


            --use that to determine if the box has enough left
            local itemag = item:getData("mag", 0)
            if(itemag <= missing) then
            --if it doesnt, give all the ammo in the box to the mag and remove the box (return true)
            --or leave it if the item isnt an ammobox
                target:setData("mag", itemag + tarmag)
                if(item.ammoBox) then
					netstream.Start(item.player, "DoMagCount")

                    return true
                else
                    item:setData("mag", 0)
				
					netstream.Start(item.player, "DoMagCount")
                end
            else
            --if it does, remove the amount of ammo to be taken from the box
            --and fill the magazine to max
                item:setData("mag", itemag - missing)
				target:setData("mag", tarmag + missing)
				
				netstream.Start(item.player, "DoMagCount")
            end

            return false
        end
    end,
    onCanRun = function(item, id)
        local target = nut.item.instances[id]
        
        if(id and target) then
            if(!IsValid(item.entity) and target.base == "base_magazines" and target.ammoType and target.ammoType == item.ammoType and target:getData("type") == item:getData("type")) then
                return true
            else
                return false
            end
        end

        return false
    end
}]]

ITEM.functions.discardAmmo = {
    name = "Discard Mag Ammo",
    tip = "You will not get the ammo back.",
    icon = "icon16/cross.png", --do trashbin icon
	isMulti = true,
	multiOptions = {
		{name = "Confirm (AMMO DISAPPEARS)", data = true},
	},	
	onRun = function(item, data)
		if(data == true) then
			item:setData("mag", 0)

			netstream.Start(item.player, "DoMagCount")
		end
		return false
    end,
    onCanRun = function(item)
        return (!IsValid(item.entity) and item:getData("mag", 0) != 0 and !item.ammoBox)
    end
}
ITEM.functions.discardMag = {
    name = "Remove Mag",
    tip = "Remove the magazine from existance.",
    icon = "icon16/cross.png", --do trashbin icon
	isMulti = true,
	multiOptions = {
		{name = "Confirm", data = true},
	},	
	onRun = function(item, data)
		if(data == true) then
			return true
		end
		return false
    end,
    onCanRun = function(item)
        return (!IsValid(item.entity) and item:getData("mag", 0) == 0)
    end
}

function ITEM:onInstanced()
    if(!self:getData("mag")) then
        self:setData("mag", 0)--self.ammoMax or 1) --default max

        if(self.ammoBox or self.dontfill) then
            self:setData("mag", self.ammoMax or 1)
		end        
    end
	if(self.specammo) then
		self:setData("type", self.specammo)
	end
end