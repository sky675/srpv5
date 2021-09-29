local PLUGIN = PLUGIN
PLUGIN.name = "Needs"
PLUGIN.author = "sky"
PLUGIN.desc = "requires you to eat and drink every so often"

HIGH_THIRST_THRESHOLD = 85
HIGH_HUNGER_THRESHOLD = 85
LOW_THIRST_THRESHOLD = 45
LOW_HUNGER_THRESHOLD = 45

do
    local charMeta = nut.meta.character 

    function charMeta:GetHunger()
        return self:getData("hunger", 100)
    end

	function charMeta:SetHunger(val)
		if(val < LOW_HUNGER_THRESHOLD) then
			self:addBoost("needboost", "end", -((val-LOW_HUNGER_THRESHOLD)*0.06)^2)
			self:addBoost("needboost", "str", -((val-LOW_HUNGER_THRESHOLD)*0.05)^2)
		else
			self:removeBoost("needboost", "end")
			self:removeBoost("needboost", "str")
		end

		self:setData("hunger", val)
		
    end

    function charMeta:GetThirst()
        return self:getData("thirst", 100)
    end

    function charMeta:SetThirst(val)
		
		if(val < LOW_THIRST_THRESHOLD) then
			self:addBoost("needboost", "stm", -((val-LOW_THIRST_THRESHOLD)*0.08)^2)
			self:addBoost("needboost", "qkn", -((val-LOW_THIRST_THRESHOLD)*0.07)^2)
		else
			self:removeBoost("needboost", "stm")
			self:removeBoost("needboost", "qkn")
		end

        self:setData("thirst", val)
    end
    
    if(CLIENT) then
        nut.bar.add(function()
        if(LocalPlayer():getChar()) then --just to be safe
            return math.min(LocalPlayer():getChar():GetHunger() / 100, 1)
        else
            return 0
        end
        end, Color(236,152,26), nil, "hunger")
        
        nut.bar.add(function()
        if(LocalPlayer():getChar()) then
            return math.min(LocalPlayer():getChar():GetThirst() / 100, 1)
        else
            return 0
        end
        end, Color(26,201,236), nil, "thirst")
	
		--this code is the stuff that drew the bars in the bottom left like it used to
		--i dont want it doing that anymore still, but im keeping this anyway
        --[[hook.Add("ShouldBarDraw", "needsBars", function(bar)
            if(bar.identifier == "hunger" or bar.identifier == "thirst") then
                return false
            end
		end)
		
        hook.Add("HUDPaintBackground", "needsBars", function()
            if(LocalPlayer():getChar()) then
                local x, y = 4, ScrH()-12
                local w, h = ScrW() * 0.1, 10
                local hunger, thirst = nut.bar.get("hunger"), nut.bar.get("thirst")
            
                nut.bar.draw(x, y, w, h, hunger.getValue(), hunger.color, hunger)
                y = y - h - 2
                nut.bar.draw(x, y, w, h, thirst.getValue(), thirst.color, thirst)
            end
		end)
		]]
    end
end


if(SERVER) then
	

    hook.Add("PostPlayerLoadout", "NeedsLoadout", function(ply)
        local id = ply:SteamID()
		local lastCheckHung = CurTime()
		local lastCheckThir = CurTime()
		local lastCheckHeal = CurTime()

		--setup boosts otherwise it wont be done for like 10 mins
		local char = ply:getChar()
		local thirst = char:GetThirst()
		local hunger = char:GetHunger()
		
		if(thirst < LOW_THIRST_THRESHOLD) then
			char:addBoost("needboost", "stm", -((thirst-LOW_THIRST_THRESHOLD)*0.08)^2)
			char:addBoost("needboost", "qkn", -((thirst-LOW_THIRST_THRESHOLD)*0.07)^2)
		end
		if(hunger < LOW_HUNGER_THRESHOLD) then
			char:addBoost("needboost", "end", -((hunger-LOW_HUNGER_THRESHOLD)*0.06)^2)
			char:addBoost("needboost", "str", -((hunger-LOW_HUNGER_THRESHOLD)*0.05)^2)
		end

        timer.Create("needsTimer"..id, 1, 0, function()
            if(IsValid(ply)) then
				if(ply:getChar()) then
					if(ply:GetMoveType() == MOVETYPE_NOCLIP) then return end
					if(IsValid(ply.nutScn) or ply:getChar():getFaction() == FACTION_OW) then return end --no degrade while scanner or ow


					local char = ply:getChar()
					local hunger = char:GetHunger()
					local thirst = char:GetThirst()
					local curTime = CurTime() --micro optimization :)

					if(thirst > 0) then					--460, 690
						if(curTime - lastCheckThir > (890 * nut.traits.getMod(ply, "thirst"))) then
							char:SetThirst(thirst - 1)
							lastCheckThir = curTime
						end
					else
						if(curTime - lastCheckThir > 60) then
							ply:SetHealth(math.min(ply:GetMaxHealth(), ply:Health()-1))
							lastCheckThir = curTime
						end
					end
					
					if(hunger > 0) then					--540, 770
						if(curTime - lastCheckHung > (970 * nut.traits.getMod(ply, "hunger"))) then
							char:SetHunger(hunger - 1)
							lastCheckHung = curTime
						end
					else
						if(curTime - lastCheckHung > 60) then
							ply:SetHealth(math.min(ply:GetMaxHealth(), ply:Health()-1))
							lastCheckHung = curTime
						end
					end

						--cannot decide between 60, 90, and 120
					if(curTime - lastCheckHeal > 180 and HIGH_HUNGER_THRESHOLD <= hunger) then --healing
						if(ply:Health() < ply:GetMaxHealth()) then --if missing hp
							ply:SetHealth(ply:Health()+1)
						end
						lastCheckHeal = curTime 
						--this will cause the first tick where 
						--the hunger meets it to immediately heal 1 but eh
					end

				end
			else
				timer.Remove("needsTimer"..id)
			end	
        end)
	end)

	hook.Add("PlayerDeath", "RefundSomeNeeds", function(ply, inf, atk) 
		local char = ply:getChar()
		if(char) then
			local hunger = char:GetHunger()
			local thirst = char:GetThirst()

			if(hunger <= 10 or thirst <= 10) then
				char:SetHunger(math.Clamp(hunger+30, 0, 100))
				char:SetThirst(math.Clamp(thirst+30, 0, 100))
			end
		end
	end)
else
    NUT_CVAR_MUTEEAT = CreateClientConVar("nut_mute_eat", 0, true, true)

	local eatSounds = {
		["interface/inv_drink_flask.ogg"] = true,
		["interface/inv_drink_can.ogg"] = true,
		["interface/inv_eat_paperwrap.ogg"] = true,
		["interface/inv_eat_can_open.ogg"] = true,
		["interface/inv_eat_mutant_food.ogg"] = true,
		["interface/inv_eat_ration1.ogg"] = true,
	}
	
    function PLUGIN:SetupQuickMenu(menu)
    	--if (LocalPlayer():IsSuperAdmin()) then
            local buttonItem = menu:addCheck("Toggle Eat/Drink Sounds", function(panel, state)
                if(state) then
                    RunConsoleCommand("nut_mute_eat", "1")
                else
                    RunConsoleCommand("nut_mute_eat", "0")
                end
            end, NUT_CVAR_MUTEEAT:GetBool())

            menu:addSpacer()
        --end
    end

	hook.Add("EntityEmitSound", "emittest", function(tbl)
		--test
		if(NUT_CVAR_MUTEEAT:GetBool() and eatSounds[tbl.SoundName]) then
			print("bad sound found stopped")
			return false
		end
	end)

end