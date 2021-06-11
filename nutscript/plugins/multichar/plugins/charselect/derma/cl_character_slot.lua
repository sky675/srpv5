local PANEL = {}

local STRIP_HEIGHT = 4

function PANEL:isCursorWithinBounds()
	local HEIGHT = (ScrH() - 400)
	local hRatio = HEIGHT/516
	local WIDTH = 217*hRatio

	local x, y = self:LocalCursorPos()
	return x >= 0 and x <= WIDTH and y >= 0 and y < HEIGHT
end

function PANEL:confirmDelete()
	local id = self.character:getID()
	vgui.Create("nutCharacterConfirm")
		:setMessage(L("Deleting a character cannot be undone."))
		:onConfirm(function()
			nutMultiChar:deleteCharacter(id)
		end)
end

function PANEL:Init()
	local HEIGHT = (ScrH() - 400) --the number is the sum of all the dock margin and heights of the tab and title above as well as the contents dock margin bottom
	local hRatio = HEIGHT/516
	local WIDTH = 217*hRatio

	self:SetWide(WIDTH)
	self:SetHeight(HEIGHT)
	self:SetDrawBackground(false)
	
	self.faction = self:Add("DLabel")
	self.faction:SetPos(12*hRatio, 382*hRatio)
	self.faction:SetTall(21*hRatio)
	self.faction:SetWide(202*hRatio)
	self.faction:SetFont("nutChatFontBold")
	self.faction:SetContentAlignment(7)

	self.money = self:Add("DLabel")
	self.money:SetPos(12*hRatio, 403*hRatio)
	self.money:SetTall(21*hRatio)
	self.money:SetWide(202*hRatio)
	self.money:SetFont("nutChatFontBold")
	self.money:SetContentAlignment(7)


	self.desc = self:Add("DLabel")
	self.desc:SetPos(12*hRatio, 424*hRatio)
	self.desc:SetTall(44*hRatio)
	self.desc:SetWide(198*hRatio)
	self.desc:SetFont("nutChatFontBold")
	self.desc:SetContentAlignment(7)

	
	-- self.faction = self:Add("DPanel")
	-- self.faction:Dock(TOP)
	-- self.faction:SetTall(STRIP_HEIGHT)
	-- self.faction:SetSkin("Default")
	-- self.faction:SetAlpha(100)
	-- self.faction.Paint = function(faction, w, h)
	-- 	--surface.SetDrawColor(faction:GetBackgroundColor())
	-- 	--surface.DrawRect(0, 0, w, h)
	-- end

	self.name = self:Add("DLabel")
	--self.name:Dock(TOP)
	--self.name:DockMargin(0, 16, 0, 0)
	self.name:SetPos(21*hRatio, 6*hRatio)
	self.name:SetTall(21*hRatio)
	self.name:SetWide(145*hRatio)
	self.name:SetFont("nutChatFontBold")
	self.name:SetTextColor(Color(255,255,255,255))
	self.name:SizeToContentsY()
	

	self.model = self:Add("nutModelPanel")
	self.model:SetPos(7*hRatio, 31*hRatio)
	self.model:SetTall(342*hRatio)
	self.model:SetWide(202*hRatio)
	--self.model:Dock(FILL)
	self.model:SetFOV(37)
	self.model.PaintOver = function(model, w, h)
		if (self.banned) then
			local centerX, centerY = w * 0.5, h * 0.5 - 24
			surface.SetDrawColor(250, 0, 0, 40)
			surface.DrawRect(0, centerY - 24, w, 48)

			draw.SimpleText(
				L("banned"):upper(),
				"nutCharSubTitleFont",
				centerX,
				centerY,
				color_white, 1, 1
			)
		end
	end

	--self.button = self:Add("DButton")
	--self.button:SetSize(WIDTH, ScrH())
	--self.button:SetDrawBackground(false)
	--self.button:SetText("")
	--self.OnCursorEntered = function(button) self:OnCursorEntered() end


	self.playbut = self:Add("DImageButton")
	self.playbut:SetPos(100*hRatio, 457*hRatio)
	self.playbut:SetImage("sky/buttons/play.png")
	self.playbut:SetSize(18*hRatio, 22*hRatio)
	self.playbut.DoClick = function(button)
		nut.gui.character:clickSound()
		if (not self.banned) then
			self:onSelected()
		end
	end

	self.copybut = self:Add("DImageButton")
	self.copybut:SetPos(173*hRatio, 457*hRatio)
	self.copybut:SetImage("sky/buttons/copy.png")
	self.copybut:SetSize(18*hRatio, 22*hRatio)
	self.copybut.DoClick = function(delete)
		nut.gui.character:clickSound()
		SetClipboardText(self.name:GetText() .. ": " .. self.desc:GetText())
	end


	self.delbut = self:Add("DImageButton")
	self.delbut:SetPos(28*hRatio, 457*hRatio)
	self.delbut:SetImage("sky/buttons/delete.png")
	self.delbut:SetSize(18*hRatio, 22*hRatio)
	self.delbut.DoClick = function(delete)
		nut.gui.character:clickSound()
		self:confirmDelete()
	end

	self.Paint = function()
		local w, h = self:GetSize()
		surface.SetDrawColor(255,255,255,255)
		surface.SetMaterial(Material('sky/charmenu/charshow.png'))
		surface.DrawTexturedRect(0, 0, w, h)
	end
	--panel:SetWide(WIDTH)
	--panel:SetTall(HEIGHT)
