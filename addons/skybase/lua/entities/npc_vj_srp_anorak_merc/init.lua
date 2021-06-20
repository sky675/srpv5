AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {
	"models/sky/npcs/female_01.mdl",
	"models/sky/npcs/female_02.mdl",
	"models/sky/npcs/female_03.mdl",
	"models/sky/npcs/female_04.mdl",
	"models/sky/npcs/female_05.mdl",
	"models/sky/npcs/female_06.mdl",
	"models/sky/npcs/female_07.mdl",
	"models/sky/npcs/female_08.mdl",
	"models/sky/npcs/female_09.mdl",
	"models/sky/npcs/female_10.mdl",
	"models/sky/npcs/female_11.mdl",
	"models/sky/npcs/female_12.mdl",
	"models/sky/npcs/female_13.mdl",
	"models/sky/npcs/female_14.mdl",
	"models/sky/npcs/female_15.mdl",
	"models/sky/npcs/female_16.mdl",
	"models/sky/npcs/female_17.mdl",
	"models/sky/npcs/female_18.mdl",
	"models/sky/npcs/female_19.mdl",
	"models/sky/npcs/female_20.mdl",
	"models/sky/npcs/female_21.mdl",
	"models/sky/npcs/female_22.mdl",
	"models/sky/npcs/female_23.mdl",
	"models/sky/npcs/male_01.mdl",
	"models/sky/npcs/male_02.mdl",
	"models/sky/npcs/male_03.mdl",
	"models/sky/npcs/male_04.mdl",
	"models/sky/npcs/male_05.mdl",
	"models/sky/npcs/male_06.mdl",
	"models/sky/npcs/male_07.mdl",
	"models/sky/npcs/male_08.mdl",
	"models/sky/npcs/male_09.mdl",
	"models/sky/npcs/male_10.mdl",
	"models/sky/npcs/male_11.mdl",
	"models/sky/npcs/male_12.mdl",
	"models/sky/npcs/male_13.mdl",
	"models/sky/npcs/male_14.mdl",
	"models/sky/npcs/male_15.mdl",
	"models/sky/npcs/male_16.mdl",
	"models/sky/npcs/male_17.mdl",
	"models/sky/npcs/male_18.mdl",
	"models/sky/npcs/male_19.mdl",
	"models/sky/npcs/male_20.mdl",
	"models/sky/npcs/male_21.mdl",
	"models/sky/npcs/male_22.mdl",
	"models/sky/npcs/male_23.mdl",
	"models/sky/npcs/male_24.mdl",
	"models/sky/npcs/male_25.mdl",
	"models/sky/npcs/male_26.mdl",
	"models/sky/npcs/male_27.mdl",
	"models/sky/npcs/male_28.mdl",
	"models/sky/npcs/male_29.mdl",
	"models/sky/npcs/male_30.mdl",
	"models/sky/npcs/male_31.mdl",
	"models/sky/npcs/male_32.mdl",
	"models/sky/npcs/male_33.mdl",
	"models/sky/npcs/male_34.mdl",
	"models/sky/npcs/male_35.mdl",
} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want

ENT.StartHealth = 50--80
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
ENT.HullSizeNormal = false -- set to false to cancel out the self:SetHullSizeNormal()
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_MERC"} 
ENT.DropWeaponOnDeath = false -- Should it drop its weapon on death?
ENT.HasBloodPool = false
ENT.HasItemDropsOnDeath = false -- Should it drop items on death?
ENT.FadeCorpse = true -- Fades the ragdoll on death
ENT.FadeCorpseTime = 180 -- How much time until the ragdoll fades | Unit = Seconds
ENT.Bleeds = true -- Does the SNPC bleed? (Blood decal, particle and etc.)
ENT.BloodParticle = "blood_impact_red_01" -- Particle that the SNPC spawns when it's damaged
ENT.BloodDecal = "Blood" -- (Red = Blood) (Yellow Blood = YellowBlood) | Leave blank for none
ENT.BloodDecalRate = 1000 -- The more the number is the more chance is has to spawn | 1000 is a good number for yellow blood, for red blood 500 is good | Make the number smaller if you are using big decal like Antlion Splat, Which 5 or 10 is a really good number for this stuffa good number for yellow blood, for red blood 500 is good | Make the number smaller if you are using big decal like Antlion Splat, Which 5 or 10 is a really good number for this stuff
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.MeleeAttackDamage = 20
ENT.AnimTbl_MeleeAttack = {"MeleeAttack01"}
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.SquadName = "merc" -- Squad name, console error will happen if two groups that are enemy and try to squad!
ENT.HasGrenadeAttack = false -- Should the SNPC have a grenade attack?

