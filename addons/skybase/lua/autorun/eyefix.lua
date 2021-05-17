if SERVER then
	AddCSLuaFile()

	return
end

local hbone
local pos, ang
local m_Clamp = math.Clamp

local function eyefunc(ply)
	hbone = ply:LookupBone("ValveBiped.Bip01_Head1")
	pos, ang = ply:GetBonePosition( m_Clamp( hbone or 0, 0, 512) )
	ply:SetEyeTarget(pos + ang:Right() * 100000)
end

hook.Add("PrePlayerDraw", "plyeyetest", function(ply)
	eyefunc(ply)
end)