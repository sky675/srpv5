local PLUGIN = PLUGIN
PLUGIN.name = "Note Writings"
PLUGIN.author = "Black Tea"
PLUGIN.desc = "You can write stuffs."
PLUGIN.NOTELIMIT = 1000
WRITINGDATA = WRITINGDATA or {} --??
PLUGIN.WRITINGDATA = WRITINGDATA or {}

nut.util.include("cl_vgui.lua")

if (CLIENT) then
	netstream.Hook("receiveNote", function(id, contents, write)
		local note = vgui.Create("noteRead")
		note:AllowEdit(write)
		note:SetText(contents)
		note.id = id
	end)
else
	function FindNoteByID(id)
		for k, v in ipairs(ents.GetAll()) do
			if (v:GetClass() == "nut_note" and v.id == id) then
				return v
			end
		end
	end
	
	netstream.Hook("noteSendText", function(client, id, contents)
		if (string.len(contents) <= PLUGIN.NOTELIMIT) then
			local note = FindNoteByID(id)
			if (note:CanWrite(client) == false) then
				return client:notify("You do not own this note", 3)
			end

			WRITINGDATA[id] = contents
		end
	end)

	function PLUGIN:EntityRemoved(entity)
		if (!nut.shuttingDown and entity and IsValid(entity) and entity:GetClass() == "nut_note" and entity.id) then
			if WRITINGDATA[entity.id] then
				WRITINGDATA[entity.id] = nil
			end
		end
	end

	function PLUGIN:OnNoteSpawned(note, item, load)
		note:SetModel(item.model)
		note:PhysicsInit(SOLID_VPHYSICS)
		note:SetMoveType(MOVETYPE_VPHYSICS)
		note:SetUseType(SIMPLE_USE)

		local physicsObject = note:GetPhysicsObject()
		if (IsValid(physicsObject)) then
			physicsObject:Wake()
		end

		if (item.player and IsValid(item.player)) then
			note:setNetVar("ownerChar", item.player:getChar().id)
		end

		if (load != true) then
			note.id = os.time()
			WRITINGDATA[note.id] = ""
		end
	end

	function PLUGIN:LoadData()
		local savedTable = self:getData() or {}
		local noteItem = nut.item.list["note"]
		WRITINGDATA = savedTable.noteData

		if (savedTable.noteEntities) then
			for k, v in ipairs(savedTable.noteEntities) do
				local note = ents.Create("nut_note")
				note:SetPos(v.pos)
				note:SetAngles(v.ang)
				note:Spawn()
				note:Activate()
				note:setNetVar("ownerChar", v.owner)
				note.id = v.id

				hook.Run("OnNoteSpawned", note, noteItem, true)
			end
		end
	end
	
	function PLUGIN:SaveData()
		local saveTable = {}
		local validNotes = {}
		saveTable.noteEntities = {}

		for _, v in ipairs(ents.GetAll()) do
			if (v:GetClass() == "nut_note") then
				table.insert(saveTable.noteEntities, {pos = v:GetPos(), ang = v:GetAngles(), id = v.id, owner = v:GetOwner()})
				table.insert(validNotes, v.id)
			end
		end

		local validNoteData = {}
		for _, v in ipairs(validNotes) do
			validNoteData[v] = WRITINGDATA[v]
		end

		saveTable.noteData = validNoteData

		self:setData(saveTable)
	end
	
end