ENT.IsMedicSNPC = true -- Is this SNPC a medic? Does it heal other friendly friendly SNPCs, and players(If friendly)
ENT.AnimTbl_Medic_GiveHealth = {"Heal"} -- Animations is plays when giving health to an ally
ENT.Medic_SpawnPropOnHealModel = "models/sky/items/bandage.mdl"
ENT.Medic_CheckDistance = 400 -- How far does it check for allies that are hurt? | World units
ENT.Medic_HealDistance = 100 -- How close does it have to be until it stops moving and heals its ally?
ENT.Medic_HealthAmount = 15 -- How health does it give?
ENT.Medic_NextHealTime1 = 20 -- How much time until it can give health to an ally again | First number in the math.random
ENT.Medic_NextHealTime2 = 65 -- How much time until it can give health to an ally again | Second number in the math.random


ENT.WeaponSpread = 1.6
ENT.Weapon_FiringDistanceFar = 4500 

	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 12 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/metropolice/gear1.wav","npc/metropolice/gear2.wav","npc/metropolice/gear3.wav","npc/metropolice/gear4.wav","npc/metropolice/gear5.wav","npc/metropolice/gear6.wav",}
ENT.SoundTbl_Idle = {
	

}
ENT.SoundTbl_CombatIdle = {
	"npcs/stalkervoices/bandit/tolls_1.ogg",
	"npcs/stalkervoices/bandit/tolls_2.ogg",
	"npcs/stalkervoices/bandit/tolls_3.ogg",
	"npcs/stalkervoices/bandit/tolls_4.ogg",
	"npcs/stalkervoices/bandit/tolls_5.ogg",
	"npcs/stalkervoices/bandit/attack_1.ogg",
	"npcs/stalkervoices/bandit/attack_2.ogg",
	"npcs/stalkervoices/bandit/attack_6.ogg",
	"npcs/stalkervoices/bandit/attack_7.ogg",
	"npcs/stalkervoices/bandit/attack_9.ogg",
	"npcs/stalkervoices/bandit/attack_12.ogg",
	"npcs/stalkervoices/bandit/attack_13.ogg",
	"npcs/stalkervoices/bandit/attack_15.ogg",
	"npcs/stalkervoices/bandit/attack_16.ogg",
	"npcs/stalkervoices/bandit/attack_18.ogg",

}
ENT.SoundTbl_Investigate = {
	"npcs/stalkervoices/bandit/search_1.ogg",
	"npcs/stalkervoices/bandit/search_2.ogg",
	"npcs/stalkervoices/bandit/search_3.ogg",
	"npcs/stalkervoices/bandit/search_4.ogg",
	"npcs/stalkervoices/bandit/search_5.ogg",
	"npcs/stalkervoices/bandit/search_6.ogg",
	"npcs/stalkervoices/bandit/search_7.ogg",
	"npcs/stalkervoices/bandit/search_8.ogg",
	"npcs/stalkervoices/bandit/search_9.ogg",
	"npcs/stalkervoices/bandit/search_10.ogg",
	"npcs/stalkervoices/bandit/search_12.ogg",
	"npcs/stalkervoices/bandit/search_16.ogg",
	"npcs/stalkervoices/bandit/search_18.ogg",
	"npcs/stalkervoices/bandit/search_20.ogg",
}
ENT.SoundTbl_Alert = {
	"npcs/stalkervoices/bandit/enemy_1.ogg",
	"npcs/stalkervoices/bandit/enemy_2.ogg",
	"npcs/stalkervoices/bandit/enemy_3.ogg",
	"npcs/stalkervoices/bandit/enemy_4.ogg",
	"npcs/stalkervoices/bandit/enemy_5.ogg",
	"npcs/stalkervoices/bandit/enemy_6.ogg",
	"npcs/stalkervoices/bandit/enemy_7.ogg",
	"npcs/stalkervoices/bandit/enemy_8.ogg",
	"npcs/stalkervoices/bandit/enemy_9.ogg",
	"npcs/stalkervoices/bandit/enemy_10.ogg",
	"npcs/stalkervoices/bandit/enemy_11.ogg",
	"npcs/stalkervoices/bandit/enemy_12.ogg",
	"npcs/stalkervoices/bandit/enemy_13.ogg",
	"npcs/stalkervoices/bandit/enemy_14.ogg",
	"npcs/stalkervoices/bandit/enemy_15.ogg",
	"npcs/stalkervoices/bandit/enemy_16.ogg",
	"npcs/stalkervoices/bandit/attack_3.ogg",
	"npcs/stalkervoices/bandit/attack_9.ogg",
	"npcs/stalkervoices/bandit/attack_11.ogg",
	"npcs/stalkervoices/bandit/attack_12.ogg",
	"npcs/stalkervoices/bandit/attack_15.ogg",
}
ENT.SoundTbl_Suppressing = {
	"npcs/stalkervoices/bandit/cover_fire_1.ogg",
	"npcs/stalkervoices/bandit/cover_fire_2.ogg",
	"npcs/stalkervoices/bandit/cover_fire_3.ogg",
	"npcs/stalkervoices/bandit/cover_fire_4.ogg",
	"npcs/stalkervoices/bandit/cover_fire_5.ogg",
	"npcs/stalkervoices/bandit/cover_fire_6.ogg",
	"npcs/stalkervoices/bandit/cover_fire_7.ogg",
	"npcs/stalkervoices/bandit/cover_fire_8.ogg",
	"npcs/stalkervoices/bandit/cover_fire_9.ogg",
	"npcs/stalkervoices/bandit/cover_fire_10.ogg",
	"npcs/stalkervoices/bandit/attack_7.ogg",
	"npcs/stalkervoices/bandit/attack_9.ogg",
	"npcs/stalkervoices/bandit/attack_13.ogg",
	"npcs/stalkervoices/bandit/attack_16.ogg",

}
ENT.SoundTbl_GrenadeAttack = {
	"npcs/stalkervoices/bandit/grenade_ready_1.ogg",
	"npcs/stalkervoices/bandit/grenade_ready_2.ogg",
	"npcs/stalkervoices/bandit/grenade_ready_3.ogg",
	"npcs/stalkervoices/bandit/grenade_ready_4.ogg",
	"npcs/stalkervoices/bandit/grenade_ready_5.ogg",
	"npcs/stalkervoices/bandit/grenade_ready_6.ogg",
	"npcs/stalkervoices/bandit/grenade_ready_7.ogg",
}
ENT.SoundTbl_OnGrenadeSight = {
	"npcs/stalkervoices/bandit/grenade_1.ogg",
	"npcs/stalkervoices/bandit/grenade_2.ogg",
	"npcs/stalkervoices/bandit/grenade_3.ogg",
}

