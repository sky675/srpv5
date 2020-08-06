ITEM.name = "Explosive Block"
ITEM.desc = "A block of explosives."
ITEM.model = "models/warz/items/c4.mdl"
ITEM.category = "Junk"
ITEM.weight = 0.45
ITEM.price = 6900
ITEM.flag = "m"

ITEM.isStackable = false

function ITEM:onDestroyed(ent)
	effectdata = EffectData()
	effectdata:SetOrigin(ent:GetPos())
	util.Effect("Explosion", effectdata)
	util.Decal("Scorch", ent:GetPos(), ent:GetPos()-Vector(0,0,15))
	--util.Effect("Explode", effectdata)
	ent.Damage = 75--110
	util.BlastDamage(item:getOwner(), item:getOwner(), ent:GetPos(), math.pow( ent.Damage / 100,0.75) * 200, ent.Damage )
	shake = ents.Create("env_shake")
	shake:SetOwner(item:getOwner())
	shake:SetPos(ent:GetPos())
	shake:SetKeyValue("amplitude", tostring(ent.Damage * 20)) -- Power of the shake
	shake:SetKeyValue("radius", tostring( math.pow( ent.Damage / 100,0.75) * 500) ) -- Radius of the shake
	shake:SetKeyValue("duration", tostring( ent.Damage / 200 )) -- Time of shake
	shake:SetKeyValue("frequency", "255") -- How har should the screenshake be
	shake:SetKeyValue("spawnflags", "4") -- Spawnflags(In Air)
	shake:Spawn()
	shake:Activate()
	shake:Fire("StartShake", "", 0)
	ent:EmitSound("weapons/explode" .. math.random(3, 5) .. ".wav", 140, 1, 100)
	ent:Remove()
end