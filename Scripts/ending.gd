extends Node2D
@onready var Monologue : Control = $CanvasLayer/Control/Monologue
@onready var Ending_Canvas = $Ending_Canvas
@onready var Ending_delay = $Ending_Canvas/Timer
func _ready() -> void:
	MusicPlayer.stream = load("res://audio/music/into-the-void-380585.mp3")
	MusicPlayer.play()
	SignalBus.monologue_finished.connect(_on_monologue_finished)

func _on_creator_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Monologue.start_monologue(
			[
			"Oh, hi!",
			"Did you know?\nYou’ve served " + str(MainGameManager.served_customers) + " customers.\nCongrats!",
			"I want to thank you, Player,\nfor giving my game a chance\nand for the time you’ve spent.",
			"I need to tell you something.\nThis is the end.\nYou reached the finale. You can leave now,",
			"but if you want, you can still keep playing.\nAs if you never met me.\nOr you can reset everything.",
			"That depends entirely on you.",
			"So... thank you."
			],
			"The Creator"
		)

func _on_monologue_finished():
	Audio_Player.play_sound("cinematic-boom")
	Ending_Canvas.show()
	Ending_delay.start()

func _on_ending_delay_timeout() -> void:
	MusicPlayer.stream = load("res://audio/music/jazz-cafe-restaurant-music-372190.mp3")
	MusicPlayer.play()
	Fade.play_transition_and_change("res://Scenes/menu.tscn")
