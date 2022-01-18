PLUGIN.name = "Corpses"
PLUGIN.author = "SuperMicronde, edits by sky"
PLUGIN.desc = "You can search the player corpses for take items and money. you also can like not too :) sometimes it can be just a normal nonlootable corpse"
--so to make you lose stuff with u die, setData("loseitems", true) on char

//Items that you dont want to be put in the corpse when you die
local BLACKLIST = {												
	"cid", // Dont forget the "," !		
	"imp_main",
	"pda",
	"monopda",
	"sep_both_cranspec"					
}																
							--1 hr :)
nut.config.add("corpseTimer", 3600, "After how many time the corpses disappear.", nil, {
	data = {min = 0, max = 86400},
	category = "server",
	default = 3600,
	value = 3600,
})

nut.config.add("corpseOpenTime", 5, "How much time for search a corpse.", nil, {
	data = {min = 0, max = 20},
	category = "server",
	default = 5,
	value = 5,
})

local entMeta = FindMetaTable("Entity")

// Shared util functions

function entMeta:isNutCorpse()
	return self:GetNWInt("nut_inventoryID", -1) > 0
end

nut.command.add("corpsesclean", {
	superAdminOnly = true,
	onRun = function (client, arguments)
		for k, ent in pairs( ents.FindByClass( "prop_ragdoll" ) ) do
			if ent:isNutCorpse() then
				ent:Remove()
			end
		end
		client:notify("Cleanup done !")
	end
})

if(SERVER)then
	
// Util functions

local function isOnBlacklist(item)
	return table.HasValue( BLACKLIST, item )
end

function entMeta:generateBonesData()

	local data = {}

	for i = 0, self:GetPhysicsObjectCount() - 1 do
		data[i] = {}
		data[i].pos, data[i].ang = self:GetBonePosition(self:TranslatePhysBoneToBone(i))
	end
	
	return data

end

// Money functions

local function addReserve(amt, ragdoll)
	ragdoll:SetNWInt("corpseMoney", ragdoll:GetNWInt("corpseMoney") + amt)
end

local function takeReserve(amt, ragdoll)
	addReserve(-amt, ragdoll)
end

// Ragdoll creation functions

function entMeta:updateBones(playerDead, velocity, data)
	for i = 0, self:GetPhysicsObjectCount() - 1 do
		local physObj = self:GetPhysicsObjectNum(i)

		if (IsValid(physObj)) then
			if velocity then
				physObj:SetVelocity(velocity)
			end

			local index = self:TranslatePhysBoneToBone(i)

			if (index) then
				local position, angles = nil
				
				if playerDead then
					position, angles = playerDead:GetBonePosition(index)
				else
					if data then
						position = data[i].pos
						angles = data[i].ang
					end
				end
				
				if position then
					physObj:SetPos(position)
				end
				
				if angles then
					physObj:SetAngles(angles)
				end
			end
		end
	end
end

