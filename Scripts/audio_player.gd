extends AudioStreamPlayer
const sound_effects = {
	"click" : preload("res://audio/SFX/click.wav"),
	"gulp" : preload("res://audio/SFX/gulp.wav"),
	"katching" : preload("res://audio/SFX/katching.wav"),
	"money" : preload("res://audio/SFX/money.mp3"),
	"cinematic-boom" : preload("res://audio/SFX/cinematic-boom.mp3"),
	"place-something" : preload("res://audio/SFX/place-something.mp3"),
	"bush" : preload("res://audio/SFX/bush.mp3"),
	"door" : preload("res://audio/SFX/opening-door.mp3")
}

func play_sound(sound):
	stream = sound_effects[sound]
	pitch_scale = randf_range(0.95,1.05)
	play()
