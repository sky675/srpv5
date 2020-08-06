ITEM.name = "Bleach"
ITEM.desc = "Cleaning solution often used for disinfecting surfaces."
ITEM.price = 5
ITEM.weight = 3
ITEM.model = "models/props_junk/garbage_plasticbottle001a.mdl"
--ITEM.category = "Other"
ITEM.functions.Drink = {
	sound = "npc/barnacle/barnacle_gulp2.wav",
	onRun = function(item)
		local player = item.player;
		timer.Create("nutBleach"..item:getID(), 5, 1, function()
			player:Kill()
		end)
	end,
	onCanRun = function(item)
		return !IsValid(item.entity)
	end
}
ITEM.flag = "J"