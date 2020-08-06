AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "SectCom Security Database"
ENT.Category = "OASIS"
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Base = "customhackbase"

ENT.name = "SectCom Security Database"
ENT.desc = "SectCom's local database. You can hack this and wipe their database, resetting everyone's wanted level"
ENT.hackname = function(self) return "sdb-"..self:GetCreationID() end --"hack name" --or ENT.hackname = function(self) end
ENT.hacktype = "database server" --or ENT.hacktype = function(self) end
ENT.model = "models/nt/props_tech/server_cabinet01.mdl"

local function shuffle(tbl)
	local size = #tbl
	for i = size, 1, -1 do
	  local rand = math.random(size)
	  tbl[i], tbl[rand] = tbl[rand], tbl[i]
	end
	return tbl
end

ENT.hackTypes = {	
	["Wipe"] = {
		onRun = function(self, ply)
			if(self.fdone) then
				ply:notify("The server is in lockdown, you cannot access it.")
				return
			end

			self.fdone = true
			ply:notify("The database has appeared to have been wiped.")
			
			nut.traits.addXp(ply, "tech_hack", 4)
			
			timer.Simple(1200, function()
				self.fdone = false
			end)
			
			for k,v in pairs(player.GetAll()) do
				if(IsValid(ply) and ply:getChar()) then
					ply:getChar():setVar("wanted", nil)
					ply:getChar():setVar("wantedtime", nil)
				end
			end
			
			ply:getChar():setVar("wanted", true)
			ply:getChar():setVar("wantedtime", CurTime()+1200)
			
		local chardata = ply:getChar():getData()
		GLOBAL_WANTED = GLOBAL_WANTED or {}
		GLOBAL_WANTED[ply:getChar():getID()] = {
			["gtop"] = chardata["gtop"],
			["gbot"] = chardata["gbot"],
			["gctop"] = chardata["gctop"],
			["gcbot"] = chardata["gcbot"],
			["gtopskin"] = chardata["gtopskin"],
			["gbotskin"] = chardata["gbotskin"],
		}
		local bgs = ply:GetBodyGroups() or {}
		for k,v in pairs(bgs) do
			if(v.name == "masks") then
				GLOBAL_WANTED[ply:getChar():getID()]["masked"] = ply:GetBodygroup(v.id)
				break
			end
		end

		timer.Create(ply:getChar():getID().."wanted", 1200, 1, function()
			if(IsValid(ply) ) then
				ply:getChar():setVar("wanted", nil)
				ply:getChar():setVar("wantedtime", nil)
			end
		end)

		local tmpspawns = shuffle(table.Copy(wantedspawns))
		for i=1, 2 do
			local spwn = tmpspawns[i]
			
			local np = ents.Create("npc_vj_sec_normal_neut")
			if(np) then
				np:SetPos(spwn[1])
				np:SetAngles(spwn[2])
				local SpawnFlags = bit.bor( SF_NPC_FADE_CORPSE, SF_NPC_ALWAYSTHINK )
				np:SetKeyValue( "spawnflags", SpawnFlags )
				np:Spawn()
				np:Activate() --just in case
				if(np.ComeonSound) then if(np.ComeonSound) then np:ComeonSound() end end
				np.dontspawn = true
				if(list.Get("NPC")[np:GetClass()]) then
					local lis = list.Get("NPC")[np:GetClass()].Weapons
					if(lis) then
						np:Give(lis[math.random(#lis)])
					end
				end
				timer.Simple(1800, function()
					if(IsValid(np) and IsValid(np:GetEnemy())) then
						np:Remove()
					end
				end)

				local unlucky = ply

				--make them move onto the map by going to a random players position, 
				--theres a complete chance that they wont meet anyone during that time but whatever
				np:StopMoving()
				np:SetLastPosition(self:GetPos())
				if np.IsVJBaseSNPC == true && (np.IsVJBaseSNPC_Creature == true or np.IsVJBaseSNPC_Human == true) then
					np:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")--[[,function(x) 
						if IsValid(np:GetEnemy()) && np:Visible(v:GetEnemy()) then
							x:EngTask("TASK_FACE_ENEMY", 0) 
							x.CanShootWhenMoving = true 
							x.ConstantlyFaceEnemy = true
						end
					end)]]
				else
					np:SetSchedule(SCHED_FORCED_GO_RUN)
				end
			end
		end
		end,
		onFail = function(self, ply)
			self.fdone = true
			ply:notify("You have been locked out of the server.")
			
			timer.Simple(3000, function()
				self.fdone = false
			end)
			
			ply:getChar():setVar("wanted", true)
			ply:getChar():setVar("wantedtime", CurTime()+1200)

			local chardata = ply:getChar():getData()
			GLOBAL_WANTED = GLOBAL_WANTED or {}
			GLOBAL_WANTED[ply:getChar():getID()] = {
				["gtop"] = chardata["gtop"],
				["gbot"] = chardata["gbot"],
				["gctop"] = chardata["gctop"],
				["gcbot"] = chardata["gcbot"],
				["gtopskin"] = chardata["gtopskin"],
				["gbotskin"] = chardata["gbotskin"],
			}
			local bgs = ply:GetBodyGroups() or {}
			for k,v in pairs(bgs) do
				if(v.name == "masks") then
					GLOBAL_WANTED[ply:getChar():getID()]["masked"] = ply:GetBodygroup(v.id)
					break
				end
			end

		timer.Create(ply:getChar():getID().."wanted", 1200, 1, function()
			if(IsValid(ply) ) then
				ply:getChar():setVar("wanted", nil)
				ply:getChar():setVar("wantedtime", nil)
			end
		end)

		local tmpspawns = shuffle(table.Copy(wantedspawns))
		for i=1, 2 do
			local spwn = tmpspawns[i]
			
			local np = ents.Create("npc_vj_sec_normal_neut")
			if(np) then
				np:SetPos(spwn[1])
				np:SetAngles(spwn[2])
				local SpawnFlags = bit.bor( SF_NPC_FADE_CORPSE, SF_NPC_ALWAYSTHINK )
				np:SetKeyValue( "spawnflags", SpawnFlags )
				np:Spawn()
				np:Activate() --just in case
				if(np.ComeonSound) then if(np.ComeonSound) then np:ComeonSound() end end
				np.dontspawn = true
				if(list.Get("NPC")[np:GetClass()]) then
					local lis = list.Get("NPC")[np:GetClass()].Weapons
					if(lis) then
						np:Give(lis[math.random(#lis)])
					end
				end
				timer.Simple(1800, function()
					if(IsValid(np) and IsValid(np:GetEnemy())) then
						np:Remove()
					end
				end)

				local unlucky = ply

				--make them move onto the map by going to a random players position, 
				--theres a complete chance that they wont meet anyone during that time but whatever
				np:StopMoving()
				np:SetLastPosition(self:GetPos())
				if np.IsVJBaseSNPC == true && (np.IsVJBaseSNPC_Creature == true or np.IsVJBaseSNPC_Human == true) then
					np:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")--[[,function(x) 
						if IsValid(np:GetEnemy()) && np:Visible(v:GetEnemy()) then
							x:EngTask("TASK_FACE_ENEMY", 0) 
							x.CanShootWhenMoving = true 
							x.ConstantlyFaceEnemy = true
						end
					end)]]
				else
					np:SetSchedule(SCHED_FORCED_GO_RUN)
				end
			end
		end
		end,
		level = 2,
	},
	["WipeStealth"] = {
		onRun = function(self, ply)
			if(self.fdone) then
				ply:notify("The server is in lockdown, you cannot access it.")
				return
			end

			self.fdone = true
			ply:notify("The database has been wiped.")
			
			nut.traits.addXp(ply, "tech_hack", 5)
			
			timer.Simple(1200, function()
				self.fdone = false
			end)
			
			for k,v in pairs(player.GetAll()) do
				if(IsValid(ply) and ply:getChar()) then
					ply:getChar():setVar("wanted", nil)
					ply:getChar():setVar("wantedtime", nil)
				end
			end
		end,
		onFail = function(self, ply)
			self.fdone = true
			ply:notify("You have been locked out of the server.")

			timer.Simple(2400, function()
				self.fdone = false
			end)
		end,
		level = 3,
	}
	--contains an onRun = function(self, ply), and level = hack type level

} --table of hacks and what theyll do i guess idk, 