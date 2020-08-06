ITEM.name = "C4 Explosive"
ITEM.desc = "A small explosive."
ITEM.weight = 1.5
ITEM.price = 15800
ITEM.model = "models/warz/items/c4.mdl"
ITEM.flag = "1"
ITEM.category = "misc"


function ITEM:getDesc()
	local item = self
	local desc = self.desc

	if(item:getData("linked")) then
		desc = desc.."\nThis is connected to a detonator."
	else
		desc = desc.."\nThis isn't connected to a detonator."
	end
	if(item:getData("armed")) then
		desc = desc.."\nThis is armed."
	else
		desc = desc.."\nThis isn't armed."
	end

	return desc
end

local effectdata, shake
function ITEM:Detonate(ent, item)
	
	if(ent:getNetVar("isjammed")) then return end

	if(!ent:getData("armed")) then return end --cant detonate unless armed
	if(!item) then print("whathteufkc") return end

	--explode c4

	effectdata = EffectData()
	effectdata:SetOrigin(ent:GetPos())
	util.Effect("Explosion", effectdata)
	util.Decal("Scorch", ent:GetPos(), ent:GetPos()-Vector(0,0,15))
	--util.Effect("Explode", effectdata)
	ent.Damage = 250--110
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

ITEM.functions.Arm = {
	name = "Set Armed",
    icon = "icon16/exclamation.png",
	sound = "weapons/c4/c4_click.wav",
	onRun = function(item)
		local arm = item:getData("armed")
		if(!arm) then
			item:setData("armed", true)
			item.player:notify("The explosive is now armed.")
		--[[else
			item:setData("armed", nil)
			item.player:notify("The explosive is now disarmed.")]]
		end
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity) and !item:getData("armed")
	end
}
ITEM.functions.Reset = {
	sound = "weapons/c4/c4_disarm.wav",
    icon = "icon16/arrow_refresh.png",
	onRun = function(item)
		local it = nut.item.instances[item:getData("linked")]

		local d = it:getData("linked", {})
		d[item.id] = nil
		it:setData("linked", d)
		item.player:notify("The explosive is no longer linked to its detonator.")

		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity) and item:getData("linked") and !item:getData("armed")
	end
}

local GLOW_MATERIAL = Material("sprites/glow04_noz.vmt")
local COLOR_ACTIVE = Color(255, 0, 0)

function ITEM:drawEntity(entity, item)
	entity:DrawModel()
	local rt = RealTime()*100
	local position = entity:GetPos() + entity:GetForward() * 0 + entity:GetUp() * 2 + entity:GetRight() * 0

	if (entity:getData("armed", false) == true) then
		if (math.ceil(rt/14)%10 == 0) then
			render.SetMaterial(GLOW_MATERIAL)
			render.DrawSprite(position, rt % 14, rt % 14, COLOR_ACTIVE)
			--entity:EmitSound("") --beep
		end
	end
end