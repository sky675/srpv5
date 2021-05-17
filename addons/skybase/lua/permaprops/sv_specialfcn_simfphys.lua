--[[-------------------------------------------------------------------------
	Modifed code from Simfphys Base
---------------------------------------------------------------------------]]

local function ValidateModel(model)
	local v_list = list.Get"simfphys_vehicles"
	for listname,_ in pairs(v_list) do
		if v_list[listname].Members.CustomWheels then
			local FrontWheel = v_list[listname].Members.CustomWheelModel
			local RearWheel = v_list[listname].Members.CustomWheelModel_R

			if FrontWheel then
				FrontWheel = string.lower(FrontWheel)
			end

			if RearWheel then
				RearWheel = string.lower(RearWheel)
			end

			if model == FrontWheel or model == RearWheel then
				return true
			end
		end
	end

	local wheels = list.Get"simfphys_Wheels"[model]

	if wheels then
		return true
	end

	return false
end

local function GetRight(ent, index, WheelPos)
	local Steer = ent:GetTransformedDirection()

	local Right = ent.Right

	if WheelPos.IsFrontWheel then
		Right = (IsValid(ent.SteerMaster) and Steer.Right or ent.Right) * (WheelPos.IsRightWheel and 1 or -1)
	else
		Right = (IsValid(ent.SteerMaster) and Steer.Right2 or ent.Right) * (WheelPos.IsRightWheel and 1 or -1)
	end

	return Right
end

local function SetWheelOffset(ent, offset_front, offset_rear)
	if not IsValid(ent) then return end

	ent.WheelTool_Foffset = offset_front
	ent.WheelTool_Roffset = offset_rear

	if not istable(ent.Wheels) or not istable(ent.GhostWheels) then return end

	for i = 1,table.Count(ent.GhostWheels) do
		local Wheel = ent.Wheels[i]
		local WheelModel = ent.GhostWheels[i]
		local WheelPos = ent:LogicWheelPos(i)

		if IsValid(Wheel) and IsValid(WheelModel) then
			local Pos = Wheel:GetPos()
			local Right = GetRight(ent, i, WheelPos)
			local offset = WheelPos.IsFrontWheel and offset_front or offset_rear

			WheelModel:SetParent(nil)

			local physObj = WheelModel:GetPhysicsObject()
			if IsValid(physObj) then
				physObj:EnableMotion(false)
			end

			WheelModel:SetPos(Pos + Right * offset)
			WheelModel:SetParent(Wheel)
		end
	end
end

local function ApplyWheel(ent, data)
	ent.CustomWheelAngleOffset = data[2]
	ent.CustomWheelAngleOffset_R = data[4]

	timer.Simple(0.05, function()
		if not IsValid(ent) then return end
		for i = 1,table.Count(ent.GhostWheels) do
			local Wheel = ent.GhostWheels[i]

			if IsValid(Wheel) then
				local isfrontwheel = (i == 1 or i == 2)
				local swap_y = (i == 2 or i == 4 or i == 6)

				local angleoffset = isfrontwheel and ent.CustomWheelAngleOffset or ent.CustomWheelAngleOffset_R

				local model = isfrontwheel and data[1] or data[3]

				local fAng = ent:LocalToWorldAngles(ent.VehicleData.LocalAngForward)
				local rAng = ent:LocalToWorldAngles(ent.VehicleData.LocalAngRight)

				local Forward = fAng:Forward()
				local Right = swap_y and -rAng:Forward() or rAng:Forward()
				local Up = ent:GetUp()

				local Camber = data[5] or 0

				local ghostAng = Right:Angle()
				local mirAng = swap_y and 1 or -1
				ghostAng:RotateAroundAxis(Forward,angleoffset.p * mirAng)
				ghostAng:RotateAroundAxis(Right,angleoffset.r * mirAng)
				ghostAng:RotateAroundAxis(Up,-angleoffset.y)

				ghostAng:RotateAroundAxis(Forward, Camber * mirAng)

				Wheel:SetModelScale(1)
				Wheel:SetModel(model)
				Wheel:SetAngles(ghostAng)

				timer.Simple(0.05, function()
					if not IsValid(Wheel) or not IsValid(ent) then return end
					local wheelsize = Wheel:OBBMaxs() - Wheel:OBBMins()
					local radius = isfrontwheel and ent.FrontWheelRadius or ent.RearWheelRadius
					local size = (radius * 2) / math.max(wheelsize.x,wheelsize.y,wheelsize.z)

					Wheel:SetModelScale(size)
				end)
			end
		end
	end)