ENT.SoundTbl_CallForHelp = {
	"npcs/stalkervoices/bandit/backup_1.ogg",
	"npcs/stalkervoices/bandit/backup_2.ogg",
	"npcs/stalkervoices/bandit/backup_3.ogg",
	"npcs/stalkervoices/bandit/backup_4.ogg",
	"npcs/stalkervoices/bandit/backup_5.ogg",
	"npcs/stalkervoices/bandit/backup_6.ogg",

}
ENT.SoundTbl_Pain = {
	"npcs/stalkervoices/bandit/hit_1.ogg",
	"npcs/stalkervoices/bandit/hit_2.ogg",
	"npcs/stalkervoices/bandit/hit_3.ogg",
	"npcs/stalkervoices/bandit/hit_4.ogg",
	"npcs/stalkervoices/bandit/hit_5.ogg",
	"npcs/stalkervoices/bandit/hit_6.ogg",
	"npcs/stalkervoices/bandit/hit_7.ogg",
	"npcs/stalkervoices/bandit/hit_8.ogg",
	"npcs/stalkervoices/bandit/hit_9.ogg",
	"npcs/stalkervoices/bandit/hit_10.ogg",
	"npcs/stalkervoices/bandit/hit_11.ogg",
	"npcs/stalkervoices/bandit/hit_12.ogg",
}
ENT.SoundTbl_Death = {
	"npcs/stalkervoices/bandit/death_1.ogg",
	"npcs/stalkervoices/bandit/death_2.ogg",
	"npcs/stalkervoices/bandit/death_3.ogg",
	"npcs/stalkervoices/bandit/death_4.ogg",
	"npcs/stalkervoices/bandit/death_5.ogg",
	"npcs/stalkervoices/bandit/death_6.ogg",
	"npcs/stalkervoices/bandit/death_7.ogg",
	"npcs/stalkervoices/bandit/death_8.ogg",
	"npcs/stalkervoices/bandit/death_9.ogg",
	"npcs/stalkervoices/bandit/death_10.ogg",

}
ENT.SoundTbl_OnKilledEnemy = {
	
}

