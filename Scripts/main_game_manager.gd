extends Node2D
var money = 0
var served_customers = 0
var is_monologue_never_played_before : bool = true
var music_volume = 50
var sfx_volume = 75
signal loading_finished()
func client_exit(order_value):
	money += order_value
	served_customers += 1
func sub_money(value):
	money -= value

#Default:
var default_save = {
	"player_pos_x" : -120,
	"player_pos_y" : -43,
	"money" : 0,
	"served_customers" : 0,
	"is_monologue_never_played_before" : true,
	"music_volume" : music_volume,
	"sfx_volume" : sfx_volume,
	"tables": [
		{"id": 0, "is_not_bought": true},
		{"id": 1, "is_not_bought": false},
		{"id": 2, "is_not_bought": true},
		{"id": 3, "is_not_bought": false},
		{"id": 4, "is_not_bought": true},
		{"id": 5, "is_not_bought": true},
		{"id": 6, "is_not_bought": false},
		{"id": 7, "is_not_bought": true}
	]
}


# Autosave:
func autosave(player):
	var data = {
		"player_pos_x" : player.position.x,
		"player_pos_y" : player.position.y,
		"money" : money,
		"served_customers" : served_customers,
		"is_monologue_never_played_before" : is_monologue_never_played_before,
		"music_volume" : music_volume,
		"sfx_volume" : sfx_volume
	}
	
	var tables_state = []
	
	for table in get_tree().get_nodes_in_group("table"):
		tables_state.append({
			"id" : table.id,
			"is_not_bought" : table.is_not_bought
		})
	data["tables"] = tables_state
	
	var autosave_file = ConfigFile.new()
	for key in data.keys():
		autosave_file.set_value("SaveData", key, data[key])
	autosave_file.save("user://save.cfg")
	emit_signal("loading_finished")

func load_save(player):
	var autosave_file = ConfigFile.new()
	var err = autosave_file.load("user://save.cfg")
	if err != OK:
		return
	if player != null:
		player.position.x = autosave_file.get_value("SaveData", "player_pos_x", 0)
		player.position.y = autosave_file.get_value("SaveData", "player_pos_y", 0)
	money = autosave_file.get_value("SaveData", "money", 0)
	served_customers = autosave_file.get_value("SaveData", "served_customers", 0)
	is_monologue_never_played_before = autosave_file.get_value("SaveData", "is_monologue_never_played_before", true)
	music_volume = autosave_file.get_value("SaveData", "music_volume", 50)
	sfx_volume = autosave_file.get_value("SaveData", "sfx_volume", 75)
	
	var tables_loaded = autosave_file.get_value("SaveData", "tables", [])
	
	if tables_loaded.size() > 0:
		var all_tables = get_tree().get_nodes_in_group("table")
		for saved_table in tables_loaded:
			for table in all_tables:
				if table.id == saved_table["id"]:
					table.is_not_bought = saved_table["is_not_bought"]
		emit_signal("loading_finished")
