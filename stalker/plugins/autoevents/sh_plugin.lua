local PLUGIN = PLUGIN
PLUGIN.name = "Autoevents"
PLUGIN.author = "sky"
PLUGIN.desc = "an in-map version of the run system, may be held together with duct tape idk"

//a rework of my gmod magnum opus, removing the accept system and having the events
//autospawn at preset locations in the world
//this file doesnt really need to be modified, everything relevant is changeable via configs or commands
//the files u should be looking at is areas and objs:

//areas: this is where the preset locations are defined
//PLUGIN.areas is a table where the key is the map name and the value is a list
//of preset locations
//you can see it set up for rp_limansk_cs there already as an example
//location table:
//name is the name used to describe the location, which could be used by objs or etc
//origin and radius defines the circle used to check if players are in or not in the area,
//so it can know what objs it can spawn and not spawn
//objs is a list of objs from the objs file that this area can spawn with
//enemySpawns is a list of {vector, angle}s, used for randomly spawning enemies in the area
//a concommand to create this based on your current position can be found in addons/skybase/autorun/sky_ammo, or here:
/* 
concommand.Add("_printpos", function(ply, cmd, args)
	if(args[1] == "f") then
		local tr = ply:GetEyeTrace()
		local pos = tr.HitPos
		print("pos: "..tostring(tr.HitPos))
		SetClipboardText("Vector("..pos.x..", "..pos.y..", "..pos.z..")")
		return
	end
	print("pos: ", ply:GetPos(), " ang: ", tostring(ply:EyeAngles()), ", clipboarded with just y")
	local pos, ang = ply:GetPos(), ply:EyeAngles()
	SetClipboardText("{Vector("..pos.x..", "..pos.y..", "..pos.z.."), Angle(0, "..ang.y..", 0)},\n")
end, nil, "this is something i made for run configs, ignore it")
*/
//itemSpawns is a list of {loottable, vector}, used with the loot plugin to randomly spawn loot in the area
//the above concommand can be used here with a f parameter (_printpos f) to get the position you're looking at
//props is a list of a table used to define what a prop is and where to spawn, 
//a command i used to make these can be found in addons/skybase/autorun/sky_ammo, or here:
/*
concommand.Add("_printentdata", function(ply, cmd, args)
	print("copied")
	local ent = ply:GetEyeTrace().Entity
	local pos, ang = ent:GetPos(), ent:GetAngles()
	SetClipboardText([[{
		class = "]]..ent:GetClass()..[[",
		model = "]]..ent:GetModel()..[[",
		skin = ]]..ent:GetSkin()..[[,
		pos = Vector(]]..pos.x..[[, ]]..pos.y..[[, ]]..pos.z..[[),
		angle = Angle(]]..ang.p..[[, ]]..ang.y..[[, ]]..ang.r..[[),
	},]])
end, nil, "this is something i made for run configs, ignore it")
*/
//mutantSpawns is a list of {vector,angle}, exactly like enemy spawns, but used for mutant spawns coming in to the area in mutant attack
//mutantTarget is a vector, where these mutants will try to head to on spawn

//the other file, objs, includes, you may have guessed it, all the defined objs that can spawn at areas
//PLUGIN.objs is a list of possible objs, which are tables that include various fields and functions
//above this however are a bunch of functions, shared between the objs to help obj creation
//the table is defined as this:
//name is used to define the name of the obj, dont think this is actually shown anywhere
//available you can include set to false to disable the obj from spawning
//needplayers is another optional bool, which when true flips whether it can spawn to be where instead of requiring no players inside the checked sphere, there must be players inside the sphere
//onSpawn is a function ran when the obj is spawned, its parameters are: 
//obj - the obj that this function is in, 
//area - the area table its spawning in, and 
//used - the entry of curUsed that the obj and area are in
//checkComplete is a function with the parameters of obj and used, used in the default timer function InitDefaultTimer, which should be in onSpawn, and is used to determine when the obj is finished so it can be cleaned up
//onCleanup is a function with the parameter of used, ran when the obj needs to be cleaned up, remove props and still existing enemies

//integration can done between this and bountyboard, spawning special jobs related to generated objs
//example of this can be seen with objs 2 and 3

nut.config.add("autoeventsEnabled", true, "Whether autoevents are being generated.", nil, {
    category = "Autoevents"    
})
nut.config.add("autoeventsMax", 2, "Max amount of active autoevents allowed, will not create more than this amount.", nil, {
	form = "Int",
	data = {min = 1, max = 10},
	category = "Autoevents"
})
nut.config.add("autoeventsTMin", 3600, "Minimum time for autoevent spawn", function(old, new)
		PLUGIN.spawnTimer[1] = new
	end, {
	data = {min = 600, max = 18000},
	category = "Autoevents"
})
nut.config.add("autoeventsTMax", 4800, "Maximum time for autoevent spawn", function(old, new)
		PLUGIN.spawnTimer[2] = new
	end, {
	data = {min = 900, max = 21000},
	category = "Autoevents"
})
nut.config.add("autoeventsChance", 3, "Picks a random number between 1 and this, if the number picked is 1, it wont spawn anything for this round. (so the larger the number, less of a chance for nothing) 1 == feature disabled (always spawn)", nil, {
	form = "Int",
	data = {min = 1, max = 12},
	category = "Autoevents"
})

