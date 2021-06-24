ITEM.name = "artifact base"
ITEM.model = "models/tnb/stalker/artifacts/bubble.mdl"
ITEM.desc = ""
ITEM.category = "Artifacts"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1

ITEM.artid = "" --a string that corresponds with a key in the ARTIFACT_DESCS table
ITEM.junkArt = false --if true, cant put into belt

function ITEM:drawEntity(ent)
	local pos = LocalPlayer():GetPos() --200 seems good
	if(!ent:getNetVar("dontinteract")) then
		ent:DrawModel()
		ent:CreateShadow()
	else
		ent:DestroyShadow()
	end
end
function ITEM:think(ent)
	if(self.junkArt) then return end
	local active = false
	for k,v in pairs( player.GetAll() ) do
		if v:GetPos():Distance( ent:GetPos() ) < 2000 then
			active = true
			break
		end
	end
	
	ent.Active = active
	
	if active == false then
		ent.ReActivate = true
	else
		local phys = ent:GetPhysicsObject()
		if IsValid( phys ) then
			phys:Wake()
		end
	end

	local nearby = ents.FindInSphere(ent:GetPos(), 200)
	local set = true
	for k,v in ipairs(nearby) do
		if(v:IsPlayer() and IsValid(v:GetActiveWeapon()) 
			and v:GetActiveWeapon():GetClass():find("detector")) then

			set = false
			break --stop it lmao dont need the rest of it
		end
	end
	ent:setNetVar("dontinteract", set) 
end
function ITEM:onEntityCreated(ent)
	if(self.junkArt) then return end
	ent:StartMotionController()

	ent.PhysicsSimulate = function(self, phys, delta)
		if not self.Active then return SIM_NOTHING end
		
		if self.ReActivate then
			self.ReActivate = false
			phys:ApplyForceCenter( Vector( 0, 0, 1 ) * ( phys:GetMass() * 15 ) )
		end
		
		local trace = {}
		trace.start = self:GetPos()
		trace.endpos = trace.start + Vector( 0, 0, -1000 )
		trace.filter = self
		
		local tr = util.TraceLine( trace )
		
		local dist = tr.HitPos:Distance( tr.StartPos )
		local scale = math.Clamp( 25 - dist, 0.25, 25 ) / 25
		
		if tr.Hit then
			phys:ApplyForceCenter( tr.HitNormal * ( phys:GetMass() * ( scale * 15 ) ) )
		end
	end
end

function ITEM:getDesc()
	local str = self.desc

	if(self.junkArt) then return str.."\nHas no useful properties." end

	if(!ARTIFACT_DESCS[self.artid]) then
		return str.."\nNon-existant artifact!"
	end
	
	local art = ARTIFACT_DESCS[self.artid]

	str = str..""
	for k,v in pairs(art.levels) do
		if(ARTIFACT_TRANS[k] and ARTIFACT_TRANS[k].hidden) then continue end
		local fu = v
		--idk could be done better?
		if(ARTIFACT_TRANS[k] and ARTIFACT_TRANS[k].func) then
			fu = ARTIFACT_TRANS[k].func(fu)
		end
		str = str.."\n"..(ARTIFACT_TRANS[k] and ARTIFACT_TRANS[k].name or k)..": "..fu
	end

	--idk any extra stuff
	if(art.onAdd or art.active) then
		str = str.."\n"..(ARTIFACT_TRANS[self.artid] or "Unknown Extra Effect")
	end

	if(art.radGive) then
		str = str.."\nRads Per Minute: "..art.radGive
	end

	return str
end


ITEM.functions.Use = { --i hate this lol
	name = "Use Active",
	tip = "equipTip",
	icon = "icon16/add.png",
	onRun = function(item)
		local desc = ARTIFACT_DESCS[item.artid]
		if(desc and desc.active) then
			if(!desc.active.canRun or desc.active.canRun(item, item.player)) then
				desc.active.run(item, item.player)
			end
		end

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity) and item.hasUse)
	end
}