end

local function GetAngleFromSpawnlist( model )
	if not model then print"invalid model" return Angle(0,0,0) end

	model = string.lower(model)

	local v_list = list.Get"simfphys_vehicles"
	for listname,_ in pairs(v_list) do
		if v_list[listname].Members.CustomWheels then
			local FrontWheel = v_list[listname].Members.CustomWheelModel
			local RearWheel = v_list[listname].Members.CustomWheelModel_R

			if FrontWheel then
				FrontWheel = string.lower(FrontWheel)
			end

			if RearWheel then
				RearWheel = string.lower(RearWheel)
			end

			if model == FrontWheel or model == RearWheel then
				local Angleoffset = v_list[listname].Members.CustomWheelAngleOffset
				if (Angleoffset) then
					return Angleoffset
				end
			end
		end
	end

	local wheels = list.Get"simfphys_Wheels"[model]
	local output = wheels and wheels.Angle or Angle(0,0,0)

	return output
end

local function SaveInfo(ent)
	local out = {}

	out.SpawnName = ent:GetSpawn_List()
	out.SteerSpeed = ent:GetSteerSpeed()
	out.SteerFadeSpeed = ent:GetFastSteerConeFadeSpeed()
	out.SteerAngFast = ent:GetFastSteerAngle()
	out.SoundPreset = ent:GetEngineSoundPreset()
	out.IdleRPM = ent:GetIdleRPM()
	out.MaxRPM = ent:GetLimitRPM()
	out.PowerStart = ent:GetPowerBandStart()
	out.PowerEnd = ent:GetPowerBandEnd()
	out.PeakTorque = ent:GetMaxTorque()
	out.HasTurbo = ent:GetTurboCharged()
	out.HasBlower = ent:GetSuperCharged()
	out.HasRevLimiter = ent:GetRevlimiter()
	out.HasBulletProofTires = ent:GetBulletProofTires()
	out.MaxTraction = ent:GetMaxTraction()
	out.GripOffset = ent:GetTractionBias()
	out.BrakePower = ent:GetBrakePower()
	out.PowerDistribution = ent:GetPowerDistribution()
	out.Efficiency = ent:GetEfficiency()
	out.HornSound = ent.snd_horn
	out.HasBackfire = ent:GetBackFire()
	out.DoesntStall = ent:GetDoNotStall()
	out.SoundOverride = ent:GetSoundoverride()

	out.FrontHeight = ent:GetFrontSuspensionHeight()
	out.RearHeight = ent:GetRearSuspensionHeight()

	out.Camber = ent.Camber or 0

	if ent.FrontDampingOverride and ent.FrontConstantOverride and ent.RearDampingOverride and ent.RearConstantOverride then
		out.FrontDampingOverride = ent.FrontDampingOverride
		out.FrontConstantOverride = ent.FrontConstantOverride
		out.RearDampingOverride = ent.RearDampingOverride
		out.RearConstantOverride = ent.RearConstantOverride
	end

	out.PoseParametors = {}
	for i = 0,ent:GetNumPoseParameters() - 1 do
		local name = ent:GetPoseParameterName(i)
		out.PoseParametors[name] = ent:GetPoseParameter(name)
	end

	out.turret_yaw = ent:GetPoseParameter"turret_yaw"
	out.turret_pitch = ent:GetPoseParameter"turret_pitch"

	if ent.CustomWheels and ent.GhostWheels then
		if IsValid(ent.GhostWheels[1]) then
			out.FrontWheelOverride = ent.GhostWheels[1]:GetModel()
		elseif IsValid(ent.GhostWheels[2]) then
			out.FrontWheelOverride = ent.GhostWheels[2]:GetModel()
		end

		if IsValid(ent.GhostWheels[3]) then
			out.RearWheelOverride = ent.GhostWheels[3]:GetModel()
		elseif IsValid(ent.GhostWheels[4]) then
			out.RearWheelOverride = ent.GhostWheels[4]:GetModel()
		end
	end

	local tsc = ent:GetTireSmokeColor()
	out.TireSmokeColor = table.concat{tsc.r, ",", tsc.g, ",", tsc.b}

	local Gears = ""
	for _,v in pairs(ent.Gears) do
		Gears = Gears .. v .. ","
	end

	local c = ent:GetColor()
	out.Color = table.concat{c.r, ",", c.g, ",", c.b, ",", c.a}

	local bodygroups = {}
	for k,v in pairs(ent:GetBodyGroups()) do
		bodygroups[k] = ent:GetBodygroup(k)
	end

	out.BodyGroups = string.Implode(",", bodygroups)

	out.Skin = ent:GetSkin()

	out.Gears = Gears
	out.FinalGear = ent:GetDifferentialGear()

	if ent.WheelTool_Foffset then
		out.WheelTool_Foffset = ent.WheelTool_Foffset
	end

	if ent.WheelTool_Roffset then
		out.WheelTool_Roffset = ent.WheelTool_Roffset
	end

	if ent.snd_blowoff then
		out.snd_blowoff = ent.snd_blowoff
	end

	if ent.snd_spool then
		out.snd_spool = ent.snd_spool
	end

	if ent.snd_bloweron then
		out.snd_bloweron = ent.snd_bloweron
	end

	if ent.snd_bloweroff then
		out.snd_bloweroff = ent.snd_bloweroff
	end

	out.backfiresound = ent:GetBackfireSound()

	out.SubMaterials = {}
	for i = 0,(table.Count(ent:GetMaterials()) - 1) do
		out.SubMaterials[i] = ent:GetSubMaterial(i)
	end

	return out
