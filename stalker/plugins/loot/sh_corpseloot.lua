local PLUGIN = PLUGIN
--todo split into server and client files

local knifeReq = {
	{--rest
		["arccw_melee_axe"] = true,
		["arccw_melee_cleaver"] = true,
		["arccw_melee_hatchet"] = true,
		["arccw_melee_knifelarge"] = true,
		["arccw_melee_knife_fal"] = true,
		["arccw_melee_knife"] = true,
		["arccw_melee_knife_t"] = true,
		--"arccw_melee_shank",
	},
	{--big
		["arccw_melee_axe"] = true,
		["arccw_melee_cleaver"] = true,
		["arccw_melee_hatchet"] = true,
		["arccw_melee_knifelarge"] = true,
		["arccw_melee_knife_fal"] = true,
		["arccw_melee_knife"] = true,
	}
}

PLUGIN.dropTables = {
	--[[
	["npc_class"] = {
		loot = {
			{"id", 1},
			{"none", 1}
		},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	]]

	["npc_vj_srp_m_boar"] = {
		loot = {
			{"hide_boar", 5},
			{"part_boar", 5},
			{"food_meat_boar", 5},
			{"none", 10},
		},
		knife = 2,
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_flesh"] = {
		loot = {
			{"hide_flesh", 5},
			{"part_flesh", 5},
			{"food_meat_flesh", 5},
			{"none", 10},
		},
		knife = 1,
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_rat"] = {
		loot = {
			{"part_rat", 5},
			{"food_meat_rat", 5},
			{"none", 5},
		},
		knife = 1,
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_zombie"] = {
		loot = {
			{"part_zombie", 5},
			{"ammo_45acp", 2},
			{"ammo_9x19", 2},
			{"ammo_9x18", 2},
			{"ammo_buckshot", 1},
			{"none", 5},
		},
		knife = 1,
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_bloodsucker"] = {
		loot = {
			{"hide_bloodsucker", 5},
			{"part_bloodsucker", 5},
			{"food_meat_bloodsucker", 5},
			{"none", 10},
		},
		knife = 1,
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_dog"] = {
		loot = {
			{"part_dog", 5},
			{"food_meat_dog", 5},
			{"none", 5},
		},
		knife = 1,
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_pseudodog"] = {
		loot = {
			{"hide_pseudodog", 5},
			{"food_meat_pseudodog", 5},
			{"part_pseudofang", 5},
			{"part_pseudotail", 5},
			{"none", 5},
		},
		knife = 1,
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_psydog"] = {
		loot = {
			{"hide_psydog", 5},
			{"food_meat_pseudodog", 5},
			{"part_pseudofang", 5},
			{"part_pseudotail", 5},
			{"part_controller_brain", 3},
			{"none", 5},
		},
		knife = 1,
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_snork"] = {
		loot = {
			{"part_snork_leg", 5},
			{"part_snork_mask", 5},
			{"food_meat_snork", 5},
			{"none", 10},
		},
		knife = 1,
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_m_chimera"] = {
		loot = {
			{"part_chimera", 5}, --theres definitely an item missing
			{"hide_chimera", 5},
			{"food_meat_chimera", 5},
			{"none", 10},
		},
		knife = 2,
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},--need pseudogiant items lol
	
	["npc_vj_srp_anorak_bandit"] = {
		loot = {
			{"ammo_45acp", 3},
			{"ammo_9x19", 3},
			{"ammo_9x18", 2},
			{"ammo_buckshot", 2},
			{"meds_bandage", 3},
			{"medkit", 5},
			{"meds_painkillers", 1},
			--{"generic_mag", 1}, 
			{"patch_bandit", 10}, 
			{"none", 20},
		},
		singleOnly = {
			["patch_bandit"] = true,
		},
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_anorak_rogue"] = {
		loot = {
			{"ammo_45acp", 3},
			{"ammo_9x19", 3},
			{"ammo_9x18", 2},
			{"ammo_buckshot", 2},
			{"meds_bandage", 3},
			{"medkit", 5},
			{"meds_painkillers", 1},
			--{"generic_mag", 1}, 
			{"patch_loner", 10}, 
			{"none", 20},
		},
		singleOnly = {
			["patch_loner"] = true,
		},
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_anorak_duty"] = {
		loot = {
			{"ammo_45acp", 3},
			{"ammo_9x19", 3},
			{"ammo_9x18", 2},
			{"ammo_buckshot", 2},
			{"meds_bandage", 3},
			{"medkit", 5},
			{"meds_painkillers", 1},
			--{"generic_mag", 1}, 
			{"patch_duty", 10}, 
			{"none", 20},
		},
		singleOnly = {
			["patch_duty"] = true,
		},
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_anorak_freedom"] = {
		loot = {
			{"ammo_45acp", 3},
			{"ammo_9x19", 3},
			{"ammo_9x18", 2},
			{"ammo_buckshot", 2},
			{"meds_bandage", 3},
			{"medkit", 5},
			{"meds_painkillers", 1},
			--{"generic_mag", 1}, 
			{"patch_freedom", 10}, 
			{"none", 20},
		},
		singleOnly = {
			["patch_freedom"] = true,
		},
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_anorak_merc"] = {
		loot = {
			{"ammo_45acp", 3},
			{"ammo_9x19", 3},
			{"ammo_9x18", 2},
			{"ammo_buckshot", 2},
			{"meds_bandage", 3},
			{"medkit", 5},
			{"meds_painkillers", 1},
			--{"generic_mag", 1}, 
			{"patch_merc", 10}, 
			{"none", 20},
		},
		singleOnly = {
			["patch_merc"] = true,
		},
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_anorak_mili"] = {
		loot = {
			{"ammo_45acp", 3},
			{"ammo_9x19", 3},
			{"ammo_9x18", 2},
			{"ammo_buckshot", 2},
			{"meds_bandage", 3},
			{"medkit", 5},
			{"meds_painkillers", 1},
			--{"generic_mag", 1}, 
			{"patch_military", 10}, 
			{"none", 20},
		},
		singleOnly = {
			["patch_military"] = true,
		},
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
	["npc_vj_srp_anorak_mono"] = {
		loot = {
			{"ammo_45acp", 3},
			{"ammo_9x19", 3},
			{"ammo_9x18", 2},
			{"ammo_buckshot", 2},
			{"meds_bandage", 3},
			{"medkit", 5},
			{"meds_painkillers", 1},
			--{"generic_mag", 1}, 
			{"patch_mono", 10}, 
			{"none", 20},
		},
		singleOnly = {
			["patch_mono"] = true,
		},
		lootAmt = {1,3},
		durability = {5, 30}, --durability when spawned if weapon or suit (for watever reason)
		randomAmmo = 0, --random ammo amt when spawning, 0 = all ammo, 1 = just mags, 2 = always max
	},
}
local realDropTab = {}
for k,v in pairs(PLUGIN.dropTables) do
	realDropTab[k] = {}
	for k2, v2 in pairs(v.loot) do
		for i=1, v2[2] do
			table.insert(realDropTab[k], v2[1])
		end
	end
end

if(SERVER) then
	--can use disconnect hook to free currently used ents if it becomes an issue
	--prob should anyway tbh

	--use for closing the window without taking anything
	netstream.Hook("stopcorpseloot", function(ply, ent)
		--local ent = Entity(index)
		--make sure we got the right one
			ply.nutShipment = nil
		if(IsValid(ent) and ent.lootusing and table.Count(ent.items) != 0) then
			ent.lootusing = false
			--ply.lootuse = nil
		end
	end)
	/*netstream.Hook("takecorpseloot", function(ply, index, npcClass, loot)
		local ent = Entity(index)
		--make sure we got the right one
		if(IsValid(ent) and ply.lootuse == ent and ent.npcClass == npcClass and ent.lootusing) then
			ent.lootusing = false
			ply.lootuse = nil --unsure if taking single closes the window?

			--check if loot is in the ents tbl
			--then give if so
		end
	end)*/
	netstream.Hook("crpUse", function(client, uniqueID, drop)
		if (client.nextUse and client.nextUse > RealTime()) then
			return
		end
		client.nextUse = RealTime() + .05

		local entity = client.nutShipment
		local itemTable = nut.item.list[uniqueID]

		if (client.shipmentTransaction and client.shipmentTransactionTimeout > RealTime()) then
			return	
		end

		if (itemTable and IsValid(entity)) then
			client.shipmentTransaction = true
			client.shipmentTransactionTimeout = RealTime() + .1

			if (entity:GetPos():Distance(client:GetPos()) > 128) then
				client.nutShipment = nil

				return
			end

			local amount = entity.items[uniqueID]

			if (amount and amount > 0) then
				if (entity.items[uniqueID] <= 0) then
					entity.items[uniqueID] = nil
				end

				local function itemTaken()
					if (IsValid(client)) then
						hook.Run("OnTakeShipmentItem", client, uniqueID, amount)
					end
					
					entity.items[uniqueID] = entity.items[uniqueID] - 1
					if (entity.items[uniqueID] <= 0) then
						entity.items[uniqueID] = nil
					end

					if (table.Count(entity.items) < 1) then
						--entity:GibBreakServer(Vector(0, 0, 0.5))
						entity.lootusing = true
						if(IsValid(client)) then
							netstream.Start(client, "killCrp")
						end
						--entity:Remove()
					end
					
					client.shipmentTransaction = nil
					netstream.Start(client, "takeShp", uniqueID, amount)
				end

				if (drop) then
					--removed the drop button for now so will just leave this
					nut.item.spawn(uniqueID, entity:GetPos() + Vector(0, 0, 16))
					itemTaken()
				else
					local quan = 1
					if(itemTable.base == "base_ammo") then
						--15-30% of the max, 
						--this low becuz the ammo primarily dropped will be pistol, 
						--which is max 50, which would be 8-15
						quan = math.ceil(math.Rand(0.15, 0.3)*itemTable.maxQuantity)
					end
					client:getChar():getInv():add(uniqueID, quan, {})
						:next(function(res)
							if (IsValid(client) and res.error) then
								client:notifyLocalizedL(res.error, 3)
							elseif (not res.error) then
								itemTaken()
							end
						end, function(error)
							client:notifyLocalizedL(error, 3)
							client.shipmentTransaction = nil
						end)
				end
			end
		end
	end)
	netstream.Hook("allcorpseloot", function(ply, index, npcClass)
		local ent = Entity(index)
		--make sure we got the right one
		if(IsValid(ent) and ply.lootuse == ent and ent.npcClass == npcClass and ent.lootusing) then
			ply.lootuse = nil
			--give all loot
		end
	end)
	hook.Add("PlayerUse", "lootuse", function(ply, ent)
		if(ent.npcClass and !ent.lootusing) then
			if(!PLUGIN.dropTables[ent.npcClass]) then return end
			if (ply.nextloot and ply.nextloot > CurTime()) then
				return
			end
			ply.nextloot = CurTime() + 1
			--knife requirements here
			local drop = PLUGIN.dropTables[ent.npcClass]
			if(drop.knife and knifeReq[drop.knife]) then
				if(!IsValid(ply:GetActiveWeapon()) or !knifeReq[drop.knife][ply:GetActiveWeapon():GetClass()]) then
					ply:notify("You don't have the required weapon for harvesting the mutant. (You need a sharp weapon active or a stronger one!)", 3)
					return
				end
			end

			if(!ent.items) then
				--no loot yet, generate table
				local amt = math.random(drop.lootAmt[1], drop.lootAmt[2])
				ent.items = {}
				local sngl = {}
				if(amt != 0) then
					for i = 1, amt do
						local it = table.Random(realDropTab[ent.npcClass])
						if(it == "none") then continue end --dont spawn anything
						if(!nut.item.get(it)) then continue end --invalid
						if(drop.singleOnly and drop.singleOnly[it]) then
							if(sngl[it]) then continue end --prevent multiples
							sngl[it] = true
						end

						if(ent.items[it]) then
							ent.items[it] = ent.items[it] + 1
						else
							ent.items[it] = 1
						end
					end
				end
			end
			ent.lootusing = true 
			--if the table is empty either initially or lootusing was removed for some reason, stop
			if(table.Count(ent.items) == 0) then 
				--todo check actual string used lol
				ply:notify("The corpse has no useful goods on it", 2)
				return 
			end

			ply.nutShipment = ent
			netstream.Start(ply, "gencorpseloot", ent, ent.items, ent.npcClass)
			//ply.lootuse = ent
			print("using")
			--then network to client to generate ui
			//netstream.Start(ply, "gencorpseloot", ent:EntIndex(), ent.npcClass, ent.lootTbl)
			--make sure when the ui is closed it gets networked back to 
			--remove lootusing, however dont do that if its empty or if its empty

			return false
		end
	end)
else
	local imgTbl = {
		--["npc_vj_srp_anorak_rogue"] = "sky/faction_icons/inven_icon/bandit.png",
		["npc_vj_srp_m_zombie"] = "sky/mutant_icons/loot_zombie.png",
		["npc_vj_srp_m_boar"] = "sky/mutant_icons/loot_boar.png",
		["npc_vj_srp_m_flesh"] = "sky/mutant_icons/loot_flesh.png",
		["npc_vj_srp_m_rat"] = "sky/mutant_icons/loot_rat.png",
		["npc_vj_srp_m_bloodsucker"] = "sky/mutant_icons/loot_bloodsucker.png",
		["npc_vj_srp_m_dog"] = "sky/mutant_icons/loot_dog.png",
		["npc_vj_srp_m_pseudodog"] = "sky/mutant_icons/loot_pseudodog.png",
		["npc_vj_srp_m_psydog"] = "sky/mutant_icons/loot_pseudogiant.png",
		["npc_vj_srp_m_snork"] = "sky/mutant_icons/loot_snork.png",
		["npc_vj_srp_m_chimera"] = "sky/mutant_icons/loot_chimera.png",
		["npc_vj_srp_m_pseudogiant"] = "sky/mutant_icons/loot_pseudogiant.png",
	}

	--remember do not start the netstream to remove lootusing if taking all
	netstream.Hook("gencorpseloot", function(entity, items, npcClass)
		nut.gui.shipment = vgui.Create("nutCorpseLoot")
		nut.gui.shipment:setItems(entity, items)
		nut.gui.shipment.npcClass = npcClass
		if(!imgTbl[npcClass]) then
			nut.gui.shipment.img:SetVisible(false)
			nut.gui.shipment:SetSize(460, 360)
		else
			nut.gui.shipment.img:SetImage(imgTbl[npcClass])
		end
		--generate corpse ui
	end)
	netstream.Hook("killCrp", function(name, amount)
		if (nut.gui.shipment and nut.gui.shipment:IsVisible()) then
			nut.gui.shipment:Remove()
		end
	end)
end