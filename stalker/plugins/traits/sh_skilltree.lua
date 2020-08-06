--[[new idea: 
	after a certain level in a skill, 
	on the trait menu a button becomes available
	and you can then click it to get a derma request which lets you
	pick from a skill (pick from one)
]]
local skills = {
	--[[
	["id"] = {
		levels = {  --levels to add a skill point at
			[1] = true, --can be true or number
		},
		picks = { 
			--picks available and the number of picks needed to choose each
			--use . to denote level that should be given
			--should technically be compatible with non-level ids too, as
			--not including it should make it nil
			["id2.1"] = 1,
		},
		picknames = { --friendlier names to display on buttons
			["id2.1"] = "",
		}
	},
	]]
	["crafting"] = {
		levels = {  --levels to add a skill point at
			[1] = true, --can be true or number
			[2] = 3, 
		},
		picks = { 
			--picks available and the number of picks needed to choose each
			--use . to denote level that should be given
			--should technically be compatible with non-level ids too, as
			--not including it should make it nil
			["crafting_weapon.1"] = 2,
			["crafting_armor.1"] = 2,
			["crafting_tech.1"] = 1,
		},
		picknames = { --friendlier names to display on buttons
		["crafting_weapon.1"] = "Weapon Crafting",
		["crafting_armor.1"] = "Armor Crafting",
		["crafting_tech.1"] = "Basic Tech Crafting",
		}
	},
	["crafting_repair"] = {
		levels = {  --levels to add a skill point at
			[1] = true, --can be true or number
			[2] = true,
		},
		picks = { 
			--picks available and the number of picks needed to choose each
			--use . to denote level that should be given
			--should technically be compatible with non-level ids too, as
			--not including it should make it nil
			["crafting_repairw.1"] = 1,
			["crafting_repaira.1"] = 1,
		},
		picknames = { --friendlier names to display on buttons
			["crafting_repairw.1"] = "Weapon Repair",
			["crafting_repairw.1"] = "Armor Repair",
		}
	},
}
--return levels for that num == add a level up pick
function PLUGIN:LevelupCheck(name, num)

end

if(SERVER) then			--orig skill, number of points to remove, new skill
	netstream.Hook("LevelupSkill", function(client, orig, add)
		local pick = client:getChar():getData("traitlevelups")
		if(!pick[orig]) then return end --just in case?
		local rem = skills[orig].picks[add]
		pick[orig] = pick[orig] - rem
		if(pick[orig] <= 0) then
			pick[orig] = nil
		end

		local spl = string.Split(add, ".")
		nut.traits.setTrait(client, spl[1], nil, tonumber(spl[2]))

		client:getChar():setData("traitlevelups", pick)

		client:notify("Skill "..skills[orig].picknames[add].." picked successfully.")
	end)
end

--get picks for name (id), only 4 at once (for now) but 
--prob wont need more than that lol
--[1] = {name = "", id = ""},
function PLUGIN:GetSkillChoiceForSkill(name)

end