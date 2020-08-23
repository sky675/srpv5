nut.newchar = {}
--mega thanks to lazarus/vin/cat.jpeg <3 heavily based on code in this
--https://github.com/NutScript/falloutrp/tree/master/plugins/clothing


--set to false to revert to older clientside code (not recommended)
local serverside = true
local sethands = true
local handstbl = {
	--["top model"] = "hands model",
	["_anorak"] = "models/sky/hands/anorak.mdl",
	["_sunrise"] = "models/sky/hands/sunrise.mdl",
	["_berill"] = "models/sky/hands/berill.mdl",
	["_cs1"] = "models/sky/hands/cs1.mdl",
	["_cs2"] = "models/sky/hands/cs2.mdl",
	["_io7a"] = "models/sky/hands/io7a.mdl",
	["_radsuit"] = "models/sky/hands/radsuit.mdl",
	["_seva"] = "models/sky/hands/seva.mdl",
	["_skat"] = "models/sky/hands/skat.mdl",
	["_eco"] = "models/sky/hands/sunrise.mdl",
}

--0 = not hidden, -1 = hidden
 defaultbothidden = -1
--change bots to the tiny 1x1 boxes i guess? idk
 defaultfemtop = "models/sky/seperate/female_anorak.mdl"
 defaultfembot = "models/hunter/plates/plate.mdl"--"models/sky/legs/female_citizen1.mdl"
 defaultmaletop = "models/sky/seperate/male_anorak.mdl"
 defaultmalebot = "models/hunter/plates/plate.mdl"--"models/sky/legs/male_citizen1.mdl"

--gs models that dont use the clothing system
local exec = { --these still use the other models weird hitboxes btw
}
--female models that dont have female in the name
local fems = { 
	["models/sky/heads/neo.mdl"] = true,
	["models/sky/heads/quiet.mdl"] = true,
}
local stringFind = string.find
--not entirely sure why i called them bm tbh
function nut.newchar.isBM(model)

	return (stringFind(model, "/sky/heads") or stringFind(model, "/sky/npcs")) and !exec[model]
end

hook.Add("CustomFemaleModel", "gs3customs", function(model, ply, char, creation)
	if(creation) then return end

	if(nut.newchar.isBM(model) and !model:find("female")) then
		return fems[model]
	end
end)

local dvars = {
	"gctop",
	"gcbot",
	"gtop",
	"gtopskin",
	"gbot",
	"gbotskin",
	"gbgs",
	"gsub",
}

if(!serverside) then
nut.command.add("reloadclothing", {
	desc = "Tell the server to try and send everyone's clothing data to your client, use if people are default clothes, missing arms, etc or if you're told to. Use anything but nothing, 0 or false to reset your clothes too, in case they disappeared as well.",
	syntax = "<bool reset>",
	onRun = function(ply, arguments)
		for k,v in pairs(player.GetAll()) do
			if(!v.getChar or !v:getChar() or !nut.newchar.isBM(v:GetModel())) then continue end
			for k2,v2 in pairs(dvars) do --this should send it to the client
				if(v:getChar():getData(v2) != nil) then
					v:getChar():setData(v2, v:getChar():getData(v2), nil, ply)
				end
			end
		end
		for k,v in pairs(ents.FindByClass("nextbot_fakeplayer")) do
			if(!v.getChar or !v:getChar() or !nut.newchar.isBM(v:GetModel())) then continue end
			for k2,v2 in pairs(dvars) do --this should send it to the client
				if(v:getChar():getData(v2) != nil) then
					v:getChar():setData(v2, v:getChar():getData(v2), nil, ply)
				end
			end
		end
		timer.Simple(1, function()
		net.Start("doallcothes")
		net.Send(ply)
		if(tobool(arguments[1] or "0")) then
			local v = ply
			local tp, bt = v:getChar():getData("gtop"), v:getChar():getData("gbot")
			local tskin, bskin = v:getChar():getData("gtopskin"), v:getChar():getData("gbotskin")
			local tbl = {reset = true, top = tp, bot = bt, topskin = tskin, botskin = bskin}
			
			if(v:getChar():getData("gctop")) then
				tbl.customt = v:getChar():getData("gctop")
			end
			if(v:getChar():getData("gcbot")) then
				tbl.customb = v:getChar():getData("gcbot")
			end
		net.Start("wearclothing")
		net.WriteEntity(ply)
		net.WriteTable(tbl)
		net.Send(ply)
		end
		end)
		
		return "ran, may take a second to go into effect"
	end
})
end

