local PLUGIN = PLUGIN
local trait = {}
local uid = ""
nonenglishname = "Ukrainian"

--[[ template
uid = "test"
trait = {
	name = "name",
	getName = function(char) return "" end, --only called in trait list, gender specific or for levels
	desc = "desc",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "cat", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {}, --table of conflicting traits
	--max = 4, --max level for level trait
	--creationMax = 2, --max for creation, 0 will do the same as hide
	--xp = {}, --xp limits for advancing skills, key should be current level,
	--gate = "gate", --a gate to prevent xp gain if they have this trait
	--faction = {[FACTION_CITIZEN] = true}, --optional to limit this trait to characters of this faction
	modify = {
		--table of stuff idk
	},
	onCreate = function(ply, char)
		--function done on char creation
	end,
	onLoad = function(ply, char)
		--function done on char loadout
	end,
	onSwitch = function(ply, char)
		--function done when someone switches from a char with this trait to someone else
	end,
	hide = true, --use to hide from char creation
}
nut.traits.add(uid, trait)
]]
--crafting
uid = "crafting"
trait = {
	name = "General",
	getName = function(char) 
		return "General Level "..(char:getTrait("crafting") or "???")--Data("traits", {})["crafting"] or "???") 
	end, --only called in trait list, gender specific or for levels
	desc = "Generic crafting level, used to determine what you can craft in a general sense.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Crafting", --shown in char creation and menu
	cost = {[1] = 3, [2] = 4, [3] = 4}, --cost in char creation, can be table for levels
	max = 5, --max level for level trait
	creationMax = 1,--3, --max for creation
	xp = {
		[1] = 25,
		--[2] = 45,
		[3] = 20,
		[4] = 45,
	},
	gate = "gate_craft",
}--todo change when more used?
nut.traits.add(uid, trait)
uid = "crafting_spec"
trait = {
	name = "Special Tech",
	getName = function(char) 
		return "Special Tech Level "..(char:getTrait("crafting_spec") or "???")--Data("traits", {})["crafting_weapon"] or "???") 
	end, --only called in trait list, gender specific or for levels
	desc = "Tech crafting level, used to determine your ability to craft technician-exclusive recipes.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Crafting", --shown in char creation and menu
	cost = {[1] = 2,}, --cost in char creation, can be table for levels
	max = 5, --max level for level trait
	hide = true,
	creationMax = 0,--3, --max for creation
	xp = {
		[1] = 5,
		[2] = 15,
		[3] = 25,
		[4] = 40,
	},
	gate = "gate_craft",
	--require = "crafting_1", --the trait required to pick this
}--todo change when more used?
nut.traits.add(uid, trait)
uid = "crafting_weapon"
trait = {
	name = "Weapon",
	getName = function(char) 
		return "Weapon Level "..(char:getTrait("crafting_weapon") or "???")--Data("traits", {})["crafting_weapon"] or "???") 
	end, --only called in trait list, gender specific or for levels
	desc = "Weapon crafting level, used to determine your ability to craft weapon-related recipes.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Crafting", --shown in char creation and menu
	cost = {[1] = 2,}, --cost in char creation, can be table for levels
	max = 3, --max level for level trait
	hide = true,
	creationMax = 0,--3, --max for creation
	xp = {
		[1] = 6,
		[2] = 12,
	},
	gate = "gate_craft",
	require = "crafting_1", --the trait required to pick this
}--todo change when more used?
nut.traits.add(uid, trait)
uid = "crafting_armor"
trait = {
	name = "Armor",
	getName = function(char) 
		return "Armor Level "..(char:getTrait("crafting_armor") or "???")--Data("traits", {})["crafting_weapon"] or "???") 
	end, --only called in trait list, gender specific or for levels
	desc = "Armor crafting level, used to determine your ability to craft armor/clothing-related recipes.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Crafting", --shown in char creation and menu
	cost = {[1] = 2,}, --cost in char creation, can be table for levels
	max = 3, --max level for level trait
	hide = true,
	creationMax = 0,--3, --max for creation
	xp = {
		[1] = 6,
		[2] = 12,
	},
	gate = "gate_craft",
	require = "crafting_1", --the trait required to pick this
}--todo change when more used?
nut.traits.add(uid, trait)
uid = "crafting_tech"
trait = {
	name = "Basic Tech",
	getName = function(char) 
		return "Basic Tech Level "..(char:getTrait("crafting_tech") or "???")--Data("traits", {})["crafting_tech"] or "???") 
	end, --only called in trait list, gender specific or for levels
	desc = "REQUIRED: General Crafting Level 1. Crafting level for low-tier/basic technology and electronics.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Crafting", --shown in char creation and menu
	cost = {[1] = 1, [2] = 5}, --cost in char creation, can be table for levels
	max = 5, --max level for level trait
