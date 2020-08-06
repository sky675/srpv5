AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "Generic Server"
ENT.Category = "OASIS"
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Base = "customhackbase"

ENT.name = "Server"
ENT.desc = "A generic server machine. You may be able to hack it and get information."
ENT.hackname = function(self) return "server-"..self:GetCreationID() end --"hack name" --or ENT.hackname = function(self) end
ENT.hacktype = "storage server" --or ENT.hacktype = function(self) end
ENT.model = "models/nt/props_tech/server_box1.mdl"

local types = {
	{
		"Local Politian Itinerary",
		"This is a local politian's travel plans for the day. Would probably catch a decent price in an auction.",
		{900, 1350},
		{5200, 6400}
	}, --name, desc, pay, time
	{
		"Drug Dealer's Ledger",
		"For whatever reason, this is a local drug dealer's ledger, complete with full names. There's some fairly well-known names on this list. Could probably find a buyer in an auction.",
		{800, 1150},
		{4600, 5600},
	},
	{
		"Leaked Chatlogs",
		"A collection of chatlogs stored on the server for whatever reason. Maybe theres something useful to someone?",
		{650, 1150},
		{5000, 6200},
	},

}

ENT.hackTypes = {	
	["Search"] = {
		onRun = function(self, ply)
			if(self.sdone) then
				ply:notify("You couldn't find anything of use.")
				return
			end
			local random = types[math.random(#types)]
			ply:getChar():getInv():add("payitem", 1, {
				customName = random[1], 
				customDesc = random[2],
				customMdl = "models/items/alyx_emptool_fix.mdl",
				paybase = math.random(random[3][1], random[3][2]),
				selltime = math.random(random[4][1], random[4][2]),
			})
			self.sdone = true
			ply:notify("The search resulted in paydata.")
			
			nut.traits.addXp(ply, "tech_hack", 6)
		end,
		level = 1,
	}
	--contains an onRun = function(self, ply), and level = hack type level

} --table of hacks and what theyll do i guess idk, 