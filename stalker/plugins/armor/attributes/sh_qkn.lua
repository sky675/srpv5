ATTRIBUTE.name = "Quickness"
ATTRIBUTE.desc = "Affects how fast you can run and perform certain actions."

function ATTRIBUTE:onSetup(client, value)
	client:SetRunSpeed(nut.config.get("runSpeed", 235) + value)
end