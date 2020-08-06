ITEM.name = "Lucky"
ITEM.desc = "ITEM IS LEFT OVER FROM OASIS, SHOULD BE FUNCTIONAL BUT MAY BE DELETED LATER\nA strange syringe. Who knows what will happen when you use it?"
ITEM.price = 500
ITEM.flag = "m"
ITEM.weight = 0.3
ITEM.model = "models/warz/items/syringe.mdl"
ITEM.category = "Medical"
ITEM.functions.Use = {
	sound = "interface/inv_stim_3p2.ogg",
	onRun = function(item)
		local val = 1
		local client = item.player
		
		val = val * nut.traits.getMod(client, "actiontime")

		client:setAction("Using...", val, function(client)
			local rng = math.random(1,8) --todo better way?

			if(rng == 1) then --nothing
				--client:notify("It seemed to have no effect.")
			elseif(rng == 2) then --remove a small amt from an attrib
				local atts = {"end", "stm", "qkn", "str"}
				local chose = atts[#atts]
				local attrib = client:getChar():getAttrib(chose, 0)

				if(attrib != 0) then
					local torem = math.Rand(0.5,5)
					if(attrib < torem) then
						torem = attrib --they have less than this so just set it to that
					end
					client:getChar():updateAttrib(chose, -(torem))
				end
			elseif(rng == 3) then --add a small amt to an attrib
				local atts = {"end", "stm", "qkn", "str"}
				local chose = atts[#atts]
				--local attrib = client:getChar():getAttrib(chose, 0)

				--if(attrib != 0) then
					local torem = math.Rand(0.5,5)
					
					client:getChar():updateAttrib(chose, torem)
				--end
			elseif(rng == 4) then --remove small amt but as a boost
				local atts = {"end", "stm", "qkn", "str"}
				local chose = atts[#atts]
				local attrib = client:getChar():getAttrib(chose, 0)

				if(attrib != 0) then
					local torem = math.Rand(0.5,5)
					if(attrib < torem) then
						torem = attrib --they have less than this so just set it to that
					end
					local id = item.id
					client:getChar():addBoost("rng"..id, chose, -(torem))
					local charid = client:getChar():getID()
					local char = client:getChar()
					timer.Simple(math.random(30,300), function()
						if(IsValid(client) and char) then
							char:removeBoost("rng"..id, chose)
						end
					end)
				end
			elseif(rng == 5) then --add small amt but as a boost
				local atts = {"end", "stm", "qkn", "str"}
				local chose = atts[#atts]
				--local attrib = client:getChar():getAttrib(chose, 0)

				--if(attrib != 0) then
					local torem = math.Rand(0.5,5)
					local id = item.id
					
					client:getChar():addBoost("rng"..id, chose, torem)

					local charid = client:getChar():getID()
					local char = client:getChar()
					timer.Simple(math.random(30,300), function()
						if(IsValid(client) and char) then
							char:removeBoost("rng"..id, chose)
						end
					end)
				--end
			elseif(rng == 6) then --deal damage
				client:TakeDamage(math.random(10,25), client)
			elseif(rng == 7) then --heal damage
				client:SetHealth(math.Clamp(client:Health()+math.random(10,25), 0, 100))
			elseif(rng == 8) then --make them deal damage to themself after time, 
				--should cause down
				client:TakeDamage(150, client)
				nut.log.addRaw(client:Name().." died because of the lucky drug")
			end

			item:remove()
		end)
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)
	end
}
ITEM.flag = "m"