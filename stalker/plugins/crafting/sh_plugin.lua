local PLUGIN = PLUGIN
PLUGIN.name = "Crafting/Junk"
PLUGIN.author = "sky"
PLUGIN.desc = "junk items and crafting systems"


nut.util.include("sh_config.lua")
nut.util.include("sh_massitems.lua")

if(SERVER) then
	util.AddNetworkString("StartCraft")
	util.AddNetworkString("OpenCraft")

	net.Receive("StartCraft", function(len, ply)
		local itemTable = PLUGIN.recipeList[net.ReadString()]
		local ent = net.ReadEntity()

		if(itemTable.timed and !ent:IsWorld()) then
			local val = itemTable.timed.time
			val = val * nut.traits.getMod(ply, "actiontime")
			ply:setAction(itemTable.timed.action, val, function(ply)
				
				if(ent and ply:GetPos():DistToSqr(ent:GetPos()) < 2400) then --idk
					local succ, pickeditem = PLUGIN:canCreate(ply, itemTable)
				
					if(succ) then
						PLUGIN:craft(ply, itemTable, pickeditem)
					else
						--play sound or something?
					end
				else
					ply:notify("You are too far away from the crafting bench.", 3)
				end
			end)
		else
			local succ, pickeditem = PLUGIN:canCreate(ply, itemTable)

			if(succ) then
				PLUGIN:craft(ply, itemTable, pickeditem)
			else
				--play sound or something?
			end
		end
	end)

function PLUGIN:canCreate(ply, recipee)
	local recipe = table.Copy(recipee)
	--check for flag (should have already been but doing it again just to be safe)
	local char = ply:getChar()
	if(recipe.flag) then
		if(char) then
			if(!char:hasFlags(recipe.flag)) then
				ply:notify("You're missing the flag(s) required for this recipe!", 3)
				return false
			end
		end
	end
	--attrib checks
	if(recipe.attribs and char) then
		for k,v in pairs(attribs) do
			if(char:getAttrib(k, 0) < v) then
				ply:notify("You do not have the minimum attributes for this recipe!", 3)
				return false
			end
		end
	end
	if(recipe.traits and char and nut.traits) then
		local traits = char:getTrait()--Data("traits", {})
		for k,v in pairs(traits) do
			local res = nut.traits.hasTrait(ply, k)
			if((type(res) == "number" and res < v) or (type(res) != "number" and res != true)) then
				ply:notify("You do not have the minimum trait requirements for this recipe!", 3)
				return false
			end
		end
	end
	--need requirements?
	if(recipe.requirements) then
		if(char) then
			local items = {}
			local req = recipe.requirements
			for k,v in pairs(char:getInv():getItems()) do
				if(tobool(req[v.uniqueID])) then
					if(type(req[v.uniqueID]) == "number") then
						req[v.uniqueID] = req[v.uniqueID] - 1
					else
						req[v.uniqueID] = false
					end
				end
			end
			for k,v in pairs(req) do
				if(tobool(req[v.uniqueID])) then
					ply:notify("You are missing requirements!", 3)
					return false
				end
			end
		end
	end
	local item, notif = nil, nil
	if(char) then
		item, notif = recipe.handpick(char:getInv():getItems())
		if(!item) then 
			ply:notify(notif or "Cannot find a valid item!", 3)
			return false 
		end
	end
	--need ingredients?
	if(recipe.ingredients) then
		if(char) then
			local items = {}
			local req = recipe.dynamicingredients and recipe.dynamicingredients(item, char) or recipe.ingredients
			for k,v in pairs(char:getInv():getItems()) do
				if(v:getData("equip")) then continue end
				if(tobool(req[v.uniqueID])) then
					if(type(req[v.uniqueID]) == "number") then
						req[v.uniqueID] = req[v.uniqueID] - v:getQuantity()
					else
						req[v.uniqueID] = false
					end
				end
			end
			for k,v in pairs(req) do
				if(type(v) == "number") then
					if(v > 0) then
						ply:notify("You are missing ingredients!", 3)
						return false
					end
				elseif(tobool(v)) then
					ply:notify("You are missing ingredients!", 3)
					return false
				end
			end
		end
	end
	if(recipe.handpick) then
		if(char) then
			if(item) then
				return true, item
			else
				ply:notify(notif or "Cannot find a valid item!", 3)
				return false
			end
		end
	end

	return true
end

