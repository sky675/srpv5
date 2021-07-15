ITEM.name = "Detonator"
ITEM.desc = "Detonates connected and armed explosives on the ground."
ITEM.weight = 0.2
ITEM.price = 500
ITEM.model = "models/weapons/w_eq_detonator.mdl"
ITEM.flag = "1"
ITEM.category = "misc"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(378.59539794922, 325.91094970703, 240.1305847168),
	ang = Angle(25, 220, 0),
	entAng = Angle(0, 0, 0),
	fov = 0.66153180990191,
}

function ITEM:getDesc()
	local desc = self.desc
	local item = self

	desc = desc.."\nThere are "..table.Count(item:getData("linked", {})).." explosives linked to this detonator."

	return desc
end

function ITEM:onCombineTo(target)
	if(target.uniqueID != "c4" and target.uniqueID != "ied") then return end
	if(target:getData("linked") == true) then return end

	local ply = self.player
	local item = self

	local d = item:getData("linked", {})
	d[target.id] = true
	item:setData("linked", d)
	target:setData("linked", item.id)
	ply:notify("The explosive is now linked to this detonator.")

end
--[[
ITEM.functions.--combine = {
	sound = "weapons/slam/mine_mode.wav",
	onRun = function(item, data)
		local target = nut.item.instances[data]
		local d = item:getData("linked", {})
		d[data] = true
		item:setData("linked", d)
		target:setData("linked", item.id)
		item.player:notify("The explosive is now linked to this detonator.")
		
		return false
	end,
	onCanRun = function(item, data)
		local target = nut.item.instances[data]
		return !IsValid(item.entity) and (target.uniqueID == "c4" and !target:getData("linked"))
	end
}]]
ITEM.functions.Use = {
    icon = "icon16/bomb.png",
	sound = "weapons/slam/buttonclick.wav",
	onRun = function(it)
		local item = it --just in case idk i dont think this is necessary
		if(item.player:getNetVar("isjammed")) then return end

		timer.Simple(2, function()
			local entt = ents.FindByClass("nut_item")
			local torem = {}
			local data = item:getData("linked", {})
			for k,v in pairs(entt) do
				if(data[v.nutItemID]) then
					v:getItemTable():Detonate(v, item)
					torem[v.nutItemID] = true
				end
			end
			for k,v in pairs(torem) do
				if(data[k]) then
					data[k] = nil
				end
			end
			item:setData("linked", data)
		end)

		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)-- and item:getData("linked")
	end
}