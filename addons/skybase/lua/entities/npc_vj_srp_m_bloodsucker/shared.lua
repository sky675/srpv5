ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Bloodsucker - Adult"
ENT.Author 			= "WickedRabbit"
ENT.Purpose 		= "Bloodsucker Aduld!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "S.T.A.L.K.E.R"

if (CLIENT) then
local Name = "Bloodsucker - Adult"
local LangName = "npc_wick_mutant_bloodsucker_adult"
language.Add(LangName, Name)
killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end