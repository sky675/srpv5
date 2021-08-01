--similar to payitem but it cant be customized
ITEM.name = "run objective"
ITEM.model = "models/props_lab/box01a.mdl"
ITEM.weight = 0
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "obj"
ITEM.flag = "m"
ITEM.category = "misc"
ITEM.onGetDropModel = true
ITEM.data = { customName = ITEM.name, customDesc = ITEM.desc }
ITEM.noBusiness = true
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(326.23556518555, 273.74407958984, 198.58656311035),
	ang = Angle(25, 220, 0),
	fov = 5.2530555555556,
}

ITEM.ignoreStash = true

ITEM.functions.Custom = {
	name = "Customize",
	tip = "Customize this item",
	icon = "icon16/wrench.png",
	onRun = function(item)
		local client = item.player
		client:requestString("Change Name", "What name do you want this item to have?", function(text)
			item:setData("customName", text)
			client:requestString("Change Description", "What Description do you want this item to have?", function(text)
				item:setData("customDesc", text)
				client:requestString("Change Model", "What Model do you want this item to have?\nBe sure it is a valid model.", function(text) --start of model
					item:setData("customMdl", text)
				end, item:getData("customMdl", item.model)) --end of model
			end, item:getDesc()) --end of desc
		end, item:getName()) --end of name
		item:setData("customCreator", client:SteamID64())
			
		--hopefully resets the player's icons
		timer.Simple(0.2, function() 
			client:ConCommand("nut_flushicon")
		end)

		
		return false
	end,
	
	onCanRun = function(item)
		local client = item.player or item:getOwner()
		return client:IsAdmin()
	end
}

ITEM.functions.Creator = {
	name = "Find Creator",
	tip = "Get the SteamID64 of the item creator",
	icon = "icon16/wrench.png",
	onRun = function(item)
		local client = item.player
		local creator = item:getData("customCreator") or nil
		if creator == nil then
			nut.util.notify("No creator logged.")
		else
			nut.util.notify("Item created by: " .. creator)
		end

		return false
	end,

	onCanRun = function(item)
		local client = item.player or item:getOwner()
		return client:IsAdmin()
	end
}

function ITEM:getDesc()
	local desc = self.desc
	
	if(self:getData("customDesc") != nil) then
		desc = self:getData("customDesc")
	end
	
	return Format(desc)
end

function ITEM:getName()
	local name = self.name
	
	if(self:getData("customName") != nil) then
		name = self:getData("customName")
	end
	
	return Format(name)
end

function ITEM:getModel()
	local model = self.model
	
	if(self:getData("customMdl") != nil) then
		model = self:getData("customMdl")
	end
	
	return Format(model)
end

function ITEM:onGetDropModel()
	local model = self.model
	
	if(self:getData("customMdl") != nil) then
		model = self:getData("customMdl")
	end
	
	return Format(model)
end