--	hide = true,
	creationMax = 1,--0,--2, --max for creation
	xp = {
		[1] = 2,
		[2] = 6,
		[3] = 12,
		[4] = 20,
	},
	gate = "gate_craft",
	require = "crafting_1", --the trait required to pick this
}--todo change when this is being used?
nut.traits.add(uid, trait)
uid = "crafting_cook"
trait = {
	name = "Cooking",
	getName = function(char) 
		return "Cooking Level "..(char:getTrait("crafting_cook") or "???")--Data("traits", {})["crafting_tech"] or "???") 
	end, --only called in trait list, gender specific or for levels
	desc = "Level for cooking. Includes cooking mutant meat into meals among other things. Does not require any other crafting traits.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Crafting", --shown in char creation and menu
	cost = {[1] = 2, [2] = 4}, --cost in char creation, can be table for levels
	max = 3, --max level for level trait
--	hide = true,
	creationMax = 1,--0,--2, --max for creation
	xp = {
		[1] = 5,
		[2] = 15,
	},
	gate = "gate_cook",
}--todo change when this is being used?
nut.traits.add(uid, trait)
uid = "crafting_high"
trait = {
	name = "High Tech",
	getName = function(char) 
		return "High Tech Level "..(char:getTrait("crafting_high") or "???")--Data("traits", {})["crafting_high"] or "???") 
	end, --only called in trait list, gender specific or for levels
	desc = "Crafting level for high-tier and more recent technology and electronics.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Crafting", --shown in char creation and menu
	cost = {[1] = 4}, --cost in char creation, can be table for levels
	max = 3, --max level for level trait
	hide = true,
	creationMax = 0, --max for creation
	xp = {
		[1] = 10,
		[2] = 20,
	},
	gate = "gate_craft",
	require = "crafting_1", --the trait required to pick this
} --todo change when this is being used?
nut.traits.add(uid, trait)
uid = "crafting_repair"
trait = {
	name = "Repair - Basic",
	getName = function(char) 
		return "Repair - Basic Level "..(char:getTrait("crafting_repair") or "???") --Data("traits", {})["crafting_repair"] or "???") 
	end, --only called in trait list, gender specific or for levels
	desc = "Basic level for repairing weapons and such. Using a lower level repair kit than your level reduces the minimum durability required to use it.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Crafting", --shown in char creation and menu
	cost = {[1] = 3, [2] = 5}, --cost in char creation, can be table for levels
	max = 3, --max level for level trait
	creationMax = 1, --max for creation
	xp = {
		[1] = 15,
		[2] = 40,
	},
	gate = "gate_repair"
}
nut.traits.add(uid, trait)
--todo books for these
uid = "crafting_repairw"
trait = {
	name = "Repair - Weapons",
	getName = function(char) 
		return "Repair - Weapons Level "..(char:getTrait("crafting_repairw") or "???")--Data("traits", {})["crafting_repairw"] or "???") 
	end, --only called in trait list, gender specific or for levels
	desc = "Advanced specialization for repairing weapons.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Crafting", --shown in char creation and menu
