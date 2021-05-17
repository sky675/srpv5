/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local PublicAddonName = "server NPCs"
local AddonName = "server NPCs"
local AddonType = "SNPC"
local AutorunFile = "autorun/vj_gs3_autorun.lua"
-------------------------------------------------------
local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua","GAME")
if VJExists == true then
	include('autorun/vj_controls.lua')
	local wepst1 = {
		"weapon_vj_css_mac10",
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_357_sky",
		"weapon_vj_smg1_sky",
		"weapon_vj_spas12_sky",
		"weapon_vj_css_ak47",
		"weapon_vj_css_elite",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
	}
	local wepst2 = {
		"weapon_vj_css_mac10",
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_357_sky",
		"weapon_vj_smg1_sky",
		"weapon_vj_spas12_sky",
		"weapon_vj_css_ak47",
		"weapon_vj_css_elite",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
	}
	local wepst3 = {
		"weapon_vj_css_mac10",
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_357_sky",
		"weapon_vj_smg1_sky",
		"weapon_vj_spas12_sky",
		"weapon_vj_css_ak47",
		"weapon_vj_css_elite",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
	}
	
	---[[
	local vCat = "Stalker Humans"
	VJ.AddNPC_HUMAN("Anorak (Neutral)","npc_vj_srp_anorak_neut", wepst1,vCat)
	VJ.AddNPC_HUMAN("Anorak (Rogue)","npc_vj_srp_anorak_rogue", wepst1,vCat)
	VJ.AddNPC_HUMAN("Anorak (Bandit)","npc_vj_srp_anorak_bandit", wepst1,vCat)
	VJ.AddNPC_HUMAN("Anorak (Duty)","npc_vj_srp_anorak_duty", wepst1,vCat)
	VJ.AddNPC_HUMAN("Anorak (Freedom)","npc_vj_srp_anorak_freedom", wepst1,vCat)
	VJ.AddNPC_HUMAN("Anorak (Merc)","npc_vj_srp_anorak_merc", wepst1,vCat)
	VJ.AddNPC_HUMAN("Anorak (Mili)","npc_vj_srp_anorak_mili", wepst1,vCat)
	VJ.AddNPC_HUMAN("Anorak (Mono)","npc_vj_srp_anorak_mono", wepst1,vCat)
	VJ.AddNPC_HUMAN("Sunrise (Neutral)","npc_vj_srp_sunrise_neut", wepst2,vCat)
	VJ.AddNPC_HUMAN("Sunrise (Bandit)","npc_vj_srp_sunrise_bandit", wepst2,vCat)
	VJ.AddNPC_HUMAN("Sunrise (Duty)","npc_vj_srp_sunrise_duty", wepst2,vCat)
	VJ.AddNPC_HUMAN("Sunrise (Freedom)","npc_vj_srp_sunrise_free", wepst2,vCat)
	VJ.AddNPC_HUMAN("Sunrise (Mono)","npc_vj_srp_sunrise_mono", wepst2,vCat)
	VJ.AddNPC_HUMAN("Berill (Freedom)","npc_vj_srp_berill_free", wepst3,vCat)
	VJ.AddNPC_HUMAN("Berill (Mili)","npc_vj_srp_berill_mili", wepst2,vCat)
	VJ.AddNPC_HUMAN("IO7A (Bandit)","npc_vj_srp_io7a_bandit", wepst2,vCat)
	VJ.AddNPC_HUMAN("IO7A (Merc)","npc_vj_srp_io7a_merc", wepst2,vCat)
	VJ.AddNPC_HUMAN("SKAT (Duty)","npc_vj_srp_skat_duty", wepst3,vCat)
	VJ.AddNPC_HUMAN("SKAT (Mili)","npc_vj_srp_skat_mili", wepst3,vCat)

	vCat = "Stalker Mutants"
	VJ.AddNPC("Boar","npc_vj_srp_m_boar",vCat)
	VJ.AddNPC("Bloodsucker","npc_vj_srp_m_bloodsucker",vCat)
	VJ.AddNPC("Chimera","npc_vj_srp_m_chimera",vCat)
	VJ.AddNPC("Dog","npc_vj_srp_m_dog",vCat)
	VJ.AddNPC("Flesh","npc_vj_srp_m_flesh",vCat)
	VJ.AddNPC("Pseudogiant","npc_vj_srp_m_pseudogiant",vCat)
	VJ.AddNPC("Pseudodog","npc_vj_srp_m_pseudodog",vCat)
	VJ.AddNPC("Psydog","npc_vj_srp_m_psydog",vCat)
	VJ.AddNPC("Rodent","npc_vj_srp_m_rat",vCat)
	VJ.AddNPC("Snork","npc_vj_srp_m_snork",vCat)
	VJ.AddNPC("Zombie","npc_vj_srp_m_zombie",vCat)
	--]]
	--[[
	local vCat = "HL2 RP" -- Category, you can also set a category individually by replacing the vCat with a string value
	VJ.AddNPC_HUMAN("Metropolice (default)","npc_vj_sky_mp", {
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
		"weapon_vj_spas12_sky",
	},vCat)
	VJ.AddNPC_HUMAN("Metropolice (storm)","npc_vj_sky_mp_storm", {
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
		"weapon_vj_spas12_sky",
		"weapon_vj_css_ump",
	},vCat)
	VJ.AddNPC_HUMAN("Metropolice (helix)","npc_vj_sky_mp_helix", {
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
		"weapon_vj_spas12_sky",
	},vCat)
	VJ.AddNPC_HUMAN("Citizen (hostile)","npc_vj_sky_citizen", {
		--"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
		--"weapon_vj_spas12_sky",
	},vCat)
	VJ.AddNPC_HUMAN("Rebel (hostile)","npc_vj_sky_rebel", {
		"weapon_vj_css_mac10",
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
		"weapon_vj_spas12_sky",
	},vCat)
	]]
	--[[
	local vCat = "OASIS" -- Category, you can also set a category individually by replacing the vCat with a string value
	VJ.AddNPC_HUMAN("Bandit","npc_vj_gsbandit", {
		"weapon_vj_css_mac10",
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_357_sky",
		"weapon_vj_smg1_sky",
		"weapon_vj_spas12_sky",
		"weapon_vj_css_ak47",
		"weapon_vj_css_elite",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
	},vCat)
	VJ.AddNPC_HUMAN("Bandit (Neutral)","npc_vj_gsbandit_neut", {
		"weapon_vj_css_mac10",
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_357_sky",
		"weapon_vj_smg1_sky",
		"weapon_vj_spas12_sky",
		"weapon_vj_css_ak47",
		"weapon_vj_css_elite",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
	},vCat)
	VJ.AddNPC_HUMAN("Bandit (2)","npc_vj_gsbandit2", {
		"weapon_vj_css_mac10",
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_357_sky",
		"weapon_vj_smg1_sky",
		"weapon_vj_spas12_sky",
		"weapon_vj_css_ak47",
		"weapon_vj_css_elite",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
	},vCat)
	VJ.AddNPC_HUMAN("Bandit (2) (Neutral)","npc_vj_gsbandit2_neut", {
		"weapon_vj_css_mac10",
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_357_sky",
		"weapon_vj_smg1_sky",
		"weapon_vj_spas12_sky",
		"weapon_vj_css_ak47",
		"weapon_vj_css_elite",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
	},vCat)
	VJ.AddNPC_HUMAN("SectCom (patrol)","npc_vj_sec_normal", {
		"weapon_vj_css_ump",
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_css_elite",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
		"weapon_vj_spas12_sky",
	},vCat) -- Adds a NPC to the spawnmenu but with a list of weapons it spawns with
	VJ.AddNPC_HUMAN("SectCom (neutral)","npc_vj_sec_normal_neut",{
		"weapon_vj_css_ump",
		"weapon_vj_css_mp5",
		"weapon_vj_9mmpistol_sky",
		"weapon_vj_css_elite",
		"weapon_vj_css_glock",
		"weapon_vj_css_p228",
		"weapon_vj_css_usp",
		"weapon_vj_spas12_sky",
	},vCat)
	VJ.AddNPC_HUMAN("SectCom (assault)","npc_vj_sec_cqb", {
		"weapon_vj_css_ump",
		"weapon_vj_css_sig552",
		"weapon_vj_css_m3super",
		"weapon_vj_css_famas",
		"weapon_vj_css_galil"
	},vCat)
	VJ.AddNPC_HUMAN("SectCom (grenadier)","npc_vj_sec_gren", {
		"weapon_vj_css_ump",
		"weapon_vj_css_m3super",
		"weapon_vj_css_famas",
	},vCat)
	VJ.AddNPC_HUMAN("SectCom (medic)","npc_vj_sec_medic", {
		"weapon_vj_css_mp5",
		"weapon_vj_css_sig552",
		"weapon_vj_css_m3super",
		"weapon_vj_css_galil"
	},vCat)
	VJ.AddNPC_HUMAN("SectCom (sniper)","npc_vj_sec_sniper", {
		"weapon_vj_css_scout",
	},vCat) -- Adds a NPC to the spawnmenu but with a list of weapons it spawns with
	VJ.AddNPC_HUMAN("Saitama Swat","npc_vj_saitama_swat",{
		"weapon_vj_css_m4a1",
		"weapon_vj_css_tmp",
		"weapon_vj_css_para",
		"weapon_vj_css_xm1014",
		"weapon_vj_css_aug"
	},vCat)
	VJ.AddNPC_HUMAN("Saitama Swat (Grenadier)","npc_vj_saitama_swat_gren",{
		"weapon_vj_css_m4a1",
		"weapon_vj_css_tmp",
		"weapon_vj_css_xm1014",
		"weapon_vj_css_aug"
	},vCat)
	VJ.AddNPC_HUMAN("Saitama Swat (Medic)","npc_vj_saitama_swat_medic",{
		"weapon_vj_css_m4a1",
		"weapon_vj_css_tmp",
		"weapon_vj_css_mp5",
		"weapon_vj_css_xm1014",
		"weapon_vj_css_aug"
	},vCat)
	VJ.AddNPC_HUMAN("Reaper","npc_vj_reaper",{
		"weapon_vj_ar2",
	},vCat)]] -- Adds a NPC to the spawnmenu but with a list of weapons it spawns with
		-- Parameters:
			-- First is the name, second is the class name
			-- Third is a table of weapon, the base will pick a random one from the table and give it to the SNPC when "Default Weapon" is selected
			-- Fourth is the category that it should be in
			-- Fifth is optional, which is a boolean that defines whether or not it's an admin-only entity

			VJ.AddWeapon("SCOUT","weapon_vj_css_scout",false,vCat)
			VJ.AddWeapon("XM1014","weapon_vj_css_xm1014",false,vCat)										
			VJ.AddWeapon("UMP","weapon_vj_css_ump",false,vCat)
			VJ.AddWeapon("AUG","weapon_vj_css_aug",false,vCat)										
			VJ.AddWeapon("SIG552","weapon_vj_css_sig552",false,vCat)										
			VJ.AddWeapon("MP5","weapon_vj_css_mp5",false,vCat)										
			VJ.AddWeapon("AWP","weapon_vj_css_awp",false,vCat)										
			VJ.AddWeapon("Galil","weapon_vj_css_galil",false,vCat)										
			VJ.AddWeapon("P90","weapon_vj_css_p90",false,vCat)										
			VJ.AddWeapon("SIG550","weapon_vj_css_sig550",false,vCat)										
			VJ.AddWeapon("FAMAS","weapon_vj_css_famas",false,vCat)
			VJ.AddWeapon("M3-SUPER","weapon_vj_css_m3super",false,vCat)	
			VJ.AddWeapon("G3/SG-1","weapon_vj_css_g3",false,vCat)
			VJ.AddWeapon("TMP","weapon_vj_css_tmp",false,vCat)										
			VJ.AddWeapon("MAC10","weapon_vj_css_mac10",false,vCat)											
			VJ.AddWeapon("PARA","weapon_vj_css_para",false,vCat)
			VJ.AddWeapon("AK47","weapon_vj_css_ak47",false,vCat)											
			VJ.AddWeapon("M4A1","weapon_vj_css_m4a1",false,vCat)
			VJ.AddNPCWeapon("VJ_CSS_M4A1","weapon_vj_css_m4a1") -- Add a weapon for NPCs to use
			VJ.AddNPCWeapon("VJ_CSS_AK47","weapon_vj_css_ak47") -- Add a weapon for NPCs to use	
			VJ.AddNPCWeapon("VJ_CSS_MAC10","weapon_vj_css_mac10") -- Add a weapon for NPCs to use
			VJ.AddNPCWeapon("VJ_CSS_TMP","weapon_vj_css_tmp") -- Add a weapon for NPCs to use											
			VJ.AddNPCWeapon("VJ_CSS_PARA","weapon_vj_css_para") -- Add a weapon for NPCs to use											
			VJ.AddNPCWeapon("VJ_CSS_G3","weapon_vj_css_g3") -- Add a weapon for NPCs to use									
			VJ.AddNPCWeapon("VJ_CSS_M3","weapon_vj_css_m3super") -- Add a weapon for NPCs to use											
			VJ.AddNPCWeapon("VJ_CSS_FAMAS","weapon_vj_css_famas") -- Add a weapon for NPCs to use	
			VJ.AddNPCWeapon("VJ_CSS_SIG550","weapon_vj_css_sig550") -- Add a weapon for NPCs to use	
			VJ.AddNPCWeapon("VJ_CSS_P90","weapon_vj_css_p90") -- Add a weapon for NPCs to use	
			VJ.AddNPCWeapon("VJ_CSS_Galil","weapon_vj_css_galil") -- Add a weapon for NPCs to use	
			VJ.AddNPCWeapon("VJ_CSS_AWP","weapon_vj_css_awp") -- Add a weapon for NPCs to use	
			VJ.AddNPCWeapon("VJ_CSS_MP5","weapon_vj_css_mp5") -- Add a weapon for NPCs to use	
			VJ.AddNPCWeapon("VJ_CSS_SIG552","weapon_vj_css_sig552") -- Add a weapon for NPCs to use	
			VJ.AddNPCWeapon("VJ_CSS_AUG","weapon_vj_css_aug") -- Add a weapon for NPCs to use										
			VJ.AddNPCWeapon("VJ_CSS_UMP","weapon_vj_css_ump") -- Add a weapon for NPCs to use
			VJ.AddNPCWeapon("VJ_CSS_Scout","weapon_vj_css_scout") -- Add a weapon for NPCs to use
			VJ.AddNPCWeapon("VJ_CSS_XM1014","weapon_vj_css_xm1014") -- Add a weapon for NPCs to use
														
			VJ.AddWeapon("9MM","weapon_vj_9mmpistol_sky",false,vCat)
			VJ.AddNPCWeapon("VJ_9MMPISTOL_EDIT","weapon_vj_9mmpistol_sky")
			VJ.AddWeapon("357","weapon_vj_357_sky",false,vCat)
			VJ.AddNPCWeapon("VJ_357_EDIT","weapon_vj_357_sky")
			VJ.AddWeapon("ELITE","weapon_vj_css_elite",false,vCat)
			VJ.AddNPCWeapon("VJ_CSS_ELITE","weapon_vj_css_elite")
			VJ.AddWeapon("GLOCK","weapon_vj_css_glock",false,vCat)
			VJ.AddNPCWeapon("VJ_CSS_GLOCK","weapon_vj_css_glock")
			VJ.AddWeapon("P228","weapon_vj_css_p228",false,vCat)
			VJ.AddNPCWeapon("VJ_CSS_P228","weapon_vj_css_p228")
			VJ.AddWeapon("USP","weapon_vj_css_usp",false,vCat)
			VJ.AddNPCWeapon("VJ_CSS_USP","weapon_vj_css_usp")
			VJ.AddWeapon("SMG1","weapon_vj_smg1_sky",false,vCat)
			VJ.AddNPCWeapon("VJ_SMG1_EDIT","weapon_vj_smg1_sky")
			VJ.AddWeapon("SPAS12","weapon_vj_spas12_sky",false,vCat)
			VJ.AddNPCWeapon("VJ_SPAS12_EDIT","weapon_vj_spas12_sky")


