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
	var save_file = ConfigFile.new()
	save_file.set_value("SaveData", "player_pos_x", MainGameManager.default_save.player_pos_x)
	save_file.set_value("SaveData", "player_pos_y", MainGameManager.default_save.player_pos_y)
	save_file.set_value("SaveData", "money", MainGameManager.default_save.money)
	save_file.set_value("SaveData", "served_customers", MainGameManager.default_save.served_customers)
	save_file.set_value("SaveData", "is_monologue_never_played_before", MainGameManager.default_save.is_monologue_never_played_before)
	save_file.set_value("SaveData", "music_volume", MainGameManager.default_save.music_volume)
	save_file.set_value("SaveData", "sfx_volume", MainGameManager.default_save.sfx_volume)
	save_file.set_value("SaveData", "is_have_keys", MainGameManager.default_save.is_have_keys)
	save_file.set_value("SaveData", "is_door_open", MainGameManager.default_save.is_door_open)
	var customer_with_keys_var = randi_range(200,250)
	save_file.set_value("SaveData", "customer_with_keys", customer_with_keys_var)
	save_file.set_value("SaveData", "tables", MainGameManager.default_save.tables)
	MainGameManager.customer_with_keys = customer_with_keys_var
	MainGameManager.is_monologue_never_played_before = true
	save_file.save("user://save.cfg")
	MainGameManager.load_save(Player)
	Engine.time_scale = 1
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
