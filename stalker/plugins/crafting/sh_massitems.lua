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
	--all items are old price *0.16
	--eft items - remember to add megapack to collection!
	["junk_ofz"] = {
		name = "OFZ 30mm Shell",
		desc = "",
		price = 8960,--56000,--12,
		model = "models/illusion/eftcontainers/30mmround.mdl",
		width = 1,
		height = 2,
		weight = 0.84,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(151.271, 127.309059, 99.512566),
			ang = Angle(25, 220, 0)
		}
		--destroy = {["id"] = 1},
	},
	["junk_aa"] = {
		name = "AA Battery",
		desc = "",
		price = 104,--652,--12,
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
		price = 1353,--8457,--12,
		model = "models/illusion/eftcontainers/alkali.mdl",
		width = 1,
		height = 2,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(106.238548, 91.531387, 69.685066),
			ang = Angle(25, 220, 0)
		}
		--destroy = {["id"] = 1},
	},
	["junk_cap"] = {
		name = "Capacitors",
		desc = "Destroy to convert into 3 Boxes of Capacitors.",
		price = 600,--2500, --not this tho, added 200
		model = "models/illusion/eftcontainers/capacitors.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(16.785751, 13.244063, 44.792107),
			ang = Angle(64.502, 218.922, 0)
		},
		destroy = {["junk_boxcap"] = 3},
	},
	["junk_cat"] = {
		name = "Cat Figurine",
		desc = "",
		price = 7568,--47300,--12,
		model = "models/illusion/eftcontainers/catfigurine.mdl",
		width = 1,
		height = 3,
		weight = 3.1,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(53.647812, 45.253075, 41.497608),
			ang = Angle(25, 220, 0)
		}
		--destroy = {["id"] = 1},
	},
	["junk_chain"] = {
		name = "Chainlet",
		desc = "",
		price = 1168,--7300,--12,
		model = "models/illusion/eftcontainers/chain.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(8.322406, -0.333569, 62.564308),
			ang = Angle(82.087, 168.746, 0)
		}
		--destroy = {["id"] = 1},
	},
	["junk_circuitboard"] = {
		name = "Circuit Board",
		desc = "Destroy to convert into Small Tech.",
		price = 300, --would be 2048 but keeping same as small tech--12800,--12,
		model = "models/illusion/eftcontainers/circuitboard.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		destroy = {["comp_tech1"] = 1},
		exRender = false,
		iconCam = {
			pos = Vector(66.909546, 0.794356, 113.482895),
			ang = Angle(59.509, 180.492, 0.000)
		}
	},
	["junk_coffee"] = {
		name = "Coffee Majaica",
		desc = "",
		price = 2384,--14900,--12,
		model = "models/illusion/eftcontainers/coffee.mdl",
		width = 1,
		height = 1,
		weight = 0.5,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-116.388031, 25.259331, 23.848083),
			ang = Angle(9.247, 347.726, -45.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_mcontrol"] = {
		name = "Motor Controller",
		desc = "",
		price = 720,--4500,--12,
		model = "models/illusion/eftcontainers/controller.mdl",
		width = 2,
		height = 1,
		weight = 2.0,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-0.000148, -17.665874, 224.618713),
			ang = Angle(94.634, 270.013, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_defib"] = {
		name = "Portable Defibrillator",
		desc = "",
		price = 35840,--224000,--12,
		model = "models/illusion/eftcontainers/defib.mdl",
		width = 1,
		height = 1,
		weight = 0.350,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(54.767628, 0.275826, 108.957840),
			ang = Angle(62.798, 108.365, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_diagset"] = {
		name = "Opthalmoscope",
		desc = "",
		price = 13584,--84900,--12,
		model = "models/illusion/eftcontainers/diagset.mdl",
		width = 1,
		height = 1,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(40.961369, 39.289696, 101.984619),
			ang = Angle(60.931, 224.479, 180.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_dryfuel"] = {
		name = "Dry Fuel",
		desc = "",
		price = 6736,--42100,--12,
		model = "models/illusion/eftcontainers/dryfuel.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(63.228062, 0.156858, 72.279739),
			ang = Angle(48.634, 180.137, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_drill"] = {
		name = "Electric Drill",
		desc = "",
		price = 3072,--19200,--12,
		model = "models/illusion/eftcontainers/electricdrill.mdl",
		width = 2,
		height = 2,
		weight = 1.2,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(41.306953, 164.723846, 86.381866),
			ang = Angle(25.551, 257.038, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_motor"] = {
		name = "Electric Motor",
		desc = "",
		price = 6880,--43000,--12,
		model = "models/illusion/eftcontainers/engine.mdl",
		width = 2,
		height = 2,
		weight = 1.4,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(158.540222, 153.201187, 68.371346),
			ang = Angle(15.790, 223.753, -110.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_vpx"] = {
		name = "VPX Flash Storage Module",
		desc = "",
		price = 24320,--152000,--12,
		model = "models/illusion/eftcontainers/flashstorage.mdl",
		width = 1,
		height = 1,
		weight = 0.8,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(41.784798, 34.801525, 118.000511),
			ang = Angle(65.115, 219.757, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_fcond"] = {
		name = "Fuel Conditioner",
		desc = "",
		price = 9696,--60604,--12,
		model = "models/illusion/eftcontainers/fuelconditioner.mdl",
		width = 1,
		height = 2,
		weight = 1.8,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(124.656532, 1.435433, 52.024826),
			ang = Angle(19.504, 180.669, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_gasa"] = {
		name = "Gas Analyser",
		desc = "",
		price = 3296,--20600,--12,
		model = "models/illusion/eftcontainers/gasanalyser.mdl",
		width = 1,
		height = 2,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-12.243372, -0.000602, 87.979858),
			ang = Angle(96.317, 180.627, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_geiger"] = {
		name = "Geiger Counter",
		desc = "",
		price = 2656,--16600,--12,
		model = "models/illusion/eftcontainers/geigercounter.mdl",
		width = 1,
		height = 2,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(8.570874, -0.004631, 86.566383),
			ang = Angle(84.256, 180.182, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_gchain"] = {
		name = "Gold Chain",
		desc = "",
		price = 6080,--38000,--12,
		model = "models/illusion/eftcontainers/goldchain.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(51.892750, 10.160728, 77.533432),
			ang = Angle(55.662, 190.020, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_gpblue"] = {
		name = "Gunpowder Kite",
		desc = "",
		price = 2240,--14000,--12,
		model = "models/illusion/eftcontainers/gpblue.mdl",
		width = 1,
		height = 2,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-60.187611, -15.693003, 36.726002),
			ang = Angle(26.818, 374.632, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_gpgreen"] = {
		name = "Gunpowder Eagle",
		desc = "",
		price = 5120,--32000,--12,
		model = "models/illusion/eftcontainers/gpgreen.mdl",
		width = 1,
		height = 2,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-60.187611, -15.693003, 36.726002),
			ang = Angle(26.818, 374.632, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_gpred"] = {
		name = "Gunpowder Hawk",
		desc = "",
		price = 5600,--35000,--12,
		model = "models/illusion/eftcontainers/gpred.mdl",
		width = 1,
		height = 2,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-60.187611, -15.693003, 36.726002),
			ang = Angle(26.818, 374.632, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_gphone"] = {
		name = "Broken GPhone",
		desc = "",
		price = 2976,--18600,--12,
		model = "models/illusion/eftcontainers/gphone.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(36.384441, 18.245768, 65.991219),
			ang = Angle(58.203, 206.680, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_gphonex"] = {
		name = "Broken GPhone X",
		desc = "",
		price = 5120,--32000,--12,
		model = "models/illusion/eftcontainers/gphonex.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(32.713799, 27.900621, -81.917984),
			ang = Angle(-62.413, 220.562, 90.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_graphicscard"] = {
		name = "Graphics Card",
		desc = "",
		price = 31680,--198000,--12,
		model = "models/illusion/eftcontainers/graphicscard.mdl",
		width = 2,
		height = 1,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(1.266420, -93.623238, 158.049042),
			ang = Angle(59.153, 90.688, 0.500)
		}
		--destroy = {["id"] = 1},
	},
	["junk_gyroscope"] = {
		name = "Single-axis Fiber Optic Gyroscope",
		desc = "",
		price = 800,--5000,--12,
		model = "models/illusion/eftcontainers/gyroscope.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(10.733521, 8.982714, 97.197456),
			ang = Angle(81.767, 220.497, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_gyrotachometer"] = {
		name = "Military Gyrotachometer",
		desc = "",
		price = 9920,--62000,--12,
		model = "models/illusion/eftcontainers/gyrotachometer.mdl",
		width = 1,
		height = 2,
		weight = 0.9,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(2.261142, -102.339340, 7.327351),
			ang = Angle(2.348, 91.257, 90.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_hdd"] = {
		name = "Damaged Hard Drive",
		desc = "",
		price = 1200,--7500,--12,
		model = "models/illusion/eftcontainers/hdd.mdl",
		width = 2,
		height = 1,
		weight = 0.25,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(0.000000, 47.471420, 151.827972),
			ang = Angle(72.564, 270.0, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_helix"] = {
		name = "Radiator Helix",
		desc = "",
		price = 2320,--14500,--12,
		model = "models/illusion/eftcontainers/helix.mdl",
		width = 1,
		height = 1,
		weight = 0.42,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(38.036377, 26.472553, 113.671822),
			ang = Angle(67.595, 214.940, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_horse"] = {
		name = "Horse Figurine",
		desc = "",
		price = 1832,--11450,--12,
		model = "models/illusion/eftcontainers/horse.mdl",
		width = 1,
		height = 2,
		weight = 0.5,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(107.150505, 82.253021, 27.060747),
			ang = Angle(8.605, 217.126, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_hose"] = {
		name = "Corrugated Hose",
		desc = "",
		price = 1944,--12150,--12,
		model = "models/illusion/eftcontainers/hose.mdl",
		width = 2,
		height = 1,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(137.794296, 115.290131, 35.091461),
			ang = Angle(10.661, 219.434, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_itape"] = {
		name = "Insulating Tape",
		desc = "Destroy to convert to a duct tape.",
		price = 400,--would be 320 but matched to same 2000,--12,
		model = "models/illusion/eftcontainers/insulatingtape.mdl",
		width = 1,
		height = 1,
		weight = 0.05,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		destroy = {["comp_duct_tape"] = 1},
		iconCam = {
			pos = Vector(22.352676, 16.364597, 30.052832),
			ang = Angle(47.027, 216.185, 0.000)
		}
	},
	["junk_lcdc"] = {
		name = "Working LCD Screen",
		desc = "",
		price = 6080,--38000,--12,
		model = "models/illusion/eftcontainers/lcdclean.mdl",
		width = 1,
		height = 2,
		weight = 0.05,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(0.000000, -27.819275, 114.123734),
			ang = Angle(103.659, 270.000, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_lcdd"] = {
		name = "Broken LCD Screen",
		desc = "",
		price = 2160,--13500,--12,
		model = "models/illusion/eftcontainers/lcddirty.mdl",
		width = 1,
		height = 2,
		weight = 0.05,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(0.000000, -27.819275, 114.123734),
			ang = Angle(103.659, 270.000, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_lightbulb"] = {
		name = "Light Bulb",
		desc = "",
		price = 1520,--9500,--12,
		model = "models/illusion/eftcontainers/lightbulb.mdl",
		width = 1,
		height = 1,
		weight = 0.09,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-24.437037, -26.796070, 51.404163),
			ang = Angle(53.047, 45.768, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_lion"] = {
		name = "Bronze Lion",
		desc = "",
		price = 25920,--162000,--12,
		model = "models/illusion/eftcontainers/lionstatue.mdl",
		width = 3,
		height = 2,
		weight = 7.2,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(75.799652, 283.329651, 102.143829),
			ang = Angle(18.146, 255.248, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_magnet"] = {
		name = "Magnet",
		desc = "",
		price = 2032,--12700,--12,
		model = "models/illusion/eftcontainers/magnet.mdl",
		width = 1,
		height = 1,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(45.092552, 37.184708, 74.983574),
			ang = Angle(51.733, 219.518, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_matches"] = {
		name = "Matches",
		desc = "",
		price = 320,--2000,--12,
		model = "models/illusion/eftcontainers/matches.mdl",
		width = 1,
		height = 1,
		weight = 0.005,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(31.287968, 28.578520, 20.039644),
			ang = Angle(24.767, 222.415, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_meds"] = {
		name = "Pile of Meds",
		desc = "",
		price = 1040,--6500,--12,
		model = "models/illusion/eftcontainers/medpile.mdl",
		width = 1,
		height = 1,
		weight = 0.2,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(55.649288, 45.556770, 81.181625),
			ang = Angle(48.363, 219.530, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_syringe"] = {
		name = "Disposable Syringe",
		desc = "",
		price = 480,--3000,--12,
		model = "models/illusion/eftcontainers/medsyringe.mdl",
		width = 1,
		height = 1,
		weight = 0.06,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(16.918648, 15.093630, 55.355949),
			ang = Angle(67.797, 221.800, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_militarybattery"] = {
		name = "Military Battery",
		desc = "",
		price = 52800,--330000,--12,
		model = "models/illusion/eftcontainers/militarybattery.mdl",
		width = 4,
		height = 2,
		weight = 43.2,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(350.396851, -2.304929, 39.662231),
			ang = Angle(5.431, 179.726, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_militaryboard"] = {
		name = "Military Circuit Board",
		desc = "",
		price = 6400,--40000,--12,
		model = "models/illusion/eftcontainers/militaryboard.mdl",
		width = 1,
		height = 1,
		weight = 0.52,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(63.196869, 2.223051, 81.200188),
			ang = Angle(52.158, 182.020, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_militarycable"] = {
		name = "Military Cable",
		desc = "",
		price = 6560,--41000,--12,
		model = "models/illusion/eftcontainers/militarycable.mdl",
		width = 2,
		height = 1,
		weight = 0.65,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(130.743088, 101.841141, 43.366348),
			ang = Angle(14.090, 217.891, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_nailpack"] = {
		name = "Pack of Nails",
		desc = "",
		price = 640,--4000,--12,
		model = "models/illusion/eftcontainers/nailpack.mdl",
		width = 1,
		height = 1,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(49.233067, 49.688862, 47.635220),
			ang = Angle(33.717, 225.179, -15.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_nixxor"] = {
		name = "NIXXOR Lens",
		desc = "",
		price = 4048,--25300,--12,
		model = "models/illusion/eftcontainers/nixxorlens.mdl",
		width = 1,
		height = 1,
		weight = 0.15,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		--destroy = {["id"] = 1},
	},
	["junk_nuts"] = {
		name = "Screw Nuts",
		desc = "Destroy to convert into 4 Light Mechanisms.",
		price = 1392,--8700,--12,
		model = "models/illusion/eftcontainers/nuts.mdl",
		width = 1,
		height = 1,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		destroy = {["comp_mech1"] = 4},
		iconCam = {
			pos = Vector(16.550480, 21.079140, 52.893337),
			ang = Angle(62.780, 231.895, 0.000)
		}
	},
	["junk_screws"] = {
		name = "Pack of Screws",
		desc = "",
		price = 496,--3100,--12,
		model = "models/illusion/eftcontainers/packofscrews.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(31.716215, -76.659256, 77.450333),
			ang = Angle(42.998, 112.513, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_paracord"] = {
		name = "Paracord",
		desc = "",
		price = 3520,--22000,--12,
		model = "models/illusion/eftcontainers/paracord.mdl",
		width = 2,
		height = 1,
		weight = 0.35,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(108.099312, 2.162381, 179.510437),
			ang = Angle(58.709, 181.176, 180.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_asea"] = {
		name = "Phased Array Element",
		desc = "",
		price = 26560,--166000,--12,
		model = "models/illusion/eftcontainers/phaseantenna.mdl",
		width = 2,
		height = 2,
		weight = 1.7,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-61.440659, -0.300000, 196.133575),
			ang = Angle(72.452, 0.025, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_relay"] = {
		name = "Phase Control Relay",
		desc = "",
		price = 1520,--9500,--12,
		model = "models/illusion/eftcontainers/phaserelay.mdl",
		width = 1,
		height = 1,
		weight = 0.08,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(1.099766, 0.185540, 98.640610),
			ang = Angle(89.912, 269.860, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_plexiglass"] = {
		name = "Piece of Plexiglas",
		desc = "",
		price = 1385,--8660,--12,
		model = "models/illusion/eftcontainers/plexiglass.mdl",
		width = 1,
		height = 1,
		weight = 0.7,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-0.202572, 38.860264, 72.925407),
			ang = Angle(61.704, 270.299, 80.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_pliers"] = {
		name = "Pliers",
		desc = "",
		price = 336,--2100,--12,
		model = "models/illusion/eftcontainers/pliers.mdl",
		width = 1,
		height = 1,
		weight = 0.5,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(52.487114, 48.302715, 95.568527),
			ang = Angle(53.013, 222.214, 180.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_powerbank"] = {
		name = "Powerbank",
		desc = "",
		price = 3200,--20000,--12,
		model = "models/illusion/eftcontainers/powerbank.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(72.203049, 23.770094, 78.239761),
			ang = Angle(45.533, 198.263, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_powercord"] = {
		name = "Powercord",
		desc = "Destroy to convert to 4 Spool of Wire.",
		price = 1920,--12000,--12,
		model = "models/illusion/eftcontainers/powercord.mdl",
		width = 2,
		height = 1,
		weight = 0.6,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		destroy = {["comp_wire1"] = 4},
		iconCam = {
			pos = Vector(136.817978, 1.265495, 25.424057),
			ang = Angle(10.234, 180.576, 0.000)
		}
	},
	["junk_powerfilter"] = {
		name = "Military Power Filter",
		desc = "",
		price = 8800,--55000,--12,
		model = "models/illusion/eftcontainers/powerfilter.mdl",
		width = 1,
		height = 1,
		weight = 0.2,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(102.693718, 19.694603, 141.252396),
			ang = Angle(53.173, 190.096, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_psu"] = {
		name = "Power Supply Unit",
		desc = "Destroy to convert to 6 Boxes of Capacitors.",
		price = 1280,--8000,--12,
		model = "models/illusion/eftcontainers/powersupplyunit.mdl",
		width = 2,
		height = 2,
		weight = 0.8,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		destroy = {["junk_boxcap"] = 6},
		iconCam = {
			pos = Vector(-83.762451, 23.027689, 144.537872),
			ang = Angle(58.749, 344.933, 0.000)
		}
	},
	["junk_pressuregauge"] = {
		name = "Pressure Gauge",
		desc = "",
		price = 9792,--61200,--12,
		model = "models/illusion/eftcontainers/pressuregauge.mdl",
		width = 2,
		height = 1,
		weight = 0.8,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-0.125678, -110.592987, 34.686291),
			ang = Angle(16.669, 90.098, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_propane"] = {
		name = "5L Propane Tank",
		desc = "",
		price = 1920,--12000,--12,
		model = "models/illusion/eftcontainers/propanetank.mdl",
		width = 2,
		height = 2,
		weight = 5.3,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(235.568497, 62.910748, 76.330696),
			ang = Angle(15.546, 194.982, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_rfid"] = {
		name = "RFID Reader",
		desc = "",
		price = 7680,--48000,--12,
		model = "models/illusion/eftcontainers/rfidreader.mdl",
		width = 1,
		height = 1,
		weight = 0.5,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(93.220474, 58.890320, 143.992310),
			ang = Angle(52.470, 212.265, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_roler"] = {
		name = "Roler Gold Wrist Watch",
		desc = "",
		price = 11360,--71000,--12,
		model = "models/illusion/eftcontainers/rolex.mdl",
		width = 1,
		height = 1,
		weight = 0.18,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(0.427798, -58.678612, 0.055938),
			ang = Angle(-0.760, 90.395, 40.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_screwdriver"] = {
		name = "Screwdriver",
		desc = "",
		price = 368,--2300,--12,
		model = "models/illusion/eftcontainers/screwdriver.mdl",
		width = 1,
		height = 1,
		weight = 0.15,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(46.590786, 42.517883, 137.434906),
			ang = Angle(65.216, 222.434, 180.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_bolts"] = {
		name = "Bolts",
		desc = "Destroy to convert into 3 Light Mechanisms.",
		price = 1400,--didnt bother to convert, did similar to screw nuts--11000,--12,
		model = "models/illusion/eftcontainers/screwnutbolt.mdl",
		width = 1,
		height = 1,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		destroy = {["comp_mech1"] = 3},
		iconCam = {
			pos = Vector(17.137867, 18.226936, 89.521225),
			ang = Angle(74.227, 225.996, 0.000)
		}
	},
	["junk_silicontube"] = {
		name = "Silicone Tube",
		desc = "",
		price = 3024,--18900,--12,
		model = "models/illusion/eftcontainers/silicontube.mdl",
		width = 1,
		height = 1,
		weight = 0.22,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(37.192829, 16.005798, 163.026123),
			ang = Angle(76.080, 203.333, 30.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_sparkplug"] = {
		name = "Spark Plug",
		desc = "",
		price = 1760,--11000,--12,
		model = "models/illusion/eftcontainers/sparkplug.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(13.805109, 16.186531, 71.133865),
			ang = Angle(73.161, 229.625, 90.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_tetriz"] = {
		name = "Tetriz Portable Game",
		desc = "",
		price = 19200,--120000,--12,
		model = "models/illusion/eftcontainers/tetriz.mdl",
		width = 1,
		height = 2,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-3.585689, 0.000000, 72.359558),
			ang = Angle(92.903, 180.000, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_thermalmodule"] = {
		name = "Military Thermal Vision Module Iridium",
		desc = "",
		price = 12992,--81200,--12,
		model = "models/illusion/eftcontainers/thermalmodule.mdl",
		width = 1,
		height = 1,
		weight = 0.21,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-80.210144, 68.904823, -60.953648),
			ang = Angle(-31.184, 319.426, 30.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_thermometer"] = {
		name = "Analog Thermometer",
		desc = "",
		price = 7296,--45600,--12,
		model = "models/illusion/eftcontainers/thermometer.mdl",
		width = 1,
		height = 2,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-11.387485, 0.989978, 84.808098),
			ang = Angle(84.247, -0.012, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_toolset"] = {
		name = "Tool Set",
		desc = "",
		price = 3200,--20000,--12,
		model = "models/illusion/eftcontainers/toolset.mdl",
		width = 2,
		height = 2,
		weight = 0.9,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(97.846741, -1.000000, 230.580795),
			ang = Angle(66.641, 180.000, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_toothpaste"] = {
		name = "Ortodontox Toothpaste",
		desc = "",
		price = 288,--1800,--12,
		model = "models/illusion/eftcontainers/toothpaste.mdl",
		width = 1,
		height = 1,
		weight = 0.1,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(38.155277, 29.073256, 65.025696),
			ang = Angle(53.498, 217.104, 75.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_virtex"] = {
		name = "Virtex Programmable Processor",
		desc = "",
		price = 19200,--120000,--12,
		model = "models/illusion/eftcontainers/virtex.mdl",
		width = 1,
		height = 1,
		weight = 0.3,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-12.634764, -20.454996, 93.551193),
			ang = Angle(104.435, 238.138, 80.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_waterfilter"] = {
		name = "Water Filter",
		desc = "",
		price = 3920,--24500,--12,
		model = "models/illusion/eftcontainers/waterfilter.mdl",
		width = 1,
		height = 2,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(1.901786, 68.199982, 26.900646),
			ang = Angle(19.668, 269.180, -90.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_weaponparts"] = {
		name = "Weapon Parts",
		desc = "Destroy to convert to 6 Scrap Metal.",
		price = 2278,--14240,--12,
		model = "models/illusion/eftcontainers/weaponparts.mdl",
		width = 2,
		height = 1,
		weight = 0.56,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		destroy = {["comp_scrap_metal"] = 6},
		iconCam = {
			pos = Vector(141.458069, 119.193077, 87.703583),
			ang = Angle(25.286, 219.740, 0.000)
		}
	},
	["junk_transmitter"] = {
		name = "Military COFDM Wireless Transmitter",
		desc = "",
		price = 23280,--145500,--12,
		model = "models/illusion/eftcontainers/wirelesstransmitter.mdl",
		width = 2,
		height = 1,
		weight = 2.0,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(-0.180000, 131.905716, 2.279910),
			ang = Angle(0.291, 270.000, 0.000)
		}
		--destroy = {["id"] = 1},
	},
	["junk_wires"] = {
		name = "Wires",
		desc = "Destroy to convert into 3 Spool of Wire.",
		price = 1184,--7400,--12,
		model = "models/illusion/eftcontainers/wires.mdl",
		width = 1,
		height = 1,
		weight = 0.25,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		destroy = {["comp_wire1"] = 3},
		iconCam = {
			pos = Vector(13.816720, 20.122938, 80.500481),
			ang = Angle(73.003, 235.015, -90.000)
		}
	},
	["junk_wrench"] = {
		name = "Wrench",
		desc = "",
		price = 560,--3500,--12,
		model = "models/illusion/eftcontainers/wrench.mdl",
		width = 1,
		height = 1,
		weight = 0.5,
		flag = "m",
		count = 1,
		isStackable = false,
		exRender = false,
		iconCam = {
			pos = Vector(43.180096, 40.987896, 175.037827),
			ang = Angle(71.259, 223.776, 0.000)
		}
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
		iconCam = {
			pos = Vector(110.30508422852, 92.789710998535, 67.568725585938),
			ang = Angle(25, 220, 0),
			entAng = Angle(23.628705978394, 3.48384141922, -13.81507396698),
			fov = 2.5971047436146,
		},		
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
		iconCam = {
			pos = Vector(51.794200897217, 43.471321105957, 32.71529006958),
			ang = Angle(25, 220, 0),
			entAng = Angle(0, 0, 0),
			fov = 2.8574466976352,
		},		
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
		iconCam = {
			pos = Vector(6.5791311264038, -0.0058006611652672, 17.625494003296),
			ang = Angle(69.593605041504, 180, 31.197961807251),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
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
		iconCam = {
			pos = Vector(6.5791311264038, -0.0058006611652672, 17.625494003296),
			ang = Angle(69.593605041504, 180, 31.197961807251),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
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
		iconCam = {
			pos = Vector(6.5791311264038, -0.0058006611652672, 17.625494003296),
			ang = Angle(69.593605041504, 180, 31.197961807251),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
		--destroy = {["id"] = 1},
	},
	["junk_toolkit1"] = {
		name = "Basic Toolkit",
		desc = "",
		price = 7000,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_box_toolkit_1.mdl",
		category = "misc",
		width = 2,
		height = 1,
		weight = 2.29,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(7.5665831565857, 0, 19.670639038086),
			ang = Angle(68.388458251953, 180, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
		--destroy = {["id"] = 1},
	},
	["junk_toolkit2"] = {
		name = "Advanced Toolkit",
		desc = "",
		price = 10000,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_box_toolkit_2.mdl",
		category = "misc",
		width = 2,
		height = 1,
		weight = 2.56,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(7.5665831565857, 0, 19.670639038086),
			ang = Angle(68.388458251953, 180, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
		--destroy = {["id"] = 1},
	},
	["junk_toolkit3"] = {
		name = "Expert Toolkit",
		desc = "",
		price = 14000,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_box_toolkit_3.mdl",
		category = "misc",
		width = 2,
		height = 1,
		weight = 2.76,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(7.5665831565857, 0, 19.670639038086),
			ang = Angle(68.388458251953, 180, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
		--destroy = {["id"] = 1},
	},
	["junk_toolkitd"] = {
		name = "Drug-making Toolkit",
		desc = "",
		price = 6600,--12,
		model = "models/wick/wrbstalker/anomaly/items/dez_drugskit.mdl",
		category = "misc",
		width = 2,
		height = 1,
		weight = 1.6,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(8.0055150985718, 0, 19.670639038086),
			ang = Angle(68.388458251953, 180, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
		--destroy = {["id"] = 1},
	},
	["junk_toolkita"] = {
		name = "Ammo-making Toolkit",
		desc = "",
		price = 8800,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_box_toolkit_ammo.mdl",
		category = "misc",
		width = 2,
		height = 1,
		weight = 2.12,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(8.0055150985718, 0, 19.670639038086),
			ang = Angle(68.388458251953, 180, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
		--destroy = {["id"] = 1},
	},

	--mutant parts
	["hide_bloodsucker"] = {
		name = "Bloodsucker Hide",
		desc = "",
		price = 2020,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_bloodsucker.mdl",
		width = 2,
		height = 1,
		weight = 1.172,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(-1.0644378662109, 0, 35.217472076416),
			ang = Angle(92.249458312988, 180, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
		--destroy = {["id"] = 1},
	},
	["hide_boar"] = {
		name = "Boar Hide",
		desc = "",
		price = 730,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_boar.mdl",
		width = 2,
		height = 2,
		weight = 1.152,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(-2.4567675590515, 2.2989861965179, 56.958599090576),
			ang = Angle(91.66463470459, -151.84664916992, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
		--destroy = {["id"] = 1},
	},
	["hide_chimera"] = {
		name = "Chimera Hide",
		desc = "",
		price = 3284,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_chimera.mdl",
		width = 2,
		height = 2,
		weight = 1.36,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(11.917684555054, -12.607728004456, 56.958599090576),
			ang = Angle(73.644142150879, 137.87001037598, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
		--destroy = {["id"] = 1},
	},
	["hide_flesh"] = {
		name = "Flesh Hide",
		desc = "",
		price = 640,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_flesh.mdl",
		width = 2,
		height = 2,
		weight = 2.183,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(0.34389463067055, 0.059496499598026, 35.487655639648),
			ang = Angle(89.559036254883, 152.80773925781, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
		--destroy = {["id"] = 1},
	},
	["hide_pseudodog"] = { --hide_pseudodog
		name = "Pseudodog Fur",
		desc = "",
		price = 940,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_pseudodog.mdl",
		width = 2,
		height = 1,
		weight = 1.11,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(24.244268417358, -5.0736255645752, 21.701318740845),
			ang = Angle(43.47953414917, 172.35638427734, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
		--destroy = {["id"] = 1},
	},
	["hide_psydog"] = { --hide_psydog
		name = "Psydog Fur",
		desc = "",
		price = 1570,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_psy_dog.mdl",
		width = 2,
		height = 1,
		weight = 1.16,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(24.244268417358, -5.0736255645752, 21.701318740845),
			ang = Angle(43.47953414917, 172.35638427734, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
		--destroy = {["id"] = 1},
	},
	["hide_pseudogiant"] = { --hide_pseudodog
		name = "Pseudogiant Hide",
		desc = "",
		price = 4090,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_hide_pseudogiant.mdl",
		width = 3,
		height = 2,
		weight = 1.11,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(42.445350646973, -8.0151166915894, 76.778266906738),
			ang = Angle(59.548477172852, 172.35638427734, 0),
			entAng = Angle(0, 0, 0),
			fov = 45,
		},		
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
		iconCam = {
			pos = Vector(192.98796081543, 162.95477294922, 124.00960540771),
			ang = Angle(25, 220, 0),
			entAng = Angle(0, -180, -0.70599770545959),
			fov = 3.9154345901654,
		}		
		--destroy = {["id"] = 1},
	},
	["part_chimera"] = {
		name = "Chimera Horn",
		desc = "",
		price = 3740,--12,
		model = "models/wick/wrbstalker/anomaly/items/dez_item_chimera_cogot.mdl",
		width = 1,
		height = 1,
		weight = 0.122,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(677.77319335938, 523.80078125, 387.59927368164),
			ang = Angle(25, 220, 0),
			entAng = Angle(0, -3.1452519893646, 25.43670463562),
			fov = 0.38433572459084,
		}		
		--destroy = {["id"] = 1},
	},
	["part_chimera_claw"] = {
		name = "Chimera Claw",
		desc = "",
		price = 790,--12,
		model = "models/wick/wrbstalker/anomaly/items/wick_crow_beak.mdl",
		width = 1,
		height = 1,
		weight = 0.122,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(52.070404052734, 43.506481170654, 32.069976806641),
			ang = Angle(25, 220, 0),
			entAng = Angle(0, -10.644762992859, -17.083503723145),
			fov = 2.8477859274274,
		}		
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
		iconCam = {
			pos = Vector(88.209983825684, 74.242218017578, 54.84411239624),
			ang = Angle(25, 220, 0),
			entAng = Angle(39.857192993164, 26.598180770874, -1.4117660522461),
			fov = 4.340351919857,
		}		
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
		iconCam = {
			pos = Vector(67.599822998047, 56.836345672607, 41.220962524414),
			ang = Angle(25, 220, 0),
			entAng = Angle(6.7982883453369, -46.205997467041, -64.048583984375),
			fov = 4.2594936878766,
		}		
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
		iconCam = {
			pos = Vector(182.45651245117, 153.70582580566, 112.90961456299),
			ang = Angle(25, 220, 0),
			entAng = Angle(0, 0.0071214139461517, -24.37558555603),
			fov = 3.7989831229897,
		}		
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
		iconCam = {
			pos = Vector(146.10583496094, 121.0281829834, 93.781967163086),
			ang = Angle(25, 220, 0),
			entAng = Angle(0.033828191459179, -180, -3.4045951366425),
			fov = 4.9296050890315,
		}		
		--destroy = {["id"] = 1},
	},
	["part_snork_mask"] = {
		name = "Snork Mask",
		desc = "",
		price = 1060,--12,
		model = "models/wick/wrbstalker/anomaly/items/dez_snork_mask.mdl",
		width = 2,
		height = 2,
		weight = 0.4,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(204.00061035156, 173.73037719727, 127.07176208496),
			ang = Angle(25, 220, 0),
			entAng = Angle(-1.0036488771439, 17.639936447144, -33.410861968994),
			fov = 2.9873577906575,
		}		
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
		iconCam = {
			pos = Vector(450.42367553711, 382.0791015625, 297.16418457031),
			ang = Angle(25, 220, 0),
			entAng = Angle(-10.72265625, 98.53197479248, -0.7247588634491),
			fov = 1.1429861681383,
		}		
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
		iconCam = {
			pos = Vector(131.85865783691, 111.28971099854, 81.068244934082),
			ang = Angle(25, 220, 0),
			entAng = Angle(34.232643127441, 85.767974853516, 15.801683425903),
			fov = 3.6173958175068,
		}		
		--destroy = {["id"] = 1},
	},
	["part_pseudofang"] = {
		name = "Pseudodog Fang",
		desc = "",
		price = 250,--12, --big fang lmao
		model = "models/wick/wrbstalker/anomaly/items/wick_crow_beak.mdl",
		width = 1,
		height = 1,
		weight = 0.05,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(52.070404052734, 43.506481170654, 32.069976806641),
			ang = Angle(25, 220, 0),
			entAng = Angle(0, -10.644762992859, -17.083503723145),
			fov = 2.8477859274274,
		}		
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
		iconCam = {
			pos = Vector(139.34733581543, 115.75588226318, 85.051696777344),
			ang = Angle(25, 220, 0),
			entAng = Angle(21.415878295898, -25.315452575684, -25.432788848877),
			fov = 4.5299924844488,
		}		
		--destroy = {["id"] = 1},
	},
	["part_pseudogiant_hand"] = {
		name = "Pseudogiant Hand",
		desc = "",
		price = 5340,--12,
		model = "models/wick/wrbstalker/anomaly/items/dez_item_burer_hand.mdl",
		width = 1,
		height = 1,
		weight = 0.184,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(190.94467163086, 160.31996154785, 117.07089233398),
			ang = Angle(25, 220, 0),
			entAng = Angle(37.701168060303, -36.980289459229, -23.149879455566),
			fov = 4.0858655159697,
		}		
		--destroy = {["id"] = 1},
	},
	["part_pseudogiant_eye"] = {
		name = "Pseudogiant Eye",
		desc = "",
		price = 5620,--12,
		model = "models/wick/wrbstalker/anomaly/items/dez_item_flesh_eye.mdl",
		width = 1,
		height = 1,
		weight = 0.034,
		flag = "m",
		count = 1,
		isStackable = false,
		iconCam = {
			pos = Vector(67.599822998047, 56.836345672607, 41.220962524414),
			ang = Angle(25, 220, 0),
			entAng = Angle(6.7982883453369, -46.205997467041, -64.048583984375),
			fov = 4.2594936878766,
		}		
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
		iconCam = {
			pos = Vector(0, 0, 200),
			ang = Angle(90, 0, 0),
			entAng = Angle(0, 180, 0),
			fov = 1.0658581049246,
		}		
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
		iconCam = {
			pos = Vector(0, 0, 200),
			ang = Angle(90, 0, 0),
			entAng = Angle(0, 180, 0),
			fov = 1.0658581049246,
		}		
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
		iconCam = {
			pos = Vector(0, 0, 200),
			ang = Angle(90, 0, 0),
			entAng = Angle(0, 180, 0),
			fov = 1.0658581049246,
		}		
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
		iconCam = {
			pos = Vector(0, 0, 200),
			ang = Angle(90, 0, 0),
			entAng = Angle(0, 180, 0),
			fov = 1.0658581049246,
		}		
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
		iconCam = {
			pos = Vector(0, 0, 200),
			ang = Angle(90, 0, 0),
			entAng = Angle(0, 180, 0),
			fov = 1.0658581049246,
		}		
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
		iconCam = {
			pos = Vector(0, 0, 200),
			ang = Angle(90, 0, 0),
			entAng = Angle(0, 180, 0),
			fov = 1.0658581049246,
		}		
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
		iconCam = {
			pos = Vector(0, 0, 200),
			ang = Angle(90, 0, 0),
			entAng = Angle(0, 180, 0),
			fov = 1.0658581049246,
		}		
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
		iconCam = {
			pos = Vector(0, 0, 200),
			ang = Angle(90, 0, 0),
			entAng = Angle(0, 180, 0),
			fov = 1.0658581049246,
		}		
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
		if(data.category) then
			ITEM.category = data.category
		end
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
		if(data.exRender != nil) then
			ITEM.exRender = data.exRender
		end
	end		
end