if(CLIENT) then

	LOCAL_BM_CACHE = LOCAL_BM_CACHE or {}

	--todo submaterial support
	local function clothesd(ply, data)
		local setthistime = false

		if(!ply or !ply.isFemale) then
			print("ply doesnt have isFemale wtf is it "..tostring(ply))
		end

						--just pick one to check i guess
		if(!ply.bm or !IsValid(ply.bm.t)) then --if the models dont exist make them
			ply.bm = {}
			setthistime = true

			local t = ClientsideModel(data.customt or (ply:isFemale() and defaultfemtop or defaultmaletop))
			local b = ClientsideModel(data.customb or (ply:isFemale() and defaultfembot or defaultmalebot))
			
			t:InvalidateBoneCache()
			t:SetParent(ply)
			ply:CallOnRemove("remtop", function(ent) t:Remove() end)
			t:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL,EF_PARENT_ANIMATES))
			t:SetupBones()
			t:CreateShadow()
			t:DrawShadow(true)
			ply.bm.t = t
			LOCAL_BM_CACHE[#LOCAL_BM_CACHE+1] = {ply, t}

			b:InvalidateBoneCache()
			b:SetParent(ply)
			ply:CallOnRemove("rembot", function(ent) b:Remove() end)
			b:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL,EF_PARENT_ANIMATES))
			b:SetupBones()
			b:CreateShadow()
			b:DrawShadow(true)
			ply.bm.b = b
			LOCAL_BM_CACHE[#LOCAL_BM_CACHE+1] = {ply, b}

			function t:Think()
				local parent = self:GetParent()
				if(IsValid(parent)) then
					if(parent:IsPlayer() and parent:getChar()) then
						if(parent:Alive()) then
							self:SetParent(ply)
							self.hasSpawned = true
						elseif(self.hasSpawned) then
							self:Remove()
							ply.bm.t = nil
							return
						end
					end

					local noDraw = parent:GetNoDraw() or !nut.newchar.isBM(parent:GetModel()) --maybe support replace models?
					if(noDraw != self.LastDrawState) then
						self:SetNoDraw(noDraw)
					end
					self.LastDrawState = noDraw
				end
			end
			hook.Add("Think", t, t.Think)

			function b:Think()
				local parent = self:GetParent()
				if(IsValid(parent)) then
					if(parent:IsPlayer() and parent:getChar()) then
						if(parent:Alive()) then
							self:SetParent(ply)
							self.hasSpawned = true
						elseif(self.hasSpawned) then
							self:Remove()
							ply.bm.b = nil
							return
						end
					end

					local noDraw = parent:GetNoDraw() or !nut.newchar.isBM(parent:GetModel()) --maybe support replace models?
					if(noDraw != self.LastDrawState) then
						self:SetNoDraw(noDraw)
					end
					self.LastDrawState = noDraw
				end
			end
			hook.Add("Think", b, b.Think)
		end

		if(data.reset&&!setthistime) then --dont need to do this if it was just set
			ply.bm.t:SetModel(data.customt or (ply:isFemale() and defaultfemtop or defaultmaletop))
			ply.bm.b:SetModel(data.customb or (ply:isFemale() and defaultfembot or defaultmalebot))
			ply.bm.t:SetBodygroup(0, 0)
			ply.bm.b:SetBodygroup(0, 0)
			ply.bm.t:SetSkin(0)
			ply.bm.b:SetSkin(0)
		end
		if(ply.bm and IsValid(ply.bm.t)) then
			ply.bm.t:SetParent(ply)
			ply.bm.b:SetParent(ply)
		end

		print("hello?", data.topskin, data.botskin)
		if(data.top) then
			if(data.top != -1) then
				if(ply.bm.t:GetRenderMode() != RENDERMODE_NORMAL) then
					ply.bm.t:SetRenderMode(RENDERMODE_NORMAL)
					ply.bm.t:SetColor(Color(255,255,255,255))
				end
				if(data.customt) then
					ply.bm.t:SetModel(data.customt)
				else --just to make sure lol
					ply.bm.t:SetModel(ply:isFemale() and defaultfemtop or defaultmaletop)
				end
				ply.bm.t:SetBodygroup(0, data.top)
				if(data.topskin) then
					ply.bm.t:SetSkin(data.topskin)
				end
			else
				ply.bm.t:SetRenderMode(RENDERMODE_TRANSALPHA)
				ply.bm.t:SetColor(Color(255,255,255,0))
			end
		end
		if(data.bot) then
			if(data.bot != -1) then
				if(ply.bm.b:GetRenderMode() != RENDERMODE_NORMAL) then
					ply.bm.b:SetRenderMode(RENDERMODE_NORMAL)
					ply.bm.b:SetColor(Color(255,255,255,255))
				end
				if(data.customb) then
					ply.bm.b:SetModel(data.customb)
				else --just to make sure lol
					ply.bm.b:SetModel(ply:isFemale() and defaultfembot or defaultmalebot)
				end
				ply.bm.b:SetBodygroup(0, data.bot)
				if(data.botskin) then
					ply.bm.b:SetSkin(data.botskin)
				end
			else
				ply.bm.b:SetRenderMode(RENDERMODE_TRANSALPHA)
				ply.bm.b:SetColor(Color(255,255,255,0))
			end
		end

		--[[
		timer.Simple(1, function()
			if(g_Legs and ply == LocalPlayer()) then nut.newchar.legsSupp(data) end
		end)
		]]
	end

	drawnewchars = drawnewchars or false

	if(!serverside) then
	hook.Add("Think", "bmfixing", function()
		if(LocalPlayer().bm and IsValid(LocalPlayer().bm.t)) then
			local val = LocalPlayer():ShouldDrawLocalPlayer()
			if(drawnewchars != val) then
				drawnewchars = val
				LocalPlayer().bm.t:DrawShadow(val)
				LocalPlayer().bm.b:DrawShadow(val)
			end
		end
		for k,v in pairs(LOCAL_BM_CACHE) do
			if(type(v) == "table" and IsValid(v[1]) and IsValid(v[2])) then
				if(!IsValid(v[2]:GetParent())) then
					v[2]:SetParent(v[1])
					v[2]:CreateShadow()
				end
			else--[[if(IsValid(v[1])) then
				
				if(v[1].getChar and v[1]:getChar() and v[1] != LocalPlayer()) then
					--nut.newchar.resetModels(v)
	
					local tp, bt = v[1]:getChar():getData("gtop", 0), v[1]:getChar():getData("gbot", 0)
					local tskin, bskin = v[1]:getChar():getData("gtopskin", 0), v[1]:getChar():getData("gbotskin", 0)
					local tbl = {reset = true, top = tp, bot = bt, topskin = tskin, botskin = bskin}
					
					if(v[1]:getChar():getData("gctop")) then
						tbl.customt = v[1]:getChar():getData("gctop")
					end
					if(v[1]:getChar():getData("gcbot")) then
						tbl.customb = v[1]:getChar():getData("gcbot")
					end
					
					clothesd(v[1], tbl)
					--if(tp) then nut.newchar.setBody(v, "top", tp) end
					--if(bt) then nut.newchar.setBody(v, "bot", bt) end
				end

			else]]
				--its not valid anymore so get rid of it
				LOCAL_BM_CACHE[k] = nil
			end
		end
	end)
	end

	net.Receive("wearclothing", function()
		local ply = net.ReadEntity()
		local data = net.ReadTable()

		if(serverside) then return end

		if(!IsValid(ply)) then return end
		if(data.reset) then
			print("ply", ply)
			ply:RemoveAllDecals() --idk
		end

		clothesd(ply, data)
	end)

	net.Receive("corpsecloth", function()
		local t = net.ReadEntity()
		local b = net.ReadEntity()
	--	local tbl = net.ReadTable()

		if(serverside) then return end

		--clothesnonply(rag, tbl, realply)
		t:InvalidateBoneCache()
	--	t:SetParent(ply)
	--	ply:CallOnRemove("remtop", function(ent) t:Remove() end)
	--	t:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL,EF_PARENT_ANIMATES))
		t:SetupBones()

		b:InvalidateBoneCache()
	--	b:SetParent(ply)
	--	ply:CallOnRemove("rembot", function(ent) b:Remove() end)
	--	b:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL,EF_PARENT_ANIMATES))
		b:SetupBones()
	end)

	net.Receive("doallcothes", function()
		print("got doall")
		if(serverside) then return end

		for k,v in pairs(player.GetAll()) do
			if(v.getChar and v:getChar() and v != LocalPlayer() and nut.newchar.isBM(v:GetModel())) then
				--nut.newchar.resetModels(v)
				print("doing ply ", v)

				local tp, bt = v:getChar():getData("gtop"), v:getChar():getData("gbot")
				local tskin, bskin = v:getChar():getData("gtopskin"), v:getChar():getData("gbotskin")
				local tbl = {reset = true, top = tp, bot = bt, topskin = tskin, botskin = bskin}
				
				if(v:getChar():getData("gctop")) then
					tbl.customt = v:getChar():getData("gctop")
				end
				if(v:getChar():getData("gcbot")) then
					tbl.customb = v:getChar():getData("gcbot")
				end
				PrintTable(tbl)
				
				clothesd(v, tbl)
				--if(tp) then nut.newchar.setBody(v, "top", tp) end
				--if(bt) then nut.newchar.setBody(v, "bot", bt) end
			end
		end
		for k,v in pairs(ents.FindByClass("nextbot_fakeplayer")) do
			if(v.getChar and v:getChar() and nut.newchar.isBM(v:GetModel())) then
				--nut.newchar.resetModels(v)
				print("doing ply ", v)

				local tp, bt = v:getChar():getData("gtop"), v:getChar():getData("gbot")
				local tskin, bskin = v:getChar():getData("gtopskin"), v:getChar():getData("gbotskin")
				local tbl = {reset = true, top = tp, bot = bt, topskin = tskin, botskin = bskin}
				
				if(v:getChar():getData("gctop")) then
					tbl.customt = v:getChar():getData("gctop")
				end
				if(v:getChar():getData("gcbot")) then
					tbl.customb = v:getChar():getData("gcbot")
				end
				PrintTable(tbl)
				
				clothesd(v, tbl)
				--if(tp) then nut.newchar.setBody(v, "top", tp) end
				--if(bt) then nut.newchar.setBody(v, "bot", bt) end
			end
		end
	end)

	--theres a bug that happens when you sit, 
	--the bones get stuck above where you sat when you get up 
	--and the bones stay there until theyre reset
	--https://cdn.discordapp.com/attachments/386367930369310738/473731141615222784/hl2_2018-07-31_01-57-58.png
	--this should fix that
	net.Receive("redobones", function()
		local ply = net.ReadEntity()
		
		if(serverside) then return end

		if(ply.bm and IsValid(ply.bm.t)) then
			local t, b = ply.bm.t, ply.bm.b
			
			t:InvalidateBoneCache()
			t:SetParent(ply)
			t:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL,EF_PARENT_ANIMATES))
			t:SetupBones()

			b:InvalidateBoneCache()
			b:SetParent(ply)
			b:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL,EF_PARENT_ANIMATES))
			b:SetupBones()
		end
	end)

