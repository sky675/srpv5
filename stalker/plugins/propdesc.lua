PLUGIN.name = "Prop Descriptions"
PLUGIN.author = "Blazing & Angelsaur"
PLUGIN.desc = "Set descriptions for props."

--saving via permaprops
if(SERVER and PermaProps) then
	local function save(ent)
		local content = {}
		content.Other = {desc = ent:getNetVar("exDesc")}

		return content
	end
	local function spawn(ent, data)
		if !data or !istable( data ) then 
			ent:Spawn()
			return 
		end

		ent:Spawn()

		if(data.desc) then
			ent:setNetVar("exDesc", data.desc)
		end
	end

	PermaProps.SpecialENTSSave["prop_physics"] = save
	PermaProps.SpecialENTSSpawn["prop_physics"] = spawn
	PermaProps.SpecialENTSSave["prop_dynamic"] = save
	PermaProps.SpecialENTSSpawn["prop_dynamic"] = spawn
end

nut.command.add("propdesc", {
	syntax = "<string description>",
	onRun = function(client, arguments)
		local objdesc = arguments[1];
		local ent = client:GetEyeTrace().Entity

		if (!arguments[1]) then
			ent:setNetVar("exDesc", "")		
		end
		
		if (IsValid(ent)) then
		   ent:setNetVar("exDesc", objdesc)
        end
		
	end
})

function PLUGIN:ShouldDrawEntityInfo(entity)

   if (IsValid(entity) and (entity:GetClass("prop_*")) and entity:getNetVar("exDesc", exdesc)) then

       return true
	
   end
end

local drawText = nut.util.drawText
local descInfo = {}
--this is supposed to be outside dummy
local stringFind = string.find
local colorAlpha = ColorAlpha

function PLUGIN:DrawEntityInfo(entity, alpha)

    local exdesc = entity:getNetVar("exDesc")
	
	descInfo = {}
	
	if stringFind(entity:GetClass(), "prop_") then
	
	if (IsValid(entity) and exdesc ) then
	
		if (exdesc != entity.nutDescCache) then
			entity.nutDescCache = exdesc
			entity.nutDescLines = nut.util.wrapText(exdesc, ScrW() * 0.5, "nutSmallFont")
		end
			
		for i = 1, #entity.nutDescLines do
			descInfo[#descInfo + 1] = {entity.nutDescLines[i]}
		end
			
	    local position = entity:LocalToWorld(entity:OBBCenter()):ToScreen()
		local ty = 0
		local x, y = position.x, position.y
		
		-- hook.Run("DrawDescInfo", descInfo)
		
		for i = 1, #descInfo do
			local info = descInfo[i]
			_, ty = drawText(info[1],
				x, y, 
				colorAlpha(color_white,alpha), --why not add the alpha?
	   			1, 1, nil)--"nutSmallFont")
			y = y + ty
			end
		end
	end
end

local entityMeta = FindMetaTable("Entity")

function entityMeta:getExDesc()
	return self:getNetVar("exDesc") 
end