end

local function ApplyInfo(Ent, info)
	local vehicle = list.Get"simfphys_vehicles"[info.SpawnName]

	if not vehicle then return false end

	local tsc = string.Explode(",", info.TireSmokeColor)
	Ent:SetTireSmokeColor(Vector(tonumber(tsc[1]), tonumber(tsc[2]), tonumber(tsc[3])))

	Ent.Turbocharged = tobool(info.HasTurbo)
	Ent.Supercharged = tobool(info.HasBlower)

	Ent:SetEngineSoundPreset(math.Clamp(tonumber(info.SoundPreset), -1, 14))
	Ent:SetMaxTorque(math.Clamp(tonumber(info.PeakTorque), 20, 1000))
	Ent:SetDifferentialGear(math.Clamp(tonumber(info.FinalGear), 0.2, 6))

	Ent:SetSteerSpeed(math.Clamp(tonumber(info.SteerSpeed), 1, 16))
	Ent:SetFastSteerAngle(math.Clamp(tonumber(info.SteerAngFast), 0, 1))
	Ent:SetFastSteerConeFadeSpeed(math.Clamp(tonumber(info.SteerFadeSpeed), 1, 5000))

	Ent:SetEfficiency(math.Clamp(tonumber(info.Efficiency), 0.2, 4))
	Ent:SetMaxTraction(math.Clamp(tonumber(info.MaxTraction), 5, 1000))
	Ent:SetTractionBias(math.Clamp(tonumber(info.GripOffset), -0.99, 0.99))
	Ent:SetPowerDistribution(math.Clamp(tonumber(info.PowerDistribution), -1, 1))

	Ent:SetBackFire(tobool(info.HasBackfire))
	Ent:SetDoNotStall(tobool(info.DoesntStall))

	Ent:SetIdleRPM(math.Clamp(tonumber(info.IdleRPM), 1, 25000))
	Ent:SetLimitRPM(math.Clamp(tonumber(info.MaxRPM), 4, 25000))
	Ent:SetRevlimiter(tobool(info.HasRevLimiter))
	Ent:SetPowerBandEnd(math.Clamp(tonumber(info.PowerEnd), 3, 25000))
	Ent:SetPowerBandStart(math.Clamp(tonumber(info.PowerStart), 2, 25000))

	Ent:SetTurboCharged(Ent.Turbocharged)
	Ent:SetSuperCharged(Ent.Supercharged)
	Ent:SetBrakePower(math.Clamp(tonumber(info.BrakePower), 0.1, 500))

	for name,pose in pairs(info.PoseParametors) do
		Ent:SetPoseParameter(name, pose)
	end

	Ent:SetSoundoverride(info.SoundOverride or "")

	Ent:SetLights_List(Ent.LightsTable or "no_lights")

	Ent:SetBulletProofTires(tobool(info.HasBulletProofTires))

	Ent.snd_horn = info.HornSound

	Ent.snd_blowoff = info.snd_blowoff
	Ent.snd_spool = info.snd_spool
	Ent.snd_bloweron = info.snd_bloweron
	Ent.snd_bloweroff = info.snd_bloweroff

	Ent:SetBackfireSound(info.backfiresound or "")

	local Gears = {}
	local Data = string.Explode(",", info.Gears)
	for i = 1,table.Count(Data) do
		local gRatio = tonumber(Data[i])

		if isnumber(gRatio) then
			if i == 1 then
				Gears[i] = math.Clamp(gRatio, -5, -0.001)
			elseif i == 2 then
				Gears[i] = 0
			else
				Gears[i] = math.Clamp(gRatio, 0.001, 5)
			end
		end
	end
	Ent.Gears = Gears

	if istable(info.SubMaterials) then
		for i = 0,table.Count(info.SubMaterials) do
			Ent:SetSubMaterial(i, info.SubMaterials[i])
		end
	end

	if info.FrontDampingOverride and info.FrontConstantOverride and info.RearDampingOverride and info.RearConstantOverride then
		Ent.FrontDampingOverride = tonumber(info.FrontDampingOverride)
		Ent.FrontConstantOverride = tonumber(info.FrontConstantOverride)
		Ent.RearDampingOverride = tonumber(info.RearDampingOverride)
		Ent.RearConstantOverride = tonumber(info.RearConstantOverride)

		local data = {
			[1] = {Ent.FrontConstantOverride, Ent.FrontDampingOverride},
			[2] = {Ent.FrontConstantOverride, Ent.FrontDampingOverride},
			[3] = {Ent.RearConstantOverride, Ent.RearDampingOverride},
			[4] = {Ent.RearConstantOverride, Ent.RearDampingOverride},
			[5] = {Ent.RearConstantOverride, Ent.RearDampingOverride},
			[6] = {Ent.RearConstantOverride, Ent.RearDampingOverride}
		}

		local elastics = Ent.Elastics
		if elastics then
			for i = 1,table.Count(elastics) do
				local elastic = elastics[i]
				if Ent.StrengthenSuspension == true then
					if IsValid(elastic) then
						elastic:Fire("SetSpringConstant", data[i][1] * 0.5, 0)
						elastic:Fire("SetSpringDamping", data[i][2] * 0.5, 0)
					end

					local elastic2 = elastics[i * 10]
					if IsValid(elastic2) then
						elastic2:Fire("SetSpringConstant", data[i][1] * 0.5, 0)
						elastic2:Fire("SetSpringDamping", data[i][2] * 0.5, 0)
					end
				else
					if IsValid(elastic) then
						elastic:Fire("SetSpringConstant", data[i][1], 0)
						elastic:Fire("SetSpringDamping", data[i][2], 0)
					end
				end
			end
		end
	end

	Ent:SetFrontSuspensionHeight(tonumber(info.FrontHeight))
	Ent:SetRearSuspensionHeight(tonumber(info.RearHeight))

	local groups = string.Explode(",", info.BodyGroups)
	for i = 1,table.Count(groups) do
		Ent:SetBodygroup(i, tonumber(groups[i]))
	end

	Ent:SetSkin(info.Skin)

	local c = string.Explode(",", info.Color)
	local Color = Color(tonumber(c[1]), tonumber(c[2]), tonumber(c[3]), tonumber(c[4]))

	local dot = Color.r * Color.g * Color.b * Color.a
	Ent.OldColor = dot
	Ent:SetColor(Color)

	if Ent.CustomWheels and Ent.GhostWheels then
		timer.Simple(Update and 0.25 or 0, function()
			if not IsValid(Ent) then return end
			if info.WheelTool_Foffset and info.WheelTool_Roffset then
				SetWheelOffset(Ent, info.WheelTool_Foffset, info.WheelTool_Roffset)
			end

			if not info.FrontWheelOverride and not info.RearWheelOverride then return end

			local front_model = info.FrontWheelOverride or vehicle.Members.CustomWheelModel
			local front_angle = GetAngleFromSpawnlist(front_model)

			local camber = info.Camber or 0
			local rear_model = info.RearWheelOverride or (vehicle.Members.CustomWheelModel_R and vehicle.Members.CustomWheelModel_R or front_model)
			local rear_angle = GetAngleFromSpawnlist(rear_model)

			if not front_model or not rear_model or not front_angle or not rear_angle then return end

			if ValidateModel(front_model) and ValidateModel(rear_model) then
				Ent.Camber = camber
				ApplyWheel(Ent, {front_model, front_angle, rear_model, rear_angle, camber})
			else
				ply:PrintMessage(HUD_PRINTTALK, "selected wheel does not exist on the server")
			end
		end)
	end
