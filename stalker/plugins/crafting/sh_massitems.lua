local itemList = {
	--[[
	["uniqueid"] = {
		name = "name",
		desc = RarityText(RARITY_UNCOMMON).."",
		price = 12,--12,
		model = "models/sky/mags/pistol_mag_ext.mdl",
		width = 1,
		height = 1,
		flag = "m",
		count = 1,
		--destroy = {["id"] = 1},
	},
	]]
	--eft items - remember to add megapack to collection!
	--[[
	models/illusion/eftcontainers/30mmround.mdl
	models/illusion/eftcontainers/aabattery.mdl
	models/illusion/eftcontainers/alkali.mdl
	models/illusion/eftcontainers/capacitors.mdl
	models/illusion/eftcontainers/catfigurine.mdl
	models/illusion/eftcontainers/chain.mdl
	models/illusion/eftcontainers/circuitboard.mdl
	models/illusion/eftcontainers/coffee.mdl
	models/illusion/eftcontainers/controller.mdl
	models/illusion/eftcontainers/defib.mdl
	models/illusion/eftcontainers/diagset.mdl
	models/illusion/eftcontainers/dryfuel.mdl
	models/illusion/eftcontainers/electricdrill.mdl
	models/illusion/eftcontainers/engine.mdl
	models/illusion/eftcontainers/flashstorage.mdl
	models/illusion/eftcontainers/fuelconditioner.mdl
	models/illusion/eftcontainers/gasanalyser.mdl
	models/illusion/eftcontainers/geigercounter.mdl
	models/illusion/eftcontainers/goldchain.mdl
	models/illusion/eftcontainers/gpblue.mdl
	models/illusion/eftcontainers/gpgreen.mdl
	models/illusion/eftcontainers/gphone.mdl
	models/illusion/eftcontainers/gphonex.mdl --broken
	models/illusion/eftcontainers/gpred.mdl
	models/illusion/eftcontainers/graphicscard.mdl
	models/illusion/eftcontainers/gyroscope.mdl
	models/illusion/eftcontainers/gyrotachometer.mdl
	models/illusion/eftcontainers/hdd.mdl
	models/illusion/eftcontainers/helix.mdl
	models/illusion/eftcontainers/horse.mdl
	models/illusion/eftcontainers/hose.mdl
	models/illusion/eftcontainers/insulatingtape.mdl
	models/illusion/eftcontainers/lcdclean.mdl
	models/illusion/eftcontainers/lcddirty.mdl
	models/illusion/eftcontainers/lightbulb.mdl
	models/illusion/eftcontainers/lionstatue.mdl
	models/illusion/eftcontainers/magnet.mdl
	models/illusion/eftcontainers/matches.mdl
	models/illusion/eftcontainers/medpile.mdl
	models/illusion/eftcontainers/medsyringe.mdl
	models/illusion/eftcontainers/militarybattery.mdl
	models/illusion/eftcontainers/militaryboard.mdl
	models/illusion/eftcontainers/militarycable.mdl
	models/illusion/eftcontainers/nailpack.mdl
	models/illusion/eftcontainers/nixxorlens.mdl
	models/illusion/eftcontainers/nuts.mdl
	models/illusion/eftcontainers/packofscrews.mdl
	models/illusion/eftcontainers/paracord.mdl
	models/illusion/eftcontainers/phaseantenna.mdl
	models/illusion/eftcontainers/phaserelay.mdl
	models/illusion/eftcontainers/plexiglass.mdl
	models/illusion/eftcontainers/pliers.mdl
	models/illusion/eftcontainers/powerbank.mdl
	models/illusion/eftcontainers/powercord.mdl
	models/illusion/eftcontainers/powerfilter.mdl
	models/illusion/eftcontainers/powersupplyunit.mdl
	models/illusion/eftcontainers/pressuregauge.mdl
	models/illusion/eftcontainers/propanetank.mdl
	models/illusion/eftcontainers/rfidreader.mdl
	models/illusion/eftcontainers/rolex.mdl
	models/illusion/eftcontainers/screwdriver.mdl
	models/illusion/eftcontainers/screwnutbolt.mdl
	models/illusion/eftcontainers/silicontube.mdl
	models/illusion/eftcontainers/sparkplug.mdl
	models/illusion/eftcontainers/tetriz.mdl
	models/illusion/eftcontainers/thermalmodule.mdl
	models/illusion/eftcontainers/thermometer.mdl
	models/illusion/eftcontainers/toolset.mdl
	models/illusion/eftcontainers/toothpaste.mdl
	models/illusion/eftcontainers/virtex.mdl
	models/illusion/eftcontainers/waterfilter.mdl
	models/illusion/eftcontainers/weaponparts.mdl
	models/illusion/eftcontainers/wirelesstransmitter.mdl
	models/illusion/eftcontainers/wires.mdl
	models/illusion/eftcontainers/wrench.mdl
	]]
	--warfare items
	--[[
	models/kek1ch/box_condensers.mdl
	models/kek1ch/box_toolkit_1.mdl --basic
	models/kek1ch/box_toolkit_2.mdl --adv
	models/kek1ch/box_toolkit_3.mdl --expert
	models/kek1ch/box_transistors.mdl
	models/kek1ch/dev_detector_0_samodel.mdl
	models/kek1ch/grease.mdl
	]]

	--mutant parts
	["hide_bloodsucker"] = {
		name = "Bloodsucker Hide",
		desc = "",
		price = 2020,--12,
		model = "models/kek1ch/hide_bloodsucker.mdl",
		width = 1,
		height = 1,
		weight = 1.172,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["hide_boar"] = {
		name = "Boar Hide",
		desc = "",
		price = 730,--12,
		model = "models/kek1ch/hide_boar.mdl",
		width = 1,
		height = 1,
		weight = 1.152,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["hide_chimera"] = {
		name = "Chimera Hide",
		desc = "",
		price = 3284,--12,
		model = "models/kek1ch/hide_chimera.mdl",
		width = 1,
		height = 1,
		weight = 1.36,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["hide_flesh"] = {
		name = "Flesh Hide",
		desc = "",
		price = 640,--12,
		model = "models/kek1ch/hide_flesh.mdl",
		width = 1,
		height = 1,
		weight = 2.183,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_boar"] = {
		name = "Boar Leg",
		desc = "",
		price = 670,--12,
		model = "models/kek1ch/item_boar_leg.mdl",
		width = 1,
		height = 1,
		weight = 0.234,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_chimera"] = {
		name = "Chimera Cogot",
		desc = "",
		price = 3740,--12,
		model = "models/kek1ch/item_chimera_cogot.mdl",
		width = 1,
		height = 1,
		weight = 0.122,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_dog"] = {
		name = "Dog Tail",
		desc = "",
		price = 620,--12,
		model = "models/kek1ch/item_dog_tail.mdl",
		width = 1,
		height = 1,
		weight = 0.082,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_flesh"] = {
		name = "Flesh Eye",
		desc = "",
		price = 640,--12,
		model = "models/kek1ch/item_flesh_eye.mdl",
		width = 1,
		height = 1,
		weight = 0.023,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_bloodsucker"] = {
		name = "Bloodsucker Jaw",
		desc = "",
		price = 1380,--12,
		model = "models/kek1ch/item_krovosos_jaw.mdl",
		width = 1,
		height = 1,
		weight = 0.162,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_snork_leg"] = {
		name = "Snork Leg",
		desc = "",
		price = 790,--12,
		model = "models/kek1ch/item_snork_leg.mdl",
		width = 1,
		height = 1,
		weight = 0.223,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_snork_mask"] = {
		name = "Snork Mask",
		desc = "",
		price = 1060,--12,
		model = "models/kek1ch/snork_mask.mdl",
		width = 1,
		height = 1,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_rat"] = {
		name = "Rodent Head",
		desc = "",
		price = 510,--12,
		model = "models/kek1ch/item_tushkano_head.mdl",
		width = 1,
		height = 1,
		weight = 0.06,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_zombie"] = {
		name = "Zombie Hand",
		desc = "",
		price = 620,--12,
		model = "models/kek1ch/item_zombie_hand.mdl",
		width = 1,
		height = 1,
		weight = 0.092,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},

	--ups
	["up_armor_2a"] = {
		name = "IIA Plate",
		desc = "Spare plate used for replacing a plate in an armor.",
		price = 10220,--12,
		model = "models/props_junk/cardboard_box002a.mdl",
		width = 1,
		height = 1,
		weight = 0.45,
		flag = "1",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["up_armor_2"] = {
		name = "II Plate",
		desc = "Spare plate used for replacing a plate in an armor.",
		price = 14420,--12,
		model = "models/props_junk/cardboard_box002a.mdl",
		width = 1,
		height = 1,
		weight = 0.9,
		flag = "1",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["up_armor_3a"] = {
		name = "IIIA Plate",
		desc = "Spare plate used for replacing a plate in an armor.",
		price = 18620,--12,
		model = "models/props_junk/cardboard_box002a.mdl",
		width = 1,
		height = 1,
		weight = 1.35,
		flag = "2",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["up_armor_3"] = {
		name = "III Plate",
		desc = "Spare plate used for replacing a plate in an armor.",
		price = 22820,--12,
		model = "models/props_junk/cardboard_box002a.mdl",
		width = 1,
		height = 1,
		weight = 1.8,
		flag = "3",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["up_armor_4"] = {
		name = "IV Plate",
		desc = "Spare plate used for replacing a plate in an armor.",
		price = 34220,--12,
		model = "models/props_junk/cardboard_box002a.mdl",
		width = 1,
		height = 1,
		weight = 2.7,
		flag = "5",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},

	--patches
	["patch_bandit"] = {
		name = "Bandit Patch",
		desc = "",
		price = 650,--12,
		model = "models/kek1ch/tfw_badge_bandit.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		flag = "m",
		count = 25,
		--destroy = {["id"] = 1},
	},
	["patch_loner"] = {
		name = "Loner Patch",
		desc = "",
		price = 650,--12,
		model = "models/kek1ch/tfw_badge_defiance.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		flag = "m",
		count = 25,
		--destroy = {["id"] = 1},
	},
	["patch_duty"] = {
		name = "Duty Patch",
		desc = "",
		price = 650,--12,
		model = "models/kek1ch/tfw_badge_dolg.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		flag = "m",
		count = 25,
		--destroy = {["id"] = 1},
	},
	["patch_freedom"] = {
		name = "Freedom Patch",
		desc = "",
		price = 650,--12,
		model = "models/kek1ch/tfw_badge_freedom.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		flag = "m",
		count = 25,
		--destroy = {["id"] = 1},
	},
	["patch_merc"] = {
		name = "Mercenary Patch",
		desc = "",
		price = 650,--12,
		model = "models/kek1ch/tfw_badge_merc.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		flag = "m",
		count = 25,
		--destroy = {["id"] = 1},
	},
	["patch_military"] = {
		name = "Military Patch",
		desc = "",
		price = 650,--12,
		model = "models/kek1ch/tfw_badge_military.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		flag = "m",
		count = 25,
		--destroy = {["id"] = 1},
	},
	["patch_mono"] = {
		name = "Monolith Patch",
		desc = "",
		price = 650,--12,
		model = "models/kek1ch/tfw_badge_monolith.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		flag = "m",
		count = 25,
		--destroy = {["id"] = 1},
	},
	["patch_eco"] = {
		name = "Ecologist Patch",
		desc = "",
		price = 650,--12,
		model = "models/kek1ch/tfw_scientist.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		flag = "m",
		count = 25,
		--destroy = {["id"] = 1},
	},

}

function PLUGIN:InitializedItems()
	for id, data in pairs(itemList) do
		local ITEM = nut.item.register(id, "base_junk", nil, nil, true)
		ITEM.name = data.name
		ITEM.desc = data.desc
		ITEM.price = data.price or 0
		ITEM.model = data.model
		ITEM.width = data.width
		ITEM.height = data.height
		ITEM.weight = data.weight
		
		if(data.isStackable) then
			ITEM.isStackable = data.isStackable
		end

		ITEM.countMax = data.count
		ITEM.maxQuantity = data.count

		ITEM.destroyval = data.destroy

		if(data.iconCam) then --prob wont be used for anything else so
			ITEM.exRender = true
			ITEM.iconCam = data.iconCam
		end
	end		
end