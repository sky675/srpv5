sound.Add({	name		= "V92_Uni_QuickMove",
	channel		= CHAN_WEAPON,
	level		= 100,
	volume		= 1.0,
	pitch		= { 95, 105 },
	sound		= "jessev92/weapons/univ/throw_gren.wav",
})

sound.Add({	name		= "V92_Uni_Draw",
	channel		= CHAN_BODY,
	level		= 75,
	volume		= 1.0,
	pitch		= { 95, 105 },
	sound		= "jessev92/weapons/univ/draw1.wav",
})

sound.Add({	name		= "V92_Uni_Holster",
	channel		= CHAN_BODY,
	level		= 75,
	volume		= 1.0,
	pitch		= { 95, 105 },
	sound		= "jessev92/weapons/univ/holster1.wav",
})

if(SERVER) then
AddCSLuaFile();
end

SWEP.PrintName			= "Bear Detector"			
SWEP.Slot				= 3
SWEP.SlotPos			= 1
SWEP.Category = "srp detectors"
SWEP.Author	= "Subleader and AirBlack with edits by sky"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "Right click for throw a bolt. left click works too idk"	
SWEP.Base	= "detector_base"
SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 61
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_slam.mdl"
--SWEP.WorldModel = "models/tnb/weapons/w_detector_bear.mdl"
SWEP.WorldModel = "models/kali/miscstuff/stalker/detector_bear.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.Spawnable	= true
SWEP.AdminSpawnable	= true

SWEP.UseDel = CurTime()

function SWEP:IdleTiming()
end

