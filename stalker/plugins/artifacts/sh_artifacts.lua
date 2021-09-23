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
		desc = "This artefact forms in areas of high thermal activity. Produces powerful infrared emissions which intensify metabolic processes, healing wounds before its bearer's very eyes."..
		"\nIts healing capabilities are even stronger than in case of the Eye as stalkers in possession of this artefact are said to have survived being wounded by chimeras. Thanks to that, it has earned the reputation of a miraculous artefact."..
		"\nMany stalkers owe it their lives, and most veteran mutant hunters carry it in case they run into danger. However, it shares not only positive but also negative properties of its cousin: entering a psy-field with this artefact on the belt is suicide. It will absorb psy energy and emitting it at a considerable rate."..
		"\nAlso, it is highly advised to proceed with caution when planning to bring the artefact to the market as prolonged exposure to even minimal amounts of radioactive materials can result in death of the user."..
		"\nIt can also be used as a reusable medkit of sorts since it heals wounds very quickly.",--A thermal artifact is known for it's strong wound healing emissions.",
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
		desc = "Also colloquially known as \"Radioactive Snowflake\". At first glance, this artefact resembles a white Kolobok."..
		"\nThanks to its unique properties, the artefact can significantly increase the bearer's muscle tone, thus greatly improving stamina recovery. Due to its high radioactivity, stalkers in possession of it are sometimes jokingly referred to as \"Radioactive Snowflakes\"."..
		"\nWhen faced with the decision whether to carry it on the belt during a mission, you have to carefully weigh its pros and cons: does it pay to have greater endurance and high protection against electricity at the cost of being constantly exposed to its deadly radiation? Even if you are determined to take it with you, it should be noted that it is not to be used on long excursions to the Zone."..
		"\nSnowflake, however, holds a big downside: it interacts with surrounding energy sources by absorbing and amplifying their effects. For this reason, approaching heat sources, toxic areas and psy-fields while holding this artefact is a suicide."..
		"\nIt is as light as a snowflake and very easy to carry around.",--Greatly improves stamina recovery, but absorbs and amplifies surrounding energy.",
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
		desc = "This artefact, which resembles the human eye, considerably increases metabolism of the body, helping wounds heal quicker. Experienced stalkers say that Eye also brings luck. Irrespective of the validity of that statement, its positive effects are indeed quite potent."..
		"\nThis artefact soothes the pain and is extremely useful when treating wounds."..
		"\nWhen worn, it is known to slightly counter harmful effects of psy-anomalies or psy-waves of certain mutants."..
		"\nThese beneficial qualities, however, come at a price. This artefact is extremely dangerous when exposed to chemical anomalies as it amplifies their toxicity and increases their potency. It is hence highly recommended to keep the artefact in your backpack, never on the body, when exploring toxic areas unless you have a death wish."..
		"\nThe artefact is also known colloquially as \"copper eye\" as it conducts electricity and amplifies its dangerous effects in the same way as copper does.",
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
		desc = "Shaped like a DNA helix, Mama's Beads are created in the Burner anomaly. One of their most characteristic features is that they constantly pulsate, generating emissions beneficial to the human body. These emissions increase the metabolism of any living creature, accelerating coagulation and healing of wounds.The mechanism behind the effects of this artefact is still unknown."..
		"\nMama's Beads also possess potent protective qualities: they are able to shield the body and objects from extreme heat."..
		"\nOn the other hand, it should be noted that the presence of this artefact increases electrical conductivity, so the probability of electrocution while wearing this artefact is much higher, especially during storms and in the vicinity of electrical anomalies."..
		"\nThe weight is also quite high for such a small artefact, which leads to a conclusion that is of high density.",
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
		desc = "A relatively rare artefact forming in chemical areas, Kolobok is highly valued for its ability to heal most kinds of wounds and stop bleeding in a matter of minutes."..
		"\nFor unknown reasons, scientists are spreading rumours among stalkers that the artefact modifies bearer's genetic code, which is unproven and should be regarded as conscious attempt at monopolizing the supply of the artefact by the scientific community. This does not, however, mean that it is completely harmless."..
		"\nOne drawback of this artefact is the fact that it will interact to radioactive particles, so it is best to avoid radiation fields when in possession of the artefact, especially since its negative effects are not balanced with positive ones. It will also reduce energy recovery, which is the result of its sharp needle-like appendages. The needles cause small and quickly healing wounds which bring constant pain and itch, thus reducing stamina."..
		"\nThis artefact also weakens protection against heat and acids due to its high flammability."..
		"\nLightweight and not too much of a burden to carry around.",
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
		desc = "Firefly interacts with fields unknown to science, considerably speeding up regeneration of tissue and organs in living beings, as well as normalizing metabolic processes."..
		"\nThis artefact can literally get a badly wounded stalker back on his feet in a matter of minutes. On the other hand, Firefly can spontaneously combust when exposed to potent radioactive sources."..
		"\nA big downside to this artefact is that it weakens the body and reduce the number of platelets in blood during heal process, thus increasing bleeding rate."..
		"\nIt seems to drain stamina and decrease stamina recovery greatly as well. Some of those who used Firefly for its healing purposes have reported that they couldn't walk for hours afterwards."..
		"\nUnfortunately, Firefly is extremely rare.",
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
		desc = "Shell is composed of two disk of bluish colour connected by semitransparent material of unknown nature."..
		"\nThis strange artefact was considered devoid of any useful properties by many scientists for a long time. Only recently has it been discovered that it is indeed quite beneficial."..
		"\nWhen the artefact comes into contact with the body, it will make one feel rejuvenated and thus it increases stamina recovery. This effect has in case of some stalkers induced hyperactivity. One downside of this artefact, however, is that it reduces the number of platelets in blood, thus increasing bleeding rate."..
		"\nIt provides a considerable level of psy protection and absorbs electromagnetic interference, acting as a grounding material."..
		"\nIt will catch fire when exposed to open flame or even spontaneously combust. Caution must be taken when approaching heat sources with this artefact."..
		"\nShell is extremely light and very portable.",
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
		desc = "This glowing artefact can generate a local directed low-gravity field. Widely used by stalkers along with Gravi, a similar artefact, to increase maximum load."..
		"\nDue to its beautiful inner core it is highly sought after by jewellers all over the world, however it is best to proceed with caution as unskilled treatment can cause the artefact to explode with power sufficient to level a small building. It is thus highly advised to perform the polishing by means of specialised machinery, which minimises the probability of explosion. Moreover, only the outer core of the artefact emits radiation."..
		"\nNightstar will also absorb toxic and chemical agents from the environment, which makes it a valuable artefact for artefact hunters, although the amount of toxicity absorbed is negligible. It is, however, relatively cheap and even stalkers with pretty tight budgets can afford it if opportunity to buy it arises."..
		"\nThat being said, Nightstar emits odour of burning flesh when in the closest proximity of heat source. Prolonged exposure may enhance its flammability and cause it to ignite.",
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
		desc = "This artefact resembles melted cheese interspersed with sapphire-like stones. Only yellow outer shell of the artefact appears to give off radiation and by careful processing it is possible to extract the non-radioactive blue parts for jewellery and other industrial purposes. This is due to the fact that if cleaned properly and polished, sapphire comparison becomes much more explicit: the stones are as hard and durable as this beautiful gem. This quality of theirs and their appearance make them perfect gemstones and jewellers all over the world strive to have them in stock."..
		"\nThe usefulness of the artefact, however, is not limited to its industrial applications. There is scientific evidence suggesting that sapphire-like stones effectively protect from psy-waves, whereas the outer shell slightly increases resistance to toxicity."..
		"\nHowever, it can cause objects in its vicinity to heat up and in extreme cases to ignite along with the artefact. For this reason, it is safe to conclude that it absorbs heat and is able to convey it to other objects."..
		"\nDue to its density the weight of artefact has increased beyond normal standards, and thus it is one of the heaviest anomalous creations in the Zone.",
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
		desc = "This unique electrostatic artefact can resonate under the influence of psy-waves. Stalkers have learned to fine-tune the artefact so that it resonates in opposite phase to the main source of emissions, thus significantly neutralizing their effects. This orb of considerable beauty also increases electrical protection by reducing conductivity in the body when exposed to high levels of electricity."..
		"\nIt should be noted that Moonlight will catch fire when exposed to open flame or even spontaneously combust.",
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
		desc = "The artefact is quite popular in the Zone and is valued by its residents and visitors alike for its energizing properties, although it has an adverse effect on the body when used for prolonged periods of time."..
		"\nOne should take note, however, that this artefact hinders blood clotting and increases bleeding rate of open wounds. On the other hand, being a powerful resistor, it is well known for its ability to shield its user from lethal doses of electricity."..
		"\nBeing an artefact of electric nature, it is well known for its ability to shield its user from lethal doses of electricity. On the contrary, it should be noted that Battery absorbs heat and is able to convey it to other objects."..
		"\nThis artefact is also extremely light and very portable. ",
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
		desc = "This artefact has the appearance of translucent spider webs. Just as proteinaceous spider silk, it is sticky and has properties of glue."..
		"\nIt can be found most commonly in or near electro anomalies and it seems to have absorbed their certain characteristics: it is able to smooth fluctuations in electric field density and acts as a weak resistor, protecting the wearer from electricity and reducing its damaging effects."..
		"\nOn the other hand, it should be noted that the presence of this artefact increases the corrosiveness of acids, leading to accelerated deterioration of equipment and higher damage to tissues of any living organism.",
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
		desc = "This artefact is very similar in appearance to Moonlight and resembles a plasma globe or a plasma lamp."..
		"\nBeing a powerful resistor, it is well known for its ability to shield its user from lethal doses of electricity."..
		"\nWhen worn, it is known to slightly counter harmful effects of psy-anomalies or psy-waves of certain mutants. Flash acts as a powerful resistor and will absorb even lethal doses of electricity."..
		"\nHowever, it also hinders healing process, thus caution is advised especially when wounded or bleeding. This artefact is also extremely light and very portable.",
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
		desc = "This artefact has soft, porous, skin-like texture and is said to be able to compress. It resembles and acts like a sponge in this regard, but reveals its special characteristics only when exposed to certain external conditions."..
		"\nFirstly, to carry the sponge metaphor further, the pores on its surface are known to absorb small amounts of toxicity from environment."..
		"\nSecondly, the artefact slightly amplifies the damaging effects of psy-fields to living organisms by absorbing psy energy and emitting it at a small rate."..
		"\nThirdly, Meat Chunk is also known to be a conductor of electricity much like the skin of a living creature.",
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
		desc = "A compound of several hollow organic formations, this artefact emits a gaseous substance that can neutralise chemical or toxic particles inside the body without harming it. Thus providing a a great level of toxic and chemical protection."..
		"\nIt also has a constant temperature regardless of its surroundings. This allows it to absorb heat from its vicinity and to create a little pocket around the user which prevents the flames from damaging the body."..
		"\nApart from that Bubble, however, possesses numerous negative properties. For example, it greatly amplifies the effects of psy-waves as well as fields produced by mutants and anomalies. This disadvantage is not to be taken lightly: some stalkers have reported that psy influence was so potent when in possession of a Bubble that they felt their heads cracking from the inside and the only thing they could do was scream in pain and run as far as they could.",
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
		"\nIt has an unique property: it has a constant temperature of 75 degrees Fahrenheit/24 degrees Celsius, regardless of its surroundings. This allows it to absorb heat from its vicinity and to create a little pocket around the user which prevents the flames from damaging the body."..
		"\nA dangerous effect of this artefact is the fact that it will increase electrical conductivity, so the probability of electrocution while wearing this artefact is much higher, especially during storms and in the vicinity of electrical anomalies.It is quite heavy due to high density of crystal-like material.",
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
		desc = "A reddish formation of compressed fossilised plants, soil and animal debris. Can partially neutralise chemical poisons by absorbing them and reducing overall toxicity level in user's bloodstream. Quite widespread and not very effective as it makes chemical burns fester. It will catch fire when exposed to open flame or even spontaneously combust."..
		"\nAnother positive effect possessed by this artefact is that it accelerates clotting if worn close to the body. Although it is not recommended to keep this artefact in your possession for longer periods of time as blood clots can be hazardous to your health.",
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
		desc = "Soul is a unique organic artefact with properties just as unique: it secretes slimy goo that dramatically increases recovery rate of wounds. Thanks to its reasonable price and attractive appearance, this artefact is a valuable collector's item."..
		"\nApplying its gooey substance to wounds will soothes the pain and speeds up healing process."..
		"\nIt also reduces the effects of psy-waves and their damage to one's brain. But it should be known that Soul drains power from its user. The artefact does not have high density and thus is not very heavy.",
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
		desc = "Direct successor to and a superior version of Gravi artefact. As was the case with Gravi, it was scientist Sakharov at Yantar who discovered its unique properties after a massive blowout/emission hit the Zone."..
		"\nThanks to meticulous research that followed, it was established that this new artefact is produced when three Gravi artefacts interact and get sucked into one another's singularity fields. This phenomenon is extremely rare, due to which the artefact is highly valued."..
		"\nIt is rumoured within Ukrainian Spetsnaz circles that in the Zone there are agents from the Ministry of Defence of the Russian Federation whose sole objective is acquiring and transporting Goldfish to specialised laboratories located outside of the Zone."..
		"\nThe artefact creates a constant anti-gravitational singularity field which affects only its closest vicinity. However, some stalkers have been known to disappear for no apparent reason leaving only a Goldfish behind."..
		"\nBig downside, however, comes along with this powerful anti-gravitational field: the velocity of moving objects inside its radius will rapidly increase, causing dangerous impacts on surrounding objects, including the holder.",
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
		desc = "Gravi is formed from metallic substances exposed to prolonged gravitation. This makes it capable of sustaining an powerful anti-gravitational field, which causes it to have various properties, among others reducing weight of all objects in its close proximity. For a long time, the artefact was a mystery, and it was scientist Sakharov at Yantar who first discovered that Gravi creates a minute singularity field of anti-gravitational nature, the phenomenon which occurs in intervals of 30 minutes."..
		"\nA dangerous effect of this artefact is the fact that it will increase electrical conductivity, so the probability of electrocution while wearing this artefact is much higher, especially during storms and in the vicinity of electrical anomalies."..
		"\nAnother downside is that it will increase the negative effects of psy-waves and is a potent conductor.",
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
		desc = "This bizarrely-shaped artefact appears in places with increased gravitational activity."..
		"\nAlthough it appears almost organic, it is actually more similar to coral. Due to its gravitational nature, It provides protection against physical impacts as it greatly reduces the friction caused by fast objects."..
		"\nActing as a kind of sponge that absorbs chemical and toxic elements as well, this artefact provides protection from external toxic agents as well as from chemical particles that have already made their way into the body."..
		"\nWrenced can generate a locally directed gravity field which increases its mass. For this reason, this artefact is heavy.",
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
		desc = "Two disks of organic formation (commonly lipids, cellulose and lignin) with nothing but empty space in between. This is due to a unique gravitation field formed in the centre that stabilise the distance between the disks."..
		"\nAny attempt to press the disks together, or pull them apart will fail due to rapid positive/negative changes in the gravitational field. As if the artefact reacts to any physical power that breaks its balance."..
		"\nBecause of this mechanism, moving with an Empty is a hard task. As the gravitational field increases the density of surrounding air and slows the body down."..
		"\nThe real usefulness of this effect comes to the ability to reduce friction, thus obtaining great protection against physical impacts.",
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
		desc = "Very common in the Zone. This gravitational artefact is able to slightly shield the body and objects from physical impacts."..
		"\nIt will slightly protect its user against extreme heat produced respectively by fire anomalies."..
		"\nThis artefact is quite heavy as the gravitational field seems to increase mass. Another downside to this artefact is that it will increase the negative effects of psy-waves and is a potent conductor.",
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
		desc = "This artefact is formed in anomalous zones with intense thermal activity. Actively consumes excessive heat and remains cool at all times."..
		"\nIt will also protect the user against electrical currents. On the other hand, exposure to such environments makes the artefact increase the conductivity due to unknown as of now mechanism. For this reason, one is forced to weigh pros and cons of Crystal when in the vicinity of areas of high conductivity."..
		"\nThis artefact is also highly sought for by jewellers outside the Zone as its inner core is not radioactive and considered to be of exceptional beauty if polished and refined. Only the first 1 cm of its outer layer emits radiation."..
		"\nIt is, however, highly advised to proceed with caution when planning to bring the artefact to the market as prolonged exposure to even minimal amounts of radioactive materials can result in death of the user. Covered with very hard layer. Relatively heavy due to high density.",
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