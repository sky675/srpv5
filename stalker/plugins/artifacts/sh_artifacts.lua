local PLUGIN = PLUGIN

--quick funcs for adding/removing max weight
local function modifyWeightAdd(ply, amt)
	ply:getChar():getInv():setData("maxWeight", ply:getChar():getInv():getMaxWeight()+amt)
end
local function modifyWeightRem(ply, amt)
	ply:getChar():getInv():setData("maxWeight", ply:getChar():getInv():getMaxWeight()+amt)
end

local function healPlayer(client, target, amount, seconds, itemid)
	if(amount == 0) then return end
	local amt, sec = hook.Run("OnPlayerHeal", client, target, amount, seconds)
	local amount = amt or amount --im not sure if doing an or ^ would work
	local seconds = sec or seconds
	
	local neg = amount < 0
	amount = math.abs(amount)

	if (client:Alive() and target:Alive()) then
		local id = "nutHeal_"..itemid..CurTime() --why did this use frametime before wtf
		timer.Create(id, (seconds/amount), amount, function() --changed it to repeat whenever 1 should be added, the other way wasnt working with slow heals (as in less than 1 per rep)
			if (!target:IsValid() or !target:Alive()) then
				timer.Destroy(id)
				return	
			end

			if(target:Health() >= 100) then return end
			nut.traits.addXp(client, "tech_med", (client != target) and 2 or 1)
			

			target:SetHealth(math.Clamp(target:Health() + (neg and -1 or 1), 2, target:GetMaxHealth()))
			if(target:Health() > 25) then
				net.Start("toggleHeartbeat")
				net.WriteBool(false)
				net.Send(target)
			end
		end)
	end
end

local function stamPlayer(client, amount, seconds, itemid)
	local neg = amount < 0
	if (client:Alive()) then
		local id = "nutStam_"..itemid..CurTime() --why did this use frametime before wtf
		timer.Create(id, (seconds/amount), amount, function() --changed it to repeat whenever 1 should be added, the other way wasnt working with slow heals (as in less than 1 per rep)
			if (!client:IsValid() or !client:Alive()) then
				timer.Destroy(id)	
			end

			client:restoreStamina(neg and -1 or 1)
		end)
	end
end