else--server
	util.AddNetworkString("wearClothing")
	util.AddNetworkString("doallcothes") --nice typo me ohwell
	util.AddNetworkString("corpsecloth")
	util.AddNetworkString("redobones")

	hook.Add("PlayerLeaveVehicle", "newchar_bugfix", function(ply, veh)
		local model = ply:GetModel()
		if(!nut.newchar.isBM(model)) then return end --just to double check

		if(!serverside) then
		net.Start("redobones")
		net.WriteEntity(ply)
		net.Broadcast()
		else
			--not sure if ss needs this or not
			
		if(ply.bm and IsValid(ply.bm.t)) then
			local t, b = ply.bm.t, ply.bm.b
			
			--t:InvalidateBoneCache()
			t:SetParent(ply)
			t:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL))
			--t:SetupBones()

			--b:InvalidateBoneCache()
			b:SetParent(ply)
			b:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL))
			--b:SetupBones()
		end
		end
	end)

hook.Add("PlayerSpawn", "regivemodels", function(ply)
	if(ply:getChar()) then
	--	ply:RemoveAllDecals() --idk
		nut.newchar.resetModels(ply)
	--	net.Start("doallcothes")
	--	net.Send(ply)
	end
end)
hook.Add("PlayerSetHandsModel", "newcharhands", function(ply, ent)
	if(!sethands) then return end
	local model = ply:GetModel() --get main model first,
	local main = ply
	--but if have top model, use that instead
	if(ply.bm and IsValid(ply.bm.t) and model:find("heads")) then
		model = ply.bm.t:GetModel()
		main = ply.bm.t
	end
	local hands
	--find hands model from config table
	for k,v in pairs(handstbl) do
		if(model:find(k)) then
			hands = v
			break
		end
	end
	--and dont bother if not found
	if(!hands) then return end

	ent:SetModel(hands)

	ent:SetSkin(main:GetSkin())
	local m = ent:GetMaterials()
	--match submats
	for k2,v2 in ipairs(ent:GetMaterials()) do
		local mat
		for k,v in ipairs(main:GetMaterials()) do
			if(v == v2) then mat = k-1 end
		end
		if(!mat) then continue end
		local sub = main:GetSubMaterial(mat)
		if(sub != "") then
			ent:SetSubMaterial(k2-1, sub)
		else
			ent:SetSubMaterial(k2-1)
		end
	end
	--match bgs
	local bgs = main:GetBodyGroups()
	for k,v in ipairs(bgs or {}) do
		local id = ent:FindBodygroupByName(v.name)
		if(id != -1) then
			ent:SetBodygroup(id, main:GetBodygroup(k))
		end
	end

	return true --prevent the gamemode hook from calling
end)
function clothesnonply(ply, data, realply)
	local setthistime = false
	
					--just pick one to check i guess
	if(!ply.bm or !IsValid(ply.bm.t)) then --if the models dont exist make them
		ply.bm = {}
		setthistime = true

		print(realply)

		local t = ents.Create("base_gmodentity")
		t:SetModel(data.customt or (realply:isFemale() and defaultfemtop or defaultmaletop))
		t:Spawn()
		t:PhysicsDestroy()
		--[[
		if(t:GetPhysicsObject()) then
			t:GetPhysicsObject():Remove()
		end
		]]
		local b = ents.Create("base_gmodentity")
		b:SetModel(data.customt or (realply:isFemale() and defaultfembot or defaultmalebot))
		b:Spawn()
		b:PhysicsDestroy()
		--[[
		if(b:GetPhysicsObject()) then
			b:GetPhysicsObject():Remove()
		end
		]]

		print("excuse me "..tostring(ply))
		print(tostring(ply.bm))
		--t:InvalidateBoneCache()
		t:SetParent(ply)
		ply:CallOnRemove("remtop", function(ent) t:Remove() end)
		t:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL))
		--t:SetupBones()
		ply.bm.t = t
		

		--b:InvalidateBoneCache()
		b:SetParent(ply)
		ply:CallOnRemove("rembot", function(ent) b:Remove() end)
		b:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL))
		--b:SetupBones()
		ply.bm.b = b

		if(defaultbothidden == -1) then --just uh putting it in here
			b:SetRenderMode(RENDERMODE_TRANSALPHA)
			b:SetColor(Color(255,255,255,0))
		end


		if(ply:IsPlayer()) then
		function t:Think()
			local parent = self:GetParent()
			if(IsValid(parent)) then
				if(parent:IsPlayer() and parent:getChar()) then
					if(parent:Alive()) then
						--self:SetParent(ply)
						self.hasSpawned = true
					elseif(self.hasSpawned) then
						self:Remove()
						ply.bm.t = nil
						return
					end
				end

				local noDraw = parent:GetNoDraw() or !nut.newchar.isBM(parent:GetModel()) --maybe support replace models?
				if(noDraw != self.LastDrawState) then
					self:SetNoDraw(noDraw)
				end
				self.LastDrawState = noDraw
			end
		end
		hook.Add("Think", t, t.Think)

		function b:Think()
			local parent = self:GetParent()
			if(IsValid(parent)) then
				if(parent:IsPlayer() and parent:getChar()) then
					if(parent:Alive()) then
						--self:SetParent(ply)
						self.hasSpawned = true
					elseif(self.hasSpawned) then
						self:Remove()
						ply.bm.b = nil
						return
					end
				end

				local noDraw = parent:GetNoDraw() or !nut.newchar.isBM(parent:GetModel()) --maybe support replace models?
				if(noDraw != self.LastDrawState) then
					self:SetNoDraw(noDraw)
				end
				self.LastDrawState = noDraw
			end
		end
		hook.Add("Think", b, b.Think)
		end
	end

	if(data.reset&&!setthistime) then --dont need to do this if it was just set
		ply.bm.t:SetModel(data.customt or (realply:isFemale() and defaultfemtop or defaultmaletop))
		ply.bm.b:SetModel(data.customb or (realply:isFemale() and defaultfembot or defaultmalebot))
		ply.bm.t:SetBodygroup(0, 0)
		ply.bm.b:SetBodygroup(0, 0)
		ply.bm.t:SetSkin(0)
		ply.bm.b:SetSkin(0)
		
		--workaround lmao
		if(ply.bm.b:GetRenderMode() != RENDERMODE_NORMAL) then
			ply.bm.b:SetRenderMode(RENDERMODE_NORMAL)
			ply.bm.b:SetColor(Color(255,255,255,255))
		end
		
		--also here just in case
		if(defaultbothidden == -1) then --just uh putting it in here
			ply.bm.b:SetRenderMode(RENDERMODE_TRANSALPHA)
			ply.bm.b:SetColor(Color(255,255,255,0))
		end

		ply.bm.t:SetSubMaterial()
		ply.bm.b:SetSubMaterial()

		ply.bm.t:SetBodyGroups("00000000") --this works for now i guess?
		ply.bm.b:SetBodyGroups("00000000") --this works for now i guess?
	end
