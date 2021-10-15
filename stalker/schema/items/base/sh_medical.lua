
ITEM.name = "Medical Stuff"
ITEM.model = "models/healthvial.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "A Medical Stuff"
ITEM.healAmount = 50
ITEM.healSeconds = 10
ITEM.category = "Medical"

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
	amount = math.abs(amount)
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
local function radPlayer(client, amount, seconds, itemid)
	local neg = amount < 0
	amount = math.abs(amount)
	if (client:Alive()) then
		local id = "nutRad_"..itemid..CurTime() --why did this use frametime before wtf
		timer.Create(id, (seconds/amount), amount, function() --changed it to repeat whenever 1 should be added, the other way wasnt working with slow heals (as in less than 1 per rep)
			if (!client:IsValid() or !client:Alive()) then
				timer.Destroy(id)	
			end

			client:getChar():addRad(neg and -1 or 1)
		end)
	end
end

function ITEM:getDesc()
	local str = self.desc
	if(self.uses) then
    local ammo = tostring(self:getData("uses", self.uses))

	str = str..(str != "" and "\n" or "")..ammo.." out of "..tostring(self.uses or 1).." uses left."
	end

    return str
end

function ITEM:getWeight()
	--for multiuse items, the weight is per use
    return self.uses and self.weight*self:getData("uses", self.uses) or self.weight
end
function ITEM:calcPrice(origprice)
	local price = origprice

	local mag = self:getData("uses")
	if(mag) then
		price = price * (mag/self.uses)
	end

	return price
end

if (CLIENT) then
	function ITEM:paintOver(item, w, h)
		if(item.uses) then
		draw.SimpleText(item:getData("uses", item.uses).."/"..item.uses, "DermaDefault", w - 5 , h - 5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
		end
	end
end
--[[
local function onUse(item)
	item.player:EmitSound("items/medshot4.wav", 80, 110)
	item.player:ScreenFade(1, Color(0, 255, 0, 100), .4, 0)
end

ITEM:hook("use", onUse)
ITEM:hook("usef", onUse)
]]
// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.use = { -- sorry, for name order.
	name = "Use",
	tip = "useTip",
	icon = "icon16/add.png",
	onRun = function(item)
		local client = item.player
		if (item.player:Alive()) then
			if(item.skillval and (nut.traits.hasTrait(item.player, "tech_med") or 0) < item.skillval) then
				item.player:notify("You don't meet trait requirements for this item!", 3)
				return false
			end
			local char = client:getChar()

			local val = item.useTime or 1
			
			val = val * nut.traits.getMod(client, "actiontime")

			client:setAction("Using...", val, function(client)
			if(client:Alive() and !client:getNetVar("neardeath") and item:getOwner() == client) then
			healPlayer(client, client, item.healAmount, item.healSeconds, item:getID())
			if(item.bleedStop and item.bleedStop != 1) then
				hook.Run("ReduceBleed", client:getChar(), item.bleedStop)
			end
			if(item.healLeg) then
				timer.Create("healLeg_"..client:SteamID(), item.legSec or 30, 1, function()
					if(client:getChar():getData("leghit")) then
						client:getChar():setData("leghit", nil, nil, player.GetAll())
						client:notify("You appear to be able to run again.")
					end
				end)
			end
			if(item.customUse) then
				item:customUse(char)
			end
			if(item.hungerAmt) then
			char:SetHunger(math.Clamp(char:GetHunger()+item.hungerAmt, 0, 100))
			end
			if(item.thirstAmt) then
			char:SetThirst(math.Clamp(char:GetThirst()+item.thirstAmt, 0, 100))
			end
			if(item.regenStam) then
				stamPlayer(client, item.regenStam[1], item.regenStam[2], item.id)
			end
			--artifact radiation support
			if(char.addRad and item.radGive) then
				if(item.radGiveTime) then
					radPlayer(client, item.radGive, item.radGiveTime, item.id)
				else
					char:addRad(item.radGive)
				end
			end
			if(item.uses) then
				if(item:getData("uses", item.uses) == 1) then
					item:remove()
					return false
				else
					item:setData("uses", item:getData("uses", item.uses)-1)
					return false
				end
			end
			item:remove()
			end
			end)
		end
		return false
	end,
	onCanRun = function(item)
		return !IsValid(item.entity) and !item.reviveOnly
	end
}

