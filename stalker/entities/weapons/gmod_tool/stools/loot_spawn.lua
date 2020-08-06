TOOL.Category = "OASIS"
TOOL.Name = "Loot Spawn Creator"

TOOL.ClientConVar["tableid"] = ""
TOOL.ClientConVar["detection"] = "600"

if CLIENT then
    language.Add("tool.loot_spawn.name", "Loot Spawn Creator")
    language.Add("tool.loot_spawn.desc", "Add loot spawns.")
    language.Add("tool.loot_spawn.0", "Left Click: Add specified table with specified detection radius, Right Click: Show spawns in ESP.")
end

function TOOL:LeftClick(tr)
    if CLIENT then return true end
    if !tr.Hit or tr.HitSky then return end
	if !self:GetOwner():IsAdmin() then return end
	
	if(nut.plugin.list["loot"].lootTables[self:GetClientInfo("tableid")]) then
		nut.command.run(self:GetOwner(), "lootspawn", {self:GetClientInfo("tableid"), self:GetClientNumber("detection")})
	end

    return true
end

function TOOL:RightClick(tr)
    if CLIENT then return true end
    if !tr.Hit or tr.HitSky then return end
    if !self:GetOwner():IsAdmin() then return end

	nut.command.run(self:GetOwner(), "lootshow")

    return true
end

function TOOL.BuildCPanel(control)
    control:TextEntry("Table ID", "loot_spawn_tableid")
    control:NumSlider("Detection Range", "loot_spawn_detection", 5,5000)
end