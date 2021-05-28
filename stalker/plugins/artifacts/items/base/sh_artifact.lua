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
	icon = "icon16/cross.png",
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