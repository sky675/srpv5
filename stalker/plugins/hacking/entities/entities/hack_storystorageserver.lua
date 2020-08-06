AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "Storage Story Server"
ENT.Category = "OASIS"
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Base = "customhackbase"

ENT.name = "Storage Server"
ENT.desc = "A portable storage server used for research outposts. (hint this is the objective)"
ENT.hackname = "kamistorageserver-3" --"hack name" --or ENT.hackname = function(self) end
ENT.hacktype = "high sec storage server" --or ENT.hacktype = function(self) end
ENT.model = "models/nt/props_tech/server_cabinet01.mdl"

ENT.story = true --so theres a reminder on spawn

local types = {
	{
		"Encrypted Files",
		"About half a gig of various files and folders with gibberish names, most of which are encrypted. Those that aren't continually mention a 'Kami' and 'her behavior'.",
	}, --name, desc, pay, time

}

ENT.hackTypes = {	
	["Search"] = {
		onRun = function(self, ply)
			if(self.sdone) then
				ply:notify("You couldn't find anything of use.")
				return
			end
			local random = types[math.random(#types)]
			ply:getChar():getInv():add("run_obj", 1, {
				customName = random[1], 
				customDesc = random[2],
				customMdl = "models/items/alyx_emptool_fix.mdl",
			})
			self.sdone = true
			ply:notify("The search found the objective.")
			nut.traits.addXp(ply, "tech_hack", 15) --bonus xp
		end,
		level = 2,
	}
	--contains an onRun = function(self, ply), and level = hack type level

} --table of hacks and what theyll do i guess idk, 