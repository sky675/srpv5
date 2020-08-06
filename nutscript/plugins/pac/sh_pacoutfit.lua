-- Store pac data from pacoutfit items.
function PLUGIN:setupPACDataFromItems()
	for itemType, item in pairs(nut.item.list) do
		if (istable(item.pacData)) then
			self.partData[itemType] = item.pacData
		end
		if (istable(item.pacF)) then
			self.partData[itemType.."fem"] = item.pacF
		end
		if (istable(item.pacM)) then
			self.partData[itemType.."male"] = item.pacM
		end
	end
end

function PLUGIN:InitializedPlugins()
	timer.Simple(1, function()
		self:setupPACDataFromItems()
	end)
end
