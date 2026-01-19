extends Node2D
@onready var Monologue : Control = $CanvasLayer/Control/Monologue

func _on_creator_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Monologue.start_monologue(
			[
			"Oh, hi!", 
			"Did you know? You have served " + str(MainGameManager.served_customers) + " customers. Congrats!", 
			"I want to thank you, Player, for giving my game a chance \nand for the time you have spent.", 
			"So... thank you."
			],
			"The Creator"
		)