--	cost = {[1] = 2}, --cost in char creation, can be table for levels
	max = 2, --max level for level trait
	hide = true,
	creationMax = 0, --max for creation
	xp = {
		[1] = 10,
	},
}
nut.traits.add(uid, trait)
uid = "crafting_repaira"
trait = {
	name = "Repair - Armor",
	getName = function(char) 
		return "Repair - Armor Level "..(char:getTrait("crafting_repaira") or "???")--Data("traits", {})["crafting_repaira"] or "???") 
	end, --only called in trait list, gender specific or for levels
	desc = "Advanced specialization for repairing armor and such.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Crafting", --shown in char creation and menu
--	cost = {[1] = 2}, --cost in char creation, can be table for levels
	max = 1, --max level for level trait
	hide = true,
	creationMax = 0, --max for creation
}
nut.traits.add(uid, trait)

--languages
uid = "lang_japanese"
trait = {
	name = "Japanese",
	desc = "The ability to speak Japanese.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
}
nut.traits.add(uid, trait)

uid = "lang_english"
trait = {
	name = "English",
	desc = "The ability to speak English.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
}
nut.traits.add(uid, trait)

uid = "lang_korean"
trait = {
	name = "Korean",
	desc = "The ability to speak Korean.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
}
nut.traits.add(uid, trait)

uid = "lang_russian"
trait = {
	name = "Russian",
	desc = "The ability to speak Russian.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
}
nut.traits.add(uid, trait)

uid = "lang_chinese"
trait = {
	name = "Chinese",
	desc = "The ability to speak Chinese.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
}
nut.traits.add(uid, trait)

uid = "lang_spanish"
trait = {
	name = "Spanish",
	desc = "The ability to speak Spanish.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
}
nut.traits.add(uid, trait)

uid = "lang_german"
trait = {
	name = "German",
	desc = "The ability to speak German.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
}
nut.traits.add(uid, trait)

uid = "lang_french"
trait = {
	name = "French",
	desc = "The ability to speak French.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
}
nut.traits.add(uid, trait)

uid = "lang_polish"
trait = {
	name = "Polish",
	desc = "The ability to speak Polish.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
}
nut.traits.add(uid, trait)

uid = "lang_arabic"
trait = {
	name = "Arabic",
	desc = "The ability to speak Arabic.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
}
nut.traits.add(uid, trait)

uid = "lang_portuguese"
trait = {
	name = "Portuguese",
	desc = "The ability to speak Portuguese.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
}
nut.traits.add(uid, trait)

uid = "lang_turkish"
trait = {
	name = "Turkish",
	desc = "The ability to speak Turkish.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
}
nut.traits.add(uid, trait)

--sign language
uid = "lang_sign"
trait = {
	name = "Sign Language",
	desc = "The ability to use sign language.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Languages", --shown in char creation and menu
	cost = 0, --cost in char creation, can be table for levels
	--conflicting = {}, --table of conflicting traits
}
nut.traits.add(uid, trait)