ENT.IdleSoundChance = 6
ENT.CombatIdleSoundChance = 5
ENT.AlertSoundChance = 3
ENT.CallForHelpSoundChance = 2
ENT.OnKilledEnemySoundChance = 3
ENT.WeaponReloadSoundChance = 3

local femsound = {
	idle = {
		
	},
	combat = {

	},
	investigate = {

	},
	alert = {
		"npcs/stalkervoices/female/enemy_1.ogg",
		"npcs/stalkervoices/female/enemy_2.ogg",
		"npcs/stalkervoices/female/enemy_3.ogg",
		"npcs/stalkervoices/female/enemy_4.ogg",
		"npcs/stalkervoices/female/enemy_5.ogg",
		"npcs/stalkervoices/female/enemy_6.ogg",
		"npcs/stalkervoices/female/enemy_7.ogg",
		"npcs/stalkervoices/female/enemy_8.ogg",
		"npcs/stalkervoices/female/enemy_9.ogg",

	},
	suppressing = {

	},
	grenade = {

	},
	grenadesee = {
		"npcs/stalkervoices/female/grenade_1.ogg",
		"npcs/stalkervoices/female/grenade_3.ogg",
		"npcs/stalkervoices/female/grenade_4.ogg",
	},
	callforhelp = {
		
	},
	pain = {
		"npcs/stalkervoices/female/hit_1.ogg",
		"npcs/stalkervoices/female/hit_2.ogg",
		"npcs/stalkervoices/female/hit_3.ogg",
		"npcs/stalkervoices/female/hit_4.ogg",
		"npcs/stalkervoices/female/hit_5.ogg",
		"npcs/stalkervoices/female/hit_6.ogg",
		"npcs/stalkervoices/female/hit_7.ogg",
		"npcs/stalkervoices/female/hit_8.ogg",
		"npcs/stalkervoices/female/hit_9.ogg",

	},
	death = {
		"npcs/stalkervoices/female/death_1.ogg",
		"npcs/stalkervoices/female/death_2.ogg",
		"npcs/stalkervoices/female/death_3.ogg",
		"npcs/stalkervoices/female/death_4.ogg",
		"npcs/stalkervoices/female/death_5.ogg",
		"npcs/stalkervoices/female/death_6.ogg",
		"npcs/stalkervoices/female/death_7.ogg",
		"npcs/stalkervoices/female/death_8.ogg",

	},
	onkilled = {
	},
}
---------------------------------------------------------------------------------------------------------------------------------------------

