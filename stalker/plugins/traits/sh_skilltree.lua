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
	["crafting_spec"] = {
		levels = {  --levels to add a skill point at
			[1] = 6, --can be true or number
			[2] = 3, 
			[3] = 3, 
			[4] = 3, 
			[5] = 3, 
		},
		picks = { 
			--picks available and the number of picks needed to choose each
			--use . to denote level that should be given
			--should technically be compatible with non-level ids too, as
			--not including it should make it nil
			["crafting.3"] = 1,
			["crafting.5"] = 3,
			["crafting_weapon.1"] = 2,
			["crafting_armor.1"] = 2,
			["crafting_tech.1"] = 2,
			["crafting_tech.2"] = 4,
			["crafting_repair.1"] = 1,
			["crafting_repair.2"] = 3,
			["crafting_repaira.1"] = 3,
			["crafting_repairw.1"] = 3,
		},
		picknames = { --friendlier names to display on buttons
		["crafting.3"] = "General Crafting Level 3",
		["crafting.5"] = "General Crafting Level 5",
		["crafting_weapon.1"] = "Weapon Crafting Level 1",
		["crafting_armor.1"] = "Armor Crafting Level 1",
		["crafting_tech.1"] = "Basic Tech Crafting Level 1",
		["crafting_tech.2"] = "Basic Tech Crafting Level 2",
		["crafting_repair.1"] = "Repair - Basic Level 1",
		["crafting_repair.2"] = "Repair - Basic Level 2",
		["crafting_repaira.1"] = "Repair - Armor Level 1",
		["crafting_repairw.1"] = "Repair - Weapon Level 1",
		}
	},
	["crafting_repair"] = {
		levels = {  --levels to add a skill point at
			--[1] = true, --can be true or number
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
	--check if name is in table above, 
	if(!skills[name]) then return end
	--and if num is in the levels table in names table
	--if(!skills[name].levels[num]) then return end
	return skills[name].levels[num]
end

if(SERVER) then			--orig skill, number of points to remove, new skill
	netstream.Hook("LevelupSkill", function(client, orig, add)
		local pick = client:getChar():getData("traitlevelups", {})
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
	if(!skills[name] or !skills[name].picks) then return end
	local levelcnt = LocalPlayer():getChar():getData("traitlevelups", {})
	if(!levelcnt[name]) then return end
	local curtrt= LocalPlayer():getChar():getTrait()

	local avail = {}
	for k,v in pairs(skills[name].picks) do
		local spl = string.Split(k, ".")
		if(curtrt[spl[1]] and (curtrt[spl[1]] == true or curtrt[spl[1]] >= tonumber(spl[2]))) then continue end 
		if(levelcnt[name] >= v) then
			avail[#avail+1] = {name = skills[name].picknames[k], id = k}
			if(#avail == 4) then break end
		end
	end
	if(#avail == 0) then return end

	return avail
end