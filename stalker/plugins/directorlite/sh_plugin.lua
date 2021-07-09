local PLUGIN = PLUGIN
PLUGIN.name = "Director"
PLUGIN.author = "sky"
PLUGIN.desc = "modified old director system"

nut.util.include("sh_commands.lua")
--nut.util.include("sh_infection.lua")

--todo uh completely rewrite this lmao, also dont know if this even works

nut.config.add("director", true, "Whether the director is globally active.", nil, {
	category = "server"
})

local mutants = {
    "npc_vj_srp_m_boar",
    "npc_vj_srp_m_boar",
    "npc_vj_srp_m_boar",
    "npc_vj_srp_m_flesh",
    "npc_vj_srp_m_flesh",
    "npc_vj_srp_m_flesh",
    "npc_vj_srp_m_rat",
    "npc_vj_srp_m_rat",
    "npc_vj_srp_m_rat",
    "npc_vj_srp_m_rat",
    "npc_vj_srp_m_rat",
    "npc_vj_srp_m_bloodsucker",
    "npc_vj_srp_m_bloodsucker",
    "npc_vj_srp_m_snork",
    "npc_vj_srp_m_snork",
    "npc_vj_srp_m_dog",
    "npc_vj_srp_m_dog",
    "npc_vj_srp_m_dog",
    "npc_vj_srp_m_dog",
    "npc_vj_srp_m_dog",
    "npc_vj_srp_m_pseudodog",
    "npc_vj_srp_m_pseudodog",
    "npc_vj_srp_m_pseudodog",
}

PLUGIN.spawnPos = PLUGIN.spawnPos or {}
--should be like
--[[
{
    --vector of position
    --min/max spawn range around it (as {min, max})
    --detection range
    --current level
    --table of zombies attached to it
	--if disabled there would be a ["disabled"]=true if it were written out
	--class attached == ["class"] = "class"
} this is auto generated tho, dont set it
]]

--this is unused but ill leave it
PLUGIN.events = {
    ["yell"] = {0.02, true, {0,1}, true},
    ["sky9x19mm"] = {0.07, true, {0,1}, true},
    ["sky45acp"] = {0.074, true, {0,1}, true},
    ["sky762x51"] = {0.36, true, {0,2}, true},
    ["jae700"] = {0.9, true, {1,3}, true}, --seperate for jae700
    ["sky762x39"] = {0.29, true, {0,2}, true},
    ["sky556"] = {0.28, true, {0,2}, true},
    ["sky22lr"] = {0.055, true, {0,1}, true},
    ["357"] = {0.1, true, {0,1}, true},
    ["buckshot"] = {0.17, true, {0,2},true}
}
--[[
    what events do to the level, is like:
["action"] = {
    levelinc, spawnzombiesbool, {zombiemin,zombiemax}, directinactive
    ex: 0.2, true, {0,1}, true
    ex 2: 0.1, false
}
zombies spawned through these actions are limited by the zombie cap for the position, 
so if the cap has max zombies, more will not spawn
]]

--only the first 2 levels are used here
--the first level is for the default config of mutants
--the second level is used when a class is specified for the spawn
PLUGIN.spawnLevels = {
	--3 spawned from a point max,
	--0 or 1 enemys spawned every cycle,
	--300 seconds per cycle
    {3, {0,1}, 300}, --synths
    {3, {0,1}, 1800}, --npcs
    {2, {0,4}, 60},
    {2, {0,4}, 60},
    {2, {0,4}, 60},
    {2, {0,4}, 45},
    {2, {0,4}, 30},
    {2, {0,4}, 20},
    {2, {0,4}, 20}
}
--[[
levels: may need to be adjusted
1 = lowest, 2 zombies max, 1 zombie spawned every 60 seconds
2 = a little disturbed, 3 zombies max, 1 zombie spawned every 40 seconds
3 = a little more, 5 zombies max, 1 or 2 zombies spawned every 40 seconds
4 = a bit more, 6 zombies max, 1 or 2 zombies spawned every 30 seconds
5 = attention gotten, 10 zombies max, 1 to 3 zombies spawned every 30 seconds
6 = more, 12 zombies max, 2 to 4 zombies spawned every 25 seconds
7 = a lot of attention, 14 zombies max, 2 to 4 zombies spawned every 20 seconds
8 = dangerous attention, 18 zombies max, 3 to 7 zombies spawned every 20 seconds
9 = highest, 24 zombies max, 5 to 10 zombies spawned every 20 seconds
]]

