local PLUGIN = PLUGIN
PLUGIN.name = "Artifacts"
PLUGIN.author = "sky"
PLUGIN.desc = "artifacts, artifact containers, radiation and other status effects maybe"

nut.util.include("sh_artifacts.lua")
nut.util.include("sh_radiation.lua")

function PLUGIN:InitializedItems()--Plugins()
	for id, data in pairs(self.artItems) do
		local ITEM = nut.item.register(id, "base_artifact", nil, nil, true)
		ITEM.name = data.name
		ITEM.desc = data.desc
		ITEM.model = data.model
		ITEM.skin = data.skin or 0
		ITEM.price = data.price or 0
		ITEM.width = data.width
		ITEM.height = data.height
		ITEM.weight = data.weight
		ITEM.noBusiness = data.noBusiness
		if(data.flag) then
			ITEM.flag = data.flag
		end
		ITEM.artid = data.artid
		ITEM.junkArt = data.junkArt
		ITEM.hasUse = data.hasUse
	end
end

function PLUGIN:GetArtifactItems(client)
	local items = {}
	if(client:getChar()) then
		local inv = client:getChar():getInv()
		for k,item in pairs(inv:getItems()) do
			if(item.base == "base_artcont" and item:getData("equip")) then
				items[item.id] = item
			end
		end
	end
	return (table.Count(items) != 0 and items) or nil
end

hook.Add("CustomArmorResists", "artifacts", function(client, levels)
	local items = PLUGIN:GetArtifactItems(client)
	if(!items or #items == 0) then return end
	for k,v in pairs(items) do
		local vals = v:getData("contain", {})
		for k3,art in pairs(vals) do
			local armor = (ARTIFACT_DESCS[art] or {levels = {}}).levels
			if(!armor) then continue end --just in case
			for k2,v2 in pairs(armor) do
				if(k2 == "spd" or k2 == "stmres") then
					levels[k2] = (levels[k2] or 1)*v2
				elseif(k2 == "nv" or k2 == "hud") then
					if(!levels[k2] or levels[k2] < v2) then --this should never be false but ya
						levels[k2] = v2
					end
				elseif(k2:find("-m")) then
					local real = string.Split(k2, "-")[1]
					levels[k2] = (levels[k2] or 0.01) * v2
				else
					levels[k2] = math.max((levels[k2] or 0) + v2, 0)
				end
			end
		end
	end
end)