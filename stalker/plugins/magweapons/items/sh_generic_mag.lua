ITEM.name = "Generic Magazine"
ITEM.desc = "Whatever magazine you want it to be. One time use. When dropping this item over a mag-based weapon, it will spawn a mag for that weapon."
ITEM.price = 25
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.flag = "m"
ITEM.category = "misc"


function ITEM:onCombineTo(target)
	if(target.base != "base_mweapons") then return end
	
	--local ats = target:getData("atts", {})
	local type = target.magType-- target.convMagTypes[ats[12]] or target.magType

	if(type == "notactuallyanitem" or string.find(type, "ammo_")) then return end --no


	local ply = self.player
	local item = self

	local succ = ply:getChar():getInv():add(type)
	if(!succ) then
		ply:notify("something went wrong when creating the mag, possibly doesnt exist?")
		return
	end
	item:remove()

end