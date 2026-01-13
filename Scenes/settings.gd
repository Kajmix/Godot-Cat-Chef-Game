extends CenterContainer
@onready var Music : Label = $VBoxContainer/SoundControl/MusicLabel
@onready var SFX : Label = $VBoxContainer/SoundControl/SFXLabel
@onready var MusicSLider : HSlider = $VBoxContainer/SoundControl/MusicSlider
@onready var SFXSLider : HSlider = $VBoxContainer/SoundControl/SFXSlider
func _ready() -> void:
	Music.text = "Music Volume: " + str(int(MusicSLider.value))
	SFX.text = "SFX Volume: " + str(int(SFXSLider.value))

func _on_reset_pressed() -> void:
	var save_file = ConfigFile.new()
	save_file.set_value("SaveData", "player_pos_x", MainGameManager.default_save.player_pos_x)
	save_file.set_value("SaveData", "player_pos_y", MainGameManager.default_save.player_pos_y)
	save_file.set_value("SaveData", "money", MainGameManager.default_save.money)
	save_file.set_value("SaveData", "served_customers", MainGameManager.default_save.served_customers)
	save_file.set_value("SaveData", "is_monologue_never_played_before", MainGameManager.default_save.is_monologue_never_played_before)
	save_file.set_value("SaveData", "tables", MainGameManager.default_save.tables)
	save_file.save("user://save.cfg")
	MainGameManager.is_monologue_never_played_before = true
	get_tree().reload_current_scene()


func _on_music_slider_value_changed(value: int) -> void:
	Music.text = "Music Volume: " + str(value)
	MusicPlayer.volume_db = linear_to_db(value / 100.0)
func _on_sfx_slider_value_changed(value: int) -> void:
	SFX.text = "SFX Volume: " + str(value)
	Audio_Player.volume_db = linear_to_db(value / 100.0)
