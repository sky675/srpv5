ITEM.name = "Drug Base"
ITEM.model = "models/healthvial.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "Makes you love dank memes"
ITEM.category = "Medical"
ITEM.duration = 30
--ITEM.useName = "Use"

-- sorry, for name order.
--something here isnt working right?
ITEM.functions._use = { 
	name = "Use",
	tip = "useTip",
	icon = "icon16/bug.png",
	onRun = function(item)
		local client = item.player
		local char = client:getChar()
		if (char and client:Alive()) then
			if (item.attribBoosts) then
				for k, v in pairs(item.attribBoosts) do
					char:addBoost(item.uniqueID..tostring(item.id), k, v)
				end
			end
			local id = item.id
			local uniq = item.uniqueID

			if(item.funcadd) then
				item:funcadd(char)
			end
			
			local charID = char:getID()
			local name = item.name
			local boosts = item.attribBoosts
			local rem = item.funcremove
			timer.Create("DrugEffect_" .. item.id, item.duration, 1, function()
				if (client and IsValid(client)) then
					local curChar = client:getChar()
					if (curChar and curChar:getID() == charID) then
						client:notify(Format("%s has worn off.", name))

					end
					if(char) then
						if (boosts) then
							for k, v in pairs(boosts) do
								char:removeBoost(item.uniqueID..tostring(id), k)
							end
						end

						if(rem) then
							rem(nil, char, uniq..tostring(id))
						end
					end
				end
			end)
			
			return true
		end

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}