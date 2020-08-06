local PLUGIN = PLUGIN

local plyMeta = FindMetaTable("Player")
--unsure if work
function plyMeta:StartHandcuffAnim()
	if(!self.getChar or !self:getChar()) then return end

	local ent = self
	if(!ent:LookupBone("ValveBiped.Bip01_L_UpperArm")) then return end
	ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_UpperArm"), Angle(20, 8.8, 0))
	ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(15, 0, 0))
	ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_Hand"), Angle(0, 0, 75))
	ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(-15, 0, 0))
	ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_Hand"), Angle(0, 0, -75))
	ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle(-20, 16.6, 0))
end

function plyMeta:EndHandcuffAnim()
	if(!self.getChar or !self:getChar()) then return end

	local ent = self
	if(!ent:LookupBone("ValveBiped.Bip01_L_UpperArm")) then return end
	ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_UpperArm"), Angle(0, 0, 0))
	ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(0, 0, 0))
	ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_Hand"), Angle(0, 0, 0))
	ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(0, 0, 0))
	ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_Hand"), Angle(0, 0, 0))
	ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle(0, 0, 0))
end

--modify bones to work while crouched, and then reset when release
hook.Add("KeyPress", "testtt", function(ply, key)
	if(SERVER and ply:getNetVar("restricted") and key == IN_DUCK) then
		print("start crouch")
		local ent = ply
		ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_UpperArm"), Angle(29.4, 43, 0))
		ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(0.9, 85.7, 0))
		ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_Hand"), Angle(0, 0, 0))
		ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(0, 80.143, 0))
		ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_Hand"), Angle(0, 0, 0))
		ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle(-39.3, 85.4, -30.4))

	end
end)
hook.Add("KeyRelease", "testtt", function(ply, key)
	if(SERVER and ply:getNetVar("restricted") and key == IN_DUCK) then
		print("stop crouch")
		local ent = ply	
		ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_UpperArm"), Angle(20, 8.8, 0))
		ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_Forearm"), Angle(15, 0, 0))
		ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_L_Hand"), Angle(0, 0, 75))
		ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(-15, 0, 0))
		ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_Hand"), Angle(0, 0, -75))
		ent:ManipulateBoneAngles(ent:LookupBone("ValveBiped.Bip01_R_UpperArm"), Angle(-20, 16.6, 0))

	end
end)