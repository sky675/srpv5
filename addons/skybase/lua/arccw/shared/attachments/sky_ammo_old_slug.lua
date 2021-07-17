att.PrintName = "Old Slugs"
att.Icon = Material("entities/acwatt_go_ammo_tmj.png", "mips smooth")
att.Description = "yes"
att.Desc_Pros = {
}
att.Desc_Cons = {
}
att.AutoStats = true
att.Slot = "go_ammo"

att.CanJam = true

att.Override_Num = 1
att.Mult_Range = 1.3
att.Mult_Penetration = 0.75

att.Mult_AccuracyMOA = 0.45
att.Mult_Range = 1.25
att.Mult_Recoil = 1.3
att.Mult_Damage = 0.65
att.Mult_DamageMin = 0.7

att.Hook_Compatible = function(wep)
    if !wep:GetIsShotgun() then return false end
end