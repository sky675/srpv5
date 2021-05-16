local PLUGIN = PLUGIN
//this may only call in sv but idk

//durability hooks

//uh if this doesnt work will need to edit base lol (should tho)
//notes: will need to not affect while in ubgl mode

//returning true will stop the func
hook.Add("Hook_ShouldNotFireFirst", "dura", function(weapon)
	if(weapon.jammed) then return true end
end)
//do the calculations here, above only is only for check bool
hook.Add("Hook_ShouldNotFire", "dura", function(weapon)
	if(weapon.jammed) then return true end
	//check for random jam, copied from mag base
	--print("check")
	if(weapon.nutItem and weapon:Clip1() != (weapon:GetMaxClip1()+1)) then
		local dura
		local itm = weapon.nutItem

		if(itm) then
			dura = itm:getData("durability")
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
	end
end)
local duraMulti = 0.75
--for later lol
hook.Add("PostLootMutant", "dura", function(ply, weapon)
	if(weapon.PrimaryBash and weapon.nutItem) then
		local item = weapon.nutItem
		local dura = item:getData("durability", 100)
		local newDura = dura or 100

		if(dura) then
			--remove here
			--the 22 is kinda arbitrary tbh, increase = degrades slower
			local torem = math.max(0.0001, (((((weapon.MeleeTime)/100)+weapon.MeleeDamage)/newDura)/(10*item:getData("incD",1))))
		--	print(self:GetStat("Primary.ClipSize"), self:GetStat("Primary.Damage"), newDura)
		--	print("cur dura: "..tostring(newDura).."to remove: "..tostring(torem))
			torem = torem * (item:getData("duraMulti") and duraMulti or 1)

			newDura = newDura-torem

			item:setData("durability", newDura)

			if(newDura <= 0) then
				item:setData("broken", true)
				ply:notify("Your "..weapon.PrintName.." has broken!")
				item:Unequip(ply)
				return
			end
		end
	end
end)
hook.Add("Hook_PostBash", "dura", function(weapon, data)
	if(weapon.PrimaryBash and IsValid(data.tr.Entity) and weapon.nutItem) then
		local item = weapon.nutItem
		local dura = item:getData("durability", 100)
		local newDura = dura or 100

		if(dura) then
			--remove here
			--the 22 is kinda arbitrary tbh, increase = degrades slower
			local torem = math.max(0.0001, (((((weapon.MeleeTime)/100)+weapon.MeleeDamage)/newDura)/(18*item:getData("incD",1))))
		--	print(self:GetStat("Primary.ClipSize"), self:GetStat("Primary.Damage"), newDura)
		--	print("cur dura: "..tostring(newDura).."to remove: "..tostring(torem))
			torem = torem * (item:getData("duraMulti") and duraMulti or 1)

			newDura = newDura-torem

			item:setData("durability", newDura)

			if(newDura <= 0) then
				item:setData("broken", true)
				weapon:GetOwner():notify("Your "..weapon.PrintName.." has broken!")
				item:Unequip(weapon:GetOwner())
				return
			end
		end
	end
end)
//dont return true here tho, just modify durability
hook.Add("Hook_PostFireBullets", "dura", function(weapon)
	//this hook is only ran after the bullet has fired
	if(!weapon:GetInUBGL() && weapon.nutItem) then
		local item = weapon.nutItem
		local dura = item:getData("durability", 100)
		local newDura = dura or 100

		if(dura) then
			--remove here
			--the 22 is kinda arbitrary tbh, increase = degrades slower
			local torem = math.max(0.0001, (((((weapon:GetFiringDelay())/100)+weapon:GetDamage(0))/newDura)/(18*item:getData("incD",1))))
		--	print(self:GetStat("Primary.ClipSize"), self:GetStat("Primary.Damage"), newDura)
		--	print("cur dura: "..tostring(newDura).."to remove: "..tostring(torem))
			torem = torem * (item:getData("duraMulti") and duraMulti or 1)

			newDura = newDura-torem

			item:setData("durability", newDura)

			if(newDura <= 0) then
				item:setData("broken", true)
				weapon:GetOwner():notify("Your "..weapon.PrintName.." has broken!")
				item:Unequip(weapon:GetOwner())
				return
			end
		end
	end
	--print("boolet")
end)
//return true so dont reload if clearing jam, maybe try and play deploy anim?
hook.Add("Hook_PreReload", "dura", function(weapon)
	if(weapon.jammed and !weapon:GetInUBGL()) then
		weapon.jammed = nil
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