ITEM.name = "hack tool"
ITEM.desc = "a hacking tool lmao"
ITEM.model = "models/nirrti/tablet/tablet_sfm.mdl"
ITEM.price = 20
ITEM.flag = "m"
ITEM.category = "Hacking"
ITEM.noBusiness = true

--todo: max hack level, past that, 
--hacks that are above that have a disadvantage, 
--scaling based on how far above it is,
--todo: programs: items dragged onto this item to give a passive or active in hacking
--variable for max programs, also need ui on hacking tool
--[[
	ITEM.hacklevel = 1 --min trait level required
	ITEM.hackstart = 11 --starting time
	ITEM.hackinc = 10 --time increased by extra first games
	ITEM.hackrange = 500 --range in units of visible hacking objects
	ITEM.maxprograms = 3 --max amount of mountable programs
]]

-- Inventory drawing
if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if (item:getData("equip")) then
			surface.SetDrawColor(110, 255, 110, 100)
			surface.DrawRect(w - 14, h - 14, 8, 8)
		end
	end
end

function ITEM:getDesc()
	local desc = self.desc
	if(self:getData("remote")) then
		desc = desc.."\nThis is connected to remote #"..tostring(self:getData("remote")).."."
	end
	if(self:getData("programs")) then
		local programdata = nut.plugin.list["hacking"].programlist
		desc = desc.."\nEquipped programs:"
		for k,v in pairs(self:getData("programs")) do
			if(programdata[k]) then
				desc = desc.."\n"..programdata[k].name
			end
			
		end
	end
	return desc
end

function ITEM:getSearchPos()
	if(self:getData("remote")) then
		local item = nut.item.instances[self:getData("remote")]
		if(item) then
			--local items = ents.FindByClass("nut_item") 
			local ent = item.entity --woops
			--[[for k,v in pairs(items) do
				if(v.nutItemID == item.id) then
					ent = v
					break
				end
			end]]
			if(IsValid(ent)) then
				if(ent:getNetVar("isjammed")) then
					self:getOwner():notify("There is a jammer nearby the remote.")
				else
					return ent:GetPos()
				end
			elseif(item:getOwner()) then
				if(ent:getNetVar("isjammed")) then
					self:getOwner():notify("There is a jammer nearby the remote.")
				else
					return item:getOwner():GetPos()
				end
			end
		end
	end
	return self:getOwner():GetPos()
end
--function to detach remote hacker
ITEM.functions.detachremote = {
	name = "Detach Remote",
	tip = "unequip the hacktool, where does this even display btw tell me pls",
	icon = "icon16/disconnect.png",
	sound = "labs/ding_off.wav",
	onRun = function(item)
		local target = nut.item.instances[item:getData("remote")]
		if(target) then
			target:setData("remote", nil)
			item:setData("remote", nil)
			item.player:notify("Remote disconnected from tool.")
		end

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("remote") != nil)
	end
}

ITEM.functions.programej ={
	name = "Eject Program", 
	tip = "unload",
	icon = "icon16/cd_eject.png",
	sound = "labs/ding_off.wav",
    isMulti = true,
    multiOptions = function(item, ply)
		local options = {}
		local programdata = nut.plugin.list["hacking"].programlist

		for k,v in pairs(item:getData("programs", {})) do
			table.insert(options, {
				name = programdata[k].name,
				data = k
			})
		end

        return options
    end,
	onRun = function(item, sub)
		--seperate
		local pro = item:getData("programs", {})
		pro[sub] = nil
		item:setData("programs", pro)
		--give item equivalent
		if(nut.plugin.list["hacking"].programlist[sub]) then
			item.player:getChar():getInv():add(nut.plugin.list["hacking"].programlist[sub].itemid)
			if(nut.plugin.list["hacking"].programlist[item.programid].onuninstall) then
				nut.plugin.list["hacking"].programlist[item.programid].onuninstall(item)
			end
		end

        return false
	end,
	onCanRun = function(item, sub)
		local ply = item.player
		if(!ply) then ply = LocalPlayer() end
		return (!IsValid(item.entity) and !hackmenu and table.Count(item:getData("programs", {})) != 0) --idk
    end
}

ITEM.functions.Open = {
    name = "Open Hacking Menu",
    tip = "Open the GUI for this PDA.",
    icon = "icon16/connect.png",
    onRun = function(item)
        net.Start("openhkmenu")
        net.Send(item.player)

        return false
    end,
    onCanRun = function(item)
        return (!IsValid(item.entity) and item:getData("equip") == true)
    end
}

ITEM.functions.Equip = {
	name = "Equip",
	tip = "equip the hacktool, where does this even display btw tell me pls",
	icon = "icon16/tick.png",
	sound = "weapons/ins2/uni/uni_weapon_draw_01.wav",
	onRun = function(item)
		if(item.hacklevel > (nut.traits.hasTrait(item.player, "tech_hack") or 0)) then
			item.player:notify("You lack the skill level to use this!", 3)
			return false
		end

		item:setData("equip", true)

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") != true)
	end
}
ITEM.functions.EquipUn = {
	name = "Unequip",
	tip = "unequip the hacktool, where does this even display btw tell me pls",
	icon = "icon16/cross.png",
	sound = "weapons/ins2/uni/uni_weapon_draw_01.wav",
	onRun = function(item)
		item:setData("equip", nil)

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item:getData("equip") == true)
	end
}

function ITEM:onInstanced()
	if(!self:getData("hackstart")) then
		self:setData("hackstart", self.hackstart)
	end
	if(!self:getData("hackinc")) then
		self:setData("hackinc", self.hackinc)
	end
end

function ITEM:onCanBeTransfered(oldInventory, newInventory)
	if (newInventory and self:getData("equip")) then
		return false
	end

	return true
end