--artifact val names (in levels and stuff)
ARTIFACT_TRANS = {
	--[[
	["valname"] = {
		name = "display name",
		--func = function(val) end --optional func to change how it displays, return val
	}
	["artname"] = "", --used to describe unique effects on an artifact, use the artifact id
	]]
	[DMG_RADIATION.."-m"] = {
		name = "Ext Rad Multiplier",
		func = function(val) return ((val*100).."%") end
	},
	[DMG_SONIC.."-m"] = {hidden = true},
	["psy-m"] = {
		name = "Psy Multiplier",
		func = function(val) return ((val*100).."%") end
	},
	[DMG_SLASH.."-m"] = {
		name = "Physical Multiplier",
		func = function(val) return ((val*100).."%") end
	},
	[DMG_CLUB.."-m"] = {hidden = true},
	[DMG_CRUSH.."-m"] = {hidden = true},
	[DMG_BULLET.."-m"] = {
		name = "Ballistic Multiplier",
		func = function(val) return ((val*100).."%") end
	},
	--burn
	[DMG_BURN.."-m"] = {
		name = "Thermal Multiplier",
		func = function(val) return ((val*100).."%") end
	},
	--explosion
	[DMG_BLAST.."-m"] = {
		name = "Explosion Multiplier",
		func = function(val) return ((val*100).."%") end
	},
	--electric
	[DMG_SHOCK.."-m"] = {
		name = "Electrical Multiplier",
		func = function(val) return ((val*100).."%") end
	},
	--chem
	[DMG_ACID.."-m"] = {
		name = "Chemical Multiplier",
		func = function(val) return ((val*100).."%") end
	},

	["stmres"] = {
		name = "Stamina Recovery",
		func = function(val) return ((val*100).."%") end
	},

	
	--bullet half of wound
	[DMG_BULLET] = {
		name = "Ballistic Resist",
		func = function(val) return ((val*100).."%") end
	},
	--phys
	[DMG_SLASH] = {
		name = "Physical Resist",
		func = function(val) return ((val*100).."%") end
	},
	[DMG_CLUB] = {hidden = true},
	[DMG_CRUSH] = {hidden = true},
	--burn
	[DMG_BURN] = {
		name = "Thermal Resist",
		func = function(val) return ((val*100).."%") end
	},
	--explosion
	[DMG_BLAST] = {
		name = "Explosion Resist",
		func = function(val) return ((val*100).."%") end
	},
	--electric
	[DMG_SHOCK] = {
		name = "Electrical Resist",
		func = function(val) return ((val*100).."%") end
	},
	--ext rad
	[DMG_RADIATION] = {
		name = "Ext Rad Resist",
		func = function(val) return ((val*100).."%") end
	},
	--chem
	[DMG_ACID] = {
		name = "Chemical Resist",
		func = function(val) return ((val*100).."%") end
	},
	--psy
	[DMG_SONIC] = {
		name = "Psy Resist",
		func = function(val) return ((val*100).."%") end
	},
	["psy"] = {hidden = true},
	spd = {
		name = "Speed Multiplier",
		func = function(val) return ((val*100).."%") end
	},

	["flame"] = "Reduces bleeding significantly. Has a 5 minute wait between each use.",
	["eye"] = "Reduces bleeding somewhat. Has a 5 minute wait between each use.",
	["mamasbeads"] = "Reduces bleeding a little. Has a 5 minute wait between each use.",
	["kolobok"] = "Produces a moderate heal with some side effects. Has a 10 minute wait between uses.",
	["nightstar"] = "Adds 5.2kg to max weight.",
	["stoneblood"] = "Weakly reduces bleeding. Has a 5 minute wait between each use.",
	["soul"] = "Provides a weak heal with some small side effects. Has a 10 minute wait between uses.",
	["goldfish"] = "Adds 13.3kg to max weight.",
	["gravi"] = "Adds 8.4kg to max weight.",
}
--a table of artifacts with their numeric effects in them, 
ARTIFACT_DESCS = {
	--[[
	["artifactid"] = {
		name = "",
		itemid = "", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it

		},
		radGive = 0, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	]]
	--low rad = 1, med = 3, high = 5
	["flame"] = {
		name = "Flame",
		itemid = "art_flame", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_RADIATION.."-m"] = 0.74,
			[DMG_SONIC.."-m"] = 0.9,
			["psy-m"] = 0.9,
			[DMG_SLASH.."-m"] = 1.07,
			[DMG_CLUB.."-m"] = 1.07,
			[DMG_CRUSH.."-m"] = 1.07,
			[DMG_BULLET.."-m"] = 0.93,
			["stmres"] = 0.75,
		},
		radGive = 5, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		active = {
			canRun = function(item, ply) 
				return item:getData("lastuse", os.time()) <= os.time() 
			end, --if true or doesnt exist, runs below
			run = function(item, ply)
				item:setData("lastuse", os.time()+300)

				hook.Run("ReduceBleed", ply:getChar(), 11)
			end
		},
	},
	["snowflake"] = {
		name = "Snowflake",
		itemid = "art_snowflake", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
			--use val-m to multiply a value instead of add onto it
			[DMG_BURN.."-m"] = 0.6,
			[DMG_ACID.."-m"] = 0.9,
			[DMG_SONIC.."-m"] = 0.9,
			["psy-m"] = 0.9,
			["stmres"] = 1.45,
		},
		radGive = 5, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["eye"] = {
		name = "Eye",
		itemid = "art_eye", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_ACID.."-m"] = 0.9,
			[DMG_SONIC.."-m"] = 1.1,
			["psy-m"] = 1.1,
			[DMG_SHOCK.."-m"] = 0.7,

		},
		radGive = 3, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		active = {
			canRun = function(item, ply) 
				return item:getData("lastuse", os.time()) <= os.time() 
			end, --if true or doesnt exist, runs below
			run = function(item, ply)
				item:setData("lastuse", os.time()+300)

				hook.Run("ReduceBleed", ply:getChar(), 8)
			end
		},
	},
	["mamasbeads"] = {
		name = "Mama's Beads",
		itemid = "art_mamasbeads", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_BURN.."-m"] = 1.25,
			[DMG_SHOCK.."-m"] = 0.7,

		},
		radGive = 1, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		active = {
			canRun = function(item, ply) 
				return item:getData("lastuse", os.time()) <= os.time() 
			end, --if true or doesnt exist, runs below
			run = function(item, ply)
				item:setData("lastuse", os.time()+300)

				hook.Run("ReduceBleed", ply:getChar(), 5)
			end
		},
	},
	["kolobok"] = {
		name = "Kolobok",
		itemid = "art_kolobok", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_RADIATION.."-m"] = 0.84,
			[DMG_BURN.."-m"] = 0.7,
			["stmres"] = 0.76,

		},
		radGive = 3, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		active = {
			canRun = function(item, ply) 
				return item:getData("lastuse", os.time()) <= os.time() 
			end, --if true or doesnt exist, runs below
			run = function(item, ply)
				item:setData("lastuse", os.time()+600)

				healPlayer(ply, ply, 40, 30, "kolobok")
				ply:getChar():addBoost("kolobokboost", "stm", -4)
				ply:getChar():addBoost("kolobokboost", "qkn", -3)
				timer.Simple(50, function()
					ply:getChar():removeBoost("kolobokboost", "stm")
					ply:getChar():removeBoost("kolobokboost", "qkn")
				end)
			end
		},
	},
	["shell"] = {
		name = "Shell",
		itemid = "art_shell", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_ACID.."-m"] = 0.77,
			[DMG_SONIC.."-m"] = 1.1,
			["psy-m"] = 1.1,
			[DMG_SLASH.."-m"] = 0.93,
			[DMG_CLUB.."-m"] = 0.93,
			[DMG_CRUSH.."-m"] = 0.93,
			["stmres"] = 1.4,

		},
		radGive = 3, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["nightstar"] = {
		name = "Nightstar",
		itemid = "art_nightstar", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_BURN.."-m"] = 0.9,
			[DMG_ACID.."-m"] = 0.9,

		},
		radGive = 1, --the amt this gives/removes per min
		onAdd = function(item, ply) modifyWeightAdd(ply, 5.2) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		onRem = function(item, ply) modifyWeightRem(ply, 5.2) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["stoneflower"] = {
		name = "Stone Flower",
		itemid = "art_stoneflower", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_BURN.."-m"] = 0.9,
			[DMG_ACID.."-m"] = 1.1,
			[DMG_SONIC.."-m"] = 1.3,
			["psy-m"] = 1.3,

		},
		radGive = 1, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["battery"] = {
		name = "Battery",
		itemid = "art_battery", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_BURN.."-m"] = 0.9,
			[DMG_SHOCK.."-m"] = 1.2,
			[DMG_BULLET.."-m"] = 0.93,
			["stmres"] = 1.22,

		},
		radGive = 1, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["sparkler"] = {
		name = "Sparkler",
		itemid = "art_sparkler", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_ACID.."-m"] = 0.9,
			[DMG_SHOCK.."-m"] = 1.5,
			[DMG_SLASH.."-m"] = 1.07,
			[DMG_CLUB.."-m"] = 1.07,
			[DMG_CRUSH.."-m"] = 1.07,

		},
		radGive = 1, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["meatchunk"] = {
		name = "Meat Chunk",
		itemid = "art_meatchunk", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_ACID.."-m"] = 1.3,
			[DMG_SONIC.."-m"] = 0.9,
			["psy-m"] = 0.9,
			[DMG_SHOCK.."-m"] = 1.1,

		},
		radGive = 3, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["bubble"] = {
		name = "Bubble",
		itemid = "art_bubble", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_BURN.."-m"] = 1.1,
			[DMG_ACID.."-m"] = 1.45,
			[DMG_SONIC.."-m"] = 0.7,
			["psy-m"] = 0.7,
			[DMG_SLASH.."-m"] = 0.93,
			[DMG_CLUB.."-m"] = 0.93,
			[DMG_CRUSH.."-m"] = 0.93,

		},
		radGive = 5, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["fireball"] = {
		name = "Fireball",
		itemid = "art_fireball", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_BURN.."-m"] = 1.45,
			[DMG_SHOCK.."-m"] = 0.67,
			[DMG_SLASH.."-m"] = 1.07,
			[DMG_CLUB.."-m"] = 1.07,
			[DMG_CRUSH.."-m"] = 1.07,
			[DMG_BULLET.."-m"] = 0.93,

		},
		radGive = 5, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["stoneblood"] = {
		name = "Stone Blood",
		itemid = "art_stoneblood", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it	
			[DMG_BURN.."-m"] = 0.9,
			[DMG_ACID.."-m"] = 1.3,

		},
		radGive = 1, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		active = {
			canRun = function(item, ply) 
				return item:getData("lastuse", os.time()) <= os.time() 
			end, --if true or doesnt exist, runs below
			run = function(item, ply)
				item:setData("lastuse", os.time()+300)

				hook.Run("ReduceBleed", ply:getChar(), 2)
			end
		},
	},
	["soul"] = {
		name = "Soul",
		itemid = "art_soul", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_RADIATION.."-m"] = 0.9,
			[DMG_SONIC.."-m"] = 1.1,
			["psy-m"] = 1.1,
			["stmres"] = 0.8,

		},
		radGive = 1, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		active = {
			canRun = function(item, ply) 
				return item:getData("lastuse", os.time()) <= os.time() 
			end, --if true or doesnt exist, runs below
			run = function(item, ply)
				item:setData("lastuse", os.time()+600)

				healPlayer(ply, ply, 20, 30, "soul")
				ply:getChar():addBoost("soulboost", "stm", -3)
				ply:getChar():addBoost("soulboost", "qkn", -2)
				timer.Simple(50, function()
					ply:getChar():removeBoost("soulboost", "stm")
					ply:getChar():removeBoost("soulboost", "qkn")
				end)
			end
		},
	},
	["goldfish"] = {
		name = "Goldfish",
		itemid = "art_goldfish", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_SLASH.."-m"] = 0.67,
			[DMG_CLUB.."-m"] = 0.67,
			[DMG_CRUSH.."-m"] = 0.67,
			[DMG_BULLET.."-m"] = 0.9,

		},
		radGive = 5, --the amt this gives/removes per min
		onAdd = function(item, ply) modifyWeightAdd(ply, 13.3) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		onRem = function(item, ply) modifyWeightRem(ply, 13.3) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["gravi"] = {
		name = "gravi",
		itemid = "art_gravi", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
		
			[DMG_SONIC.."-m"] = 0.9,
			["psy-m"] = 0.9,
			[DMG_SHOCK.."-m"] = 0.9,
			[DMG_BULLET.."-m"] = 1.07,

		},
		radGive = 3, --the amt this gives/removes per min
		onAdd = function(item, ply) modifyWeightAdd(ply, 8.4) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		onRem = function(item, ply) modifyWeightRem(ply, 8.4) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["wrenched"] = {
		name = "Wrenched",
		itemid = "art_wrenched", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_ACID.."-m"] = 1.1,
			[DMG_SHOCK.."-m"] = 0.9,
			[DMG_SLASH.."-m"] = 1.4,
			[DMG_CLUB.."-m"] = 1.4,
			[DMG_CRUSH.."-m"] = 1.4,
			[DMG_BULLET.."-m"] = 1.4,

		},
		radGive = 3, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["jellyfish"] = {
		name = "Jellyfish",
		itemid = "art_jellyfish", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_BURN.."-m"] = 1.1,
			[DMG_SONIC.."-m"] = 0.9,
			["psy-m"] = 0.9,
			[DMG_SLASH.."-m"] = 1.25,
			[DMG_CLUB.."-m"] = 1.25,
			[DMG_CRUSH.."-m"] = 1.25,
			[DMG_BULLET.."-m"] = 1.25,

		},
		radGive = 1, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},
	["crystal"] = {
		name = "crystal",
		itemid = "art_crystal", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_BURN.."-m"] = 1.3,
			[DMG_SHOCK.."-m"] = 1.1,
			[DMG_SLASH.."-m"] = 0.93,
			[DMG_CLUB.."-m"] = 0.93,
			[DMG_CRUSH.."-m"] = 0.93,
			[DMG_BULLET.."-m"] = 0.93,

		},
		radGive = 1, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		/*active = {
			--canRun = function(ply) end, --if true or doesnt exist, runs below
			run = function(ply) end
		},*/
	},

	--[[["firefly"] = {--i dont seem to have a model for this but i did it anyway
		name = "Firefly",
		itemid = "art_firefly", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_RADIATION.."-m"] = 0.74,
			[DMG_SLASH.."-m"] = 0.93,
			[DMG_CLUB.."-m"] = 0.93,
			[DMG_CRUSH.."-m"] = 0.93,
			[DMG_BULLET.."-m"] = 0.93,
			["stmres"] = 0.54,

		},
		radGive = 5, --the amt this gives/removes per min
		--onAdd = function(item, ply) end, --adding extra stuff when equipping it in a belt
		--onAddLoadout = function(item, ply) end, --used for adding when loadout is ran
		--onRem = function(item, ply) end, --removing that extra stuff
		--used for adding active abilities
		active = {
			canRun = function(item, ply) 
				return item:getData("lastuse", os.time()) <= os.time() 
			end, --if true or doesnt exist, runs below
			run = function(item, ply)
				item:setData("lastuse", os.time()+300)

				healPlayer(ply, ply, 40, 30, "firefly")
				ply:getChar():addBoost("fireflyboost", "stm", -6)
				ply:getChar():addBoost("fireflyboost", "qkn", -4)
				timer.Simple(30, function()
					ply:getChar():removeBoost("fireflyboost", "stm")
					ply:getChar():removeBoost("fireflyboost", "qkn")
				end)
			end
		},
	},]]
}
--and a mass item table
PLUGIN.artItems = {
	--[[
    ["ex"] = {
		name = "name",
		desc = "desc",
		model = "model",
		--skin = 0,
		price = 1,
		width = 1,
		height = 1,
		weight = 1,
		--flag = "",
		artid = "",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
	]]
    ["art_flame"] = {
		name = "Flame",
		desc = "",--A thermal artifact is known for it's strong wound healing emissions.",
		model = "models/kali/miscstuff/stalker/artifacts/flame.mdl",
		--skin = 0,
		price = 46925,
		width = 1,
		height = 1,
		weight = 3.18,
		--flag = "",
		artid = "flame",
		junkArt = false,
		hasUse = true, --true if has an active in desc
	},
    ["art_snowflake"] = {
		name = "Snowflake",
		desc = "",--Greatly improves stamina recovery, but absorbs and amplifies surrounding energy.",
		model = "models/kali/miscstuff/stalker/artifacts/snowflake.mdl",
		--skin = 0,
		price = 51400,
		width = 1,
		height = 1,
		weight = 0.54,
		--flag = "",
		artid = "snowflake",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_eye"] = {
		name = "Eye",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/eye.mdl",
		--skin = 0,
		price = 36900,
		width = 1,
		height = 1,
		weight = 3.12,
		--flag = "",
		artid = "eye",
		junkArt = false,
		hasUse = true, --true if has an active in desc
	},
    ["art_mamasbeads"] = {
		name = "Mama's Beads",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/mama's beads.mdl",
		--skin = 0,
		price = 24800,
		width = 1,
		height = 1,
		weight = 3.43,
		--flag = "",
		artid = "mamasbeads",
		junkArt = false,
		hasUse = true, --true if has an active in desc
	},
    ["art_kolobok"] = {
		name = "Kolobok",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/kolobok.mdl",
		--skin = 0,
		price = 40600,
		width = 1,
		height = 1,
		weight = 1.4,
		--flag = "",
		artid = "kolobok",
		junkArt = false,
		hasUse = true, --true if has an active in desc
	},
    ["art_shell"] = {
		name = "Shell",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/shell.mdl",
		--skin = 0,
		price = 37200,
		width = 1,
		height = 1,
		weight = 0.37,
		--flag = "",
		artid = "shell",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_nightstar"] = {
		name = "Nightstar",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/night star.mdl",
		--skin = 0,
		price = 33200,
		width = 1,
		height = 1,
		weight = 0.83,
		--flag = "",
		artid = "nightstar",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_stoneflower"] = {
		name = "Stone Flower",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/stone flower.mdl",
		--skin = 0,
		price = 22800,
		width = 1,
		height = 1,
		weight = 5.08,
		--flag = "",
		artid = "stoneflower",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_battery"] = {
		name = "Battery",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/battery.mdl",
		--skin = 0,
		price = 27200,
		width = 1,
		height = 1,
		weight = 0.36,
		--flag = "",
		artid = "battery",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_sparkler"] = {
		name = "Sparkler",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/sparkler.mdl",
		--skin = 0,
		price = 21600,
		width = 1,
		height = 1,
		weight = 0.15,
		--flag = "",
		artid = "sparkler",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_meatchunk"] = {
		name = "Meat Chunk",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/meat chunk.mdl",
		--skin = 0,
		price = 31300,
		width = 1,
		height = 1,
		weight = 1.24,
		--flag = "",
		artid = "meatchunk",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_bubble"] = {
		name = "Bubble",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/bubble.mdl",
		--skin = 0,
		price = 47400,
		width = 1,
		height = 1,
		weight = 1.44,
		--flag = "",
		artid = "bubble",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_fireball"] = {
		name = "Fireball",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/fireball.mdl",
		--skin = 0,
		price = 46800,
		width = 1,
		height = 1,
		weight = 3.67,
		--flag = "",
		artid = "fireball",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_stoneblood"] = {
		name = "Stone Blood",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/stone blood.mdl",
		--skin = 0,
		price = 22200,
		width = 1,
		height = 1,
		weight = 1.22,
		--flag = "",
		artid = "stoneblood",
		junkArt = false,
		hasUse = true, --true if has an active in desc
	},
    ["art_soul"] = {
		name = "Soul",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/soul.mdl",
		--skin = 0,
		price = 26200,
		width = 1,
		height = 1,
		weight = 1.34,
		--flag = "",
		artid = "soul",
		junkArt = false,
		hasUse = true, --true if has an active in desc
	},
    ["art_goldfish"] = {
		name = "Goldfish",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/goldfish.mdl",
		--skin = 0,
		price = 66200,
		width = 1,
		height = 1,
		weight = 1.49,
		--flag = "",
		artid = "goldfish",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_gravi"] = {
		name = "Gravi",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/gravi.mdl",
		--skin = 0,
		price = 47500,
		width = 1,
		height = 1,
		weight = 1.14,
		--flag = "",
		artid = "gravi",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_wrenched"] = {
		name = "Wrenched",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/wrenched.mdl",
		--skin = 0,
		price = 35500,
		width = 1,
		height = 1,
		weight = 5.07,
		--flag = "",
		artid = "wrenched",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_jellyfish"] = {
		name = "Jellyfish",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/jellyfish.mdl",
		--skin = 0,
		price = 24900,
		width = 1,
		height = 1,
		weight = 3.25,
		--flag = "",
		artid = "jellyfish",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_crystal"] = {
		name = "Crystal",
		desc = "",
		model = "models/kali/miscstuff/stalker/artifacts/crystal.mdl",
		--skin = 0,
		price = 31800,
		width = 1,
		height = 1,
		weight = 2.73,
		--flag = "",
		artid = "crystal",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},

	
    ["art_atom"] = {
		name = "Atom",
		desc = "",
		model = "models/artefacts/atom.mdl",
		--skin = 0,
		price = 9800,
		width = 1,
		height = 1,
		weight = 0.66,
		--flag = "",
		artid = "atom",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_ball"] = {
		name = "Ball",
		desc = "",
		model = "models/artefacts/ball.mdl",
		--skin = 0,
		price = 9800,
		width = 1,
		height = 1,
		weight = 0.78,
		--flag = "",
		artid = "ball",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_basilisk"] = {
		name = "Basilisk",
		desc = "",
		model = "models/artefacts/basilisk.mdl",
		--skin = 0,
		price = 64650,
		width = 1,
		height = 1,
		weight = 0.5,
		--flag = "",
		artid = "basilisk",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_bat"] = {
		name = "Bat",
		desc = "",
		model = "models/artefacts/bat.mdl",
		--skin = 0,
		price = 30300,
		width = 1,
		height = 1,
		weight = 2.27,
		--flag = "",
		artid = "bat",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_blackangel"] = {
		name = "Black Angel",
		desc = "",
		model = "models/artefacts/black_angel.mdl",
		--skin = 0,
		price = 26700,
		width = 1,
		height = 1,
		weight = 3.85,
		--flag = "",
		artid = "blackangel",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_cell"] = {
		name = "Cell",
		desc = "",
		model = "models/artefacts/cell.mdl",
		--skin = 0,
		price = 23200,
		width = 1,
		height = 1,
		weight = 1.81,
		--flag = "",
		artid = "cell",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_chain"] = {
		name = "Chain",
		desc = "",
		model = "models/artefacts/chelust.mdl",
		--skin = 0,
		price = 22400,
		width = 1,
		height = 1,
		weight = 5.73,
		--flag = "",
		artid = "chain",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_cocoon"] = {
		name = "Cocoon",
		desc = "",
		model = "models/artefacts/cocon.mdl",
		--skin = 0,
		price = 17400,
		width = 1,
		height = 1,
		weight = 1.03,
		--flag = "",
		artid = "atom",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_blackstone"] = {
		name = "Black Stone",
		desc = "",
		model = "models/artefacts/diablo.mdl",
		--skin = 0,
		price = 21600,
		width = 1,
		height = 1,
		weight = 1.37,
		--flag = "",
		artid = "blackstone",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_dragoneye"] = {
		name = "Dragon Eye",
		desc = "",
		model = "models/artefacts/dragon_eye.mdl",
		--skin = 0,
		price = 15600,
		width = 1,
		height = 1,
		weight = 1.16,
		--flag = "",
		artid = "dragoneye",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_heart"] = {
		name = "Heart",
		desc = "",
		model = "models/artefacts/ear.mdl",
		--skin = 0,
		price = 6700,
		width = 1,
		height = 1,
		weight = 0.58,
		--flag = "",
		artid = "heart",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_electron"] = {
		name = "Electron",
		desc = "",
		model = "models/artefacts/electron.mdl",
		--skin = 0,
		price = 20700,
		width = 1,
		height = 1,
		weight = 5.9,
		--flag = "",
		artid = "electron",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_knot"] = {
		name = "Knot",
		desc = "",
		model = "models/artefacts/fire_loop.mdl",
		--skin = 0,
		price = 17800,
		width = 1,
		height = 1,
		weight = 1.68,
		--flag = "",
		artid = "knot",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_fountain"] = {
		name = "Fountain",
		desc = "",
		model = "models/artefacts/fountain.mdl",
		--skin = 0,
		price = 17300,
		width = 1,
		height = 1,
		weight = 1.32,
		--flag = "",
		artid = "fountain",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_generator"] = {
		name = "Generator",
		desc = "",
		model = "models/artefacts/generator.mdl",
		--skin = 0,
		price = 20700,
		width = 1,
		height = 1,
		weight = 4.07,
		--flag = "",
		artid = "generator",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_gimlet"] = {
		name = "Gimlet",
		desc = "",
		model = "models/artefacts/gimlet.mdl",
		--skin = 0,
		price = 30700,
		width = 1,
		height = 1,
		weight = 0.09,
		--flag = "",
		artid = "gimlet",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_grapes"] = {
		name = "Grapes",
		desc = "",
		model = "models/artefacts/grapes.mdl",
		--skin = 0,
		price = 18700,
		width = 1,
		height = 1,
		weight = 4.78,
		--flag = "",
		artid = "grapes",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_sourpuss"] = {
		name = "Sourpuss",
		desc = "",
		model = "models/artefacts/kislushka.mdl",
		--skin = 0,
		price = 7890,
		width = 1,
		height = 1,
		weight = 1.17,
		--flag = "",
		artid = "sourpuss",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_claw"] = {
		name = "Claw",
		desc = "",
		model = "models/artefacts/kogot.mdl",
		--skin = 0,
		price = 7400,
		width = 1,
		height = 1,
		weight = 0.64,
		--flag = "",
		artid = "claw",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_beacon"] = {
		name = "Beacon",
		desc = "",
		model = "models/artefacts/lighthouse.mdl",
		--skin = 0,
		price = 24500,
		width = 1,
		height = 1,
		weight = 1.75,
		--flag = "",
		artid = "beacon",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_medal"] = {
		name = "Medal",
		desc = "",
		model = "models/artefacts/medalion.mdl",
		--skin = 0,
		price = 26900,
		width = 1,
		height = 1,
		weight = 2.96,
		--flag = "",
		artid = "medal",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_moon"] = {
		name = "Moon",
		desc = "",
		model = "models/artefacts/peas.mdl",
		--skin = 0,
		price = 8700,
		width = 1,
		height = 1,
		weight = 0.8,
		--flag = "",
		artid = "moon",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_phantomstar"] = {
		name = "Phantom Star",
		desc = "",
		model = "models/artefacts/phantom_star.mdl",
		--skin = 0,
		price = 19000,
		width = 1,
		height = 1,
		weight = 4.09,
		--flag = "",
		artid = "phantomstar",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_thistle"] = {
		name = "Thistle",
		desc = "",
		model = "models/artefacts/repei.mdl",
		--skin = 0,
		price = 10560,
		width = 1,
		height = 1,
		weight = 0.3,
		--flag = "",
		artid = "thistle",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_sandstone"] = {
		name = "Sandstone",
		desc = "",
		model = "models/artefacts/sandstone.mdl",
		--skin = 0,
		price = 19800,
		width = 1,
		height = 1,
		weight = 2.22,
		--flag = "",
		artid = "sandstone",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_seraphim"] = {
		name = "Seraphim",
		desc = "",
		model = "models/artefacts/serafim.mdl",
		--skin = 0,
		price = 9800,
		width = 1,
		height = 1,
		weight = 0.6,
		--flag = "",
		artid = "seraphim",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_miserskull"] = {
		name = "Miser's Skull",
		desc = "",
		model = "models/artefacts/skull.mdl",
		--skin = 0,
		price = 7800,
		width = 1,
		height = 1,
		weight = 0.32,
		--flag = "",
		artid = "miserskull",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_spike"] = {
		name = "Spike",
		desc = "",
		model = "models/artefacts/spaika.mdl",
		--skin = 0,
		price = 19200,
		width = 1,
		height = 1,
		weight = 1.5,
		--flag = "",
		artid = "spike",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_sun"] = {
		name = "Sun",
		desc = "",
		model = "models/artefacts/sun.mdl",
		--skin = 0,
		price = 21800,
		width = 1,
		height = 1,
		weight = 3.49,
		--flag = "",
		artid = "sun",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_tapeworm"] = {
		name = "Tapeworm",
		desc = "",
		model = "models/artefacts/tapeworm.mdl",
		--skin = 0,
		price = 12700,
		width = 1,
		height = 1,
		weight = 0.83,
		--flag = "",
		artid = "tapeworm",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
}