--[[
	if(data.top) then
		ply.bm.t:SetBodygroup(0, data.top)
	end
	if(data.bot) then
		ply.bm.b:SetBodygroup(0, data.bot)
	end
	]]
	if(data.top) then
		if(data.top != -1) then
			if(ply.bm.t:GetRenderMode() != RENDERMODE_NORMAL) then
				ply.bm.t:SetRenderMode(RENDERMODE_NORMAL)
				ply.bm.t:SetColor(Color(255,255,255,255))
			end
			if(data.customt) then
				ply.bm.t:SetModel(data.customt)
			else --just to make sure lol
				ply.bm.t:SetModel(realply:isFemale() and defaultfemtop or defaultmaletop)
			end
			ply.bm.t:SetBodygroup(0, data.top)
			if(data.topskin) then
				ply.bm.t:SetSkin(data.topskin)
			end
			if(data.custombgst) then
				for k,v in pairs(data.custombgst) do
					ply.bm.t:SetBodygroup(k, v)
				end
			end
			if(data.customsubt) then
				--[[
					currently there is a bug (according to chair)
					in which on loading, submats arent applied, and
					are never applied to the body even after reequipping the suit
					make a mono, try it, check gsubs getData table (the t table
					should have everything in it), make sure this appears so
					its actually running, because nothing looks on here
					and this does work (or has worked) in sp, keeping mats and all
					(i think), however ive gotten this bug myself, but on the black
					bandana and reequipping it fixes it
					he also reported about helmets with anorak always showing skat
					helms? (no matter the helmet)
					there is also the hood status not saving, i have no idea
				]]
				nut.log.addRaw("doing top submats "..tostring(ply))
				local mats = ply.bm.t:GetMaterials()
				for k,v in pairs(data.customsubt) do
					local mat
					for k2,v2 in pairs(mats) do
						if(string.find(v2, k)) then
							mat = k2-1
						end
					end
					if(mat) then
						nut.log.addRaw("setting "..tostring(ply)..mat..v)
						ply.bm.t:SetSubMaterial(mat, v)
					end
				end
			end
		else
			ply.bm.t:SetRenderMode(RENDERMODE_TRANSALPHA)
			ply.bm.t:SetColor(Color(255,255,255,0))
		end
		if(sethands) then
			ply:SetupHands()
		end
	end
	if(data.bot) then
		if(data.bot != -1) then
			if(ply.bm.b:GetRenderMode() != RENDERMODE_NORMAL) then
				ply.bm.b:SetRenderMode(RENDERMODE_NORMAL)
				ply.bm.b:SetColor(Color(255,255,255,255))
			end
			if(data.customb) then
				ply.bm.b:SetModel(data.customb)
			else --just to make sure lol
				ply.bm.b:SetModel(realply:isFemale() and defaultfembot or defaultmalebot)
			end
			ply.bm.b:SetBodygroup(0, data.bot)
			if(data.botskin) then
				ply.bm.b:SetSkin(data.botskin)
			end
			if(data.custombgsb) then
				for k,v in pairs(data.custombgsb) do
					ply.bm.b:SetBodygroup(k, v)
				end
			end
			if(data.customsubb) then
				local mats = ply.bm.b:GetMaterials()
				for k,v in pairs(data.customsubb) do
					local mat
					for k2,v2 in pairs(mats) do
						if(string.find(v2, k)) then
							mat = k2-1
						end
					end
					if(mat) then
						ply.bm.b:SetSubMaterial(mat, v)
					end
				end
			end
		else
			ply.bm.b:SetRenderMode(RENDERMODE_TRANSALPHA)
			ply.bm.b:SetColor(Color(255,255,255,0))
		end
	end