end

local function MakeVehicle(Ent, VName)
	local VTable = list.Get"simfphys_vehicles"[VName]
	Ent.VehicleName = VName
	Ent.VehicleTable = VTable
	Ent.EntityOwner = nil
	Ent:SetSpawn_List(VName)

	if VTable.Members then
		table.Merge(Ent, VTable.Members)

		if Ent.ModelInfo then
			if Ent.ModelInfo.Bodygroups then
				for i = 1,table.Count(Ent.ModelInfo.Bodygroups) do
					Ent:SetBodygroup(i, Ent.ModelInfo.Bodygroups[i])
				end
			end

			if Ent.ModelInfo.Skin then
				Ent:SetSkin(Ent.ModelInfo.Skin)
			end

			if Ent.ModelInfo.Color then
				Ent:SetColor(Ent.ModelInfo.Color)

				local Color = Ent.ModelInfo.Color
				local dot = Color.r * Color.g * Color.b * Color.a
				Ent.OldColor = dot
			end
		end

		Ent:SetTireSmokeColor(Vector(180,180,180) / 255)

		Ent.Turbocharged = Ent.Turbocharged or false
		Ent.Supercharged = Ent.Supercharged or false

		Ent:SetEngineSoundPreset(Ent.EngineSoundPreset)
		Ent:SetMaxTorque(Ent.PeakTorque)

		Ent:SetDifferentialGear(Ent.DifferentialGear)

		Ent:SetSteerSpeed(Ent.TurnSpeed)
		Ent:SetFastSteerConeFadeSpeed(Ent.SteeringFadeFastSpeed)
		Ent:SetFastSteerAngle(Ent.FastSteeringAngle)

		Ent:SetEfficiency(Ent.Efficiency)
		Ent:SetMaxTraction(Ent.MaxGrip)
		Ent:SetTractionBias(Ent.GripOffset / Ent.MaxGrip)
		Ent:SetPowerDistribution(Ent.PowerBias)

		Ent:SetBackFire(Ent.Backfire or false)
		Ent:SetDoNotStall(Ent.DoNotStall or false)

		Ent:SetIdleRPM(Ent.IdleRPM)
		Ent:SetLimitRPM(Ent.LimitRPM)
		Ent:SetRevlimiter(Ent.Revlimiter or false)
		Ent:SetPowerBandEnd(Ent.PowerbandEnd)
		Ent:SetPowerBandStart(Ent.PowerbandStart)

		Ent:SetTurboCharged(Ent.Turbocharged)
		Ent:SetSuperCharged(Ent.Supercharged)
		Ent:SetBrakePower(Ent.BrakePower)

		Ent:SetLights_List(Ent.LightsTable or "no_lights")

		Ent:SetBulletProofTires(Ent.BulletProofTires or false)

		Ent:SetBackfireSound(Ent.snd_backfire or "")

		if not simfphys.WeaponSystemRegister then
			if simfphys.ManagedVehicles then
				print"[SIMFPHYS ARMED] IS OUT OF DATE"
			end
		else
			timer.Simple(0.2, function()
				simfphys.WeaponSystemRegister(Ent)
			end)

			if (simfphys.armedAutoRegister and not simfphys.armedAutoRegister()) or simfphys.RegisterEquipment then
				print"[SIMFPHYS ARMED]: ONE OF YOUR ADDITIONAL SIMFPHYS-ARMED PACKS IS CAUSING CONFLICTS!!!"
				print"[SIMFPHYS ARMED]: PRECAUTIONARY RESTORING FUNCTION:"
				print"[SIMFPHYS ARMED]: simfphys.FireHitScan"
				print"[SIMFPHYS ARMED]: simfphys.FirePhysProjectile"
				print"[SIMFPHYS ARMED]: simfphys.RegisterCrosshair"
				print"[SIMFPHYS ARMED]: simfphys.RegisterCamera"
				print"[SIMFPHYS ARMED]: simfphys.armedAutoRegister"
				print"[SIMFPHYS ARMED]: REMOVING FUNCTION:"
				print"[SIMFPHYS ARMED]: simfphys.RegisterEquipment"
				print"[SIMFPHYS ARMED]: CLEARING OUTDATED ''RegisterEquipment'' HOOK"
				print"[SIMFPHYS ARMED]: !!!FUNCTIONALITY IS NOT GUARANTEED!!!"

				simfphys.FireHitScan = function(data) simfphys.FireBullet(data) end
				simfphys.FirePhysProjectile = function(data) simfphys.FirePhysBullet(data) end
				simfphys.RegisterCrosshair = function(ent, data) simfphys.xhairRegister(ent, data) end
				simfphys.RegisterCamera = function(ent, offset_firstperson, offset_thirdperson, bLocalAng, attachment)
					simfphys.CameraRegister(ent, offset_firstperson, offset_thirdperson, bLocalAng, attachment)
				end

				hook.Remove("PlayerSpawnedVehicle", "simfphys_armedvehicles")
				simfphys.RegisterEquipment = nil
				simfphys.armedAutoRegister = function(vehc)
					simfphys.WeaponSystemRegister(vehc)
					return true
				end
			end
		end
	end
end

--[[-------------------------------------------------------------------------
	PermaProps simfphys special Spawn/Save functions
---------------------------------------------------------------------------]]

PermaProps.SpecialENTSSave.gmod_sent_vehicle_fphysics_base = function(ent)
	if not ent.VehicleName then return false end

	local content = {Other = {}}
	content.Other.VehicleName = ent.VehicleName
	content.Other.VehicleData = SaveInfo(ent)

	return content
end

PermaProps.SpecialENTSSpawn.gmod_sent_vehicle_fphysics_base = function(ent, data)
	if not data then return false end

	ent:SetPos(ent:GetPos() + Vector(0, 0, 15))
	ent:Spawn()
	ent:Activate()

	MakeVehicle(ent, data.VehicleName)
	ApplyInfo(ent, data.VehicleData)

	return true
end