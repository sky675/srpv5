AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "custom hacking test"
ENT.Category = "OASIS"
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Base = "customhackbase"

ENT.name = "in person name"
ENT.desc = "uh description"
ENT.hackname = "hack name" --or ENT.hackname = function(self) end
ENT.hacktype = "hack type" --or ENT.hacktype = function(self) end

ENT.model = "models/props_borealis/bluebarrel001.mdl"
ENT.hackTypes = {	
	["bloop"] = {
		onRun = function(self, ply)
			print("woah")
			print(tostring(self), tostring(ply))
		end,
		level = 1,
	}
	--contains an onRun = function(self, ply), and level = hack type level

} --table of hacks and what theyll do i guess idk, 