end

hook.Add("OnCharFallover", "bmfall", function(pl, rag, state)
	if(!state) then return end

	local model = rag:GetModel()
	if(!nut.newchar.isBM(model)) then return end
	if(!pl) then return end
	local ply = pl:getChar() --notactuallyplayerbutlmao
	local tbl = {top = ply:getData("gtop", 0), topskin = ply:getData("gtopskin", 0), 
	bot = ply:getData("gbot", defaultbothidden), botskin = ply:getData("gbotskin", 0),
	}
	local bgs = ply:getData("gbgs", {})
	if(bgs.t) then
		tbl.custombgst = bgs.t
	end
	if(bgs.b) then
		tbl.custombgsb = bgs.b
	end
	local subs = ply:getData("gsub", {})
	if(bgs.t) then
		tbl.customsubt = subs.t
	end
	if(bgs.b) then
		tbl.customsubb = subs.b
	end

	if(ply:getData("gctop")) then
		tbl.customt = ply:getData("gctop")
	end
	if(ply:getData("gcbot")) then
		tbl.customb = ply:getData("gcbot")
	end

	clothesnonply(rag, tbl, pl)


	--[[
	net.Start("corpsecloth")
	net.WriteEntity(rag)
	net.WriteEntity(pl)
	net.WriteTable(tbl)
	net.Broadcast()
	]]


end)

