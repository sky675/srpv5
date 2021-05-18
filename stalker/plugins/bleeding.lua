local PLUGIN = PLUGIN

PLUGIN.name = "Bleeding"
PLUGIN.author = "sky"
PLUGIN.desc = "Adds the possibility for players to bleed"

nut.config.add("bleed", false, "Whether bleeding is on.", nil, {
    category = "server"    
})

function PLUGIN:GetBleed(char)
	return char:getData("bleed", 0)
end

if(SERVER) then
	function PLUGIN:RemoveBleed(char, death)
			if(char:getData("bleed")) then
				if(death) then char:setData("bleed", nil, nil, nil, player.GetAll()) end
				if(timer.Exists("bleedtime"..char:getID())) then
					timer.Remove("bleedtime"..char:getID())
				end
			end
	end

	--[[
		freq = delay
		do quicker freqs for faster bleeds (constant 1 dmg)
	]]

	function PLUGIN:CreateBleed(char, freq)
		local ply = char:getPlayer()
		local id = "bleedtime"..ply:getChar():getID()
		if(timer.Exists(id)) then
			timer.Remove(id)
		end
		local targ = ply --justincaseidk
		local tiks = 0
		local max = freq*10
		local typtik = 0
		ply:getChar():setData("bleed", freq, nil, nil, player.GetAll())
		timer.Create(id, freq, 0, function()
			if(!IsValid(targ) or targ:getNetVar("neardeath") or !targ:Alive()) then
				timer.Remove(id)
				return
			end
			
			--this could be changed to always but idk id prefer no
			--this will slow bleeding for players so they can type, it ticks at 1/4th of the normal time
			--increased it to 1/16
			if(ply:getNetVar("typing") and !ply:getNutData("typeImm") and typtik < 16) then
				typtik = typtik + 1
				return
			elseif(ply:getNetVar("typing") and !ply:getNutData("typeImm") and typtik == 16) then
				typtik = 0
			end

			tiks = tiks+1
			if(tiks > freq*6) then
				tiks = 0
				
				hook.Run("ReduceBleed", char, 1.5)
				--self:CreateBleed(char, freq*1.5)
				return
			end
			targ:TakeDamage(1, game.GetWorld(), game.GetWorld())
		end)
	end

	hook.Add("ReduceBleed", "function", function(char, amt)
		local bleed = char:getData("bleed", 0)
		local mult = nut.traits.getMod(char:getPlayer(), "bleed", bleed, amt)
		if(bleed == 0) then
			return
		end
		if(((bleed*amt)*mult) >= 3) then
			PLUGIN:RemoveBleed(char, true)
		else
			PLUGIN:CreateBleed(char, ((bleed*amt)*mult))
		end
	end)

	
	hook.Add("EntityTakeDamage", "zzbleed", function(target, dmg)
		if(!(dmg:IsDamageType(DMG_BULLET) --whitelisting to only these dmg types
			or dmg:IsDamageType(DMG_CRUSH) 
			or dmg:IsDamageType(DMG_SLASH) 
			or dmg:IsDamageType(DMG_FALL) 
			or dmg:IsDamageType(DMG_BLAST))) then
			return
		end
		if(!nut.config.get("bleed", false)) then return end

		
		if(target:IsPlayer()) then
			if(target:HasGodMode()) then return end --ye
			
			local min, chance, chance2 = nut.traits.getMod(target, "minbleed")
			if(IsValid(dmg:GetAttacker()) and dmg:GetAttacker():IsPlayer() and math.random(20) <= 5) then return end --25% chance for no bleed at all vs player
			if((dmg:GetDamage() >= (min or 19)) and math.random(1,chance or 100) > (chance2 or 75)) then
				print("bleeding!")
				local bleed = target:getChar():getData("bleed") and -0.25 or 2.75 --todo better way?
				PLUGIN:CreateBleed(target:getChar(), math.Clamp(target:getChar():getData("bleed", 0)+(1*bleed), 0.01, 2.999)) --need to do some kind of thing to determine freq based on dmg?
			end
		end
	end)

	hook.Add("PlayerLoadedChar", "bleedswitch", function(ply, char, lastChar)
		if(lastChar) then
			PLUGIN:RemoveBleed(lastChar)
		end

		local bleed = ply:getChar():getData("bleed")
		if(bleed) then
			PLUGIN:CreateBleed(char, bleed)
		end
	end)

	function PLUGIN:PlayerDeath(client, inflictor, attacker)
		self:RemoveBleed(client:getChar(), true)
	end

	hook.Add("OnDown", "stopbleeding", function(ply, dmg)
		PLUGIN:RemoveBleed(ply:getChar(), true)
	end)
else--client
	
	nut.bar.add(function()
		if(LocalPlayer():getChar()) then --just to be safe
			local bleed = PLUGIN:GetBleed(LocalPlayer():getChar())
            return math.min(((bleed == 0 and 3) or bleed / 3), 1)
        else
            return 0
        end
    end, Color(255, 45, 126), nil, "bleed")
end