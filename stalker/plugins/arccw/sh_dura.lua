local PLUGIN = PLUGIN

hook.Add("Hook_ShouldNotFireFirst", "dura", function(weapon)
	if(weapon:getNetVar("jammed")) then return true end
end)
if(SERVER) then
hook.Add("Hook_PostFireBullets", "dura", function(weapon)
	//this hook is only ran after the bullet has fired
	if(!weapon:GetInUBGL() && weapon.nutItem && !weapon:getNetVar("jammed")) then
		local dura
		local itm = weapon.nutItem

		if(itm) then
			dura = itm:getData("durability")
		end
		if(weapon:GetBuff_Override("CanJam")) then
			dura = 10
		end

		if(dura and dura < 90) then 
			if(math.random(0, dura*2) == 0) then
				weapon:setNetVar("jammed", true)
				weapon:GetOwner():ChatPrint("Weapon jammed! Press reload to unjam.")
				print("jam")
			end
		end
	end
end)
hook.Add("Hook_PreReload", "dura", function(weapon)
	if(weapon:getNetVar("jammed") and !weapon:GetInUBGL()) then
		weapon:setNetVar("jammed")
		print("unjammed")
		weapon:GetOwner():ChatPrint("Weapon unjammed")
		
		--copy pasted draw anim from deploy
        local prd = false

        local r_anim = weapon:SelectAnimation("ready")
        local d_anim = weapon:SelectAnimation("draw")

        if weapon.Animations[r_anim] and weapon.UnReady then
            weapon:PlayAnimation(r_anim, 1, true, 0, true)

            weapon:SetReloading(CurTime() + weapon:GetAnimKeyTime(r_anim))

            prd = weapon.Animations[r_anim].ProcDraw
        else
            weapon:PlayAnimation(d_anim, weapon:GetBuff_Mult("Mult_DrawTime"), true, 0, true)
			weapon:SetReloading(CurTime() + (weapon:GetAnimKeyTime(d_anim) * weapon:GetBuff_Mult("Mult_DrawTime")))

            prd = weapon.Animations[d_anim].ProcDraw
        end

        if prd then
            weapon:ProceduralDraw()
        end

		return true
	end
end)
end
hook.Add("Hook_ShouldNotFire", "dura", function(weapon)
	if(weapon:getNetVar("jammed")) then return true end
	//check for random jam, copied from mag base
	--print("check")
	--[[if(weapon.nutItem and weapon:Clip1() != (weapon:GetMaxClip1()+1)) then
		local dura
		local itm = weapon.nutItem

		if(itm) then
			dura = itm:getData("durability")
		end
		if(weapon:GetBuff_Override("CanJam")) then
			dura = 10
		end

		if(dura and dura < 90) then 
			if(math.random(0, dura*2) == 0) then
				weapon.jammed = true
				weapon:GetOwner():ChatPrint("Weapon jammed! Press reload to unjam.")
				print("jam")
			end
		end
	end

	if(weapon.jammed) then
		return true
	end]]
end)