hook.Add("OnCorpseCreated", "bmcorpse", function(rag, pl)
	local model = rag:GetModel()
	if(!nut.newchar.isBM(model)) then return end
	if(!pl) then return end
	local ply = pl:getChar() --notactuallyplayerbutlmao
	local tbl = {top = ply:getData("gtop", 0), topskin = ply:getData("gtopskin", 0), 
	bot = ply:getData("gbot", defaultbothidden), botskin = ply:getData("gbotskin", 0),
	}
	local bgs = ply:getData("gbgs", {})
	if(bgs.t) then
		tbl.custombgst = bgs.t
	end
	if(bgs.b) then
		tbl.custombgsb = bgs.b
	end
	local subs = ply:getData("gsub", {})
	if(subs.t) then
		tbl.customsubt = subs.t
	end
	if(subs.b) then
		tbl.customsubb = subs.b
	end

	if(ply:getData("gcustomtop")) then
		tbl.customt = ply:getData("gcustomtop")
	end
	if(ply:getData("gcustombot")) then
		tbl.customb = ply:getData("gcustombot")
	end

	clothesnonply(rag, tbl, pl)


	--[[
	net.Start("corpsecloth")
	net.WriteEntity(rag)
	net.WriteEntity(pl)
	net.WriteTable(tbl)
	net.Broadcast()
	]]

	--[[
	ply:setData("gdtop", nil, nil, player.GetAll())
	ply:setData("gdbot", nil, nil, player.GetAll())
	ply:setData("gdtopskin", nil, nil, player.GetAll())
	ply:setData("gdbotskin", nil, nil, player.GetAll())
	ply:setData("gcustomtop", nil, nil, player.GetAll())
	ply:setData("gcustombot", nil, nil, player.GetAll())
	ply:setData("gbgs", nil, nil, player.GetAll())
	ply:setData("gsub", nil, nil, player.GetAll())
	]]
end)

