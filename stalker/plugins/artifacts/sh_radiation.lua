local PLUGIN = PLUGIN

--maybe make these configs?
local maxRad = 100 --ez change, allows for easy modifying of the limit if 100 is too low
local dmgThreshold = 80 --start doing dmg at 80
local dmgSoloThresh = 50 --on dmg only, use this one instead
local maxDmg = 6 --max dmg per rad tick, at max rad level
local needThreshold = 40 --start affecting needs at 40
local needThreshMax = 80 --past 80, stays at max
local maxNeeds = 10 --max needs itll take from both per tick



nut.config.add("radDmgType", 1, [[The type of damage done as a consequence of excessive radiation:
	1 - Quicker hunger/thirst depletion, and health damage at excessive levels
	2 - Quicker hunger/thirst only
	3 - Health damage only
	4 - No consquence for high radiation levels]], nil,
{
	category = "Artifacts",
	data = {min = 1, max = 4},
})

do
	local charMeta = nut.meta.character

	function charMeta:getRad()
		return self:getData("rads", 0)
	end

	function charMeta:setRad(val)
		self:setData("rads", math.Clamp(val, 0, maxRad))
	end

	function charMeta:addRad(val)
		self:setRad(self:getData("rads", 0)+val)
	end	
end

if(SERVER) then
	hook.Add("PostPlayerLoadout", "RadsLoadout", function(ply)
		local id = ply:SteamID()

		timer.Create("radsTimer"..id, 60, 0, function()
			if(IsValid(ply)) then
				local char = ply:getChar()
				if(char and ply:Alive() and !ply:getNetVar("neardeath")) then
					local rads = char:getRad()
					local added = -0.5 --so it slowly removes on its own
					local items = char:getInv():getItems()
					for k,v in pairs(items) do
						--not doing 2 different for loops like an idiot again!
						if(v.base == "base_artifact") then
							added = added + (ARTIFACT_DESCS[v.artid] and ARTIFACT_DESCS[v.artid].radGive or 0)
						elseif(v.base == "base_artcont" and !v.isSafe) then
							local vals = v:getData("res", {})
							for k3,art in pairs(vals) do
								
								local armor = math.max((ARTIFACT_DESCS[art] and ARTIFACT_DESCS[art].radGive or 0) + (v.radRemove or 0), 0)

								added = added + armor
							end
						end
					end

					local cur = rads+added

					--im honestly not sure for effects
					--could do damage again
					--also had an idea for hunger/thirst quickening effects?
					local type = nut.config.get("radDmgType", 1)

					--health
					if(type == 1 or type == 3) then
						local thresh = type == 1 and dmgThreshold or dmgSoloThresh

						if(cur >= thresh) then
							local scl = 1-((maxRad-cur)/(maxRad-thresh))

							local dmg = maxDmg*scl
							local d = DamageInfo()
							d:SetDamage(dmg)
							d:SetAttacker(ply)
							d:SetDamageType(DMG_RADIATION)

							ply:TakeDamageInfo(d)
						end
					end
					--needs
					if(type == 1 or type == 2) then
						if(cur >= needThreshold) then
							--same deal should work
							local scl = math.min(1-((needThreshMax-cur)/(needThreshMax-needThreshold)), 1)

							--thisll be fine ig lol
							char:SetHunger(char:GetHunger()-(maxNeeds*scl))
							char:SetThirst(char:GetThirst()-(maxNeeds*scl))
						end
					end

					char:setRad(cur)
				end
			else
				timer.Remove("radsTimer"..id)
			end
		end)
	end)

else--client
	nut.bar.add(function()
		if(LocalPlayer():getChar()) then --just to be safe
			return math.Clamp(math.min(LocalPlayer():getChar():getRad() / maxRad, 1), 0, 1)
		else
			return 0
		end
	end, Color(53,156,53), nil, "radiation")
end