local sels = {
	head = {
		--gasmask = true, --hide the hair automatically
		--glasses = true, --do glasses
		--real = 0, --the actual bodygroup if glasses
		--beanie = 1 or 2,
		[0] = {}, --idk doesnt matter
		[1] = {}, --bandana
		[2] = {
			gasmask = true
		},
		[3] = {}, --breather
		[4] = {}, --surgical
		[5] = {
			glasses = true,
			real = 0,
		},
		[6] = {
			glasses = true,
			real = 1,
		},
		[7] = {
			glasses = true,
			real = 3,
		},
		[8] = {
			glasses = true,
			real = 4,
		},
		[9] = {
			beanie = 1,
			real = 0,
			nohood = true,
		},
		[10] = {
			beanie = 2,
			real = 0,
			nohood = true,
		},
		[11] = {
			beanie = 1,
			real = 1,
			nohood = true,
		},
		[12] = {
			beanie = 2,
			real = 1,
			nohood = true,
		},
		[13] = {
			beanie = 1,
			real = 3,
			nohood = true,
		},
		[14] = {
			beanie = 2,
			real = 3,
			nohood = true,
		},
		[15] = {
			beanie = 1,
			real = 4,
			nohood = true,
		},
		[16] = {
			beanie = 2,
			real = 4,
			nohood = true,
		},
		[17] = {
			beanie = 1,
			glasses = true,
			real = 0,
			nohood = true,
		},
		[18] = {
			beanie = 2,
			glasses = true,
			real = 0,
			nohood = true,
		},
		[19] = {
			beanie = 1,
			glasses = true,
			real = 1,
			nohood = true,
		},
		[20] = {
			beanie = 2,
			glasses = true,
			real = 1,
			nohood = true,
		},
		[21] = {
			beanie = 1,
			glasses = true,
			real = 3,
			nohood = true,
		},
		[22] = {
			beanie = 2,
			glasses = true,
			real = 3,
			nohood = true,
		},
		[23] = {
			beanie = 1,
			glasses = true,
			real = 4,
			nohood = true,
		},
		[24] = {
			beanie = 2,
			glasses = true,
			real = 4,
			nohood = true,
		},
	}
}

function ENT:CustomOnInitialize()
	self:CheckFemale()
	self:SetCollisionBounds(Vector(-15, -15, 0), Vector(15, 15, 75))
end

