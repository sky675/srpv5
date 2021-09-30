local PLUGIN = PLUGIN
PLUGIN.name = "Item Return"
PLUGIN.author = "sky"
PLUGIN.desc = "will return items that a player who died picked up in the few minutes to their original position"

if(SERVER) then
	hook.Add("OnItemPickup", "return", function(item, ply, ent)
		if(!IsValid(ply)) then return end
		if(!item) then return end

		//this is uh fine
		ply.lastitems = ply.lastitems or {}
		local id = item.id

		ply.lastitems[id] = ent:GetPos()
		timer.Create("lastpos"..id, 300, 1, function()
			if(!IsValid(ply)) then return end
			if(ply:getNetVar("neardeath")) then return end
			if(!ply.lastitems) then return end
			if(ply.lastitems[id]) then
				ply.lastitems[id] = nil
			end
		end)
	end)

	hook.Add("OnDownedFinish", "returning", function(ply, atk)
		if(ply.lastitems) then
			local cnt = table.Count(ply.lastitems)
			if(cnt == 0) then return end
			nut.log.addRaw(ply:Name().." ("..ply:SteamID()..") died, and "..cnt.." items were returned to where they were when picked up.")
			for k,v in pairs(ply.lastitems) do
				--it does not make it from here to the other print???
				local item = nut.item.instances[k]
				if(!item) then continue end

				local character = ply:getChar()
				--dont have
				if (!character or !character:getInv() or !character:getInv().items[k]) then
					continue
				end
				print(k, v)

				character:getInv():removeItem(k, true)
				item:spawn(v)
			end

			ply.lastitems = nil
		end
	end)
end