function entMeta:setBodygroups(bodygroups, ply)
	for k,v in pairs(bodygroups) do
		self:SetBodygroup(k, v)
	end
	--ill set these here too lmao
	local char = ply:getChar()
	local mats = self:GetMaterials()
	for k,v in pairs(char:getData("submat", {})) do
		local mat
		for k2,v2 in ipairs(mats) do
			if(string.find(v2, k)) then
				mat = k2-1
			end
		end
		if(mat) then
			self:SetSubMaterial(mat, v)
		end
	end
	char:setData("submat") --reset it here

	
	local mat = {}
	for k,v in pairs(mats) do
		if(string.find(v, "eyeball_l")) then
			mat[#mat+1] = {mat = k-1, type = "l"}
		end
		if(string.find(v, "eyeball_r")) then
			mat[#mat+1] = {mat = k-1, type = "r"}
		end
	end

	if(char:getData("eyes")) then
		if(char:getData("eyes") == "blue") then
			for k,v in pairs(mat) do
				self:SetSubMaterial(v.mat, v.type == "l" and "models/bloo_ltcom_zel/citizens/eyeball_l_blue" or "models/bloo_ltcom_zel/citizens/eyeball_r_blue")
			end
		elseif(char:getData("eyes") == "green") then
			for k,v in pairs(mat) do
				self:SetSubMaterial(v.mat, v.type == "l" and "models/bloo_ltcom_zel/citizens/eyeball_l_green" or "models/bloo_ltcom_zel/citizens/eyeball_r_green")
			end
		else
			for k,v in pairs(mat) do
				self:SetSubMaterial(v.mat)
			end
		end
	else
		for k,v in pairs(mat) do
			self:SetSubMaterial(v.mat)
		end
	end
end

function createRagdoll(ragdollData, vel, ply)
	local ragdoll = ents.Create("prop_ragdoll")
	ragdoll:SetNWString("nut_inventoryOwner", ragdollData[1])
	ragdoll:SetMaterial(ragdollData[2])
	ragdoll:SetAngles(ragdollData[3])
	ragdoll:SetColor(ragdollData[4])
	ragdoll:SetModel(ragdollData[5])
	ragdoll:SetSkin(ragdollData[6])
	ragdoll:SetPos(ragdollData[7])
	ragdoll:SetVar("time", ragdollData[8])
	ragdoll:SetNWInt("nut_inventoryID", ragdollData[9])
	ragdoll:SetNWInt("corpseMoney", ragdollData[10])
	ragdoll:SetNWInt("corpseInvH", ragdollData[11])
	ragdoll:SetNWInt("corpseInvW", ragdollData[12])
	ragdoll:SetVar("allBodyGroupsCorpses", ragdollData[13])
	ragdoll:setBodygroups(ragdollData[13], ply)
	ragdoll:Spawn()
	ragdoll:updateBones(ply, vel, ragdollData[14])
	ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON) --better than player tbh
	if(SERVER) then hook.Run("OnCorpseCreated", ragdoll, ply) end
		
	if (ply && IsValid(ply)) then

		ragdoll:SetVar("player", ply)

		ragdoll:CallOnRemove("fixer", function()
					
			if (IsValid(ragdoll:GetVar("player", nil))) then

				ragdoll:GetVar("player"):setLocalVar("ragdollEntNsCorpses", ragdoll)
				ragdoll:SetVar("player", nil)

			end
						
		end)

		ply:setLocalVar("ragdollEntNsCorpses", ragdoll:EntIndex())

	end
end

// Server/Client communication

netstream.Hook("askOpenToServer", function(client, index, ownerName, ragdollEnt)
	if !nut.item.inventories[index] then
		nut.item.restoreInv(index, ragdollEnt:GetNWInt("corpseInvW"), ragdollEnt:GetNWInt("corpseInvH"))
	end
	
	nut.item.inventories[index]:sync(client)
	
	local corpseOpenTime = nut.config.get("corpseOpenTime")
	
	client:setAction("Searching...", corpseOpenTime)
	client:doStaredAction(ragdollEnt, function() if IsValid(ragdollEnt) then
		netstream.Start(client, "corpseInvSynced", index, ownerName, ragdollEnt)
		end end, corpseOpenTime, function()
		if (IsValid(client)) then
			client:setAction()
		end		
	end)
end)

netstream.Hook("BankTakeMoneyCorpse", function(client, value, ragdoll)
	if IsValid(ragdoll) && ragdoll:GetNWInt("corpseMoney") >= value then
		client:getChar():giveMoney(value)
		takeReserve(value, ragdoll)
	end
end)
	
netstream.Hook("BankGiveMoneyCorpse", function(client, value, ragdoll)
	if IsValid(ragdoll) && client:getChar():getMoney() >= value then
		client:getChar():takeMoney(value)
		addReserve(value, ragdoll)
	end
end)

// Creating a ragdoll when a player die

function PLUGIN:PlayerDeath(victim, inflictor, attacker)
	
	if victim:getChar() then
		local OldRagdoll = victim:GetRagdollEntity()
		if ( OldRagdoll && OldRagdoll:IsValid() ) then OldRagdoll:Remove() end
		
		if(victim:getChar():getData("loseitems")) then
		local victimInv = victim:getChar():getInv()
		nut.inventory.instance("grid", {w = victimInv:getWidth(), h = victimInv:getHeight()}, function(inventory)

			local groups = table.Copy(victim:getChar():getData("groups", {}))
			

			for k, slot in pairs(victimInv.slots) do
				for key, itm in pairs(slot) do
					if(itm.onCorpseTrans) then
						itm:onCorpseTrans(inventory)
					end
					if !isOnBlacklist(itm.uniqueID) then
						if(itm:getData("equip")) then
						if(itm.functions.deathun) then
							itm.player = victim
							itm.functions.deathun.onRun(itm)
							itm.player = nil
						elseif itm.functions.EquipUn then
							itm.player = victim
							itm.functions.EquipUn.onRun(itm)
							itm.player = nil
						end
						end

						
						itm:transfer(inventory:getID(), itm.gridX, itm.gridY)
					end
				end
			end
			victim:getChar():setData("loseitems") --there u go
			
			local ragdollData = {victim:getChar():getName(), victim:GetMaterial(), victim:GetAngles(), victim:GetColor(), victim:GetModel(), victim:GetSkin(), victim:GetPos(), 0, inventory:getID(), 0, inventory.h, inventory.w, groups}--GetBodyGroups()}
			createRagdoll(ragdollData, victim:GetVelocity(), victim)
		end)
		else
			local groups = table.Copy(victim:getChar():getData("groups", {}))
			
			local ragdollData = {victim:getChar():getName(), victim:GetMaterial(), victim:GetAngles(), victim:GetColor(), victim:GetModel(), victim:GetSkin(), victim:GetPos(), 0, 0, 0, 0, 0, groups}--GetBodyGroups()}
			createRagdoll(ragdollData, victim:GetVelocity(), victim)
			
		end
		

	end
	
