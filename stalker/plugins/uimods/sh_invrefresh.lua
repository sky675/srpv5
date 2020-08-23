local PLUGIN = PLUGIN
local ipairs = ipairs

if(SERVER) then
	local refreshfuncs = {
		["equip"] = true,
		["equipun"] = true,
		["drop"] = true,
	}
	hook.Add("OnPlayerInteractItem", "invupdate", function(ply, type, item, result, data)
		if(refreshfuncs[type:lower()]) then
			timer.Simple(0, function() netstream.Start(ply, "refreshModel") end)
		end
	end)

else--client
	netstream.Hook("refreshModel", function()
		if(IsValid(nut.gui.info)) then
			local self = nut.gui.info
			local ply = LocalPlayer()
			local char = ply:getChar()
			local modelPanel = self.model
			
			modelPanel:SetModel(ply:GetModel())
			local ent = modelPanel.Entity
			ent:SetSkin(ply:GetSkin())

			for k, v in ipairs(ply:GetBodyGroups()) do
				ent:SetBodygroup(v.id, ply:GetBodygroup(v.id))
			end

			if (ent and IsValid(ent)) then
				local mats = ply:GetMaterials()
				for k, v in ipairs(mats) do
					ent:SetSubMaterial(k - 1, ply:GetSubMaterial(k - 1))
				end
				
				local model = ply:GetModel()
				if(modelPanel.modelcache and modelPanel.modelcache != 0) then
					for k,v in pairs(modelPanel.modelcache) do
						v:Remove()
						modelPanel.modelcache[k] = nil --srsly it doesnt get removed from the table
					end
				end
				if(nut.newchar and nut.newchar.isBM(model)) then

					local top = ClientsideModel(char:getData("gctop", 
						ply:isFemale() and defaultfemtop or 
						defaultmaletop))--, RENDERGROUP_OPAQUE)
					--top:Spawn() --spawn here if needed not sure if needed
					top:SetParent(ent)
					top:AddEffects(EF_BONEMERGE)
					top:SetNoDraw(true) --it does this so..
					top:SetBodygroup(0, char:getData("gtop", 0))
					top:SetSkin(char:getData("gtopskin", 0))
					
					local bgs = char:getData("gbgs", {})
					if(bgs["t"]) then
						for k,v in pairs(bgs["t"]) do
							top:SetBodygroup(k, v)
						end
					end
					local subs = char:getData("gsub", {})
					if(subs["t"]) then
						local mats1 = top:GetMaterials()
						for k,v in pairs(subs["t"]) do
							local mat
							for k2,v2 in ipairs(mats1) do
								if(string.find(v2, k)) then
									mat = k2-1
								end
							end
							if(mat) then
								top:SetSubMaterial(mat, v)
							end
						end
					end
					
					modelPanel.modelcache = modelPanel.modelcache or {}
					table.insert(modelPanel.modelcache, top)

	
					local bot = ClientsideModel(char:getData("gcbot", 
						ply:isFemale() and defaultfembot or 
						defaultmalebot))--, RENDERGROUP_OPAQUE)
					--bot:Spawn() --spawn here if needed not sure if needed
					bot:SetParent(ent)
					bot:AddEffects(EF_BONEMERGE)
					bot:SetNoDraw(true) --it does this so..
					local gbot = char:getData("gbot", 0)
					bot:SetBodygroup(0, gbot)
					bot:SetSkin(char:getData("gbotskin", 0))
					
					if(bgs["b"]) then
						for k,v in pairs(bgs["b"]) do
							bot:SetBodygroup(k, v)
						end
					end
					if(subs["b"]) then
						local mats1 = bot:GetMaterials()
						for k,v in pairs(subs["b"]) do
							local mat
							for k2,v2 in ipairs(mats1) do
								if(string.find(v2, k)) then
									mat = k2-1
								end
							end
							if(mat) then
								top:SetSubMaterial(mat, v)
							end
						end
					end

					modelPanel.modelcache = modelPanel.modelcache or {}
					table.insert(modelPanel.modelcache, bot)
					--PrintTable(modelPanel.modelcache)
					if(defaultbothidden == -1 or gbot == -1) then
						bot.nodraw = true
					end
					--print("model info test")
				end
			end
		end
	end)

end