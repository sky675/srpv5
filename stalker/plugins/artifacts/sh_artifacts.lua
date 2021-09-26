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
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/radiation.png")
	},
	[DMG_SONIC.."-m"] = {hidden = true},
	["psy-m"] = {
		name = "Psy Multiplier",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/psy.png")
	},
	[DMG_SLASH.."-m"] = {
		name = "Physical Multiplier",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/rupture.png")
	},
	[DMG_CLUB.."-m"] = {hidden = true},
	[DMG_CRUSH.."-m"] = {hidden = true},
	[DMG_BULLET.."-m"] = {
		name = "Ballistic Multiplier",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/ballistic.png")
	},
	--burn
	[DMG_BURN.."-m"] = {
		name = "Thermal Multiplier",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/burn.png")
	},
	--explosion
	[DMG_BLAST.."-m"] = {
		name = "Explosion Multiplier",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/explsoive.png")
	},
	--electric
	[DMG_SHOCK.."-m"] = {
		name = "Electrical Multiplier",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/electrical.png")
	},
	--chem
	[DMG_ACID.."-m"] = {
		name = "Chemical Multiplier",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/chemical.png")
	},

	["stmres"] = {
		name = "Stamina Recovery",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/sprint.png")
	},

	
	--bullet half of wound
	[DMG_BULLET] = {
		name = "Ballistic Resistance",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/ballistic.png")
	},
	--phys
	[DMG_SLASH] = {
		name = "Physical Resistance",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/rupture.png")
	},
	[DMG_CLUB] = {hidden = true},
	[DMG_CRUSH] = {hidden = true},
	--burn
	[DMG_BURN] = {
		name = "Burn Resistance",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/burn.png")
	},
	--explosion
	[DMG_BLAST] = {
		name = "Explosive Resistance",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/explosive.png")
	},
	--electric
	[DMG_SHOCK] = {
		name = "Electrical Resistance",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/electrical.png")
	},
	--ext rad
	[DMG_RADIATION] = {
		name = "Ext. Radiation Resistance",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/radiation.png")
	},
	--chem
	[DMG_ACID] = {
		name = "Chemical Resistance",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/chemical.png")
	},
	--psy
	[DMG_SONIC] = {
		name = "Psychic Resistance",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/psy.png")
	},
	["psy"] = {hidden = true},
	spd = {
		name = "Speed Multiplier",
		func = function(val) return ((val*100).."%") end,
		icon = Material("sky/markup_icons/id/sprint.png")
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
	["moonlight"] = {
		name = "Moonlight",
		itemid = "art_moonlight", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_BURN.."-m"] = 0.7,
			[DMG_SHOCK.."-m"] = 1.1,
			[DMG_SONIC.."-m"] = 1.5,
			["psy-m"] = 1.5,

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
	["flash"] = {
		name = "Flash",
		itemid = "art_flash", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_SONIC.."-m"] = 1.1,
			["psy-m"] = 1.1,
			[DMG_SHOCK.."-m"] = 2.2,
			[DMG_SLASH.."-m"] = 0.93,
			[DMG_CLUB.."-m"] = 0.93,
			[DMG_CRUSH.."-m"] = 0.93,
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
	["empty"] = {
		name = "Empty",
		itemid = "art_empty", --the item uniqueid this corresponds to
		levels = { --this is what gets added in resist calcs
		--use val-m to multiply a value instead of add onto it
			[DMG_SHOCK.."-m"] = 1.1,
			[DMG_SLASH.."-m"] = 1.6,
			[DMG_CLUB.."-m"] = 1.6,
			[DMG_CRUSH.."-m"] = 1.6,
			[DMG_BULLET.."-m"] = 1.6,
			["stmres"] = 0.8,

		},
		radGive = 5, -- this should be 3 but since no full empty doing this for balance, otherwise its just a straight upgrade from wrenched --the amt this gives/removes per min
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

	["firefly"] = {
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
	},
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
		desc = "This artefact forms in areas of high thermal activity. Produces powerful infrared emissions which intensify metabolic processes, healing wounds before its bearer's very eyes.",--A thermal artifact is known for it's strong wound healing emissions.",
		model = "models/spec45as/stalker/artefacts/af_fire.mdl",
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
		desc = "Also colloquially known as \"Radioactive Snowflake\". At first glance, this artefact resembles a white Kolobok.",--Greatly improves stamina recovery, but absorbs and amplifies surrounding energy.",
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
		desc = "This artefact, which resembles the human eye, considerably increases metabolism of the body, helping wounds heal quicker. Experienced stalkers say that Eye also brings luck. Irrespective of the validity of that statement, its positive effects are indeed quite potent.",
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
		desc = "Shaped like a DNA helix, Mama's Beads are created in the Burner anomaly. One of their most characteristic features is that they constantly pulsate, generating emissions beneficial to the human body. These emissions increase the metabolism of any living creature, accelerating coagulation and healing of wounds.The mechanism behind the effects of this artefact is still unknown.",
		model = "models/spec45as/stalker/artefacts/af_dummy_glassbeads.mdl",
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
		desc = "A relatively rare artefact forming in chemical areas, Kolobok is highly valued for its ability to heal most kinds of wounds and stop bleeding in a matter of minutes.",
		model = "models/spec45as/stalker/artefacts/af_fuzz_kolobok.mdl",
		--skin = 0,
		price = 40600,
		width = 1,
		height = 1,
		weight = 1.4,
		--flag = "",
		artid = "kolobok",
		junkArt = false,
		hasUse = true, --true if has an active in desc
		iconCam = {
			pos = Vector(147.28645324707, 123.82252502441, 94.496612548828),
			ang = Angle(25, 220, 0),
			entAng = Angle(0, 0, 0),
			fov = 2.6518231768487,
		}		
	},
    ["art_firefly"] = {
		name = "Firefly",
		desc = "Firefly interacts with fields unknown to science, considerably speeding up regeneration of tissue and organs in living beings, as well as normalizing metabolic processes.",
		model = "models/spec45as/stalker/artefacts/af_glass.mdl",
		--skin = 0,
		price = 54400,
		width = 1,
		height = 1,
		weight = 1.49,
		--flag = "",
		artid = "firefly",
		junkArt = false,
		hasUse = true, --true if has an active in desc
		iconCam = {
			pos = Vector(178.26388549805, 149.56039428711, 117.08714294434),
			ang = Angle(25, 220, 0),
			entAng = Angle(0, 0, 0),
			fov = 1.2979553936818,
		}		
	},
    ["art_shell"] = {
		name = "Shell",
		desc = "Shell is composed of two disk of bluish colour connected by semitransparent material of unknown nature.",
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
		desc = "This glowing artefact can generate a local directed low-gravity field. Widely used by stalkers along with Gravi, a similar artefact, to increase maximum load.",
		model = "models/spec45as/stalker/artefacts/af_night_star.mdl",
		--skin = 0,
		price = 33200,
		width = 1,
		height = 1,
		weight = 0.83,
		--flag = "",
		artid = "nightstar",
		junkArt = false,
		hasUse = false, --true if has an active in desc
		iconCam = {
			pos = Vector(147.28645324707, 123.82252502441, 94.496612548828),
			ang = Angle(25, 220, 0),
			entAng = Angle(0, 0, 0),
			fov = 2.6518231768487,
		}		
	},
    ["art_stoneflower"] = {
		name = "Stone Flower",
		desc = "This artefact resembles melted cheese interspersed with sapphire-like stones. Only yellow outer shell of the artefact appears to give off radiation and by careful processing it is possible to extract the non-radioactive blue parts for jewellery and other industrial purposes.",
		model = "models/spec45as/stalker/artefacts/af_cristall_flower.mdl",
		--skin = 0,
		price = 22800,
		width = 1,
		height = 1,
		weight = 5.08,
		--flag = "",
		artid = "stoneflower",
		junkArt = false,
		hasUse = false, --true if has an active in desc
		iconCam = {
			pos = Vector(96.859771728516, 81.424224853516, 58.952766418457),
			ang = Angle(25, 220, 0),
			entAng = Angle(33.017581939697, 0.39450764656067, -28.045347213745),
			fov = 3.4138372093174,
		}		
	},
    ["art_moonlight"] = {
		name = "Moonlight",
		desc = "This unique electrostatic artefact can resonate under the influence of psy-waves. Stalkers have learned to fine-tune the artefact so that it resonates in opposite phase to the main source of emissions, thus significantly neutralizing their effects.",
		model = "models/spec45as/stalker/artefacts/af_electra_moonlight.mdl",
		--skin = 0,
		price = 43600,
		width = 1,
		height = 1,
		weight = 0.19,
		--flag = "",
		artid = "moonlight",
		junkArt = false,
		hasUse = false, --true if has an active in desc
		iconCam = {
			pos = Vector(105.26225280762, 88.346755981445, 67.645332336426),
			ang = Angle(25, 220, 0),
			entAng = Angle(0, 0.39450764656067, 0),
			fov = 2.6705417261291,
		}		
	},
    ["art_battery"] = {
		name = "Battery",
		desc = "The artefact is quite popular in the Zone and is valued by its residents and visitors alike for its energizing properties, although it has an adverse effect on the body when used for prolonged periods of time.",
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
		desc = "This artefact has the appearance of translucent spider webs. Just as proteinaceous spider silk, it is sticky and has properties of glue.",
		model = "models/spec45as/stalker/artefacts/af_electra_sparkler.mdl",
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
    ["art_flash"] = {
		name = "Flash",
		desc = "This artefact is very similar in appearance to Moonlight and resembles a plasma globe or a plasma lamp.",
		model = "models/spec45as/stalker/artefacts/af_electra_flash.mdl",
		--skin = 0,
		price = 48900,
		width = 1,
		height = 1,
		weight = 0.17,
		--flag = "",
		artid = "flash",
		junkArt = false,
		hasUse = false, --true if has an active in desc
		iconCam = {
			pos = Vector(178.26388549805, 149.56039428711, 116.42101287842),
			ang = Angle(25, 220, 0),
			entAng = Angle(0, 0, 0),
			fov = 1.2979553936818,
		}		
	},
    ["art_meatchunk"] = {
		name = "Meat Chunk",
		desc = "This artefact has soft, porous, skin-like texture and is said to be able to compress. It resembles and acts like a sponge in this regard, but reveals its special characteristics only when exposed to certain external conditions.",
		model = "models/spec45as/stalker/artefacts/af_mincer_meat.mdl",
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
		desc = "A compound of several hollow organic formations, this artefact emits a gaseous substance that can neutralise chemical or toxic particles inside the body without harming it. Thus providing a a great level of toxic and chemical protection.",
		model = "models/spec45as/stalker/artefacts/af_baloon.mdl",
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
		desc = "It is a spherical artefact made of red-coloured crystal, created in the Burner anomaly."..
		"\nIt has an unique property: it has a constant temperature of 75 degrees Fahrenheit/24 degrees Celsius, regardless of its surroundings. This allows it to absorb heat from its vicinity and to create a little pocket around the user which prevents the flames from damaging the body.",
		model = "models/spec45as/stalker/artefacts/af_fireball.mdl",
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
		desc = "A reddish formation of compressed fossilised plants, soil and animal debris. Can partially neutralise chemical poisons by absorbing them and reducing overall toxicity level in user's bloodstream. Quite widespread and not very effective as it makes chemical burns fester. It will catch fire when exposed to open flame or even spontaneously combust.",
		model = "models/spec45as/stalker/artefacts/af_blood.mdl",
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
		desc = "Soul is a unique organic artefact with properties just as unique: it secretes slimy goo that dramatically increases recovery rate of wounds. Thanks to its reasonable price and attractive appearance, this artefact is a valuable collector's item.",
		model = "models/spec45as/stalker/artefacts/af_soul.mdl",
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
		desc = "Direct successor to and a superior version of Gravi artefact. As was the case with Gravi, it was scientist Sakharov at Yantar who discovered its unique properties after a massive blowout/emission hit the Zone.",
		model = "models/spec45as/stalker/artefacts/af_gold_fish.mdl",
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
		desc = "Gravi is formed from metallic substances exposed to prolonged gravitation. This makes it capable of sustaining an powerful anti-gravitational field, which causes it to have various properties, among others reducing weight of all objects in its close proximity.",
		model = "models/spec45as/stalker/artefacts/af_gravi.mdl",
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
		desc = "This bizarrely-shaped artefact appears in places with increased gravitational activity. Although it appears almost organic, it is actually more similar to coral.",
		model = "models/spec45as/stalker/artefacts/af_vyvert.mdl",
		--skin = 0,
		price = 35500,
		width = 1,
		height = 1,
		weight = 5.07,
		--flag = "",
		artid = "wrenched",
		junkArt = false,
		hasUse = false, --true if has an active in desc
		iconCam = {
			pos = Vector(158.5043182373, 133.03677368164, 100.18608856201),
			ang = Angle(25, 220, 0),
			entAng = Angle(0, 0, 0),
			fov = 2.7708888642801,
		}		
	},
    ["art_empty"] = {
		name = "Empty",
		desc = "Two disks of organic formation (commonly lipids, cellulose and lignin) with nothing but empty space in between. This is due to a unique gravitation field formed in the centre that stabilise the distance between the disks.",
		model = "models/spec45as/stalker/artefacts/af_dummy_dummy.mdl",
		--skin = 0,
		price = 35500,
		width = 1,
		height = 1,
		weight = 5.07,
		--flag = "",
		artid = "empty",
		junkArt = false,
		hasUse = false, --true if has an active in desc
	},
    ["art_jellyfish"] = {
		name = "Jellyfish",
		desc = "Very common in the Zone. This gravitational artefact is able to slightly shield the body and objects from physical impacts.",
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
		desc = "This artefact is formed in anomalous zones with intense thermal activity. Actively consumes excessive heat and remains cool at all times.",
		model = "models/spec45as/stalker/artefacts/af_cristall.mdl",
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
		desc = "A rare and beautiful abnormal formation. Looks like an Atom. Is a weak source of heat. Has no useful properties, Not radioactive. Very valuable to collectors.",
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
		desc = "There is no data on the conditions under which this round artefact is formed, hence the name, but practice shows that it is most often found in places of increased electrical activity. Very agile and bouncy artefact. Has no useful properties. Not radioactive.",
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
		desc = "One of the few artefacts in the Zone, which copes well with all kinds of physical influences on its owner.",
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
		desc = "A very beautiful abnormal formation. Has no useful properties, Not radioactive and quite heavy. Valued by collectors.",
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
		desc = "A root-like artefact. When not in contact with anything, it lets out a bit of steam from it's surface. Very valued by collectors. Has no useful properties. Not radioactive.",
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
		desc = "An artefact of gravitational nature. A useless trinket, yet is highly valued by collectors and jewellers. Not radioactive.",
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
		desc = "A very strange artefact. Generates a strong gravitational field while nothing touches it. Has no useful properties, very heavy. Valuable to collectors outside of the Zone.",
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
		desc = "A formation of gravitational nature. A useless trinket, yet is highly valued by collectors and jewellers. Not radioactive.",
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
		desc = "Truly, an amazing thing. The Black Stone protects against broadly considered adversity but instead is slowly killing the owner. Some stalkers suspect the artefact is a shard of the Monolith.",
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
		desc = "The artefact is mostly formed in fiery anomalies and has the appearance of a reptile's eye. Has no useful properties. Not radioactive.",
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
		desc = "Artefact with a bizarre shape. Its core resembles a human body. Has no useful properties, Not radioactive. Valuable to collectors outside of the Zone.",
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
		desc = "This artefact is a product of electrical anomalies. Very heavy. Has no useful properties. Not radioactive. Very valued beyond the perimeter.",
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
		desc = "A necessary condition for the generation of this artefact is the close impact of a thermal anomaly. It has a bizarre appearance and is therefore appreciated by collectors. Not radioactive, Has no useful properties.",
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
		desc = "An anomaly of presumably gravitational nature. It does not have any useful properties, but because of it's bizarre shape it is very valued by collectors. Not radioactive.",
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
		desc = "This artefact generates weak electric currents and an electromagnetic field. It is a source of energy and therefore very much valued outside the perimeter. Has no useful properties. Not radioactive.",
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
		desc = "Bowl-shaped petals of the artefact release a powerful gaseous stimulant. The result of which is a positive change in human hormones.",
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
		desc = "Amber-like substance of a slight greenish hue. As a result of powerful anomalies it is very heavy. Very valued by collectors. Has no useful properties. Not radioactive.",
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
		desc = "A hollow spherical formation resembling a transparent parchment of some sorts. Covered with a layer of film, pleasant to the touch. Has no useful properties, Not radioactive. Valued by collectors.",
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
		desc = "A beautiful glass-like formation from electrostatic anomalies. Has no useful properties. Not radioactive. Has no value beyond the perimeter.",
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
		desc = "A clot of superdense substance. Contains valuable materials that are used in production, so there is a huge demand for it in the area unaffected by the Zone. Not radioactive, Has no useful properties.",
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
		desc = "It is a small hoop with four embedded parts of a streamlined triangular shape, which have two pairs of opposite charges arbitrarily changing their location within the design. Valued by collectors. Has no useful properties. Not radioactive.",
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
		desc = "Crescent-shaped artefact. Generates a very dim light. Has no useful properties. Not radioactive. Has some value to collectors and jewellers.",
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
		desc = "Formed from an Anomaly. It is a plasma-like substance in a transparent pulsating shell. Generates a weak gravitational field. Has no useful properties. Not radioactive.",
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
		desc = "It is quite often spawned by anomalies of a gravitational nature. It has no valuable properties, but the absence of any harmful effects on the body makes it a must-have for many stalkers. Light, and very valued by jewellers and collectors. Not radioactive.",
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
		desc = "An artefact, which is formed in zones with extreme temperatures. Has no useful properties and Not radioactive. Does not attract collectors or jewellers, but it contains a small amount of gold, so it has some value.",
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
		desc = "An artefact of electric nature. Generates a temporary gravitational field. Has no useful properties. Not radioactive.",
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
    ["art_signet"] = {
		name = "Signet",
		desc = "Some stalkers call this artefact the \"Amulet\". Quite useless, yet some stalkers believe that this artefact brings good luck. Not radioactive.",
		model = "models/artefacts/signet.mdl",
		--skin = 0,
		price = 11800,
		width = 1,
		height = 1,
		weight = 0.6,
		--flag = "",
		artid = "signet",
		junkArt = true,
		hasUse = false, --true if has an active in desc
	},
    ["art_miserskull"] = {
		name = "Miser's Skull",
		desc = "Very light and fragile artefact. Has absolutely no useful properties. Not radioactive.",
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
		desc = "Looks much like a petrified formation. Is an anomaly of presumably gravitational nature. Has no useful properties, Not radioactive.",
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
		desc = "A rare specimen that is very much appreciated by collectors. Has no useful properties, but it is an inexhaustible source of light, very heavy. Not radioactive.",
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
		desc = "This is pure silicon dioxide, if we exclusively take into account the atomic mass of matter. Displays strange behaviour. Has no useful properties. Not radioactive.",
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