--tech
--[[
uid = "tech_drone"
trait = {
	name = "Drone Operation",
	getName = function(char) 
		return "Drone Operation Level "..(char:getTrait("tech_drone") or "???")--Data("traits", {})["tech_drone"] or "???") 
	end,
	desc = "Skill level of operating drones and drone knowledge. Higher levels allow more advanced drones and more advanced drone related crafting.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Technology", --shown in char creation and menu
	cost = {[1] = 3, [2] = 6}, --cost in char creation, can be table for levels
	--conflicting = {}, --table of conflicting traits
	max = 4, --max level for level trait
	creationMax = 2, --max for creation
	modify = {
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
]]

uid = "tech_hack"
trait = {
	name = "Hack Knowledge",
	getName = function(char) 
		return "Hack Knowledge Level "..(char:getTrait("tech_hack") or "???")--Data("traits", {})["tech_hack"] or "???") 
	end,
	desc = "Skill level of hacking objects. Higher levels allow more advanced hacks.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Knowledge", --shown in char creation and menu
	--cost = {[1] = 3, [2] = 6}, --cost in char creation, can be table for levels
	--conflicting = {}, --table of conflicting traits
	max = 3, --max level for level trait
	hide = true,
	creationMax = 0, --this is hidden now but not removed so i can used it
	modify = {
		--table of stuff idk
	},
	xp = {
		[1] = 45,
		[2] = 90,
	},
	gate = "gate_hack"
}--[[
nut.traits.add(uid, trait)
uid = "tech_imp"
trait = {
	name = "Cyberware Knowledge",
	getName = function(char) 
		return "Cyberware Knowledge Level "..(char:getTrait("tech_imp") or "???")--Data("traits", {})["tech_imp"] or "???") 
	end,
	desc = "Skill level of installing and removing cyberware. Higher levels allow to install/remove more advanced cyberware.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Technology", --shown in char creation and menu
	--cost = {[1] = 4}, --cost in char creation, can be table for levels
	--conflicting = {}, --table of conflicting traits
	max = 3, --max level for level trait
	creationMax = 0, --max for creation
	modify = {
		--table of stuff idk
	},
}]]
nut.traits.add(uid, trait)
uid = "tech_med"
trait = {
	name = "Medical Skill",
	getName = function(char) 
		return "Medical Skill Level "..(char:getTrait("tech_med") or "???")--Data("traits", {})["tech_med"] or "???") 
	end,
	desc = "Medical knowledge. First level decreases healing time from medical items by 16.7 percent, second instead decreases healing time by 33.3 percent.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Knowledge", --shown in char creation and menu
	cost = {[1] = 1,[2] = 3}, --cost in char creation, can be table for levels
	conflicting = {"gen_healdec"}, --table of conflicting traits
	max = 2, --max level for level trait
	creationMax = 2, --max for creation
	modify = {
		--table of stuff idk
	},
	xp = {
		[1] = 180,
	},
	gate = "gate_med"
}
nut.traits.add(uid, trait)

