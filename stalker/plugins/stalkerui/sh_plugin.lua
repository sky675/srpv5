PLUGIN.name = "Stalker UI Elements"
PLUGIN.author = "🧔 Nate"
PLUGIN.desc = "Adds a variety of stalker themed UI elements."
nut.util.include("sh_commands.lua")

if (CLIENT) then
    if (CLIENT) then
        hook.Add( "ForceDermaSkin", "stalkerSkin", function()
            return "stalker"
        end )
        
        hook.Add( "OnSpawnMenuOpen", "defaultQmenu", function()
            for _, v in ipairs( g_SpawnMenu:GetChildren() ) do
                 v:SetSkin("Default") 
            end
            for _, v in ipairs( g_SpawnMenu.ToolMenu:GetChildren() ) do
                v:SetSkin("Default") 
            end
        end )
    end
end