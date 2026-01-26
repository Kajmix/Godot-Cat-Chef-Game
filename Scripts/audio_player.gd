extends AudioStreamPlayer
const sound_effects = {
	"click" : "res://audio/SFX/click.wav",
	"gulp" : "res://audio/SFX/gulp.wav",
	"katching" : "res://audio/SFX/katching.wav",
	"money" : "res://audio/SFX/money.mp3",
	"cinematic-boom" : "res://audio/SFX/cinematic-boom.mp3",
	"place-something" : "res://audio/SFX/place-something.mp3",
	"bush" : "res://audio/SFX/bush.mp3"
}

func play_sound(sound):
	stream = load(sound_effects[sound])
	pitch_scale = randf_range(0.95,1.05)
	play()