end

function PANEL:onSelected()
end

function PANEL:setCharacter(character)
	self.character = character

	self.name:SetText(character:getName():gsub("#", "\226\128\139#"):upper())
	self.model:SetModel(character:getModel())
	
	self.faction:SetColor(team.GetColor(character:getFaction()))
	self.faction:SetText(string.upper(team.GetName(character:getFaction())))
	
	self.money:SetText(character:getMoney() .. " RU")

	self.desc:SetText(character:getDesc())
	
	self:setBanned(character:getData("banned"))

	local entity = self.model.Entity
	if (IsValid(entity)) then
		-- Match the skin and bodygroups.
		entity:SetSkin(character:getData("skin", 0))
		for k, v in pairs(character:getData("groups", {})) do
			entity:SetBodygroup(k, v)
		end

		-- Approximate the upper body position.
		local mins, maxs = entity:GetRenderBounds()
		local height = math.abs(mins.z) + math.abs(maxs.z)
		local scale = math.max((960 / ScrH()) * 0.5, 0.5)
		self.model:SetLookAt(entity:GetPos() + Vector(0, 0, height * scale))
		
									
		local mats = self.model.Entity:GetMaterials()
		for k,v in pairs(character:getData("submat", {})) do
			local mat
			for k2,v2 in ipairs(mats) do
				if(string.find(v2, k)) then
					mat = k2-1
				end
			end
			if(mat) then
				self.model.Entity:SetSubMaterial(mat, v)
			end
		end

		if(character:getModel():find("sky/stalker") and ANORAKTEXTURES and character:getData("anorak")) then
			local mat
			for k,v in ipairs(mats) do
				if(string.find(v, "anorak_lone")) then
					mat = k-1
					break
				end
			end
	
			self.model.Entity:SetSubMaterial(mat, ANORAKTEXTURES[character:getData("anorak")])
		end
		
		local model = character:getModel()
		if(nut.newchar and nut.newchar.isBM(model)) then
			local fem = hook.Run("CustomFemaleModel", model, LocalPlayer(), character) or model:find("female") or model:find("metroll/f")

			if(self.model.modelcache and self.model.modelcache != 0) then
				for k,v in pairs(self.model.modelcache) do
					v:Remove()
					self.model.modelcache[k] = nil --srsly it doesnt get removed from the table
				end
			end

			--get items (idk how else to do this lmao)
			local tb = {top = character:getData("gtop", 0), 
			bot = character:getData("gbot", 0), 
			customt = character:getData("gctop"), 
			customb = character:getData("gcbot"), 
			topskin = character:getData("gtopskin", 0), 
			botskin = character:getData("gbotskin", 0),
			}
			local bgs = character:getData("gbgs", {})
			if(bgs.t) then
				tb.custombgst = bgs.t
			end
			if(bgs.b) then
				tb.custombgsb = bgs.b
			end
			local subs = character:getData("gsub", {})
			if(subs.t) then
				tb.customsubt = subs.t
			end
			if(subs.b) then
				tb.customsubb = subs.b
			end

			self.model.Entity.bm = {}

			local top = ClientsideModel(tb.customt or (fem and defaultfemtop) or defaultmaletop)--, RENDERGROUP_OPAQUE)
			--top:Spawn() --spawn here if needed not sure if needed
			top:SetParent(entity)
			top:AddEffects(EF_BONEMERGE)
			top:SetNoDraw(true) --it does this so..
			top:SetBodygroup(0, tb.top)
			top:SetSkin(tb.topskin)
			self.model.Entity.bm.t = top
			
			if(tb.custombgst) then
				for k,v in pairs(tb.custombgst) do
					top:SetBodygroup(k, v)
				end
			end
			if(tb.customsubt) then
				local mats = top:GetMaterials()
				for k,v in pairs(tb.customsubt) do
					local mat
					for k2,v2 in ipairs(mats) do
						if(string.find(v2, k)) then
							mat = k2-1
						end
					end
					if(mat) then
						top:SetSubMaterial(mat, v)
					end
				end
			end

			self.model.modelcache = self.model.modelcache or {}
			table.insert(self.model.modelcache, top)

			local bot = ClientsideModel(tb.customb or (fem and defaultfembot) or defaultmalebot)--, RENDERGROUP_OPAQUE)
			--bot:Spawn() --spawn here if needed not sure if needed
			bot:SetParent(entity)
			bot:AddEffects(EF_BONEMERGE)
			bot:SetNoDraw(true) --it does this so..
			bot:SetBodygroup(0, tb.bot)
			bot:SetSkin(tb.botskin)
			self.model.Entity.bm.b = bot
			
			if(tb.custombgsb) then
				for k,v in pairs(tb.custombgsb) do
					bot:SetBodygroup(k, v)
				end
			end
			if(tb.customsubb) then
				local mats = bot:GetMaterials()
				for k,v in pairs(tb.customsubb) do
					local mat
					for k2,v2 in ipairs(mats) do
						if(string.find(v2, k)) then
							mat = k2-1
						end
					end
					if(mat) then
						bot:SetSubMaterial(mat, v)
					end
				end
			end

			self.model.modelcache = self.model.modelcache or {}
			table.insert(self.model.modelcache, bot)
			if(tb.bot == -1 || defaultbothidden == -1) then		
				bot.nodraw = true
			end
			
			--PrintTable(self.model.modelcache)
		end
	end
end

function PANEL:setBanned(banned)
	self.banned = banned
end

-- function PANEL:onHoverChanged(isHovered)
-- 	--print("isHovered: " .. tostring(isHovered))
-- 	local ANIM_SPEED = nut.gui.character.ANIM_SPEED
-- 	--if (self.isHovered == isHovered) then return end
-- 	self.isHovered = isHovered

-- 	nut.gui.character:hoverSound()
	

-- end

function PANEL:Paint(w, h)
	nut.util.drawBlur(self)
	surface.SetDrawColor(0, 0, 0, 50)
	surface.DrawRect(0, STRIP_HEIGHT, w, h)

	if (not self:isCursorWithinBounds() and self.isHovered) then
		--self:onHoverChanged(false)
	end
end

function PANEL:OnCursorEntered()
	--self:onHoverChanged(true)
end

vgui.Register("nutCharacterSlot", PANEL, "DPanel")