-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile(AutorunFile)
	VJ.AddAddonProperty(AddonName,AddonType)
else
	if (CLIENT) then
		chat.AddText(Color(0,200,200),PublicAddonName,
		Color(0,255,0)," was unable to install, you are missing ",
		Color(255,100,0),"VJ Base!")
	end
	--[[timer.Simple(1,function()
		if not VJF then
			if (CLIENT) then
				VJF = vgui.Create("DFrame")
				VJF:SetTitle("ERROR!")
				VJF:SetSize(790,560)
				VJF:SetPos((ScrW()-VJF:GetWide())/2,(ScrH()-VJF:GetTall())/2)
				VJF:MakePopup()
				VJF.Paint = function()
					draw.RoundedBox(8,0,0,VJF:GetWide(),VJF:GetTall(),Color(200,0,0,150))
				end
				
				local VJURL = vgui.Create("DHTML",VJF)
				VJURL:SetPos(VJF:GetWide()*0.005, VJF:GetTall()*0.03)
				VJURL:Dock(FILL)
				VJURL:SetAllowLua(true)
				VJURL:OpenURL("https://sites.google.com/site/vrejgaming/vjbasemissing")
			elseif (SERVER) then
				timer.Create("VJBASEMissing",5,0,function() print("VJ Base is Missing! Download it from the workshop!") end)
			end
		end
	end)]]
end