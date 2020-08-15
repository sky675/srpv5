ITEM.name = "Camera Controller"
ITEM.model = "models/props_junk/PopCan01a.mdl"
ITEM.desc = "view placed special ent cameras (todo)"
ITEM.category = "misc"
ITEM.flag = "m"
ITEM.width = 1
ITEM.height = 1

--todo: change model
--funcs: set camera circuit id (text), and 
--func to switch to camera operating

ITEM.functions.toggle = {
    name = "Activate",
    tip = "turn off/on",
    icon = "icon16/drive_edit.png",
	onRun = function(item)
		netstream.Start(item.player, "camsStart")

        return false
    end,
	onCanRun = function(item)
		return !IsValid(item.entity)
        --[[local char
        if(item.player) then
            char = item.player:getChar()
        else
            char = LocalPlayer():getChar()
        end

        return char:hasFlags("Z")]]
    end
}