if(SERVER) then

sound.Add( {
	name = "Bloodsucker.FootStep",
	channel = CHAN_BODY,
	volume = 1,
	level = 320,
	pitch = { 100, 102 },
	sound = {"wick/bloodsucker/foot1.wav",
	"wick/bloodsucker/foot2.wav",
	"wick/bloodsucker/foot3.wav",
	"wick/bloodsucker/foot4.wav"}
} )

sound.Add( {
	name = "Bloodsucker.PunchGrass",
	channel = CHAN_BODY,
	volume = 1,
	level = 320,
	pitch = { 100, 100 },
	sound = {"wick/bloodsucker/punch.wav"}
} )

sound.Add( {
	name = "Bloodsucker.DigGrass",
	channel = CHAN_BODY,
	volume = 1,
	level = 320,
	pitch = { 100, 102 },
	sound = {"wick/bloodsucker/dig.wav"}
} )

sound.Add( {
	name = "Bloodsucker.Eat",
	channel = CHAN_BODY,
	volume = 1,
	level = 320,
	pitch = { 100, 102 },
	sound = {"wick/bloodsucker/eat_0.wav", "wick/bloodsucker/eat_1.wav"}
} )


end