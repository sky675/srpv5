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

SWEP.PrintName			= "Echo Detector"			
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
--SWEP.WorldModel = "models/tnb/weapons/w_detector_echo.mdl"
SWEP.WorldModel = "models/kali/miscstuff/stalker/detector_echo.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
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
	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-19.997, 7.368, 0) },
	["ValveBiped.Bip01_L_Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0.847, -23.803, 0) },
	["ValveBiped.Bip01_L_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-2.1, 2.605, -0.06), angle = Angle(-3.211, -1.39, -79.242) },
	["ValveBiped.Bip01_L_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.266, 0.855, 0.841) },
	["Detonator"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-4.672, -25.209, 0) },
	["ValveBiped.Bip01_R_Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 39.986, 0) },
	["ValveBiped.Bip01_L_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-0.908, -6.158, -6.349) },
	["ValveBiped.Bip01_L_Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-4.692, 15.583, 0) },
	["Slam_base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -18.889, 0) },
	["ValveBiped.Bip01_R_Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0.898, 1.899) },
	["ValveBiped.Bip01_L_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.875, 16.205, 0) },
	["ValveBiped.Bip01_L_Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(4.118, 19.423, 0) },
	["ValveBiped.Bip01_L_Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 56.792, 0) },
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(25.115, -88.232, 0) },
	["ValveBiped.Bip01_L_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -30.184, 0) },
	["ValveBiped.Bip01_R_Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(18.989, -64.88, 0) },
	["ValveBiped.Bip01_R_Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(4.327, -45.591, -13.356) },
	["ValveBiped.Bip01_L_Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 59.638, 0) },
	["ValveBiped.Bip01_R_Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0.537, -8.941, 0) },
	["ValveBiped.Bip01_R_Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 30.1, 0) },
	["ValveBiped.Bip01_L_Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 81.625, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(11.39, -0.225, 0.365) },
	["ValveBiped.Bip01_R_Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(6.951, -60.103, -2.806) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(2.674, -20.901, 0) }
}


SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.VElements = {
	["echo"] = { type = "Model", model = "models/kali/miscstuff/stalker/detector_echo.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(4.032, 1.725, 1.968), angle = Angle(36.025, 16.77, 56.62), size = Vector(0.911, 0.911, 0.911), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {[1] = 1, [2] = 1} },
	--["detector"] = { type = "Model", model = "models/kali/miscstuff/stalker/detector_bear.mdl", bone = "l-upperarm", rel = "", pos = Vector(8.831, 0.518, -2.5), angle = Angle(33.895, 68.96, 17.531), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
	["bolt"] = { type = "Model", model = "models/kali/miscstuff/stalker/bolt.mdl", bone = "Slam_base", rel = "", pos = Vector(-2.962, -64.35, 19.85), angle = Angle(-1.163, 18.54, 108.359), size = Vector(0.856, 0.856, 0.856), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["Bear"] = { type = "Model", model = "models/kali/miscstuff/stalker/detector_echo.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.675, 1.557, -2.597), angle = Angle(-106.364, -167.144, 12.857), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
}


local anomalies = {
	--list of ["uniqueid"] = true that this detects
	//junk
	["art_dragoneye"] = true,
	["art_basilisk"] = true,
	["art_blackstone"] = true, --this apparently is unused
	["art_knot"] = true,
	["art_ball"] = true,
	["art_gimlet"] = true,
	["art_tapeworm"] = true,
	["art_seraphim"] = true,
	["art_signet"] = true,
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
}
local detectionRange = 500

SWEP.LastBeep = 0
function SWEP:Think()
	if CLIENT then
		local anoms = {}
		--iterate through a smaller table? idk
		for k,v in pairs(ents.FindInSphere(self:GetOwner():GetPos(), detectionRange)) do
			--[[ --old way for backup
			if anomalies[string.lower(v:GetClass())] then
				table.insert(anoms, v)
			end]]
			--[[if(v:GetClass() == "nut_item") then
				if(v:getItemTable().artifactID and anomalies[string.lower(v:getItemTable().artifactID)]) then
					table.insert(anoms, v)
				end
			end]]
			if(v.getItemID and anomalies[v:getItemID()]) then
				table.insert(anoms, v)
			end
			--im not entirely sure what else it should beep at so
			
		end
		local dist = 501
		local ent = nil
		for k,v in pairs(anoms) do
			local pos = v:GetPos()
			local dek = pos - self.Owner:GetShootPos()
			local aimvec = self.Owner:GetAimVector()
			local sos = dek:GetNormalized()
			local dot = sos:Dot(aimvec)
			local clampdot = (1-math.Clamp(dot, 0, 0.5))
			if v:GetPos():Distance(self.Owner:GetPos())*clampdot < dist then
				dist = v:GetPos():Distance(self.Owner:GetPos())*clampdot
				ent = v
			end
		end
		if dist < 500 then
			if self.LastBeep + dist/300 - CurTime() <= 0 then
				self.LastBeep = CurTime()
				self.VElements["echo"].skin = 2
				timer.Simple(0.1, function()
					if IsValid(self) then
						self.VElements["echo"].skin = 1
					end
				end)
				self.Owner:EmitSound(Sound("stalkerdetectors/echo.wav"), 100, 100)//math.Clamp(250-dist/2,50,250))
			end
		end
	end
end