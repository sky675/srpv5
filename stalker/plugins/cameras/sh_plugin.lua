local PLUGIN = PLUGIN
PLUGIN.name = "Cameras"
PLUGIN.author = "sky"
PLUGIN.desc = "surveillance cameras but theyre an actual thing now :)"

--spectate stuff? setupmove or something for changing shit?
function PLUGIN:GetCameras(id)
	local cams = ents.FindByClass("sky_cam_*")
	local fin = {}
	for k,v in pairs(cams) do
		if(v:GetCircuitID() == id and !v:GetDestroyed()) then
			table.insert(fin, v)
		end
	end

	return fin
end
--for sanity
if(SERVER) then
	--change bools, set default cam (if can) and id
	function PLUGIN:StartCams(ply, id)
		local cams = PLUGIN:GetCameras(id)
		if(!cams or #cams == 0) then 
			ply:notify("no cams found")
			return 
		end --just in case
		ply:SetNW2Bool("viewcams", true)
		ply:SetNW2String("viewcamid", id)
		ply:SetNW2Int("viewcamentid", 1)
		if(IsValid(cams[1])) then --default first
			ply:SetNW2Entity("viewcament", cams[1])
		end
	end
	--change bools, remove cam vars
	function PLUGIN:EndCams(ply)
		ply:SetNW2Bool("viewcams")
		ply:SetNW2String("viewcamid")
		ply:SetNW2Entity("viewcament")
		ply:SetNW2Int("viewcamentid")
	end
	netstream.Hook("camsStartServ", function(ply, id) 
		PLUGIN:StartCams(ply, id)
	end)
else
	--this should be started from the camera control item
	netstream.Hook("camsStart", function()
		--derma query, return netstream Start camsStartServ
		Derma_StringRequest("Camera Controller", "Enter Circuit ID",
			"", function(text)
				if(text == "") then nut.util.notify("text empty") return end
				netstream.Start("camsStartServ", text)
			end)
	end)
end

hook.Add("StartCommand", "cammovement", function(ply, cmd)
	if(!ply:GetNW2Bool("viewcams")) then return end --get outttaaaaaaaa here

	--idk wat else here?
	--e to exit
	--just do endcams ig?
	if(cmd:KeyDown(IN_USE)) then
		--exit
		if(SERVER) then PLUGIN:EndCams(ply) end
		print("exit")
		cmd:ClearMovement()
		cmd:ClearButtons() --uh just in case
		return
	end

	--a/d to switch cam forward/back
	--put thing to only do this if touched a or d
	local cams = PLUGIN:GetCameras(ply:GetNW2String("viewcamid"))
	if(!cams or #cams == 0) then return end --just in case
	local id = table.KeyFromValue(cams, ply:GetNW2Entity("viewcament")) or 1
	local move = cmd:GetSideMove()
	--i thiiiiiiiiink this should work?
	--ok now if pressed a, move id down one, 
	if(move < 0) then --left, so down
		--and if not in cams make it 1 instead
		if(id != 1) then
			id = id - 1
		end
		--and ofc set new ent to that
		ply:SetNW2Int("viewcamentid", id)
		ply:SetNW2Entity("viewcament", cams[id])

	--else if pressed d move it up one instead,
	elseif(move < 0) then --right, so sup
		--and if 0 make it max cams
		if(id <= #cams-1) then
			id = 1
		else
			id = id + 1
		end
		--and ofc do same
		ply:SetNW2Int("viewcamentid", id)
		ply:SetNW2Entity("viewcament", cams[id])

	else
		--nothing?
	end

	cmd:ClearMovement()
	cmd:ClearButtons() --uh just in case
end)

--no idea how to view at origin, calcview?
if(CLIENT) then
	hook.Add("CalcView", "aaacameraview", function(ply, origin, angles, fov, znear, zfar)
		if(!ply:GetNW2Bool("viewcams")) then return end --nah

		local tbl = {drawviewer = true, ["fov"] = fov, ["znear"] = znear, ["zfar"] = zfar}
		local cam = ply:GetNW2Entity("viewcament")
		if(IsValid(cam) and !cam:GetDestroyed()) then
			tbl.origin = cam:GetPos()+cam.viewOffset
			tbl.angles = cam:GetForward():Angle()+cam.anglOffset
			return tbl
		else
			--idk
		end
	end)
	local drawText, scrw, scrh = nut.util.drawText, ScrW(), ScrH()
	--thisll do for now, should try and find something better tbh
	local mat = Material("effects/security_noise2"):GetTexture("$basetexture")
	--i dont like checking it twice, but cant do this in ^
	hook.Add("HUDPaintBackground", "cameraeffects", function()
		local ply = LocalPlayer()
		if(!ply:GetNW2Bool("viewcams")) then return end --nah
		--i hate doing this in different thing but whatever
		local cam = ply:GetNW2Entity("viewcament")
		if(IsValid(cam) and !cam:GetDestroyed()) then
			--? draw text cam id?
			local id = ply:GetNW2Int("viewcamentid", 1)
			drawText("Cam ID - "..id.." | +use to exit, left/right to change cams", scrw/2, 12, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, "nutSmallFont", 255)
		else
			render.DrawTextureToScreen(mat)
			drawText("NO CAM", scrw/2, 12, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, "nutSmallFont", 255)
			--show static here? idk
		end
	end)
else--server
	hook.Add("SetupPlayerVisibility", "cameravis", function(ply, view)
		if(ply:GetNW2Bool("viewcams")) then
			--mebi this is right?
			local cam = ply:GetNW2Entity("viewcament")
			if(IsValid(cam) and !cam:GetDestroyed()) then
				AddOriginToPVS(cam:GetPos())
			end
		end
	end)
end

--save/load cameras and the netvars