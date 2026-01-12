extends AudioStreamPlayer
const sound_effects = {
	"click" : "res://audio/SFX/click.wav",
	"gulp" : "res://audio/SFX/gulp.wav",
	"katching" : "res://audio/SFX/katching.wav"
}

func play_sound(sound):
	stream = load(sound_effects[sound])
	pitch_scale = randf_range(0.95,1.05)
	play()