function PLUGIN:craft(ply, recipee, pickeditem)
	local recipe = table.Copy(recipee)
	local char = ply:getChar()	
	nut.log.addRaw(ply:Name().." ("..ply:steamName()..") crafted "..recipe.name)

	if(char) then
		local items = {}
		local req = recipe.dynamicingredients and recipe.dynamicingredients(item, char) or recipe.ingredients
		local adddata = {}
		for k,v in pairs(char:getInv():getItems()) do
			if(v:getData("equip")) then continue end
			if(type(req[v.uniqueID]) == "number") then
				local count =  v:getQuantity() - req[v.uniqueID]
				local reqleft = req[v.uniqueID] - v:getQuantity()
				if(reqleft <= 0) then --done
					req[v.uniqueID] = false
					if(count <= 0) then
						v:remove()
					else
						v:setQuantity(count)
					end
				else --continue
					req[v.uniqueID] = reqleft
					--it will always be below 0 so byebye
					v:remove()
				end
				--[[
				if(count <= 0) then

					if(neww <= 0) then --its truely empty
						req[v.uniqueID] = false
						if(new == 0) then
							v:remove()
						else
							v:setQuantity(count) --i think this should work
						end
					else
						req[v.uniqueID] = math.abs(count)
						v:setQuantity(neww)
					end
				else
					req[v.uniqueID] = count
					v:setQuantity(math.abs(count))
				end
				]]
			elseif(tobool(req[v.uniqueID])) then
				if(type(req[v.uniqueID]) == "number") then
					req[v.uniqueID] = req[v.uniqueID] - 1
				else
					req[v.uniqueID] = false
				end
				items[k] = v
			end
		end
		if(recipe.beforeCraft) then
			adddata = recipe.beforeCraft(ply, items, pickeditem)
		end
		for k,v in pairs(items) do
			local rm = v:remove()
			if(!rm) then
				ply:notify("Something went wrong??? with remove")
				return
			end
		end

		if(recipe.addbasedonpick) then
			local toadd, quan = recipe.addbasedonpick(pickeditem)
			local add = char:getInv():add(toadd, quan or 1, recipe.adddata and adddata or nil)
			if(!add) then
				nut.item.spawn(recipe.result, ply:getItemDropPos(), function(item, ent)
					if(recipe.onCreate) then
						recipe.onCreate(ply, item, adddata, it)
					end
				end, nil, recipe.adddata and adddata or nil)
			else
			if(recipe.onCreate) then
				recipe.onCreate(ply, add.value, adddata)
			end
			end
		elseif(type(recipe.result) == "table") then
			local res = recipe.result
			for k,v in pairs(res) do
				if(tonumber(v)) then
					char:getInv():add(k, v)
				else
					char:getInv():add(k)
				end
			end
		elseif(recipe.result) then
			--these might need to be looked at, was made before ns2 (add is a promise now)
			--i changed it to value but may not be enough
			local add = char:getInv():add(recipe.result, 1, recipe.adddata and adddata or nil)
			if(!add) then
				nut.item.spawn(recipe.result, ply:getItemDropPos(), function(item, ent)
					if(recipe.onCreate) then
						recipe.onCreate(ply, item, adddata, it)
					end
				end, nil, recipe.adddata and adddata or nil)
			else
			if(recipe.onCreate) then
				recipe.onCreate(ply, add.value, adddata)
			end
			end
		end
		hook.Run("OnCraftFinish", ply, recipe)
		if(recipe.traits and char and nut.traits) then
			for k,v in pairs(recipe.traits) do --+1 per craft?
				nut.traits.addXp(ply, k, 1)
			end
		end
		ply:notify("Successful!")
	end
end
else
	net.Receive("OpenCraft", function()
		local typ = net.ReadString()
		local ne = net.ReadString()
		local ent = net.ReadEntity()
		local tbl = PLUGIN:getByVisible(typ, LocalPlayer():getChar())

		local craftmenu = vgui.Create("nutCrafting")
		craftmenu.ent = ent
		craftmenu:fill(tbl, ne)
	end)
end

function PLUGIN:getByVisible(workbench, char)
	local gt = {}

	for k,v in pairs(PLUGIN.recipeList) do
		if(v.workbench[workbench]) then
			if(v.flags and !char:hasFlags(v.flags)) then
				continue 
			end
			--this is so i can have unique crafting for me (remake hacktool etc)
			if(v.steamid and char:getPlayer():SteamID() != v.steamid) then
				continue
			end

			gt[k] = v
		end
	end
	
	return gt
end