--finds the point that vec is inside, returns nil if vec is not inside any point
function PLUGIN:FindNearbyPoint(vec)
    local points = self.spawnPos

    if (#points == 0) then return nil end --no points so nothing

    local inRange = {}
    for k,v in pairs(points) do
        if(v[1]:Distance(vec) <= v[3]) then
            table.insert(inRange, {k, v[1]:Distance(vec)})
        end
    end
    table.sort(inRange, function(a,b) return a[2] < b[2] end)

    if(#inRange != 0) then
    return inRange[1][1] 
    else
    return nil
    end
end

function PLUGIN:SetInactiveZTarget(p, target)
    local point = self.spawnPos[p]
    if(!nut.config.get("director", false)) then return end --gone

    for k,v in pairs(point[5]) do
        if(v:GetEnemy() == nil) then
            v:SetEnemy(target)
        end
    end
end

--spawns zombies at the point selected, optionally set their enemy, and optionally ignore the max
function PLUGIN:SpawnZombiesAtPoint(p, amt, target, ignoremax)
    local point = self.spawnPos[p]
    if(!nut.config.get("director", false)) then return end --gone

    if(amt == 0) then return end --jus in case

    for i=1, amt do
        if(#point[5] >= self.spawnLevels[point.class and 2 or 1][1] and !ignoremax) then
            return --were full, dont spawn any more here
        end

        local pos = Vector(point[1].x + math.random(point[2][1], point[2][2]), point[1].y + math.random(point[2][1], point[2][2]), point[1].z + 55)

		
		local tr = {
			start = pos,
			endpos = pos,
			mins = Vector( -16, -16, 0 ),
			maxs = Vector( 16, 16, 71 )
		}

		local hullTrace = util.TraceHull( tr )
		local al
		if ( hullTrace.Hit ) then
			for t=1, 5 do
				if ( hullTrace.Hit ) then
				pos = Vector(point[1].x + math.random(point[2][1], point[2][2]), point[1].y + math.random(point[2][1], point[2][2]), point[1].z + 55)
				tr.start = pos
				tr.endpos = pos
				hullTrace = util.TraceHull( tr )
				else
					al = hullTrace.HitPos
					break
				end
			end		
		else
			al = hullTrace.HitPos

		end
		if(!al) then print("spawn failed "..p) continue end

        --[[local nav = navmesh.GetNearestNavArea(pos)
        local al = nav:GetClosestPointOnArea(pos)
        if(!al) then 
            print("failed to spawn")
            continue 
        end]]
        local tr = util.TraceLine({start = al + Vector(0,0,50), endpos = al + Vector(0,0,-250)})

        local spawn = tr.HitPos + tr.HitNormal * 16

        local ent = ents.Create(point.class or mutants[math.random(#mutants)]) --unsure about what should be spawned yet so just do fast
		if(IsValid(ent) and !ent.NEXTBOT) then
			ent:SetPos(spawn)
			ent:SetAngles(Angle(0, math.random(-180,180), 0))

			local SpawnFlags = bit.bor( SF_NPC_FADE_CORPSE, SF_NPC_ALWAYSTHINK )
			ent:SetKeyValue( "spawnflags", SpawnFlags )
			ent:Spawn()
			ent:Activate() --just in case
			if(ent.ComeonSound) then
				ent:ComeonSound()
			end
			if(list.Get("NPC")[ent:GetClass()]) then
			local lis = list.Get("NPC")[ent:GetClass()].Weapons
			if(lis) then
				ent:Give(lis[math.random(#lis)])
			end
			end
		elseif(IsValid(ent)) then
			ent:SetPos(spawn)
			ent:SetAngles(Angle(0, math.random(-180,180), 0))
			ent:Spawn() --hoping they wont get stuck
		end

        local fixed = false
        for t=1, 5 do
            local around = ents.FindInSphere(ent:GetPos(), 60)
            local relevent = {}

            if(#around != 0) then
                for k,v in pairs(around) do
                    if(v == ent) then continue end
                    local clas = v:GetClass()
                    if(clas and (string.find(clas, "npc_nextbot_") or string.find(clas, "nz_") or (point.class and clas == point.class))) then
                        table.insert(relevent, v)
                    end
                end

                if(#relevent != 0) then
                    local newpos = Vector(point[1].x + math.random(point[2][1], point[2][2]), point[1].y + math.random(point[2][1], point[2][2]), point[1].z + 35)

                    local nnav = navmesh.GetNearestNavArea(newpos)
					local nal = nnav:GetClosestPointOnArea(newpos)
					if(!nal) then continue end --try again
                    local ntr = util.TraceLine({start = nal, endpos = nal + Vector(0,0,-250)})

                    local spawn = ntr.HitPos + ntr.HitNormal * 16

                    ent:SetPos(spawn)
                else
                    fixed = true
                    break --might still be stuck in world tho
                end
            else
                fixed = true
                break --might still be stuck in world tho
            end
        end
        if(!fixed) then 
            print("couldnt spawn a zombie")
            nut.log.addRaw("couldnt spawn a zombie at "..p)
            ent:Remove()
        end

        table.insert(point[5], ent)
        if(target) then
            ent:SetEnemy(target)
        end
    end
end


function PLUGIN:SpawnZombiesAroundPos(vec, amt, target, range)
    if(!nut.config.get("director", false)) then return end --gone

    if(amt == 0) then return end --jus in case

    for i=1, amt do
        local _neglol = {-1, 1}
        local negx = table.Random(_neglol)
        local negy = table.Random(_neglol)

        local pos = Vector(vec.x + (math.random(range[1], range[2])*negx), vec.y + (math.random(range[1], range[2])*negy), vec.z + 35)

        local nav = navmesh.GetNearestNavArea(pos)
        local al = nav:GetClosestPointOnArea(pos)
        local tr = util.TraceLine({start = al + Vector(0,0,50), endpos = al + Vector(0,0,-250)})

        local spawn = tr.HitPos + tr.HitNormal * 16

        local ent = ents.Create("nz_sky_base") --unsure about what should be spawned yet so just do fast
        ent:SetPos(spawn)
        ent:Spawn() --hoping they wont get stuck

        local fixed = false
        for t=1, 5 do
            local around = ents.FindInSphere(ent:GetPos(), 60)
            local relevent = {}

            if(#around != 0) then
                for k,v in pairs(around) do
                    if(v == ent) then continue end
                    local clas = v:GetClass()
                    if(clas and (string.find(clas, "npc_nextbot_") or string.find(clas, "nz_"))) then
                        table.insert(relevent, v)
                    end
                end

                if(#relevent != 0) then
                    local newpos = Vector(vec.x + (math.random(range[1], range[2])*negx), vec.y + (math.random(range[1], range[2])*negy), vec.z + 35)

                    local nnav = navmesh.GetNearestNavArea(newpos)
                    local nal = nnav:GetClosestPointOnArea(newpos)
                    local ntr = util.TraceLine({start = nal, endpos = nal + Vector(0,0,-250)})

                    local spawn = ntr.HitPos + ntr.HitNormal * 16

                    ent:SetPos(spawn)
                else
                    fixed = true
                    break --might still be stuck in world tho
                end
            else
                fixed = true
                break --might still be stuck in world tho
            end
        end
        if(!fixed) then 
            print("couldnt spawn a zombie")
            nut.log.add("couldnt spawn a zombie for a aroundpoint event")
            ent:Remove()
        end

        --table.insert(point[5], ent)
        if(target) then
            ent:SetEnemy(target)
        else
            ent:SetEnemy(vec)
        end
    end
end

function PLUGIN:CreatePoint(pos, range, detection, startDis, class)
    local new = {}
    new[1] = pos
    new[2] = range
    new[3] = detection
    new[4] = 1
	new[5] = {}
	local decspawn
	if(class) then
		new["class"] = class
		decspawn = true
	end

    if(SERVER) then
        new["time"] = 0
    end
    if(startDis) then
        new["disabled"] = true
    end

    local ins = table.insert(self.spawnPos, new)
    if(SERVER) then
    timer.Create("pointTimer"..ins, 1, 0, function()
        local point = self.spawnPos[ins]
		if(!point) then timer.Remove("pointTimer"..ins) return end
        local lvl = self.spawnLevels[decspawn and 2 or 1]
		if(point["disabled"]) then return end
		
		if(player.GetCount() == 0) then return end

        if(point["time"] < lvl[3]) then
            point["time"] = point["time"] + 1
            return --not done yet
        end
        point["time"] = 0

        --local rem = (math.Round(point[4]) * 5)*0.015 --hopefully this will work? higher levels will lower quicker, this is intentional

        --point[4] = math.Clamp(point[4] - rem, 1, 9)

        local rand = math.random(lvl[2][1], lvl[2][2])
        self:SpawnZombiesAtPoint(ins, rand)
        --[[local inSphere = ents.FindInSphere(point[1], point[3]*1.75)
        for k,v in pairs(inSphere) do
            if(v:IsPlayer() and v:getChar() and v:GetMoveType() != MOVETYPE_NOCLIP) then
                self:SpawnZombiesAtPoint(ins, rand)
                break
            end
        end
        for k,v in pairs(point[5]) do
            if(v:GetEnemy() == nil) then
                v:Remove()
            end
        end]]
    end)
    self:SaveData()
    end
    return ins
end

function PLUGIN:RemovePoint(id)
    timer.Remove("pointTimer"..id)
    table.remove(self.spawnPos, id)
    self:SaveData()
end


	function PLUGIN:SaveData()
		local data = {}

		for k, v in ipairs(self.spawnPos) do
			if (v) then
				data[#data + 1] = {v[1], v[2], v[3], disabled = v["disabled"], class = v["class"]} --this is all we need saved
			end
		end

		self:setData(data)
	end

	function PLUGIN:LoadData()
		local data = self:getData() or {}

        if(#self.spawnPos != 0) then return end

		for k, v in ipairs(data) do
            self:CreatePoint(v[1], v[2], v[3], v["disabled"] or nil, v["class"])
		end
    end

if(SERVER) then

--util.AddNetworkString("ReqDirPoints")
util.AddNetworkString("RecDirPoints")
--[[net.Receive("ReqDirPoints", function(_, ply)
    local points = PLUGIN.spawnPos
    local time = net.ReadInt(32)
    local limP = {}

    for k,v in pairs(points) do
        limP[k] = v[1]
    end

    print("nani")
    PrintTable(limP)

    net.Start("RecDirPoints")
    net.WriteTable(limP)
    net.WriteInt(time, 32)
    net.Send(ply)
end)]]

hook.Add("InitPostEntity", "IgnoreTeamNoTwo", function()
    --[[local ignoreno = GetConVar("nb_ignoreteam")
    ignoreno:SetInt(0) --every time this convar gets set to 2
    --walking amongst them is probably a terrible idea, but here i guess?
    local targ = GetConVar("nb_targetmethod")
    targ:SetInt(1) --every time this convar gets set to 2
    local prop = GetConVar("nb_attackprop")
    prop:SetInt(0)]]
end)

hook.Add("EntityRemoved", "OnNBRemoved", function(ent)
    local clas = ent:GetClass()
    if(clas and ent:IsNPC() or ent.NEXTBOT) then
    for k,v in pairs(PLUGIN.spawnPos) do
        if(table.HasValue(v[5], ent)) then
            table.RemoveByValue(v[5], ent)
        end
    end
    --can also do them dropping stuff here too
    end
end)


--[[
hook.Add("OnReloaded", "GiveSpawnsBack", function()
    PLUGIN:LoadData()
end)
]]

else --client

local localSpawns = {}

net.Receive("RecDirPoints", function()
    local points = net.ReadTable()
    local time = net.ReadInt(32)

    localSpawns = points

    timer.Simple(time, function()
        localSpawns = {}
    end)
end)

    --NUT_CVAR_MAPFILTER = CreateClientConVar("nutMapFilters", "0")

    hook.Add("InitPostEntity", "ClientFilterMapOut", function()
        --[[if(NUT_CVAR_MAPFILTER:GetInt() == 1) then
        local con = GetConVar("con_filter_enable")
        con:SetInt(1)
        if(game.GetMap() == "rp_lp_fork") then
            RunConsoleCommand("con_filter_text_out", "GetSpriteAxes")
        end
        end]]
    end)

    function PLUGIN:HUDPaint()
        local client = LocalPlayer()

        local sx, sy = surface.ScreenWidth(), surface.ScreenHeight()

            for k, v in ipairs(localSpawns) do
                local scrPos = v:ToScreen()
				local marginx, marginy = sy*.1, sy*.1
                local x, y = math.Clamp(scrPos.x, marginx, sx - marginx), math.Clamp(scrPos.y, marginy, sy - marginy)
                local distance = client:GetPos():Distance(v)
                local factor = 1 - math.Clamp(distance/1024, 0, 1)
                local size = math.max(10, 32*factor)
                local alpha = math.Clamp(255*factor, 80, 255)

                surface.SetDrawColor(80, 30, 80, alpha)
                surface.DrawRect(x - size/2, y - size/2, size, size)

                nut.util.drawText("point - id: "..k, x, y-size, ColorAlpha(Color(220,220,220,255),alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, nil, alpha)
            end
    end
end