SWEP.Primary.Delay				= 0
SWEP.Primary.Recoil				= 0
SWEP.Primary.Damage				= 0
SWEP.Primary.NumShots			= 0
SWEP.Primary.Cone				= 0	
SWEP.Primary.ClipSize			= 1
SWEP.Primary.DefaultClip		= 25
SWEP.Primary.Automatic   		= false
SWEP.Primary.Ammo         		= "pistol"
SWEP.Secondary.Delay			= 0
SWEP.Secondary.Recoil			= 0
SWEP.Secondary.Damage			= 0
SWEP.Secondary.NumShots			= 0
SWEP.Secondary.Cone		  		= 0
SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Automatic   		= false
SWEP.Secondary.Ammo         	= "none"

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -9.969, 0) },
	["ValveBiped.Bip01_L_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0.848, -23.802, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(11.39, -0.225, -0.366) },
	["ValveBiped.Bip01_R_Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 39.987, 0) },
	["Detonator"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0.898, 1.899) },
	["ValveBiped.Bip01_L_Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 59.638, 0) },
	["ValveBiped.Bip01_L_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-1.208, -0.471, 0) },
	["ValveBiped.Bip01_L_Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-4.692, 15.583, 0) },
	["ValveBiped.Bip01_R_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(4.327, -45.591, -13.356) },
	["Slam_base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -18.889, 0) },
	["ValveBiped.Bip01_L_Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 56.793, 0) },
	["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-0.9, 15.387, 0) },
	["ValveBiped.Bip01_L_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(4.119, 19.423, 0) },
	["ValveBiped.Bip01_R_Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 30.101, 0) },
	["ValveBiped.Bip01_R_Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0.537, -8.941, 0) },
	["ValveBiped.Bip01_R_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(6.951, -60.102, -2.806) },
	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(18.99, -64.88, 0) },
	["ValveBiped.Bip01_L_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -33.022, 0) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(25.166, -88.231, 0) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(2.674, -20.901, 0) },
	["ValveBiped.Bip01_L_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-4.671, -25.209, 0) },
	["ValveBiped.Bip01_L_Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 81.625, 0) },
	["ValveBiped.Bip01_L_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.267, 0.855, 0.841) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-2.1, 2.605, -0.06), angle = Angle(-3.211, -1.389, -79.242) },
	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-19.997, 7.368, 0) }
}

SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.WElements = {
	["Bear"] = { type = "Model", model = "models/kali/miscstuff/stalker/detector_bear.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.675, 1.557, -2.597), angle = Angle(-106.364, -167.144, 12.857), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
}

SWEP.VElements = {
	["veles"] = { type = "Model", model = "models/kali/miscstuff/stalker/detector_bear.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(3.365, 1.164, 0.809), angle = Angle(35.68, 13.017, 54.263), size = Vector(0.944, 0.944, 0.944), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {[1] = 1, [2] = 1, [3] = 1} },
	["bolt"] = { type = "Model", model = "models/kali/miscstuff/stalker/bolt.mdl", bone = "Slam_base", rel = "", pos = Vector(-2.962, -64.35, 19.85), angle = Angle(-1.163, 18.54, 108.359), size = Vector(0.856, 0.856, 0.856), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


local anomalies = {
	--list of ["uniqueid"] = true that this detects
	["art_dragoneye"] = true,
	["art_knot"] = true,
	["art_ball"] = true,
	["art_tapeworm"] = true,
	["art_seraphim"] = true,
	["art_electron"] = true,
	["art_claw"] = true,
	["art_generator"] = true,
	["art_blackangel"] = true,
	["art_grapes"] = true,
	["art_miserskull"] = true,
	["art_phantomstar"] = true,
	["art_medal"] = true,
	["art_moon"] = true,
	["art_sourpuss"] = true,
	["art_sandstone"] = true,
	["art_fountain"] = true,
	["art_spike"] = true,
	["art_thistle"] = true,
	["art_bat"] = true,
	["art_sun"] = true,
	["art_heart"] = true,
	["art_chain"] = true,
	["art_atom"] = true,
	["art_beacon"] = true,
	["art_cell"] = true,
	["art_cocoon"] = true,
	
	["art_stoneblood"] = true,
	["art_meatchunk"] = true,
	["art_sparkler"] = true,
	["art_stoneflower"] = true,
	["art_jellyfish"] = true,
	["art_nightstar"] = true,
	["art_mamasbeads"] = true,
	["art_battery"] = true,
	["art_soul"] = true,

	["art_crystal"] = true,
	["art_wrenched"] = true,
	["art_gravi"] = true,
	["art_eye"] = true,
	["art_kolobok"] = true,
	["art_shell"] = true,
}
local detectionRange = 500

if CLIENT then
	--[[
	local matScreen = Material("models/kali/miscstuff/stalker/detectors/detector_bear_c"); // ��������, ������� ����
	local RTTexture = GetRenderTarget("DTC_BEAR", 512, 512); // ����� ��������

	local dot = surface.GetTextureID("models/kali/miscstuff/stalker/detectors/detector_bear_segment_copy");
	local bg = surface.GetTextureID("models/kali/miscstuff/stalker/detectors/detector_bear_copy");

	function SWEP:RenderScreen()

		local NewRT = RTTexture;
		local oldW = ScrW();
		local oldH = ScrH();
		local ply = LocalPlayer();

		matScreen:SetTexture( "$basetexture", NewRT);
	
		local OldRT = render.GetRenderTarget();
		render.SetRenderTarget(NewRT);
		render.SetViewPort( 0, 0, 512, 512);

		cam.Start2D();

			render.Clear( 50, 50, 100, 0 );

			surface.SetDrawColor( 255, 255, 255, 255 );
			surface.SetTexture( bg );
			surface.DrawTexturedRect( 0, 0, 512, 512);

			surface.SetTexture(dot);
		
		
			local anoms = {}
			for k,v in pairs(ents.FindInSphere(self:GetOwner():GetPos(), detectionRange)) do
				if(v.getItemID and anomalies[v:getItemID()]) then
					table.insert(anoms, v)
				end
				--im not entirely sure what else it should beep at so
			end
			local dist = 501
			local ent = nil
			for k,v in pairs(anoms) do
				if v:GetPos():Distance(LocalPlayer():GetPos()) < dist then
					dist = v:GetPos():Distance(LocalPlayer():GetPos())
					ent = v --im psure it detects more than one but idk
				end
			end
			if dist < 500 then
				local ang = ply:GetAngles();
				local pos = ent:GetPos() - ply:GetShootPos()
				surface.SetDrawColor(255, 255, 255, 255)
				pos:Rotate(Angle(0, -1*ang.Yaw, 0));
				if (math.abs(pos.z)<2000) then
					surface.DrawTexturedRectRotated( 131, 118, 150, 150, ((pos:Angle().y % 15) / 15 < 0.5 and pos:Angle().y - (pos:Angle().y % 15) or (pos:Angle().y % 15) / 15 >= 0.5 and pos:Angle().y - (pos:Angle().y % 15)  + 15) + 30  )//�������. �� ������� ������� ������� ���� �� 15(� ��������� 24 �������. 360/24 = 15) � ���� ������� ������ �������� 15, �� �� ���� �������� �������, � ���� ������� ������ �������� 15, �� �� ���� �������� ������� � ���������� 15. ��� ����� ������. ����� ������� �� �������� ����, ������� 15. ������� 'Black Pheonix'� �� �����.
				end
			end

		cam.End2D();

		render.SetRenderTarget(OldRT);
		render.SetViewPort( 0, 0, oldW, oldH )

	end]]
end
SWEP.LastBeep = 0
function SWEP:Think()
	if CLIENT then
		local anoms = {}
		for k,v in pairs(ents.FindInSphere(self:GetOwner():GetPos(), detectionRange)) do
			--[[ --old way for backup
			if anomalies[string.lower(v:GetClass())] then
				table.insert(anoms, v)
			end]]
			if(v.getItemID and anomalies[v:getItemID()]) then
				table.insert(anoms, v)
			end
			--im not entirely sure what else it should beep at so
		end
		local dist = 501
		local ent = nil
		for k,v in pairs(anoms) do
			if v:GetPos():Distance(self.Owner:GetPos()) < dist then
				dist = v:GetPos():Distance(self.Owner:GetPos())
				ent = v
			end
		end
		--still bad at angles and math, taken from a thread on facepunch i found
		--this V wouldnt go negative so wasnt useful
		--[[local tarpos = ent:GetPos()
		tarpos.z = 0
		local plypos = LocalPlayer():GetPos()
		plypos.z = 0
		local eyeToMonster = (tarpos - plypos):GetNormalized() -- Normalized direction to the monster
		local dotProduct = eyeToMonster:Dot(LocalPlayer():GetAngles():Forward()) -- How similar is the player's aim direction to the direction of the monster?
		local aimDegree = math.deg(math.acos(dotProduct))]] -- Convert similarity to degrees
		-- If the degree difference in similarity is bigger than the player's FOV, then most likely it isn't being rendered
		--print("pos ", eyeToMonster, dotProduct, math.acos(dotProduct), aimDegree)

		if(IsValid(ent)) then
			local md = self.VElements["veles"].modelEnt
			if(IsValid(md)) then
				self.VElements["veles"].bodygroup[2] = 1--md:SetBodygroup(2, 1)
				local ply = LocalPlayer()
				local ang = ply:GetAngles();
				local pos = ent:GetPos() - ply:GetShootPos()
				pos:Rotate(Angle(0, -1*ang.Yaw, 0));

				local ange = Angle(0, 0, -pos:Angle().y)
				md:ManipulateBoneAngles(4, ange)
			end

			if dist < 500 and self.LastBeep + dist/300 - CurTime() <= 0 then
				self.LastBeep = CurTime()
				self.Owner:EmitSound(Sound("stalkerdetectors/echo.wav"), 100, 100)//math.Clamp(250-dist/2,50,250))
			end
		else
			self.VElements["veles"].bodygroup[2] = 0--md:SetBodygroup(2, 1)
		end
	end
end