function ENT:CheckFemale()
	self:SetSkin(math.random(0, self:SkinCount()-1)) --pick a random skin

	local topmodel = "models/sky/seperate/male_anorak.mdl"
	if(string.find(self:GetModel(), "female")) then
		self.SoundTbl_Alert = nil
		self.SoundTbl_Death = nil
		self.SoundTbl_Idle = nil
		self.SoundTbl_CombatIdle = nil
		self.SoundTbl_OnKilledEnemy = nil
		self.SoundTbl_Pain = nil
		self.SoundTbl_Suppressing = nil
		self.SoundTbl_CallForHelp = nil
		self.SoundTbl_GrenadeAttack = nil
		self.SoundTbl_Investigate = nil
		self.SoundTbl_OnGrenadeSight = nil
		self.SoundTbl_Alert = femsound.alert
		self.SoundTbl_Death = femsound.death
		self.SoundTbl_Idle = femsound.idle
		self.SoundTbl_CombatIdle = femsound.combat
		self.SoundTbl_OnKilledEnemy = femsound.onkilled
		self.SoundTbl_Pain = femsound.pain
		self.SoundTbl_Suppressing = femsound.suppressing
		self.SoundTbl_CallForHelp = femsound.callforhelp
		self.SoundTbl_GrenadeAttack = femsound.grenade
		self.SoundTbl_Investigate = femsound.investigate
		self.SoundTbl_OnGrenadeSight = femsound.grenadesee

		topmodel = "models/sky/seperate/female_anorak.mdl"
		self.fem = true
	end
	
	local ply = self
	--[[if(math.random(1,8) == 2) then
		--choose a helm
		if(self.fem) then
			ply:SetModel("models/sky/seperate/female_anorak_mask.mdl")
		else
			ply:SetModel("models/sky/seperate/male_anorak_mask.mdl")
		end
		
		local mats = ply:GetMaterials()
		local mat
		for k,v in pairs(mats) do
			if(string.find(v, "anorak_lone")) then
				mat = k-1
				break
			end
		end

		local rando = 10
		ply:SetSubMaterial(mat, ANORAKTEXTURES[rando])

		local validhelms = {1,1,1,1,6}
		local helm = validhelms[math.random(#validhelms)]
		local bg = ply:FindBodygroupByName("hood")
		ply:SetBodygroup(bg, helm)

		--i dont think this stuff needs to be saved?
		return
	else]]
		local ana = ply:FindBodygroupByName("arms")
		ply:SetBodygroup(ana, self.fem and 3 or 4)
		ana = ply:FindBodygroupByName("hands")
		ply:SetBodygroup(ana, 3)
	--end

	local t = ents.Create("base_gmodentity")
	t:SetModel(topmodel)
	t:Spawn()
	t:PhysicsDestroy()

	local hood = math.random(1,5) >= 3
	self.hood = hood

	ply.bm = ply.bm or {}
	
	t:SetParent(ply)
	ply:CallOnRemove("remtop", function(ent) t:Remove() end)
	t:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL))
	ply.bm.t = t

	local rando = 12

	self.dedsub = rando

	local mats = t:GetMaterials()
	local mat
	for k,v in pairs(mats) do
		if(string.find(v, "anorak_lone")) then
			mat = k-1
			break
		end
	end
	self.mat = mat

	
	
	if(nut) then

	t:SetSubMaterial(mat, ANORAKTEXTURES[rando])

	if(hood) then
		local an = t:FindBodygroupByName("anorak")
		local repl = ANORAKHOODGROUP[ply:GetModel():gsub("npcs","heads")] or 1
		self.repl = repl
		t:SetBodygroup(an, repl)

		--if(ANORAKBODYGROUPS[self:GetModel()]) then
		for k,v in pairs(ANORAKBODYGROUPS[self:GetModel()] or {}) do
			local ind = self:FindBodygroupByName(k)
			ply:SetBodygroup(ind, v)
		end
		--end
	end
	else
		print("hey just so you remember, these models need the schema to work")
	end

	if(math.random(1, 30) <= 20) then
		print("hi")
		local hand = ply:FindBodygroupByName("masks")
		local val, valtt = table.Random(sels.head)
		if(val.nohood and hood) then
			return 
		end

		if(val.beanie) then
			ply:SetBodygroup(hand, val.real)
		elseif(val.glass) then
			ply:SetBodygroup(ply:FindBodygroupByName("glasses"), 1)
			ply:SetBodygroup(hand, val.real)
		else
			ply:SetBodygroup(hand, valtt)
		end

		for k,v in pairs(val) do
			if(tostring(k) == "gasmask") then-- and !hairhide) then
			local hair = ply:FindBodygroupByName("hair")
				if(hair != -1 and ply:GetBodygroupCount(hair) == 3) then --hide hair too
				--if(modelsgoodfor1[ply:GetModel()]) then 
					if(!string.find(ply:GetModel(), "neo")) then
						ply:SetBodygroup(hair, 1)
					else
						ply:SetBodygroup(hair, 2)
					end
				--[[else
					bg["hair"] = 2
				end]]
				elseif(hair != -1) then
					ply:SetBodygroup(hair, 1)
				end
			elseif(type(k) == "string" and type(v) == "number") then
				local l = ply:FindBodygroupByName(k)
				ply:SetBodygroup(l, v)
			elseif(type(k) == "number") then
				ply:SetBodygroup(k, v)
			end
		end

		if(val.beanie) then
			local hair = ply:FindBodygroupByName("hair")
			if(hair != -1 and ply:GetBodygroupCount(hair) == 3) then
				ply:SetBodygroup(hair, 2)
			end
		end
	end
end

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,ply) 
	ply.npcClass = self:GetClass()
	if(ply:GetModel():find("_mask")) then return end --nope
 
	local topmodel = "models/sky/seperate/male_anorak.mdl"
	if(self.fem or string.find(self.GetModel and self:GetModel() or "", "female")) then
		topmodel = "models/sky/seperate/female_anorak.mdl"
	end

	local t = ents.Create("base_gmodentity")
	t:SetModel(topmodel)
	t:Spawn()
	t:PhysicsDestroy()
	
	ply.bm = ply.bm or {}

	t:SetParent(ply)
	ply:CallOnRemove("remtop", function(ent) t:Remove() end)
	t:AddEffects(bit.bor(EF_BONEMERGE,EF_BONEMERGE_FASTCULL))
	ply.bm.t = t

	if(self.hood) then
		local an = t:FindBodygroupByName("anorak")
		t:SetBodygroup(an, self.repl)
	end

	--print("hi hello?", self.dedsub)

	t:SetSubMaterial(self.mat, ANORAKTEXTURES[self.dedsub])
end

-- All functions and variables are located inside the base files. It can be found in the GitHub Repository: https://github.com/DrVrej/VJ-Base

/*-----------------------------------------------
	*** Copyright (c) 2012-2018 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/