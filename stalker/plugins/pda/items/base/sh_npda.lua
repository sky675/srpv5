ITEM.name = "nPDA"
ITEM.desc = "A PDA. Vital for communicating with other stalkers across the zone."
ITEM.model = "models/stalker/item/handhelds/pda.mdl"
ITEM.price = 200
ITEM.flag = "m"
ITEM.category = "misc"

function ITEM:getDesc()
	local desc = self.desc

    desc = desc.."\nPower is "..(self:getData("isoff", false) and "off." or "on.")

	return desc
end
--[[
function ITEM:getDesc()
	local desc = self.desc

	if(self:getData("money") and self:getData("credtype")) then
		local cred = self:getData("credtype", "INVALID TELL ADMIN")
		desc = desc.."\nSlotted Credstick: "..cred.." - "..self:getData("money", 0).."/"..nut.item.get(cred).moneymax or "???".." credits"
	end

	return desc
end

function ITEM:onCorpseTrans(newInv)
	--keep the pda but give the money to the corpse inv
	if(newInv and newInv.vars and newInv.vars.invType and string.find(newInv.vars.invType, "corpse.")) then
	if(self:getData("money") and self:getData("credtype")) then
		newInv:add(self:getData("credtype"), 1, {money = self:getData("money")}, self.gridX, self.gridY)
	end
		self:setData("money", 0)
		self:setData("credtype", "cred_n5k") --free 5k credstick
	end
end

function ITEM:onCombineTo(target)
	if(target.base != "base_credstick" or (target.base != "base_npda" or !target:getData("money")) or !self:getData("money")) then return end
	
	local ply = self.player
	local item = self

	--these checks are irrelevant tbh but ill leave them
	if(target.base == "base_npda" and target:getData("money")) then
		net.Start("CredSplitC")
		net.WriteInt(item.id, 20)
		net.WriteInt(target.id, 20)
		net.Send(ply)

	elseif(target.base == "base_credstick") then
		net.Start("CredSplitC")
		net.WriteInt(item.id, 20)
		net.WriteInt(target.id, 20)
		net.Send(ply)
		
	end

end
]]

--[[
ITEM.functions.--combine = {
    name = "Combine",
    tip = "Equip to active weapon",
    icon = "icon16/wrench.png",
    --sound = "", --like this
    onRun = function(item, id)
        local target = nut.item.instances[id]
        local ply = item.player

		if(id and target) then
			if(target.base == "base_npda" and target:getData("money")) then
				net.Start("CredSplitC")
				net.WriteInt(item.id, 20)
				net.WriteInt(target.id, 20)
				net.Send(item.player)

			elseif(target.base == "base_credstick") then
				net.Start("CredSplitC")
				net.WriteInt(item.id, 20)
				net.WriteInt(target.id, 20)
				net.Send(item.player)
				
			end

            return false
        end
    end,
    onCanRun = function(item, id)
        local target = nut.item.instances[id]

        if(id and target) then
            if(!IsValid(item.entity) and (target.base == "base_credstick" or (target.base == "base_npda" and target:getData("money"))) and item:getData("money")) then    
                return true
            end
        end

        return false
    end
}]]--[[
ITEM.functions.Ejectslot = {
	name = "Eject Credstick",
	tip = "unload",
	icon = "icon16/cd_eject.png",
	onRun = function(item)
		local target = item:getData("credtype")
		local succ, err = item.player:getChar():getInv():add(target, 1, {money = item:getData("money")})
		if(!succ) then
			item.player:notify(err)
		end
		item:setData("money", nil, player.GetAll())
		item:setData("credtype", nil)

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and (item:getData("credtype") != nil))
	end
}]]

ITEM.functions.open = {
    name = "Open PDA",
    tip = "Open the GUI for this PDA.",
    icon = "icon16/connect.png",
    onRun = function(item)
        net.Start("OpenPDA")
        net.WriteInt(item:getData("simid"), 20)
        net.WriteInt(item.id, 32)
        net.Send(item.player)

        return false
    end,
    onCanRun = function(item)
        return !IsValid(item.entity)
    end
}

ITEM.functions.toggle = {
    name = "Toggle Power",
    tip = "turn off/on",
    icon = "icon16/drive_edit.png",
    onRun = function(item)
        local val = !item:getData("isoff", false)
        item:setData("isoff", val)

        item.player:notify("PDA is now "..val and "off" or "on")

        return false
    end,
	onCanRun = function(item)
		return !IsValid(item.entity)
        --[[local char
        if(item.player) then
            char = item.player:getChar()
        else
            char = LocalPlayer():getChar()
        end

        return char:hasFlags("Z")]]
    end
}
ITEM.functions.zfindid = {
    name = "Find ID",
    tip = "Find ID of PDA",
    icon = "icon16/drive_edit.png",
    onRun = function(item)
        item.player:notify("ID of pda: "..tostring(item:getData("simid")))
        return false
    end,
	onCanRun = function(item)
		return !IsValid(item.entity)
        --[[local char
        if(item.player) then
            char = item.player:getChar()
        else
            char = LocalPlayer():getChar()
        end

        return char:hasFlags("Z")]]
    end
}
--[[
ITEM.functions.simhack = {
    name = "SIM Card Hack",
    tip = "Modify properties of a SIM Card.",
    icon = "icon16/drive_edit.png",
    onRun = function(item)
        return false
    end,
    onCanRun = function(item)
        return item.player:IsAdmin()
    end
}
]]
function ITEM:onInstanced()
    local sims = nut.plugin.list["pda"]:GetSimList()
    local num = math.random(111111,999999)
    for k, v in pairs(sims) do
        if(v == num) then --if the number happens to be an existing one
            num = math.random(111111,999999) --random another one
        end
    end
    self:setData("simid", num)

    local handle = "invalid"

    self:setData("pdahandle", handle)
    self:setData("pdablocked", "")
end

function ITEM:GetPDAData()
    local tab = {}
    tab.Handle = self:getData("pdahandle", "invalid")
    tab.Blocked = self:getData("pdablocked", "")

    --should auto setup data before it can error
    --is this even needed? idk
    if(!self:getData("pdahandle")) then
        self:setData("pdahandle", "invalid")
    elseif(!self:getData("pdablocked")) then
        self:setData("pdablocked", "")
    elseif(!self:getData("simid")) then
        local sims = nut.plugin.list["pda"]:GetSimList()
        local num = math.random(111111,999999)
        for k, v in pairs(sims) do
            if(v == num) then --if the number happens to be an existing one
                num = math.random(111111,999999) --random another one
            end
        end
        self:setData("simid", num)
    end

    return self:getData("simid"), tab
end