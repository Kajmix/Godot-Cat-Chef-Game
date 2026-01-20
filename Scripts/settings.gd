extends CenterContainer
@onready var Music : Label = $VBoxContainer/SoundControl/MusicLabel
@onready var SFX : Label = $VBoxContainer/SoundControl/SFXLabel
@onready var MusicSLider : HSlider = $VBoxContainer/SoundControl/MusicSlider
@onready var SFXSLider : HSlider = $VBoxContainer/SoundControl/SFXSlider
@onready var Player = $"../../../../Player"
func _ready() -> void:
	Music.text = "Music Volume: " + str(int(MusicSLider.value))
	SFX.text = "SFX Volume: " + str(int(SFXSLider.value))
	MainGameManager.loading_finished.connect(_on_loading_finished)
func _on_reset_pressed() -> void:
	MainGameManager.default_save["customer_with_keys"] = randi_range(200, 250)
	
	var save_file = ConfigFile.new()
	for key in MainGameManager.default_save.keys():
		save_file.set_value("SaveData", key, MainGameManager.default_save[key])
	
	save_file.save("user://save.cfg")
	
	MainGameManager.load_save(Player);
	get_tree().reload_current_scene()

func _on_music_slider_value_changed(value: int) -> void:
	Music.text = "Music Volume: " + str(value)
	MusicPlayer.volume_db = linear_to_db(value / 100.0)
	MainGameManager.music_volume = value

func _on_sfx_slider_value_changed(value: int) -> void:
	SFX.text = "SFX Volume: " + str(value)
	Audio_Player.volume_db = linear_to_db(value / 100.0)
	MainGameManager.sfx_volume = value

func _on_loading_finished():
	MusicSLider.value = MainGameManager.music_volume
	SFXSLider.value = MainGameManager.sfx_volume
	Music.text = "Music Volume: " + str(MainGameManager.music_volume)
	MusicPlayer.volume_db = linear_to_db(MainGameManager.music_volume / 100.0)
	SFX.text = "SFX Volume: " + str(MainGameManager.sfx_volume)
	Audio_Player.volume_db = linear_to_db(MainGameManager.sfx_volume / 100.0)