hook.Add("PlayerLoadedChar", "aaaSwapGSModels", function(ply, char, lastChar)
	//nut.newchar.resetModels(ply)

	if(serverside) then return end
	if(!lastChar) then --should give the models on first loading char idk
		net.Start("doallcothes")
		net.Send(ply)
	end
end)

--[[i dont know if theyre gonna remove themselves so just to be safe 
they will dw
hook.Add("PlayerDisconnected", "aaaremoveGS", function(ply)
	if(IsValid(ply:GetNWEntity("top"))) then
		ply:GetNWEntity("top"):Remove()
	end
	if(IsValid(ply:GetNWEntity("bot"))) then
		ply:GetNWEntity("bot"):Remove()
	end
end)]]

function nut.newchar.resetModels(pl)
	local model = pl:GetModel()
	if(!nut.newchar.isBM(model)) then return end
	
	local ply = pl:getChar() --notactuallyplayerbutlmao

	local tbl = {top = ply:getData("gtop", 0), topskin = ply:getData("gtopskin", 0), 
	bot = ply:getData("gbot", defaultbothidden), botskin = ply:getData("gbotskin", 0),
	}
	local bgs = ply:getData("gbgs", {})
	if(bgs.t) then
		tbl.custombgst = bgs.t
	end
	if(bgs.b) then
		tbl.custombgsb = bgs.b
	end
	local subs = ply:getData("gsub", {})
	if(subs.t) then
		tbl.customsubt = subs.t
	end
	if(subs.b) then
		tbl.customsubb = subs.b
	end

	if(ply:getData("gcustomtop")) then
		tbl.customt = ply:getData("gcustomtop")
	end
	if(ply:getData("gcustombot")) then
		tbl.customb = ply:getData("gcustombot")
	end

	tbl.reset = true

	if(!serverside) then
	net.Start("wearclothing")
	net.WriteEntity(pl)
	net.WriteTable({reset = true})
	net.Broadcast()
	else
		clothesnonply(pl, tbl, pl)
	end
end

hook.Add("PlayerInitialSpawn", "aaagiveallnewchar", function(ply)
	if(serverside) then return end

	--clientside stuff, likely not needed
	timer.Simple(1, function()
	for k,v in pairs(player.GetAll()) do
		if(!v.getChar or !v:getChar() or v == ply or !nut.newchar.isBM(v:GetModel())) then continue end
		for k2,v2 in pairs(dvars) do --this should send it to the client
			if(v:getChar():getData(v2) != nil) then
				v:getChar():setData(v2, v:getChar():getData(v2), nil, ply)
			end
		end
	end
	for k,v in pairs(ents.FindByClass("nextbot_fakeplayer")) do
		if(!v.getChar or !v:getChar() or !nut.newchar.isBM(v:GetModel())) then continue end
		for k2,v2 in pairs(dvars) do --this should send it to the client
			if(v:getChar():getData(v2) != nil) then
				v:getChar():setData(v2, v:getChar():getData(v2), nil, ply)
			end
		end
	end
	timer.Simple(1, function()
	net.Start("doallcothes")
	net.Send(ply)
	end)
	end)
end)

hook.Add("OnReloaded", "resetclothesssss", function(ply)
	if(serverside) then return end

	net.Start("doallcothes")
	net.Broadcast()
end)


--[[
	how use:
	ply: the player to apply this to
	type: the type thats being set, top, bot or seperate 
	(seperate will use top model and hide bot model)
	bg: the bodygroup (on ind 0) to set it to
	custommodel: if there is a custom model to set it to (ex something from default),
	put it here
	skin: changing the skin of the model to the specified skin
	custombgs: (unimplemented reminder) a table of further bodygroup values 
	for indexs higher than 0
	submats: a table of materials to replace materials as submaterials
	["sourcemat"] = "replacemat",
	force: if, for whatever reason, you want it to force it to do this even if the 
	model isnt a bm model, you can set this

	datas:
	"gctop",
	"gcbot",
	"gtop",
	"gtopskin",
	"gbot",
	"gbotskin",
	"gbgs",
	"gsub",


	note: i dont think this needs to be networked to everyone for serverside?
]]
--extra thing to only change bgs:  ply, t or b, tbl of bgs to change, submats
function nut.newchar.setBodygroups(ply, ind, bgs, submats)
	if(ind != "t" and ind != "b") then
		print("youre using setbodygroups incorrectly! ind should be t or b, not "..ind)
		return
	end

	if(!ply.bm or !ply.bm[ind] or !IsValid(ply.bm[ind])) then return end

	local char = ply:getChar()
	local sdf = char:getData("gbgs", {})
	local adf = char:getData("gsub", {})

	for k,v in pairs(bgs or {}) do
		ply.bm[ind]:SetBodygroup(k, v)
		sdf[ind] = sdf[ind] or {}
		sdf[ind][k] = v
	end
	
	if(submats) then
		local mats = ply.bm[ind]:GetMaterials()
		for k,v in pairs(submats) do
			local mat
			for k2,v2 in pairs(mats) do
				if(string.find(v2, k)) then
					mat = k2-1
				end
			end
			if(mat) then
				ply.bm[ind]:SetSubMaterial(mat, v)
			end
			adf[ind] = adf[ind] or {}
			adf[ind][k] = v
		end
	end

	if(ind == "t" and sethands) then
		ply:SetupHands()
	end
	
	char:setData("gbgs", sdf, nil, player.GetAll())
	char:setData("gsub", adf, nil, player.GetAll())