--weapon specs
uid = "wepspec_pistol"
trait = {
	name = "Specialization: Pistols",
	desc = "You, somehow or another, are trained in using pistols. You have better overall control of them than average.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Weapon Specialization", --shown in char creation and menu
	cost = 3, --cost in char creation, can be table for levels
	conflicting = {"gen_badwep"}, --table of conflicting traits
	modify = {
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
uid = "wepspec_smg"
trait = {
	name = "Specialization: SMGs",
	desc = "You, somehow or another, are trained in using SMGs. You have better overall control of them than average.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Weapon Specialization", --shown in char creation and menu
	cost = 3, --cost in char creation, can be table for levels
	conflicting = {"gen_badwep"}, --table of conflicting traits
	modify = {
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
uid = "wepspec_shotgun"
trait = {
	name = "Specialization: Shotguns",
	desc = "You, somehow or another, are trained in using shotguns. You have better overall control of them than average.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Weapon Specialization", --shown in char creation and menu
	cost = 3, --cost in char creation, can be table for levels
	conflicting = {"gen_badwep"}, --table of conflicting traits
	modify = {
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
uid = "wepspec_ar"
trait = {
	name = "Specialization: Automatic Rifles",
	desc = "You, somehow or another, are trained in using automatic rifles. You have better overall control of them than average.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Weapon Specialization", --shown in char creation and menu
	cost = 3, --cost in char creation, can be table for levels
	conflicting = {"gen_badwep"}, --table of conflicting traits
	modify = {
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
uid = "wepspec_sniper"
trait = {
	name = "Specialization: Snipers",
	desc = "You, somehow or another, are trained in using snipers and non-automatic rifles. You have better overall control of them than average.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Weapon Specialization", --shown in char creation and menu
	cost = 3, --cost in char creation, can be table for levels
	conflicting = {"gen_badwep"}, --table of conflicting traits
	modify = {
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)

--general (pos)
--[[
uid = "gen_richkid"
trait = {
	name = "Rich Kid",
	desc = "Start with a 20000 credstick with 5000 inside it, on top of the starting 5k one.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = 3, --cost in char creation, can be table for levels
--	conflicting = {}, --table of conflicting traits
	onCreate = function(ply, char)
		local inventory = char:getInv()
		inventory:add("cred_n20k", 1, {money = 5000})
	end,
}
nut.traits.add(uid, trait)
]]

uid = "gen_hungdec"
trait = {
	name = "Light Eater",
	desc = "You need to eat less often.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = 1, --cost in char creation, can be table for levels
	conflicting = {"gen_hunginc"}, --table of conflicting traits
	modify = {
		inc = 1.2 --less is more often
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
uid = "gen_thirdec"
trait = {
	name = "Less Thirst",
	desc = "You need to drink less often.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = 1, --cost in char creation, can be table for levels
	conflicting = {"gen_thirinc"}, --table of conflicting traits
	modify = {
		inc = 1.3 --less is more often
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
uid = "gen_bleeddec"
trait = {
	name = "Thick Skin",
	desc = "You bleed less and less often.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = 1, --cost in char creation, can be table for levels
	conflicting = {"gen_bleedinc"}, --table of conflicting traits
	modify = {
		inc = 1.3 --less is more often
		--theres hardcoded stuff in getmod
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)

--depot
--[[
uid = "gen_depotchance"
trait = {
	name = "Good Searcher",
	desc = "You have a small chance to not use up a depot (trash piles, etc) charge when searching it.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = 1, --cost in char creation, can be table for levels
	--conflicting = {"gen_bleedinc"}, --table of conflicting traits
	modify = {
		inc = 2, --chance out of below
		total = 10 --to not use a charge
		--2/10 is 20%
	},
}
nut.traits.add(uid, trait)

uid = "gen_anticc" --unsure?
trait = {
	name = "Anti-Crowd Control",
	desc = "You are more resistant to stunstick stuns and stamina damage.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = 2, --cost in char creation, can be table for levels
	conflicting = {"gen_cc"}, --table of conflicting traits
	modify = {
		inc = 4,
		st = 0.75,
	},
}
nut.traits.add(uid, trait)
--[[
uid = "gen_jobinc" --not done
trait = {
	name = "Favored Worker",
	desc = "You get more money every job tick.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = 1, --cost in char creation, can be table for levels
	conflicting = {"gen_jobdec"}, --table of conflicting traits
	modify = {
		inc = 1.2, --% to use
	},
}
nut.traits.add(uid, trait)
]]
uid = "gen_catlike"
trait = {
	name = "Catlike",
	desc = "You crouch at a faster speed and have much quieter footsteps when crouching.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = 1, --cost in char creation, can be table for levels
	conflicting = {},--"gen_bleedinc"}, --table of conflicting traits
	--faction = {[2] = true}, --this is citizen, for some reason the enum doesnt count at this time
	onLoad = function(ply, char)
		ply:SetCrouchedWalkSpeed(0.8)
	end,
	onSwitch = function(ply, char)
		ply:SetCrouchedWalkSpeed(0.6) --default
	end,
}
nut.traits.add(uid, trait)

--active abilities
uid = "gen_escape"
trait = {
	name = "Escape Artist",
	--desc = "Once a day (every 20 hours), while tied you can use a command (/struggle) to start an action to break free of the tie.\nThis will automatically do a /me to notify others nearby, and display a notification below your desc while this action is running.\nAnybody can stop it by pressing e on you and starting it in general will put the ability on cooldown.",
	desc ="Once a day, you can use (/struggle) to start an action to break free of ties. This will notify surrounding players with a /me of the attempt. Anybody can stop this action by pressing 'use' on your character.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Abilities", --shown in char creation and menu
	cost = 2, --cost in char creation, can be table for levels
	conflicting = {"big_cripple"}, --table of conflicting traits
	modify = {
	},
}
nut.traits.add(uid, trait)

--general (neg)
uid = "gen_hunginc"
trait = {
	name = "Hearty Appetite",
	desc = "Causes you to need to eat more often.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = -1, --cost in char creation, can be table for levels
	conflicting = {"gen_hungdec"}, --table of conflicting traits
	modify = {
		inc = 0.6 --less is more often
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
uid = "gen_thirinc"
trait = {
	name = "High Thirst",
	desc = "Causes you to need to drink more often.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = -1, --cost in char creation, can be table for levels
	conflicting = {"gen_thirdec"}, --table of conflicting traits
	modify = {
		inc = 0.7 --less is more often
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
uid = "gen_bleedinc"
trait = {
	name = "Thin Skin",
	desc = "You bleed more and more often.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = -1, --cost in char creation, can be table for levels
	conflicting = {"gen_bleeddec"}, --table of conflicting traits
	modify = {
		inc = 0.7 --less is more often
		--theres hardcoded stuff in getmod
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
uid = "gen_healdec"
trait = {
	name = "Hemophobia",
	desc = "You heal less when healing yourself and healing others.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = -1, --cost in char creation, can be table for levels
	conflicting = {"tech_med_1","tech_med_2"},--need to specify level because it changes for level traits --table of conflicting traits
	modify = {
		inc = 0.5 --less is more often
		--theres hardcoded stuff in getmod
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
uid = "gen_clumsy"
trait = {
	name = "Clumsy",
	desc = "You're fairly clumsy. Actions with timers, such as using meds and lockpicks, and reloading take longer than usual.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = -2, --cost in char creation, can be table for levels
	--conflicting = {"gen_bleeddec"}, --table of conflicting traits
	modify = {
		inc = 1.5 --less is more often
		--theres hardcoded stuff in getmod
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
uid = "gen_badwep"
trait = {
	name = "Bad with Weapons",
	desc = "You can't use weapons well. Your stats with weapons (reload speed, spread, etc) is worse than normal.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = -2, --cost in char creation, can be table for levels
	conflicting = {"wepspec_sniper","wepspec_pistol","wepspec_smg","wepspec_shotgun","wepspec_ar",}, --table of conflicting traits
	modify = {
		inc = 1.3, --less is more often
		incd = 0.7,
		--theres hardcoded stuff in getmod
		--table of stuff idk
	},
}
nut.traits.add(uid, trait)
--[[
uid = "gen_cc" --unsure?
trait = {
	name = "Easily Crowd Controlled",
	desc = "You are take less stunstick stuns and more stamina damage than usual.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = -1, --cost in char creation, can be table for levels
	conflicting = {"gen_anticc"}, --table of conflicting traits
	modify = {
		inc = 2,
		st = 1.3,
	},
}
nut.traits.add(uid, trait)
--[[
uid = "gen_jobdec" --not done
trait = {
	name = "Unfavored Worker",
	desc = "You get less money every job tick.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "General", --shown in char creation and menu
	cost = -1, --cost in char creation, can be table for levels
	conflicting = {"gen_jobinc"}, --table of conflicting traits
	modify = {
		inc = 0.8, --% to use
	},
}
nut.traits.add(uid, trait)
]]
--big gameplay changing traits
--(pos)
uid = "big_trilingual"
trait = {
	name = "Trilingual",
	desc = "You get an extra pick for languages in char creation.",
	type = "pos", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Special", --shown in char creation and menu
	cost = 2, --cost in char creation, can be table for levels
}
nut.traits.add(uid, trait)

--(neg)
uid = "big_glasses"
trait = {
	name = "Glasses",
	desc = "You need glasses to see. Get a pair of glasses on creation.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Special", --shown in char creation and menu
	cost = -1, --cost in char creation, can be table for levels
	onCreate = function(ply, char)
		local inventory = char:getInv()
		inventory:add("eyes_glasses", 1, {equip = true})
		--[[nut.item.instance(inventory:getID(), "eyes_glasses", {equip = true}, 1, 2,
		function(item)
			inventory:add(item.id, nil, nil, 1, 2)
		end)]]
	end,
	onLoad = function(ply, char)
		local id = char:getID()
		timer.Create("glassblur"..id, 4, 0, function()
			if(!IsValid(ply) or !ply:getChar() or ply:getChar():getID() != id) then timer.Remove("glassblur"..id) return end
			--if(!char:getInv():hasItem("eyes_glasses", {equip = true}) and !char:getInv():hasItem("eyes_glasses_dark", {equip = true})) then
			local has = false
			for k,v in pairs(char:getInv():getItems()) do
				if(v.uniqueID == "eyes_glasses" or v.uniqueID == "eyes_glasses_dark" or v.uniqueID:find("gasmask") or v.uniqueID:find("helm_") or v.uniqueID:find("eco") or v.uniqueID:find("seva")) then
					if(v:getData("equip")) then
						has = true
						break
					end
				end
			end
			
			if(has) then
				ply:setLocalVar("blur", nil)
			else
				ply:setLocalVar("blur", 7)
			end
		end)
	end,
}
nut.traits.add(uid, trait)

--[[
uid = "big_nocyber"
trait = {
	name = "Cyberware Rejection",
	desc = "Your character's body will not accept any cyberware. You won't be able to equip the main cyberware control.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Special", --shown in char creation and menu
	cost = -3, --cost in char creation, can be table for levels
}
nut.traits.add(uid, trait)
]]

uid = "big_cripple"
trait = {
	name = "'Movement Impaired'",
	desc = "Somehow or another, you have a hard time moving. You cannot sprint and have a slower than normal walkspeed.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Special", --shown in char creation and menu
	cost = -2, --cost in char creation, can be table for levels
}
nut.traits.add(uid, trait)

--[[
uid = "big_illit"
trait = {
	name = "Illiteracy",
	desc = "Somehow, you can't read. You cannot use skillbooks.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Special", --shown in char creation and menu
	cost = -3, --cost in char creation, can be table for levels
}
nut.traits.add(uid, trait)

uid = "big_mostwanted"
trait = {
	name = "Most Wanted",
	desc = "For whatever reason, you are permanently wanted by SectCom. No amount of clearing their local databases will make them not hostile to you.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Special", --shown in char creation and menu
	cost = -3, --cost in char creation, can be table for levels
	onCreate = function(ply, char)
		char:setData("permawanted", true)
	end,
}
nut.traits.add(uid, trait)
]]

uid = "big_alcohol"
trait = {
	name = "Alcoholic", 
	desc = "You're an alcoholic. You need to have a drink every now and then or you'll get various debuffs (longer action times, worse aiming, etc).\nNo matter what you do you can't seem to shake this, so the longer you are without a drink the worse the debuffs are.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Special", --shown in char creation and menu
	cost = -1, --cost in char creation, can be table for levels
	onLoad = function(ply, char)
		local id = char:getID()
		timer.Create("alcoh"..id, 2400, 0, function()
			if(!IsValid(ply) or !ply:getChar() or ply:getChar():getID() != id) then timer.Remove("alcoh"..id) return end
			local cur = ply:getChar():getData("alcoh", 0)
			ply:getChar():setData("alcoh", math.Clamp(cur+1, 0, 6))
			if(cur+1 >= 2) then
				local ineedit = {
					[2] = "I could go for a drink about now.",
					[3] = "I wish I had a drink right now.",
					[4] = "I could use a drink sometime soon.",
					[5] = "I really want a drink about now.",
					[6] = "I really need a drink right now.",
				}
				nut.chat.send(ply, "traitthink", ineedit[cur+1] or ineedit[#ineedit], false, {ply})
			end
		end)
	end,
}
nut.traits.add(uid, trait)

uid = "big_mute"
trait = {
	name = "Mute",
	desc = "Your character is mute, meaning they cannot speak. RP this properly or your character will be banned.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Special", --shown in char creation and menu
	cost = -2,---3, --cost in char creation, can be table for levels
	conflicting = {},--"lang_japanese","lang_chinese","lang_korean","lang_russian","big_nonenglish"}, --table of conflicting traits
	onLoad = function(ply, char)
		netstream.Start(ply, "fakechatmessage", "As a reminder, this character is mute. You cannot use speaking commands such as normal ic chat, yell, whisper etc, but you can use the sign language command. Please RP properly, if you do not your character will be banned.")
	end,
}
nut.traits.add(uid, trait)

uid = "big_nonenglish"
trait = {
	name = "Does not understand "..nonenglishname,
	desc = "Your character does not understand "..nonenglishname..", meaning in order to talk they must use another language. THIS MEANS YOU CANNOT USE NORMAL SPEAKING CHAT TYPES (ic, yell, etc). RP this properly or your character will be banned.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Special", --shown in char creation and menu
	cost = -1, --cost in char creation, can be table for levels
	conflicting = {},--"big_mute"}, --table of conflicting traits
	onLoad = function(ply, char)
		netstream.Start(ply, "fakechatmessage", "As a reminder, this character cannot understand "..nonenglishname..". You cannot use or understand default speaking commands such as normal ic chat, yell, whisper etc, but can still use/understand languaged versions if you have the language trait for it, and PDA chat (PDA chat ICly would automatically be translated to whatever language you'd have it set to). Please RP properly, if you do not your character will be banned. This message might display twice.")
	end,
}
nut.traits.add(uid, trait)

--gates
uid = "gate_hack"
trait = {
	name = "Hack Skill Gate",
	desc = "You learned hacking level 1 from a skillbook, therefore you cant use higher level skillbooks.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Gate", --shown in char creation and menu
	creationMax = 0, --max for creation
	hide = true, --hide from char creation
}
nut.traits.add(uid, trait)
uid = "gate_med"--imp"
trait = {
	name = "Medical Skill Gate",
	desc = "You learned medical skill level 1 from a skillbook, therefore you cant use higher level skillbooks.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Gate", --shown in char creation and menu
	creationMax = 0, --max for creation
	hide = true, --hide from char creation
}
nut.traits.add(uid, trait)
uid = "gate_drone"
trait = {
	name = "Drone Skill Gate",
	desc = "You learned drone knowledge level 1 from a skillbook, therefore you cant use higher level skillbooks.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Gate", --shown in char creation and menu
	creationMax = 0, --max for creation
	hide = true, --hide from char creation
}
nut.traits.add(uid, trait)
uid = "gate_repair"
trait = {
	name = "Repair Skill Gate",
	desc = "You learned basic repair level 1 from a skillbook, therefore you cant use higher level skillbooks.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Gate", --shown in char creation and menu
	creationMax = 0, --max for creation
	hide = true, --hide from char creation
}
nut.traits.add(uid, trait)
uid = "gate_craft"
trait = {
	name = "Crafting Skill Gate",
	desc = "You learned general crafting level 1 from a skillbook, therefore you cant use higher level skillbooks.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Gate", --shown in char creation and menu
	creationMax = 0, --max for creation
	hide = true, --hide from char creation
}
nut.traits.add(uid, trait)
uid = "gate_cook"
trait = {
	name = "Cooking Skill Gate",
	desc = "You learned general crafting level 1 from a skillbook, therefore you cant use higher level skillbooks.",
	type = "neg", --can be pos or neg for listing on char creation, pos is left column, neg is right column, anything else will hide it from char creation
	category = "Gate", --shown in char creation and menu
	creationMax = 0, --max for creation
	hide = true, --hide from char creation
}
nut.traits.add(uid, trait)