nut.command.add("autoeventsDisableArea", {
	syntax = "<int area> [bool status]",
	adminOnly = true,
	desc = "Used to temp (per session) disable a specific area from being considered in the spawning function.",
	onRun = function(client, arguments)
		if(!arguments[1] or !tonumber(arguments[1])) then return "not a number" end
		local id = tonumber(arguments[1])
		if(PLUGIN.areas[id]) then
			--uh this is confusing but basically its opposite lmfao
			if(arguments[2] and tobool(arguments[2])) then
				PLUGIN.areas[id].available = !tobool(arguments[2])
			else
				PLUGIN.areas[id].available = false
			end
		end
 	end
})
nut.command.add("autoeventsForce", {
	syntax = "[int area] [int type]",
	adminOnly = true,
	desc = "Used to force spawn an event at an area with a type (does random if not specified).",
	onRun = function(client, arguments)
		local id = tonumber(arguments[1]) or math.random(#PLUGIN.areas)
		
		local obj = tonumber(arguments[2])
		if(!obj) then
			local valobj = {}
			for k,v in pairs(PLUGIN.objs) do
				if(v.available == false or !PLUGIN.areas[id].objs[k]) then
				else --idk if != will work with ^
					valobj[#valobj+1] = k
				end
			end
			obj = valobj[math.random(#valobj)]
		end
		if(!obj) then return "uh theres no valid objs for this area" end

		if(PLUGIN.curUsed[k] && PLUGIN.curUsed[k].active) then return "this is currently being used sry dont want to add force clean" end

		PLUGIN:SpawnArea(id, obj)
 	end
})

--file names speak for themsleves
nut.util.include("sh_objs.lua")
nut.util.include("sh_areas.lua")

local uniqueid = uniqueid or 0

--list of areas currently being used
PLUGIN.curUsed = PLUGIN.curUsed or {}

PLUGIN.curNextSpawn = PLUGIN.curNextSpawn or nil
PLUGIN.spawnTimer = {5800,8400} --idk for now
PLUGIN.minplayers = 7

if(SERVER) then
	--moved so i can manually restart it
	function PLUGIN:InitTimer()
		local map = game.GetMap()
		timer.Create("autoeventspawner", 600, 0, function()
			if(#self.objs == 0 or #self.areas == 0) then return end --uh just in case lol
			if(!self.areas[map]) then return end --nothing on this map
			if(CurTime() < self.curNextSpawn) then return end --wait

			if(!nut.config.get("autoeventsEnabled", true)) then return end --were disabled rn?
			if(table.Count(self.curUsed) >= nut.config.get("autoeventsMax", 4)) then return end --no more for now

			local mon = nut.config.get("autoeventsChance", 3)
			if(mon != 1 and math.random(1,mon) == 1) then return end --% to not do anything
			self.curNextSpawn = CurTime()+math.random(self.spawnTimer[1], self.spawnTimer[2])

			local num = 0
			local go = false
			for k, v in ipairs(player.GetAll()) do
				num = num + 1
				if(num > PLUGIN.minplayers) then go = true end 
				if(v:IsSuperAdmin()) then go = true end
				if(go) then break end
			end
			if(!go) then return end

			--if i do area first, ones that only have 1 area like mutant attack
			--will be very rare
			local valobj = {}
			for k,v in ipairs(self.objs) do
				if(v.available == false) then
				else --idk if != will work with ^
					valobj[#valobj+1] = k
				end
			end
			local obj = valobj[math.random(#valobj)]

			local valids = {}

			for k,v in pairs(self.areas[map]) do
				if(!v.objs[obj]) then continue end
				--its been otherwise disabled
				if(v.available == false) then continue end
				--theres already one here
				if(self.curUsed[k] && self.curUsed[k].active) then continue end

				--i feel like theres a better way to do this, 
				--this could be bad since were doing probably a bunch at once
				local nearby = ents.FindInSphere(v.origin, v.radius)
				local found = self.objs[obj].needplayers or false
				for k2,v2 in ipairs(nearby) do
					if(IsValid(v2) 
						&& v2:GetClass():lower() == "player" 
						&& v2:GetMoveType() != MOVETYPE_NOCLIP) then

						if(self.objs[obj].needplayers) then
							found = false
						else
							found = true
						end
						break
					end
				end
				if(found) then continue end

				valids[#valids+1] = k
			end
			if(#valids == 0) then return end --no valid areas
			local area = valids[math.random(#valids)]

			self:SpawnArea(area, obj)
		end)

	end

	--idk i did this in the other one
	auto_loadedalready = auto_loadedalready or false
	function PLUGIN:InitializedPlugins()
		if(auto_loadedalready) then
			return
		else
			auto_loadedalready = true
		end

		self.spawnTimer = {
			nut.config.get("autoeventsTMin", 3600), 
			nut.config.get("autoeventsTMax", 4800)
		}
		self.curNextSpawn = CurTime()+math.random(self.spawnTimer[1], self.spawnTimer[2])

		self:InitTimer()
	end

	function PLUGIN:SpawnArea(areaid, obj)
		local map = game.GetMap()
		local area = self.areas[map][areaid]
		if(obj == nil) then
			local valobj = {}
			for k,v in ipairs(self.objs) do
				if(area.objs[k]) then
					valobj[valobj+1] = k
				end
			end
			obj = valobj[math.random(#valobj)]
		end	

		--ok now spawn
		print("spawning event at "..areaid)

		if(self.curUsed[areaid]) then
			self.objs[self.curUsed[areaid].obj].onCleanup(self.curUsed[areaid])
		end
		uniqueid = uniqueid + 1
		self.curUsed[areaid] = {
			["area"] = areaid, --to put on npcs
			["obj"] = obj,
			["active"] = true,
			["uniqueid"] = uniqueid
		}
		nut.log.addRaw("spawning event "..self.objs[obj].name.." ("..obj..") at area "..self.areas[map][areaid].name.." ("..areaid..")")

		self.objs[obj].onSpawn(self.objs[obj], self.areas[map][areaid], self.curUsed[areaid])


	end

else --client

end