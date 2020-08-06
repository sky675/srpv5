local PLUGIN = PLUGIN

PLUGIN.skilllist = {
	--[[
	[""] = {
		name = "",
		desc = "",
		price = 0,
		--model = "",
		skillgive = "",
		skillval = 1,
		skillreq = {[""] = 1}
	},
	]]
	["sb_hack1"] = {
		name = "Hacking Knowledge Level 1",
		desc = "item that gives you hacking level 1, but you wont be able to use higher level skillbooks",
		price = 1400,--800,
		--model = "",
		skillgive = {["tech_hack"] = 1},--, ["gate_hack"] = true},
		skillval = 1,
		skillreq = {}--{[""] = 1}
	},
	["sb_hack2"] = {
		name = "Hacking Knowledge Level 2",
		desc = "item that gives you hacking level 2",
		price = 6900,--3000,
		--model = "",
		skillgive = "tech_hack",
		skillval = 2,
		skillreq = {["tech_hack"] = 1},
		skillconflict = {["gate_hack"] = true},
	},
	["sb_hack3"] = {
		name = "Hacking Knowledge Level 3",
		desc = "item that gives you hacking level 3",
		price = 13500,--6600,
		--model = "",
		skillgive = "tech_hack",
		skillval = 3,
		skillreq = {["tech_hack"] = 2},
		skillconflict = {["gate_hack"] = true},
	},
	["sb_med1"] = {
		name = "Medical Skill Level 1",
		desc = "item that gives you medical skill level 1, but you wont be able to use higher level skillbooks",
		price = 1800,--1200,
		--model = "",
		skillgive = {["tech_med"] = 1, ["gate_med"] = true},
		skillval = 1,
	},
	["sb_med2"] = {
		name = "Medical Skill Level 2",
		desc = "item that gives you medical skill level 2",
		price = 8600,--3200,
		--model = "",
		skillgive = "tech_med",
		skillval = 2,
		skillreq = {["tech_med"] = 1},
		skillconflict = {["gate_med"] = true},
	},
	--[[
	["sb_imp1"] = {
		name = "Cyberware Knowledge Level 1",
		desc = "item that gives you cyberware level 1, requires medical level 2",
		price = 4200,
		--model = "",
		skillgive = {["tech_imp"] = 1},
		skillval = 1,
		skillreq = {["tech_med"] = 2}--{[""] = 1}
	},
	["sb_imp2"] = {
		name = "Cyberware Knowledge Level 2",
		desc = "item that gives you cyberware level 2",
		price = 9600,
		--model = "",
		skillgive = "tech_imp",
		skillval = 2,
		skillreq = {["tech_imp"] = 1},
		--skillconflict = {["gate_imp"] = true},
	},
	["sb_imp3"] = {
		name = "Cyberware Knowledge Level 3",
		desc = "item that gives you cyberware level 3",
		price = 19200,
		--model = "",
		skillgive = "tech_imp",
		skillval = 3,
		skillreq = {["tech_imp"] = 2},
		--skillconflict = {["gate_imp"] = true},
	},]]
	["sb_drone1"] = {
		name = "Drone Knowledge Level 1",
		desc = "item that gives you drones level 1, but you wont be able to use higher level skillbooks",
		price = 2400,
		--model = "",
		skillgive = {["tech_drone"] = 1, ["gate_drone"] = true},
		skillval = 1,
		skillreq = {},--{[""] = 1}
	},
	["sb_drone2"] = {
		name = "Drone Knowledge Level 2",
		desc = "item that gives you drones level 2",
		price = 6800,
		--model = "",
		skillgive = "tech_drone",
		skillval = 2,
		skillreq = {["tech_drone"] = 1},
		skillconflict = {["gate_drone"] = true},
	},
	["sb_drone3"] = {
		name = "Drone Knowledge Level 3",
		desc = "item that gives you drones level 3",
		price = 13000,
		--model = "",
		skillgive = "tech_drone",
		skillval = 3,
		skillreq = {["tech_drone"] = 2},
		skillconflict = {["gate_drone"] = true},
	},
	["sb_drone4"] = {
		name = "Drone Knowledge Level 4",
		desc = "item that gives you drones level 4",
		price = 22600,
		--model = "",
		skillgive = "tech_drone",
		skillval = 4,
		skillreq = {["tech_drone"] = 3},
		skillconflict = {["gate_drone"] = true},
	},
	["sb_repair1"] = {
		name = "Crafting - Basic Repair Level 1",
		desc = "item that gives you basic repair level 1, however you wont be able to use higher level skillbooks",
		price = 1400,
		--model = "",
		skillgive = {["crafting_repair"] = 1, ["gate_repair"]=true},
		skillval = 1,
		skillreq = {},
	},
	["sb_repair2"] = {
		name = "Crafting - Basic Repair Level 2",
		desc = "item that gives you basic repair level 2",
		price = 4900,
		--model = "",
		skillgive = "crafting_repair",
		skillval = 2,
		skillreq = {["crafting_repair"] = 1},
		skillconflict = {["gate_repair"] = true},
	},
	["sb_repairw1"] = {
		name = "Crafting - Weapons Repair",
		desc = "item that gives you weapons repair, requires basic repair level 2",
		price = 12500,
		--model = "",
		skillgive = "crafting_repairw",
		skillval = 1,
		skillreq = {["crafting_repair"] = 2},
		skillconflict = {["gate_repair"] = true},
	},
	["sb_repaira1"] = {
		name = "Crafting - Armor Repair",
		desc = "item that gives you armor repair, requires basic repair level 2",
		price = 10500,
		--model = "",
		skillgive = "crafting_repaira",
		skillval = 1,
		skillreq = {["crafting_repair"] = 2},
		skillconflict = {["gate_repair"] = true},
	},
	
	["sb_craft1"] = {
		name = "Crafting - General Level 1",
		desc = "item that gives you general crafting level 1, but you wont be able to use higher level skillbooks",
		price = 700,--800,
		--model = "",
		skillgive = {["crafting"] = 1, ["gate_craft"] = true},
		skillval = 1,
		skillreq = {}--{[""] = 1}
	},
	["sb_craft2"] = {
		name = "Crafting - General Level 2",
		desc = "item that gives you general crafting level 2, you can use more advanced crafting books after this one",
		price = 1950,--3000,
		--model = "",
		skillgive = "crafting",
		skillval = 2,
		skillreq = {["crafting"] = 1},
		skillconflict = {["gate_craft"] = true},
	},
	["sb_craftwep1"] = {
		name = "Crafting - Weapon Level 1",
		desc = "item that gives you weapon crafting level 1, you need general crafting level 2 to use this",
		price = 2400,--3000,
		--model = "",
		skillgive = "crafting_weapon",
		skillval = 1,
		skillreq = {["crafting"] = 2},
		skillconflict = {["gate_craft"] = true},
	},
	["sb_craftwep2"] = {
		name = "Crafting - Weapon Level 2",
		desc = "item that gives you weapon crafting level 2",
		price = 4200,--3000,
		--model = "",
		skillgive = "crafting_weapon",
		skillval = 2,
		skillreq = {["crafting_weapon"] = 1},
		skillconflict = {["gate_craft"] = true},
	},
	["sb_craftarmor1"] = {
		name = "Crafting - Armor Level 1",
		desc = "item that gives you armor crafting level 1, you need general crafting level 2 to use this",
		price = 2300,--3000,
		--model = "",
		skillgive = "crafting_armor",
		skillval = 1,
		skillreq = {["crafting"] = 2},
		skillconflict = {["gate_craft"] = true},
	},
	["sb_crafttech1"] = {
		name = "Crafting - Basic Tech Level 1",
		desc = "item that gives you basic tech crafting level 1, you need general crafting level 2 to use this",
		price = 2300,--3000,
		--model = "",
		skillgive = "crafting_tech",
		skillval = 1,
		skillreq = {["crafting"] = 2},
		skillconflict = {["gate_craft"] = true},
	},
}


function PLUGIN:InitializedPlugins()
    do
		for id, data in pairs(self.skilllist) do
			local ITEM = nut.item.register(id, "base_skillbook", nil, nil, true)
			ITEM.name = data.name
			ITEM.desc = data.desc
			ITEM.price = data.price or 0
			ITEM.model = "models/props_lab/binderblue.mdl"
			if(data.model) then
				ITEM.model = data.model
			end

			--tbh these could have lit permit?

			ITEM.skillgive = data.skillgive --skill to give
			ITEM.skillval = data.skillval --value to set, true for non-level abilities, number for level to set to
			ITEM.skillreq = data.skillreq --requirements for using the book, value would be similar to skillval
			ITEM.skillconflict = data.skillconflict
			
		end
	end
end