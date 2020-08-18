local PLUGIN = PLUGIN

if(SERVER) then
	local refreshfuncs = {
		["equip"] = true,
		["equipun"] = true,
		["drop"] = true,
	}
	hook.Add("OnPlayerInteractItem", "invupdate", function(ply, type, item, result, data)
		print("interact ", type)
		if(refreshfuncs[type:lower()]) then
			netstream.Start(ply, "refreshModel")
		end
	end)

else--client
	netstream.Hook("refreshModel", function()
		if(IsValid(nut.gui.info)) then
			local self = nut.gui.info
			local char = LocalPlayer():getChar()
			
			self.model:SetModel(LocalPlayer():GetModel())
			self.model.Entity:SetSkin(LocalPlayer():GetSkin())

			for k, v in ipairs(LocalPlayer():GetBodyGroups()) do
				self.model.Entity:SetBodygroup(v.id, LocalPlayer():GetBodygroup(v.id))
			end

			local ent = self.model.Entity
			if (ent and IsValid(ent)) then
				local mats = LocalPlayer():GetMaterials()
				for k, v in pairs(mats) do
					ent:SetSubMaterial(k - 1, LocalPlayer():GetSubMaterial(k - 1))
				end
				
				local model = LocalPlayer():GetModel()
				if(self.model.modelcache and self.model.modelcache != 0) then
					for k,v in pairs(self.model.modelcache) do
						v:Remove()
						self.model.modelcache[k] = nil --srsly it doesnt get removed from the table
					end
				end
				if(nut.newchar and nut.newchar.isBM(model)) then

					local top = ClientsideModel(char:getData("gctop", 
						LocalPlayer():isFemale() and defaultfemtop or 
						defaultmaletop))--, RENDERGROUP_OPAQUE)
					--top:Spawn() --spawn here if needed not sure if needed
					top:SetParent(self.model:GetEntity())
					top:AddEffects(EF_BONEMERGE)
					top:SetNoDraw(true) --it does this so..
					top:SetBodygroup(0, char:getData("gtop", 0))
					top:SetSkin(char:getData("gtopskin", 0))
					
					if(char:getData("gbgs", {})["t"]) then
						for k,v in pairs(char:getData("gbgs", {})["t"]) do
							top:SetBodygroup(k, v)
						end
					end
					if(char:getData("gsub", {})["t"]) then
						local mats1 = top:GetMaterials()
						for k,v in pairs(char:getData("gsub", {})["t"]) do
							local mat
							for k2,v2 in pairs(mats1) do
								if(string.find(v2, k)) then
									mat = k2-1
								end
							end
							if(mat) then
								top:SetSubMaterial(mat, v)
							end
						end
					end
					
					self.model.modelcache = self.model.modelcache or {}
					table.insert(self.model.modelcache, top)

	
					local bot = ClientsideModel(char:getData("gcbot", 
						LocalPlayer():isFemale() and defaultfembot or 
						defaultmalebot))--, RENDERGROUP_OPAQUE)
					--bot:Spawn() --spawn here if needed not sure if needed
					bot:SetParent(self.model:GetEntity())
					bot:AddEffects(EF_BONEMERGE)
					bot:SetNoDraw(true) --it does this so..
					bot:SetBodygroup(0, char:getData("gbot", 0))
					bot:SetSkin(char:getData("gbotskin", 0))
					
					if(char:getData("gbgs", {})["b"]) then
						for k,v in pairs(char:getData("gbgs", {})["b"]) do
							bot:SetBodygroup(k, v)
						end
					end
					if(char:getData("gsub", {})["b"]) then
						local mats1 = bot:GetMaterials()
						for k,v in pairs(char:getData("gsub", {})["b"]) do
							local mat
							for k2,v2 in pairs(mats1) do
								if(string.find(v2, k)) then
									mat = k2-1
								end
							end
							if(mat) then
								top:SetSubMaterial(mat, v)
							end
						end
					end

					self.model.modelcache = self.model.modelcache or {}
					table.insert(self.model.modelcache, bot)
					--PrintTable(self.model.modelcache)
					if(defaultbothidden == -1 or LocalPlayer():getChar():getData("gbot", 0) == -1) then
						bot.nodraw = true
					end
					--print("model info test")
				end
			end
		end
	end)

end