end

function nut.newchar.setBody(ply, type, bg, custommodel, skin, custombgs, submats, force)
	local model = ply:GetModel()
	print("wtf", bg)
	if(!nut.newchar.isBM(model) and !force) then return end
	local realbg = bg
	if((type == "top" or type == "bot" or type == "seperate") and bg == -1) then
		bg = 0
		skin = 0
	end

	local realtype = type
	if(type == "seperate") then
		realtype = "top"
	end

	print(type, bg, custommodel, skin, realtype)

	local tbl = {[realtype] = bg}
	if(type == "seperate" and realbg != -1) then
		tbl.bot = -1
	elseif(type == "seperate") then --this is removing it
		tbl.bot = defaultbothidden
	end

	if(realtype == "top") then
		tbl.topskin = skin or 0
	elseif(realtype == "bot") then
		tbl.botskin = skin or 0
	end
	
	if(custommodel) then
		if(realtype == "top" and realbg != -1) then
			tbl.customt = custommodel
		elseif(realtype == "bot" and realbg != -1) then
			tbl.customb = custommodel
		end
	end

	if(custombgs) then
		if(realtype == "top") then
			tbl.custombgst = custombgs
		elseif(realtype == "bot") then
			tbl.custombgsb = custombgs
		end
	end

	if(submats) then
		if(realtype == "top") then
			tbl.customsubt = submats
		elseif(realtype == "bot") then
			tbl.customsubb = submats
		end
	end

	PrintTable(tbl)

	if(!serverside) then
	net.Start("wearclothing")
	net.WriteEntity(ply)
	net.WriteTable(tbl)
	net.Broadcast()
	else
		clothesnonply(ply, tbl, ply)
	end

	local char = ply:getChar()
	if(type == "reset") then
		char:setData("gtop", nil, nil, player.GetAll())
		char:setData("gbot", nil, nil, player.GetAll())
		char:setData("gctop", nil, nil, player.GetAll())
		char:setData("gcbot", nil, nil, player.GetAll())
		char:setData("gbgs", nil, nil, player.GetAll())
		char:setData("gsub", nil, nil, player.GetAll())
	end

	if(custommodel) then
		if(type == "top" or type == "seperate") then
			if(realbg != -1) then
				char:setData("gctop", custommodel, nil, player.GetAll())
			else
				char:setData("gctop", nil, nil, player.GetAll())
			end
		elseif(type == "bot") then
			if(realbg != -1) then
				char:setData("gcbot", custommodel, nil, player.GetAll())
			else
				char:setData("gcbot", nil, nil, player.GetAll())
			end
		end
	end
	if(realtype == "top") then
		char:setData("gtop", bg, nil, player.GetAll())
		char:setData("gtopskin", skin, nil, player.GetAll())

		local sdf = char:getData("gbgs", {})
		sdf["t"] = custombgs
		local adf = char:getData("gsub", {})
		adf["t"] = submats
		char:setData("gbgs", sdf, nil, player.GetAll())
		char:setData("gsub", adf, nil, player.GetAll())
	end
	if(type == "seperate" and realbg != -1) then
		char:setData("gbot", -1, nil, player.GetAll())

		local sdf = char:getData("gbgs", {})
		sdf["t"] = custombgs
		local adf = char:getData("gsub", {})
		adf["t"] = submats
		char:setData("gbgs", sdf, nil, player.GetAll())
		char:setData("gsub", adf, nil, player.GetAll())
	
	elseif(type == "seperate") then
		char:setData("gbot", nil, nil, player.GetAll())
		
	end
	if(type == "bot") then
		char:setData("gbot", bg, nil, player.GetAll())
		char:setData("gbotskin", skin, nil, player.GetAll())

		local sdf = char:getData("gbgs", {})
		sdf["b"] = custombgs
		local adf = char:getData("gsub", {})
		adf["b"] = submats
		char:setData("gbgs", sdf, nil, player.GetAll())
		char:setData("gsub", adf, nil, player.GetAll())
	end

end
end