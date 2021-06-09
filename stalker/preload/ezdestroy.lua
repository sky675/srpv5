PLUGIN.name = "easy destroy"
PLUGIN.author = "sky"
PLUGIN.desc = "some stuff to create deconstruct functions on items easily"

local function destroyRun(item, data)
	if(!data) then return false end

	local ply = item.player

	local nearby = ents.FindInSphere(ply:GetPos(), 300)
	local hasbase = false
	for k,v in pairs(nearby) do
		if(v.Base and v.Base == "sky_crafting_base") then
			hasbase = true
			break
		end
	end
	if(!hasbase) then ply:notify("You need to be near a workbench to deconstruct!", 3) return false end

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

end
local function destroyCanRun(item)
	return !IsValid(item.entity) and item.destroyval != nil and item:getData("equip") != true
end

function EZADDDESTROYFUNC(item)
	if(item.destroyval) then
		item.functions.zdestroy = {	
			name = "Deconstruct",
		    tip = "deconstruct item for parts",
			icon = "icon16/cancel.png",
			isMulti = true,
			multiOptions = {
				{name = "Confirm", data = true},
			},	
			onRun = destroyRun,
			onCanRun = destroyCanRun
		}
	end


	return item
end

hook.Add("OnItemRegistered", "destroyfunction", function(item)
	if(item.destroyval) then
		item.functions.zdestroy = {	
			name = "Deconstruct",
		    tip = "deconstruct item for parts",
			icon = "icon16/cancel.png",
			isMulti = true,
			multiOptions = {
				{name = "Confirm", data = true},
			},	
			onRun = destroyRun,
			onCanRun = destroyCanRun
		}
	end


	return item
end)