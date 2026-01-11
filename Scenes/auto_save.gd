extends Timer

@onready var Player : CharacterBody2D = $"../Player"

func _ready() -> void:
	MainGameManager.load_save(Player)
	MainGameManager.autosave(Player)
	print("Loaded Save")

func _on_auto_save_timeout() -> void:
	MainGameManager.autosave(Player)
	print("Saved Save")
