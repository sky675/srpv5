
--arccw: m_hook_(name), func(data) data is table of buff and cur mult

--i guess a way to go around this is by using the TFA_GetStat hook, idk
--itd just be if statements for each stat, all the ones in the att
-- ply:getImplantRes() to get implant specific adds to this, but do GetArmorResists instead just in case
--Hook_ModifyRecoil normal hook, var is tbl of Recoil, RecoilSide, VisualRecoilMul
hook.Add("Hook_ModifyRecoil", "MainS", function(wep, rectbl)
	local rec = nut.traits.getMod(wep:GetOwner(), wep:GetState() == ArcCW.STATE_SIGHTS and "wepireceff" or "wepreceff", wep.Type or "")
	rectbl.Recoil = rectbl.Recoil * rec
	rectbl.RecoilSide = rectbl.RecoilSide * rec
	rectbl.VisualRecoilMul = rectbl.VisualRecoilMul * rec
	--i sure hope some fuckhead using this hook doesnt return the tbl like a fucking idiot
end)

--Damage
hook.Add("M_Hook_Mult_Damage", "MainS", function(wep, data)
	local stat = data.mult
	data.mult = stat * nut.traits.getMod(wep:GetOwner(), "wepdmgeff", wep.Type or "")
	return data
end)
--accuracymoa or Mult_HipDispersion?
hook.Add("M_Hook_Mult_AccuracyMOA", "MainS", function(wep, data)
	local stat = data.mult
	data.mult = stat * nut.traits.getMod(wep:GetOwner(), "wepspreff", wep.Type or "")
	return data
end)
--SightsDispersion?
hook.Add("M_Hook_Mult_SightsDispersion", "MainS", function(wep, data)
	local res = wep:GetOwner():GetArmorResists()

	local stat = data.mult
	data.mult = stat * (res["ironacc"] or 1)
	return data
end)
--SightTime
hook.Add("M_Hook_Mult_SightTime", "MainS", function(wep, data)
	local res = wep:GetOwner():GetArmorResists()
	local qk = wep:GetOwner():getChar():getAttrib("qkn", 0)
	local qkn = 1+((qk/30)*0.15)

	local stat = data.mult

	data.mult = stat * (res["irontime"] or 1) * qkn * nut.traits.getMod(wep:GetOwner(), "wepireff", wep.Type or "")
	return data
end)

--SightedSpeedMult
hook.Add("M_Hook_Mult_SightedSpeedMult", "MainS", function(wep, data)
	local res = wep:GetOwner():GetArmorResists()
	local stat = data.mult
	data.mult = stat * (res["ironms"] or 1)
	return data
end)
--this should be a way to speed up reloads
--Mult_ReloadTime
hook.Add("M_Hook_Mult_ReloadTime", "MainS", function(wep, data)
	--todo prob reload below
	if(!IsValid(wep) or !IsValid(wep:GetOwner()) or !wep:GetOwner():getChar()) then return end

	local qk = wep:GetOwner():getChar():getAttrib("qkn", 0)
	local qkn = 1+((qk/30)*0.16)
		
	qkn = qkn * nut.traits.getMod(wep:GetOwner(), "wepreloadeff", wep.Type or "")

	local rate = data.mult

	data.mult = rate * qkn
	return data
end)