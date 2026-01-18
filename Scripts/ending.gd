extends Node2D
@onready var Monologue : Control = $CanvasLayer/Control/Monologue

func _on_creator_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Monologue.start_monologue(
			[
			"Oh, hi User ^^"
			],
			"The Creator"
		)
