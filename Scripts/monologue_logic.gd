extends Control

@onready var Name : Label = $Background/Name_Background/Name
@onready var MonologueText : Label = $Background/Text

signal monologue_finished()

var lines = []
var index = 0

func start_monologue(monologue_lines, character_name):
	lines = monologue_lines
	Name.text = character_name
	index = 0
	show()
	MainGameManager.is_player_frozen = true
	print_line()

func print_line():
	if index < lines.size():
		MonologueText.text = lines[index]
	else:
		hide()
		MainGameManager.is_monologue_never_played_before = false
		MainGameManager.is_player_frozen = false
		SignalBus.emit_signal("monologue_finished")
		Engine.time_scale = 1

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		index += 1
		print_line()

func _ready() -> void:
	if str(get_tree().current_scene.name) == "Main":
		if MainGameManager.is_monologue_never_played_before:
			start_monologue([
				"Oh hi! \nDo you want a tutorial on how things work here? \n(Press 'E', or 'Z' to continue)",
				"We're in a restaurant and you're the chef.\nUnfortunately, all the waiters took the day off,\nso you'll have to be the waiter today.",
				"Use WASD or arrow keys to move.\nPress 'E', or 'Z' to interact.",
				"If you get tired, I have milk for $30.\nServe customers by delivering food to their \ntables.",
				"Oh, I almost forgot to mention! \nYou can buy upgrades for tables.\nCustomers will then pay more.",
				"You need to purchase some of tables\nto get more customers and deliver their food \nfaster.",
				"You can pick up the ordered items\nfrom the spot near my shop :3"
			], "Mr. Meow")