end

// Removing inventory from Database when the corpse is removed

hook.Add("EntityRemoved", "remove_inv_from_db_corpse", function(ent)
	if ent:GetClass() == "prop_ragdoll" && ent:GetNWInt("nut_inventoryID", -1) > 0 then
		local index = ent:GetNWInt("nut_inventoryID")

		if (!nut.shuttingDown and !ent.nutIsSafe and index) then
			local item = nut.item.inventories[index]

			if (item) then
				nut.item.inventories[index] = nil
				nut.db.query("DELETE FROM nut_items WHERE _invID = "..index)
				nut.db.query("DELETE FROM nut_inventories WHERE _invID = "..index)
			end
		end
	end
end)

// Decomposition system

local nextUpdate = 0

hook.Add("Think", "supprimer_le_corps", function()
	if CurTime() > nextUpdate then
		nextUpdate = CurTime() + 1
		for k, v in pairs(ents.FindByClass( "prop_ragdoll" )) do
			if v:GetVar( "time" ) then
				v:SetVar("time", v:GetVar( "time" ) + 1)
				if v:GetVar( "time" ) >= nut.config.get("corpseTimer") then
					v:Remove()
				end
			end
		end
	end
end)

end

if(CLIENT)then

	local inventory = nil
	local name = nil
	local showHud = nil
	local inventoryMoney = nil
	local ragdollEntity = nil
	
	// Hud painting with died player information
	
	hook.Add("HUDPaint", "corpse_hud_nut1.1", function()
		if LocalPlayer():getChar() && LocalPlayer():Alive() then
			local eyeTrace = LocalPlayer():GetEyeTraceNoCursor().Entity
			if IsValid(eyeTrace) && eyeTrace:GetClass() == "prop_ragdoll" && eyeTrace:GetNWInt("nut_inventoryID", -1) > 0 && LocalPlayer():GetPos():Distance( eyeTrace:GetPos()) < 60 then
				inventory = eyeTrace:GetNWInt("nut_inventoryID")
				name = eyeTrace:GetNWString("nut_inventoryOwner")
				ragdollEntity = eyeTrace
				// HUD
				if 	showHud != false then
					surface.SetFont( "CenterPrintText" )
					surface.SetTextColor( 255, 255, 255 )
					local invOwnerID = eyeTrace:GetNWInt("nut_inventoryID")
					local invOwner = eyeTrace:GetNWString("nut_inventoryOwner")
					local textToDraw = ""
					
					if LocalPlayer():getChar().doesRecognize then
						if LocalPlayer():getChar():doesRecognize(invOwnerID) then
							textToDraw = invOwner
						else
							textToDraw = L("noRecog")
						end
					else
						textToDraw = invOwner
					end
					
					local xSize, ySize = surface.GetTextSize( textToDraw )
					surface.SetTextPos( (ScrW() / 2) - (xSize / 2), (ScrH() / 2) - (ySize / 2) - ScrH() * 0.035)
					surface.DrawText( textToDraw )
				
					surface.SetFont( "Trebuchet24" )
					//surface.SetTextColor( 156, 56, 58 ) Bug de transparence
					textToDraw = "Search: \""..string.upper( input.LookupBinding( "+use" ) ).."\""
					xSize, ySize = surface.GetTextSize( textToDraw )
					surface.SetTextPos( (ScrW() / 2) - (xSize / 2), (ScrH() / 2) - (ySize / 2) + ScrH() * 0.035)
					surface.DrawText( textToDraw )
				end
			else
				inventory = nil
				inventoryMoney = nil
				name = nil
				ragdollEntity = nil
			end
		end
	end)
	
	// Corpse menu
	
	local function displayInventory(inventoryId, ownerName, ragdollEnt)
		nut.gui.inv1 = vgui.Create("nutInventory")
		nut.gui.inv1:ShowCloseButton(true)

		local inventory2 = LocalPlayer():getChar():getInv()

		if (inventory2) then
			nut.gui.inv1:setInventory(inventory2)
		end

		safebox_menuINV = vgui.Create("nutInventory")
		safebox_menuINV:ShowCloseButton(true)
		
		local title = nil
		
		if LocalPlayer():getChar().doesRecognize then
			if LocalPlayer():getChar():doesRecognize(inventoryId) then
				title = ownerName
			else
				title = L("noRecog")
			end
		else
			title = ownerName
		end
		
		safebox_menuINV:SetTitle(title)
		safebox_menuINV:setInventory(nut.item.inventories[inventoryId])
		safebox_menuINV:MoveRightOf(nut.gui.inv1, 4)

		safebox_menuINV.OnClose = function(this)
			if (IsValid(nut.gui.inv1) and !IsValid(nut.gui.menu)) then
				nut.gui.inv1:Remove()
			end
		end
		
		local oldClose = nut.gui.inv1.OnClose
		nut.gui.inv1.OnClose = function()
			if (IsValid(safebox_menuINV) and !IsValid(nut.gui.menu)) then
				safebox_menuINV:Remove()
			end
			nut.gui.inv1.OnClose = oldClose
		end

        nut.gui["inv"..inventoryId] = safebox_menuINV
        local text = nut.gui.inv1:Add("DLabel")
        text:SetText("")
		text.Think = function()
			if LocalPlayer():getChar() && IsValid(ragdollEnt) then
				--text:SetText(nut.currency.get(LocalPlayer():getChar():getMoney()))
			else
				nut.gui.inv1:Remove()
				safebox_menuINV:Remove()
			end
		end
		text:Dock(BOTTOM)
		text:DockMargin(0, 0, 0, 0)
		text:SetTextColor(color_white)
		text:SetFont("nutGenericFont")
	end
	
	// Server/Client communication
	
	netstream.Hook("corpseInvSynced", function(index, ownerName, ragdollEnt)
		displayInventory(index, ownerName, ragdollEnt )
	end)
	
	// Open menu when Use key is pressed

	hook.Add( "Tick", "CheckPlayer1Forward", function()
		if IsValid(LocalPlayer()) && inventory && LocalPlayer():Alive() then
			if (LocalPlayer():KeyPressed( IN_USE )) then
				netstream.Start("askOpenToServer", inventory, name, ragdollEntity)
			end
		end
	end )
	
end

// Black Tea is a sushi --i agree but so are you for using // comments in lua