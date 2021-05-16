PLUGIN.name = "plugin disabler"
PLUGIN.author = "sky"
PLUGIN.desc = "will disable plugins not needed"

local pluginstoyeet = {
	["scoreboard"] = true,
	["stamina"] = true
}

hook.Add("PluginShouldLoad", "disablescoreboard", function(id)
	if(pluginstoyeet[id]) then return false end
end)