// On player uneqipped the item, Removes a weapon from the player and keep the ammo in the item.
ITEM.functions.usef = { -- sorry, for name order.
	name = "Give",
	tip = "useTip",
	icon = "icon16/arrow_up.png",
	onRun = function(item)
		local client = item.player
		local trace = client:GetEyeTraceNoCursor() -- We don't need cursors.
		local faketarget = trace.Entity
		local target = faketarget
		
		if(item.skillval and (nut.traits.hasTrait(item.player, "tech_med") or 0) < item.skillval) then
			item.player:notify("You don't meet trait requirements for this item!", 3)
			return false
		end
		local val = item.useTimeGive or (item.useTime*2) or 2
		
		val = val * nut.traits.getMod(client, "actiontime")

		client:setAction("Using...")
		if(faketarget:getNetVar("player")) then
			target = faketarget:getNetVar("player")
		end
		client:doStaredAction(target, function()
			if(!client:Alive() or client:getNetVar("neardeath") or item:getOwner() != client) then return end
			if(faketarget:getNetVar("player")) then
				local ply = faketarget:getNetVar("player")
				if(ply:IsValid()) then
				--if(item.canRevive) then --dont think ill ever do this again but just in case
					if(item.canRevive and ply:getNetVar("canrevive")) then
						client:setAction("Reviving", 10, function()
							ply:setRagdolled(false)
							ply:setNetVar("neardeath", nil)
							ply:setNetVar("startdown", nil)
							ply:setNetVar("canrevive", nil)
							ply:setNetVar("canscirevive", nil)
							ply:setNetVar("canplatrevive", nil)
							ply:SetNoTarget(false) --so npcs stop attacking
							ply:SetHealth(15)
							ply:setAction()
							nut.traits.addXp(client, "tech_med", 25)
						end)

						item:remove()
						return
					elseif(item.sciRevive and ply:getNetVar("canscirevive")) then
						client:setAction("Reviving", 10, function()
							ply:setRagdolled(false)
							ply:setNetVar("neardeath", nil)
							ply:setNetVar("startdown", nil)
							ply:setNetVar("canrevive", nil)
							ply:setNetVar("canscirevive", nil)
							ply:setNetVar("canplatrevive", nil)
							ply:SetNoTarget(false) --so npcs stop attacking
							ply:SetHealth(45)
							ply:setAction()
							nut.traits.addXp(client, "tech_med", 25)
						end)

						item:remove()
						return
					elseif(item.platRevive and ply:getNetVar("canplatrevive")) then
						client:setAction("Reviving", 10, function()
							ply:setRagdolled(false)
							ply:setNetVar("neardeath", nil)
							ply:setNetVar("startdown", nil)
							ply:setNetVar("canrevive", nil)
							ply:setNetVar("canscirevive", nil)
							ply:setNetVar("canplatrevive", nil)
							ply:SetNoTarget(false) --so npcs stop attacking
							ply:SetHealth(75)
							ply:setAction()
							nut.traits.addXp(client, "tech_med", 25)
						end)
						item:remove()
						return 
					else
						client:notify("You cannot revive this person.", 3)
					end
			--end
				end
			end

			if (target and target:IsValid() and target:IsPlayer() and target:Alive() and !target:getNetVar("neardeath") and !item.reviveOnly) then
				local char = target:getChar()
				healPlayer(client, target, item.healAmount, item.healSeconds, item:getID())
				if(item.bleedStop and item.bleedStop != 1) then --1 is the same so ignore
					hook.Run("ReduceBleed", client:getChar(), item.bleedStop)
				end
				if(item.healLeg) then
					timer.Create("healLeg_"..target:SteamID(), item.legSec or 30, 1, function()
						if(target:getChar():getData("leghit")) then
							target:getChar():setData("leghit", nil, nil, player.GetAll())
							target:notify("You appear to be able to run again.")
						end
					end)
				end
				if(item.customUse) then
					item:customUse(char)
				end
				if(item.hungerAmt) then
				char:SetHunger(math.Clamp(char:GetHunger()+item.hungerAmt, 0, 100))
				end
				if(item.thirstAmt) then
				char:SetThirst(math.Clamp(char:GetThirst()+item.thirstAmt, 0, 100))
				end
				if(item.regenStam) then
					stamPlayer(target, item.regenStam[1], item.regenStam[2], item.id)
				end
				--artifact radiation support
				if(char.addRad and item.radGive) then
					if(item.radGiveTime) then
						radPlayer(target, item.radGive, item.radGiveTime, item.id)
					else
						char:addRad(item.radGive)
					end
				end
				if(item.uses) then
					if(item:getData("uses", item.uses) == 1) then
						item:remove()
						return false
					else
						item:setData("uses", item:getData("uses", item.uses)-1)
						return false
					end
				end
				item:remove()
				return
			end
		end, val, function()
			client:setAction()
		end)

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}