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

SWEP.PrintName			= "Veles Detector"			
SWEP.Slot				= 3
SWEP.SlotPos			= 5
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
SWEP.WorldModel = "models/kali/miscstuff/stalker/detector_veles.mdl"--models/tnb/weapons/w_detector_veles.mdl"
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

SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)
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

SWEP.VElements = {
	["veles"] = { type = "Model", model = "models/kali/miscstuff/stalker/detector_veles.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(3.394, 1.174, 0.809), angle = Angle(35.681, 13.017, 54.263), size = Vector(0.945, 0.945, 0.945), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {[1] = 1} },
	["screen"] = { type = "Quad", bone = "ValveBiped.Bip01_Spine4", rel = "veles", pos = Vector(2.94, 0.125, 0.959), angle = Angle(0, -90, 0), size = 0.05, draw_func = nil},
	["bolt"] = { type = "Model", model = "models/kali/miscstuff/stalker/bolt.mdl", bone = "Slam_base", rel = "", pos = Vector(-2.962, -64.35, 19.85), angle = Angle(-1.163, 18.54, 108.359), size = Vector(0.856, 0.856, 0.856), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


SWEP.WElements = {
	["Bear"] = { type = "Model", model = "models/kali/miscstuff/stalker/detector_veles.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.675, 1.557, -2.597), angle = Angle(-106.364, -167.144, 12.857), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {[1] = 1} }
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

	["art_fireball"] = true,
	["art_bubble"] = true,
	["art_goldfish"] = true,
	["art_flame"] = true,
	["art_snowflake"] = true,
}
local detectionRange = 700

if CLIENT then

		/*self.VElements["screen"].draw_func = function( weapon )
			//surface.SetDrawColor(quadInnerColor)
			draw.SimpleText(weapon:Clip1(), "QuadFont", 0, 0, Color(0,255,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end*/

end
SWEP.LastBeep = 0

function PointOnCircle( ang, radius, offX, offY )
	ang = math.rad( ang )
	local x = math.cos( ang ) * -radius + offX
	local y = math.sin( ang ) * radius + offY
	return x, y
end

function SWEP:Think()
	if CLIENT then
		self.VElements["screen"].draw_func = function( weapon )
			
			local function DrawPointOnThatShit(material, x, y, ang, size )
				surface.SetMaterial(Material(material))
				surface.DrawTexturedRectRotated(x, y, size, size, ang )
			end
			
			local plypos = self.Owner:GetPos()
			--i dont like looping through it twice but eh
			for k,v in pairs(ents.FindInSphere(plypos, detectionRange)) do
						
				if ( v:IsValid() ) then
						
					local tstdeg = ( (v:GetPos() - self.Owner:GetPos()):Angle().yaw - self.Owner:EyeAngles().yaw ) - 90
					local dest = self.Owner:GetPos():Distance(v:GetPos())-- plypos.x - v:GetPos().x, plypos.y - v:GetPos().y
					local x, y = PointOnCircle( tstdeg, dest/30, -3, 21 )
						
					if dest < 700 then
						if v.getItemID and anomalies[v:getItemID()] then
							--print(v:GetClass())
							surface.SetDrawColor( 0, 255, 0, 255 )
							DrawPointOnThatShit("icon16/control_play.png", x, y, v:GetAngles().yaw, 2 )
							--draw.SimpleText(".", "QuadFont", 0, 0, Color(0,255,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						end
					end					
				end
			end
		end
		--veles dont make sounds
		--[[local anoms = {}
		for k,v in pairs(ents.FindInSphere(self:GetOwner():GetPos(), detectionRange)) do
			--[[ --old way for backup
			if anomalies[string.lower(v:GetClass())] then
				table.insert(anoms, v)
			end]
			if(v.getItemID and anomalies[v:getItemID()]) then
				table.insert(anoms, v)
			end
		end
		local dist = 501
		local ent = nil
		for k,v in pairs(anoms) do
			if v:GetPos():Distance(self.Owner:GetPos()) < dist then
				dist = v:GetPos():Distance(self.Owner:GetPos())
				ent = v
			end
		end
		if dist < 500 and self.LastBeep + dist/300 - CurTime() <= 0 then
			self.LastBeep = CurTime()
			self.Owner:EmitSound(Sound("stalkerdetectors/echo.wav"), 100, 100)//math.Clamp(250-dist/2,50,250))
		end
		]]
	end
end