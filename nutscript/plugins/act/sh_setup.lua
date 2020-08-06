local function facingWall(client)
	local data = {}
	data.start = client:GetPos()
	data.endpos = data.start + client:GetAimVector()*54
	data.filter = client

	if (!util.TraceLine(data).HitWorld) then
		return "@faceWall"
	end
end

local function facingWallBack(client)
	local data = {}
	data.start = client:GetPos()
	data.endpos = data.start - client:GetAimVector()*54
	data.filter = client

	if (!util.TraceLine(data).HitWorld) then
		return "@faceWallBack"
	end
end

local function combinefacingWallBack(client)
	if(client.isCombine and client:isCombine()) then
		return facingWallBack(client)
	elseif(!client.isCombine) then
		return
	else
		return "You need to be MPF to do this!"
	end
end

local function facingWallLeft(client)
	local data = {}
	data.start = client:GetPos()
	data.endpos = data.start + client:GetAimVector():Angle():Right()*(-54)
	data.filter = client

	if (!util.TraceLine(data).HitWorld) then
		return "You are not close enough to a wall on your left!"
	end
end

local function needCombine(client)
	if(client.isCombine and client:isCombine()) then
		return
	elseif(!client.isCombine) then
		return
	else
		return "You need to be MPF to do this!"
	end
end

local function requireStunstick(client)
	if(client:GetActiveWeapon() and client:GetActiveWeapon():GetClass() == "nut_stunstick") then
		return
	else
		return "You need a stunstick out for this!"
	end
end

ACT_ENDSEQ = 0
ACT_STARTSEQ = 1

PLUGIN.acts["sit"] = {
	["citizen_male"] = {sequence = "sit_ground", untimed = true, transition = {[ACT_STARTSEQ] = "Idle_to_Sit_Ground", [ACT_ENDSEQ] = "Sit_Ground_to_Idle"}},
	["citizen_female"] = {sequence = "sit_ground", untimed = true},
	["player"] = {sequence = "pose_ducking_02", untimed = true}
}
PLUGIN.acts["sit2"] = {
	["player"] = {sequence = "male_sit_ground", untimed = true, transition = {[ACT_STARTSEQ] = "male_Idle_to_Sit_Ground", [ACT_ENDSEQ] = "male_Sit_Ground_to_Idle"}},
	["player_female"] = {sequence = "female_sit_ground", untimed = true, transition = {[ACT_STARTSEQ] = "female_Idle_to_Sit_Ground", [ACT_ENDSEQ] = "female_Sit_Ground_to_Idle"}},

}
PLUGIN.acts["kneel"] = {
	["player"] = {sequence = "pose_ducking_01", untimed = true}
}
PLUGIN.acts["crossarms"] = {
	["player"] = {sequence = {"male_lineidle01","pose_standing_01",}, untimed = true},
	["player_female"] = {sequence = {"female_lineidle01","pose_standing_01",}, untimed = true}
}
PLUGIN.acts["wait"] = {
	["player"] = {sequence = "male_lineidle02", untimed = true},
	["player_female"] = {sequence = {"female_lineidle02", "female_lineidle03"}, untimed = true}
}
PLUGIN.acts["injured"] = {
	["player"] = {sequence = "male_d1_town05_wounded_idle_1", untimed = true},
	["player_female"] = {sequence = "female_d1_town05_wounded_idle_1", untimed = true}
}
PLUGIN.acts["leanwall"] = {
	["player"] = {sequence = "male_lean_back", untimed = true, transition = {[ACT_STARTSEQ] = "male_idle_to_lean_back", [ACT_ENDSEQ] = "male_lean_back_to_idle"}, onCheck = facingWallBack},
	["player_female"] = {sequence = "female_lean_back", untimed = true, transition = {[ACT_STARTSEQ] = "female_idle_to_lean_back", [ACT_ENDSEQ] = "female_lean_back_to_idle"}, onCheck = facingWallBack}
}
PLUGIN.acts["leanleft"] = {
	["player"] = {sequence = "male_lean_left", untimed = true, transition = {[ACT_STARTSEQ] = "male_idle_to_lean_left", [ACT_ENDSEQ] = "male_lean_left_to_idle"}, onCheck = facingWallLeft},
	["player_female"] = {sequence = "female_lean_left", untimed = true, transition = {[ACT_STARTSEQ] = "female_idle_to_lean_left", [ACT_ENDSEQ] = "female_lean_left_to_idle"}, onCheck = facingWallLeft}
}
PLUGIN.acts["mpfleanwall"] = {
	["player"] = {sequence = "police_busyidle1", untimed = true, onCheck = combinefacingWallBack},
}
PLUGIN.acts["mpfmotionleft"] = {
	["player"] = {sequence = "police_motionleft", onCheck = needCombine},
}
PLUGIN.acts["mpfmotionright"] = {
	["player"] = {sequence = "police_motionleft", onCheck = needCombine},
}
PLUGIN.acts["mpfplazathreat1"] = {
	["player"] = {sequence = "police_plazathreat1", onCheck = function(client)
		local res = needCombine(client)
		if(res != nil) then
			res = requireStunstick(client)
		end
		return res
	end},
}
PLUGIN.acts["mpfplazathreat2"] = {
	["player"] = {sequence = "police_plazathreat2", onCheck = needCombine},
}
PLUGIN.acts["mpfpoint"] = {
	["player"] = {sequence = "police_point", onCheck = needCombine},
}
--[[
PLUGIN.acts["injured"] = {
	["citizen_male"] = {sequence = {"d1_town05_wounded_idle_1", "d1_town05_wounded_idle_2", "d1_town05_winston_down"}, untimed = true},
	["citizen_female"] = {sequence = "d1_town05_wounded_idle_1", untimed = true}
}

PLUGIN.acts["arrest"] = {
	["citizen_male"] = {sequence = "apcarrestidle", untimed = true, onCheck = facingWall}
}

PLUGIN.acts["cheer"] = {
	["citizen_male"] = {sequence = {"cheer1", "cheer2", "wave_smg1"}},
	["citizen_female"] = {sequence = {"cheer1", "wave_smg1"}}
}

PLUGIN.acts["here"] = {
	["citizen_male"] = {sequence = {"wave_close", "wave"}},
	["citizen_female"] = {sequence = {"wave_close", "wave"}}
}

PLUGIN.acts["sitwall"] = {
	["citizen_male"] = {sequence = {"plazaidle4", "injured1"}, untimed = true, onCheck = facingWallBack},
	["citizen_female"] = {sequence = {"plazaidle4", "injured1", "injured2"}, untimed = true, onCheck = facingWallBack}
}

PLUGIN.acts["stand"] = {
	["citizen_male"] = {sequence = {"lineidle01", "lineidle02", "lineidle03", "lineidle04"}, untimed = true},
	["citizen_female"] = {sequence = {"lineidle01", "lineidle02", "lineidle03"}, untimed = true},
	["metrocop"] = {sequence = "plazathreat2", untimed = true}
}
]]