AddCSLuaFile()

local PLUGIN = PLUGIN

ENT.PrintName = "Camera"
ENT.Category = "STALKER"
ENT.Author = "sky"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Base = "sky_cam_base"

ENT.model = "models/props/cs_assault/camera.mdl"
--pos Vector( 13.58, 33.51, -6.41 )

--lua_run local fwd = Entity(1):GetEyeTrace().Entity:GetForward() Entity(1):SetEyeAngles(fwd:Angle()+Angle( 21.5, 32.5, 0 ))

ENT.viewOffset = Vector( 13.62, 33.53, -6.37 )
ENT.anglOffset = Angle( 21.5, 32.5, 0 )

--lua_run_cl local vec = Vector( 1.79, -20.4, -1 ) local self = LocalPlayer():GetEyeTrace().Entity CreateParticleSystem(self, "smoke_gib_01", PATTACH_ABSORIGIN_FOLLOW, 0, vec)

if(CLIENT) then
	ENT.relativeAtt = Vector( 1.79, -20.4, -1 ) --vector where smoke should appear
	ENT.relativeSpark = Vector( 1.79, -20.4, -1 ) --vector where spark should appear
end