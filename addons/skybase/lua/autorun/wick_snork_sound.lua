if(SERVER) then

sound.Add( {
	name = "Snork.FootStep",
	channel = CHAN_BODY,
	volume = 1,
	level = 320,
	pitch = { 100, 102 },
	sound = {"wick/snork/earth01gr.wav",
	"wick/snork/earth02gr.wav"}
} )


sound.Add( {
	name = "Snork.Floor",
	channel = CHAN_BODY,
	volume = 1,
	level = 320,
	pitch = { 100, 102 },
	sound = {"wick/snork/large1.wav",
	"wick/snork/large2.wav"}
} )
end
