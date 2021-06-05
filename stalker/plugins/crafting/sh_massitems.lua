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
	["junk_ofz"] = {
		name = "OFZ 30mm Shell",
		desc = "",
		price = 56000,--12,
		model = "models/illusion/eftcontainers/30mmround.mdl",
		width = 1,
		height = 2,
		weight = 0.84,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_aa"] = {
		name = "AA Battery",
		desc = "",
		price = 652,--12,
		model = "models/illusion/eftcontainers/aabattery.mdl",
		width = 1,
		height = 1,
		weight = 0.01,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_alkali"] = {
		name = "Alkali Surface Washer",
		desc = "",
		price = 8457,--12,
		model = "models/illusion/eftcontainers/alkali.mdl",
		width = 1,
		height = 2,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_cap"] = {
		name = "Capacitors",
		desc = "",
		price = 2500,--sells to mechanic for 1425
		model = "models/illusion/eftcontainers/capacitors.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_cat"] = {
		name = "Cat Figurine",
		desc = "",
		price = 47300,--12,
		model = "models/illusion/eftcontainers/catfigurine.mdl",
		width = 1,
		height = 3,
		weight = 3.1,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_chain"] = {
		name = "Chainlet",
		desc = "",
		price = 7300,--12,
		model = "models/illusion/eftcontainers/chain.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_circuitboard"] = {
		name = "Circuit Board",
		desc = "",
		price = 12800,--12,
		model = "models/illusion/eftcontainers/circuitboard.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_coffee"] = {
		name = "Coffee Majaica",
		desc = "",
		price = 14900,--12,
		model = "models/illusion/eftcontainers/coffee.mdl",
		width = 1,
		height = 1,
		weight = 0.5,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_mcontrol"] = {
		name = "Motor Controller",
		desc = "",
		price = 4500,--12,
		model = "models/illusion/eftcontainers/controller.mdl",
		width = 2,
		height = 1,
		weight = 2.0,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_defib"] = {
		name = "Portable Defibrillator",
		desc = "",
		price = 224000,--12,
		model = "models/illusion/eftcontainers/defib.mdl",
		width = 1,
		height = 1,
		weight = 0.350,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_diagset"] = {
		name = "Opthalmoscope",
		desc = "",
		price = 84900,--12,
		model = "models/illusion/eftcontainers/diagset.mdl",
		width = 1,
		height = 1,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_dryfuel"] = {
		name = "Dry Fuel",
		desc = "",
		price = 42100,--12,
		model = "models/illusion/eftcontainers/dryfuel.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_drill"] = {
		name = "Electric Drill",
		desc = "",
		price = 19200,--12,
		model = "models/illusion/eftcontainers/electricdrill.mdl",
		width = 2,
		height = 2,
		weight = 1.2,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_motor"] = {
		name = "Electric Motor",
		desc = "",
		price = 43000,--12,
		model = "models/illusion/eftcontainers/engine.mdl",
		width = 2,
		height = 2,
		weight = 1.4,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_vpx"] = {
		name = "VPX Flash Storage Module",
		desc = "",
		price = 152000,--12,
		model = "models/illusion/eftcontainers/flashstorage.mdl",
		width = 1,
		height = 1,
		weight = 0.8,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_fcond"] = {
		name = "Fuel Conditioner",
		desc = "",
		price = 152000,--12,
		model = "models/illusion/eftcontainers/fuelconditioner.mdl",
		width = 1,
		height = 2,
		weight = 1.8,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_gasa"] = {
		name = "Gas Analyser",
		desc = "",
		price = 20600,--12,
		model = "models/illusion/eftcontainers/gasanalyser.mdl",
		width = 1,
		height = 2,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_geiger"] = {
		name = "Geiger Counter",
		desc = "",
		price = 16600,--12,
		model = "models/illusion/eftcontainers/geigercounter.mdl",
		width = 1,
		height = 2,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_gchain"] = {
		name = "Gold Chain",
		desc = "",
		price = 38000,--12,
		model = "models/illusion/eftcontainers/goldchain.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_gpblue"] = {
		name = "Gunpowder Kite",
		desc = "",
		price = 14000,--12,
		model = "models/illusion/eftcontainers/gpblue.mdl",
		width = 1,
		height = 2,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_gpgreen"] = {
		name = "Gunpowder Eagle",
		desc = "",
		price = 32000,--12,
		model = "models/illusion/eftcontainers/gpgreen.mdl",
		width = 1,
		height = 2,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_gpred"] = {
		name = "Gunpowder Hawk",
		desc = "",
		price = 35000,--12,
		model = "models/illusion/eftcontainers/gpred.mdl",
		width = 1,
		height = 2,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_gphone"] = {
		name = "Broken GPhone",
		desc = "",
		price = 18600,--12,
		model = "models/illusion/eftcontainers/gphone.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_gphonex"] = {
		name = "Broken GPhone X",
		desc = "",
		price = 32000,--12,
		model = "models/illusion/eftcontainers/gphonex.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_graphicscard"] = {
		name = "Graphics Card",
		desc = "",
		price = 198000,--12,
		model = "models/illusion/eftcontainers/graphicscard.mdl",
		width = 2,
		height = 1,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_gyroscope"] = {
		name = "Single-axis Fiber Optic Gryoscope",
		desc = "",
		price = 5000,--12,
		model = "models/illusion/eftcontainers/gyroscope.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_gyrotachometer"] = {
		name = "Military Gyrotachometer",
		desc = "",
		price = 62000,--12,
		model = "models/illusion/eftcontainers/gyrotachometer.mdl",
		width = 1,
		height = 2,
		weight = 0.9,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_hdd"] = {
		name = "Damaged Hard Drive",
		desc = "",
		price = 7500,--12,
		model = "models/illusion/eftcontainers/hdd.mdl",
		width = 2,
		height = 1,
		weight = 0.25,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_helix"] = {
		name = "Radiator Helix",
		desc = "",
		price = 14500,--12,
		model = "models/illusion/eftcontainers/helix.mdl",
		width = 1,
		height = 1,
		weight = 0.42,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_horse"] = {
		name = "Horse Figurine",
		desc = "",
		price = 11450,--12,
		model = "models/illusion/eftcontainers/horse.mdl",
		width = 1,
		height = 2,
		weight = 0.5,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_hose"] = {
		name = "Corrugated Hose",
		desc = "",
		price = 12150,--12,
		model = "models/illusion/eftcontainers/hose.mdl",
		width = 2,
		height = 1,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_itape"] = {
		name = "Insulating Tape",
		desc = "",
		price = 2000,--12,
		model = "models/illusion/eftcontainers/insulatingtape.mdl",
		width = 1,
		height = 1,
		weight = 0.05,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_lcdc"] = {
		name = "Working LCD Screen",
		desc = "",
		price = 38000,--12,
		model = "models/illusion/eftcontainers/lcdclean.mdl",
		width = 1,
		height = 2,
		weight = 0.05,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_lcdd"] = {
		name = "Broken LCD Screen",
		desc = "",
		price = 13500,--12,
		model = "models/illusion/eftcontainers/lcddirty.mdl",
		width = 1,
		height = 2,
		weight = 0.05,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_lightbulb"] = {
		name = "Light Bulb",
		desc = "",
		price = 9500,--12,
		model = "models/illusion/eftcontainers/lightbulb.mdl",
		width = 1,
		height = 1,
		weight = 0.09,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_lion"] = {
		name = "Bronze Lion",
		desc = "",
		price = 162000,--12,
		model = "models/illusion/eftcontainers/lionstatue.mdl",
		width = 3,
		height = 2,
		weight = 7.2,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_magnet"] = {
		name = "Magnet",
		desc = "",
		price = 12700,--12,
		model = "models/illusion/eftcontainers/magnet.mdl",
		width = 1,
		height = 1,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_matches"] = {
		name = "Matches",
		desc = "",
		price = 2000,--12,
		model = "models/illusion/eftcontainers/matches.mdl",
		width = 1,
		height = 1,
		weight = 0.005,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_meds"] = {
		name = "Pile of Meds",
		desc = "",
		price = 6500,--12,
		model = "models/illusion/eftcontainers/medpile.mdl",
		width = 1,
		height = 1,
		weight = 0.2,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_syringe"] = {
		name = "Disposable Syringe",
		desc = "",
		price = 3000,--12,
		model = "models/illusion/eftcontainers/medsyringe.mdl",
		width = 1,
		height = 1,
		weight = 0.06,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_militarybattery"] = {
		name = "Military Battery",
		desc = "",
		price = 330000,--12,
		model = "models/illusion/eftcontainers/militarybattery.mdl",
		width = 4,
		height = 2,
		weight = 43.2,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_militaryboard"] = {
		name = "Military Circuit Board",
		desc = "",
		price = 40000,--12,
		model = "models/illusion/eftcontainers/militaryboard.mdl",
		width = 1,
		height = 1,
		weight = 0.52,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_militarycable"] = {
		name = "Military Cable",
		desc = "",
		price = 41000,--12,
		model = "models/illusion/eftcontainers/militarycable.mdl",
		width = 2,
		height = 1,
		weight = 0.65,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_nailpack"] = {
		name = "Pack of Nails",
		desc = "",
		price = 41000,--12,
		model = "models/illusion/eftcontainers/nailpack.mdl",
		width = 1,
		height = 1,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_nixxor"] = {
		name = "NIXXOR Lens",
		desc = "",
		price = 25300,--12,
		model = "models/illusion/eftcontainers/nixxorlens.mdl",
		width = 1,
		height = 1,
		weight = 0.15,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_nuts"] = {
		name = "Screw Nuts",
		desc = "",
		price = 8700,--12,
		model = "models/illusion/eftcontainers/nuts.mdl",
		width = 1,
		height = 1,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_screws"] = {
		name = "Pack of Screws",
		desc = "",
		price = 3100,--12,
		model = "models/illusion/eftcontainers/packofscrews.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_paracord"] = {
		name = "Paracord",
		desc = "",
		price = 22000,--12,
		model = "models/illusion/eftcontainers/paracord.mdl",
		width = 2,
		height = 1,
		weight = 0.35,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_asea"] = {
		name = "Phased Array Element",
		desc = "",
		price = 166000,--12,
		model = "models/illusion/eftcontainers/phaseantenna.mdl",
		width = 2,
		height = 2,
		weight = 1.7,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_relay"] = {
		name = "Phase Control Relay",
		desc = "",
		price = 9500,--12,
		model = "models/illusion/eftcontainers/phaserelay.mdl",
		width = 1,
		height = 1,
		weight = 0.08,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_plexiglass"] = {
		name = "Piece of Plexiglas",
		desc = "",
		price = 8660,--12,
		model = "models/illusion/eftcontainers/plexiglass.mdl",
		width = 1,
		height = 1,
		weight = 0.7,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_pliers"] = {
		name = "Pliers",
		desc = "",
		price = 2100,--12,
		model = "models/illusion/eftcontainers/pliers.mdl",
		width = 1,
		height = 1,
		weight = 0.5,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_powerbank"] = {
		name = "Powerbank",
		desc = "",
		price = 20000,--12,
		model = "models/illusion/eftcontainers/powerbank.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_powercord"] = {
		name = "Powercord",
		desc = "",
		price = 12000,--12,
		model = "models/illusion/eftcontainers/powercord.mdl",
		width = 2,
		height = 1,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_powerfilter"] = {
		name = "Military Power Filter",
		desc = "",
		price = 55000,--12,
		model = "models/illusion/eftcontainers/powerfilter.mdl",
		width = 1,
		height = 1,
		weight = 0.2,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_psu"] = {
		name = "Power Supply Unit",
		desc = "",
		price = 8000,--12,
		model = "models/illusion/eftcontainers/powersupplyunit.mdl",
		width = 2,
		height = 2,
		weight = 0.8,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_pressuregauge"] = {
		name = "Pressure Gauge",
		desc = "",
		price = 61200,--12,
		model = "models/illusion/eftcontainers/pressuregauge.mdl",
		width = 2,
		height = 1,
		weight = 0.8,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_propane"] = {
		name = "5L Propane Tank",
		desc = "",
		price = 12000,--12,
		model = "models/illusion/eftcontainers/propanetank.mdl",
		width = 2,
		height = 2,
		weight = 5.3,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_rfid"] = {
		name = "RFID Reader",
		desc = "",
		price = 48000,--12,
		model = "models/illusion/eftcontainers/rfidreader.mdl",
		width = 1,
		height = 1,
		weight = 0.5,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_roler"] = {
		name = "Roler Gold Wrist Watch",
		desc = "",
		price = 71000,--12,
		model = "models/illusion/eftcontainers/rolex.mdl",
		width = 1,
		height = 1,
		weight = 0.18,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_screwdriver"] = {
		name = "Screwdriver",
		desc = "",
		price = 2300,--12,
		model = "models/illusion/eftcontainers/screwdriver.mdl",
		width = 1,
		height = 1,
		weight = 0.15,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_bolts"] = {
		name = "Bolts",
		desc = "",
		price = 11000,--12,
		model = "models/illusion/eftcontainers/screwnutbolt.mdl",
		width = 1,
		height = 1,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_silicontube"] = {
		name = "Silicone Tube",
		desc = "",
		price = 18900,--12,
		model = "models/illusion/eftcontainers/silicontube.mdl",
		width = 1,
		height = 1,
		weight = 0.22,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_sparkplug"] = {
		name = "Spark Plug",
		desc = "",
		price = 11000,--12,
		model = "models/illusion/eftcontainers/sparkplug.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_tetriz"] = {
		name = "Tetriz Portable Game",
		desc = "",
		price = 120000,--12,
		model = "models/illusion/eftcontainers/tetriz.mdl",
		width = 1,
		height = 2,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_thermalmodule"] = {
		name = "Military Thermal Vision Module Iridium",
		desc = "",
		price = 81200,--12,
		model = "models/illusion/eftcontainers/thermalmodule.mdl",
		width = 1,
		height = 1,
		weight = 0.21,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_thermometer"] = {
		name = "Analog Thermometer",
		desc = "",
		price = 45600,--12,
		model = "models/illusion/eftcontainers/thermometer.mdl",
		width = 1,
		height = 2,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_toolset"] = {
		name = "Tool Set",
		desc = "",
		price = 20000,--12,
		model = "models/illusion/eftcontainers/toolset.mdl",
		width = 2,
		height = 2,
		weight = 0.9,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_toothpaste"] = {
		name = "Toothpaste",
		desc = "",
		price = 1800,--12,
		model = "models/illusion/eftcontainers/toothpaste.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_virtex"] = {
		name = "Virtex Programmable Processor",
		desc = "",
		price = 120000,--12,
		model = "models/illusion/eftcontainers/virtex.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_waterfilter"] = {
		name = "Water Filter",
		desc = "",
		price = 24500,--12,
		model = "models/illusion/eftcontainers/waterfilter.mdl",
		width = 1,
		height = 2,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_weaponparts"] = {
		name = "Weapon Parts",
		desc = "",
		price = 14240,--12,
		model = "models/illusion/eftcontainers/weaponparts.mdl",
		width = 2,
		height = 1,
		weight = 0.56,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_transmitter"] = {
		name = "Military COFDM Wireless Transmitter",
		desc = "",
		price = 145500,--12,
		model = "models/illusion/eftcontainers/wirelesstransmitter.mdl",
		width = 2,
		height = 1,
		weight = 2.0,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_wires"] = {
		name = "Wires",
		desc = "",
		price = 7400,--12,
		model = "models/illusion/eftcontainers/wires.mdl",
		width = 1,
		height = 1,
		weight = 0.25,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_wrench"] = {
		name = "Wrench",
		desc = "",
		price = 3500,--12,
		model = "models/illusion/eftcontainers/wrench.mdl",
		width = 1,
		height = 1,
		weight = 0.5,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	
	--warfare items
	["junk_detector"] = {
		name = "Broken Detector",
		desc = "",
		price = 4200,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_dev_detector_0.mdl",
		width = 1,
		height = 1,
		weight = 0.42,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_grease"] = {
		name = "Industrial Grease",
		desc = "",
		price = 1200,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_grease.mdl",
		width = 1,
		height = 1,
		weight = 0.34,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_boxcap"] = {
		name = "Box of Capacitors",
		desc = "",
		price = 193,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_box_condensers.mdl",
		width = 1,
		height = 1,
		weight = 0.13,
		flag = "m",
		count = 25,
		--destroy = {["id"] = 1},
	},
	["junk_boxtrans"] = {
		name = "Box of Transistors",
		desc = "",
		price = 240,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_box_transistors.mdl",
		width = 1,
		height = 1,
		weight = 0.12,
		flag = "m",
		count = 25,
		--destroy = {["id"] = 1},
	},
	["junk_boxres"] = {
		name = "Box of Resistors",
		desc = "",
		price = 140,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_box_resistors.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 25,
		--destroy = {["id"] = 1},
	},
	["junk_toolkit1"] = {
		name = "Basic Toolkit",
		desc = "",
		price = 7000,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_box_toolkit_1.mdl",
		width = 2,
		height = 1,
		weight = 2.29,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_toolkit2"] = {
		name = "Advanced Toolkit",
		desc = "",
		price = 10000,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_box_toolkit_2.mdl",
		width = 2,
		height = 1,
		weight = 2.56,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_toolkit3"] = {
		name = "Expert Toolkit",
		desc = "",
		price = 14000,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_box_toolkit_3.mdl",
		width = 2,
		height = 1,
		weight = 2.76,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_toolkitd"] = {
		name = "Drug-making Toolkit",
		desc = "",
		price = 6600,--12,
		model = "models/wick/wrbstalker/anomaly/items/dez_drugskit.mdl",
		width = 2,
		height = 1,
		weight = 1.6,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["junk_toolkita"] = {
		name = "Ammo-making Toolkit",
		desc = "",
		price = 8800,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_box_toolkit_ammo.mdl",
		width = 2,
		height = 1,
		weight = 2.12,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},

	--mutant parts
	["hide_bloodsucker"] = {
		name = "Bloodsucker Hide",
		desc = "",
		price = 2020,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_bloodsucker.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_boar.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_chimera.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_flesh.mdl",
		width = 1,
		height = 1,
		weight = 2.183,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["hide_pseudodog"] = { --hide_pseudodog
		name = "Pseudodog Fur",
		desc = "",
		price = 940,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_pseudodog.mdl",
		width = 1,
		height = 1,
		weight = 1.11,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["hide_psydog"] = { --hide_psydog
		name = "Psydog Fur",
		desc = "",
		price = 1570,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_psy_dog.mdl",
		width = 1,
		height = 1,
		weight = 1.16,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_boar"] = {
		name = "Boar Leg",
		desc = "",
		price = 670,--12,
		model = "models/wick/wrbstalker/anomaly/items/dez_item_boar_leg.mdl",
		width = 1,
		height = 1,
		weight = 0.234,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_chimera"] = {
		name = "Chimera Fang",
		desc = "",
		price = 3740,--12,
		model = "models/wick/wrbstalker/anomaly/items/dez_item_chimera_cogot.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_item_dog_tail.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_item_flesh_eye.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_item_krovosos_jaw.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_item_snork_leg.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_snork_mask.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_item_tushkano_head.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_item_zombie_hand.mdl",
		width = 1,
		height = 1,
		weight = 0.092,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_pseudofang"] = {
		name = "Pseudodog Fang",
		desc = "",
		price = 250,--12, --big fang lmao
		model = "models/wick/wrbstalker/anomaly/items/dez_item_chimera_cogot.mdl",
		width = 1,
		height = 1,
		weight = 0.05,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_pseudotail"] = {
		name = "Pseudodog Tail",
		desc = "",
		price = 690,--12,
		model = "models/wick/wrbstalker/anomaly/items/dez_item_psevdodog_tail.mdl",
		width = 1,
		height = 1,
		weight = 0.11,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},
	["part_controller_brain"] = {
		name = "Controller Brain Tissue",
		desc = "",
		price = 4790,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_burer.mdl",--models/kek1ch/item_controller_brain.mdl",
		width = 1,
		height = 1,
		weight = 1.5,
		flag = "m",
		count = 1,
		isStackable = false,
		--destroy = {["id"] = 1},
	},

	--patches
	["patch_bandit"] = {
		name = "Bandit Patch",
		desc = "",
		price = 650,--12,
		model = "models/wick/wrbstalker/anomaly/items/dez_tfw_badge_bandit.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_tfw_badge_defiance.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_tfw_badge_dolg.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_tfw_badge_freedom.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_tfw_badge_merc.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_tfw_badge_military.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_tfw_badge_monolith.mdl",
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
		model = "models/wick/wrbstalker/anomaly/items/dez_tfw_badge_ecolog.mdl",
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