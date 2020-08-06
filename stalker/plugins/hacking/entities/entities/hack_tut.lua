AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "Hack Tutorial"
ENT.Category = "OASIS"
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Base = "customhackbase"

ENT.name = "Hacking Practice Machine"
ENT.desc = "A machine made to practice the hacking minigame."
ENT.hackname = function(self) return "tut-"..self:GetCreationID() end --"hack name" --or ENT.hackname = function(self) end
ENT.hacktype = "tutorialmachine" --or ENT.hacktype = function(self) end
ENT.model = "models/nt/props_tech/monitor_wall.mdl"


ENT.hackTypes = {	
	["SecLvl1"] = {
		onRun = function(self, ply)
			ply:notify("The machine prints a 'Success :)' on the screen.")
		end,
		onFail = function(self, ply)
			ply:notify("The machine prints a 'Failure :(' on the screen.")
		end,
		level = 1,
	},
	["SecLvl2"] = {
		onRun = function(self, ply)
			ply:notify("The machine prints a 'Success :)' on the screen.")
		end,
		onFail = function(self, ply)
			ply:notify("The machine prints a 'Failure :(' on the screen.")
		end,
		level = 2,
	},
	["SecLvl3"] = {
		onRun = function(self, ply)
			ply:notify("The machine prints a 'Success :)' on the screen.")
		end,
		onFail = function(self, ply)
			ply:notify("The machine prints a 'Failure :(' on the screen.")
		end,
		level = 3,
	},
	--contains an onRun = function(self, ply), and level = hack type level

} --table of hacks and what theyll do i guess idk, 