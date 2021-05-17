if CLIENT then
	RunConsoleCommand("mat_motion_blur_enabled", 1) --forces motion blur to be enabled through a console command
	
	local rblur = 0 --local used by the radial motion blur
	local blur = 0 --local used by the fullscreen motion blur
	
	local healthblurcurrent = 0 --current value used by the main postfx call
	
	local approachingmin = 0
	local approachingmax = 0 --dummies to tell the code to approach a value
	
	local function EFT_BlurEffects()		
						--trying to change this to 75 min
	local healthblur = ( (75 - LocalPlayer():Health()) * 0.01 ) --base formula
	local healthblurmin = healthblur * 0.5 --lowest point
	local healthblurmax = healthblur * 1.5 --highest point
	
	if healthblurcurrent < healthblurmin then healthblurcurrent = healthblurmin end --failsafes in case healthblurcurrent falls out of range
	if healthblurcurrent > healthblurmax then healthblurcurrent = healthblurmax end
	
	if healthblurcurrent == healthblurmin then --if blur is at the lowest point, start rising to the highest
		approachingmax = 1
		approachingmin = 0
	end
	if healthblurcurrent == healthblurmax then --if blur is at the highest point, start dropping to the lowest
		approachingmax = 0
		approachingmin = 1
	end
	
	if approachingmax == 1 then
		healthblurcurrent = math.Approach(healthblurcurrent, healthblurmax, FrameTime() * healthblur * 2 * healthblur) --approach the highest point
	end
	
	if approachingmin == 1 then
		healthblurcurrent = math.Approach(healthblurcurrent, healthblurmin, FrameTime() * healthblur * 2 * healthblur) --approach the lowest point
	end
	
	if LocalPlayer():Health() < 75 then
		rblur = math.Approach(rblur, healthblurcurrent, FrameTime() * 1.25) --set the value for postfx
		blur = math.Approach(blur, healthblur, FrameTime() * 1.25)
	else
		rblur = math.Approach(rblur, healthblurcurrent * 0, FrameTime() * 0.5) --approach it to zero if health is a-o-kay
		blur = math.Approach(blur, healthblur * 0, FrameTime() * 0.5)
	end
	
	if !LocalPlayer():Alive() then
		rblur = math.Approach(rblur, 2, FrameTime() * 1.5) --sets radial blur to a static maxed value when LocalPlayer is dead
		blur = math.Approach(blur, 2, FrameTime() * 1.5) --sets fullscreen motion blur to a static maxed value when LocalPlayer is dead
	end
		
		if blur > 0 then
			DrawMotionBlur( 0.1, blur * 0.5, 0.01 ) --draws fullscreen motion blur
		end
		
	end
	
	hook.Add("RenderScreenspaceEffects", "EFT_BlurEffects", EFT_BlurEffects)
	
	local function EFT_BlurEffects_RadialMotionBlur(x, y, f, r) --handles the radial motion blur by adding the value only to forward blur
		f = f + rblur * 0.1
		return x, y, f, r
	end
	
	hook.Add("GetMotionBlurValues", "EFT_BlurEffects_RadialMotionBlur", EFT_BlurEffects_RadialMotionBlur)
	
end