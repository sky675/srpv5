local PLUGIN = PLUGIN
PLUGIN.name = "Stalker Intro"
PLUGIN.author = "🧔 Nate"
PLUGIN.desc = "Stalker themed video intro."

nut.config.add("introEnabled", true, "Whether or not intro is enabled.", nil, {
	category = PLUGIN.name
})

nut.config.add("playIntroOnlyOnce", true, "Whether the intro, if enabled, should play every time, or only on first join", nil, {
	category = PLUGIN.name
})

if (CLIENT) then

	function PLUGIN:CreateIntroduction()
		if (nut.config.get("introEnabled")) then
			return vgui.Create("nutIntro")
		end
	end
end
