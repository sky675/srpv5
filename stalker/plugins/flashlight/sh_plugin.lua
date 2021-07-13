PLUGIN.name = "Flashlight"
PLUGIN.author = "Chessnut"
PLUGIN.desc = "Provides a flashlight item to regular flashlight usage."

--[[ --i decided nvm with flashlight battery
function PLUGIN:InitializedPlugins()
	timer.Create("flashlighttimer", 5, 0, function()
		local plys = player.GetAll()

		for k,ply in pairs(plys) do
		if(ply:FlashlightIsOn()) then
			local inv = ply:getChar():getInv():getItems()
			local item
			for k,v in pairs(inv) do
				if(v:getData("equip")) then
				if(v.uniqueID == "headlamp") then
					item = v
					break
				end
				if(v.uniqueID == "flashlight") then
					item = v
					break
				end
				end
			end
			if(!item) then continue end
			--flashlight battery degredation here
			
		end
		end
	end)
end
]]



function PLUGIN:PlayerSwitchFlashlight(client, state)
	local character = client:getChar()

	if (!character or !character:getInv()) then
		return false
	end

	if(client:getNetVar("isjammed")) then return false end


	--[[if(character:getImplants("implants", "flash")) then--Data("implants", {})["flash"]) then
		return true
	end]]

	if(wep and wep.GetHasFlashlights and wep:GetHasFlashlights()) then
		return false
	end
	
	local item = character:getInv():getFirstItemOfType("headlamp")
	if (item and item:getData("equip")) then --change to false
		return true --let them switch if they have a headlamp and its equipped
	end

	local wep = client:GetActiveWeapon()
	--item = character:getInv():getFirstItemOfType("flashlight")
	if(!wep.TwoHandedWep) then
		for _, item in pairs(character:getInv():getItems()) do
			if (item.uniqueID == "flashlight" and item:getData("equip")) then
				return true
			end
		end
	end
	--[[if(item and item:getData("equip") and !wep.TwoHandedWep) then
		return true
	end]]


	if(wep and ((wep.GetStat and wep:GetStat("HasFlashlight")) or wep.HasFlashlight)) then
		return true --let them switch if the current weapon has a flashlight
	end
	return false
end

function PLUGIN:PlayerSwitchWeapon(client, old, new)
	if(old and (old.GetHasFlashlights and old:GetHasFlashlights()) and new and (new.GetHasFlashlights and new:GetHasFlashlights())) then
		return
	end
	if(old and ((old.GetStat and old:GetStat("HasFlashlight")) or old.HasFlashlight) and new and ((new.GetStat and new:GetStat("HasFlashlight")) or new.HasFlashlight)) then
		return --dont worry about it if both the old and new wep has a flashlight
	end

	local character = client:getChar()
	if(!character) then return end --just dont worry about it lmao
	

	--[[if(character:getImplants("implants", "flash")) then--Data("implants", {})["flash"]) then
		return
	end]]

	local item = character:getInv():getFirstItemOfType("headlamp")
	if (item and item:getData("equip")) then --change to false
		return --if they have headlamp, its ok
	end
	
	item = character:getInv():getFirstItemOfType("flashlight")
	if(item and item:getData("equip") and !new.TwoHandedWep) then
		return
	end

	--hm
	if(SERVER) then
	if(client:FlashlightIsOn()) then --otherwise if its on, turn it off
		client:Flashlight(false) --ik this wont work need new one
	end
	end
end