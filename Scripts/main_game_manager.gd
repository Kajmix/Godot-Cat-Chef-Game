extends Node2D
var money = 0
var served_customers = 0
func client_exit(order_value):
	money += order_value
	served_customers += 1
func sub_money(value):
	money -= value

# Autosave:
func autosave(player):
	var data = {
		"player_pos_x" : player.position.x,
		"player_pos_y" : player.position.y,
		"money" : money,
		"served_customers" : served_customers
	}
	
	var autosave_file = ConfigFile.new()
	for key in data.keys():
		autosave_file.set_value("SaveData", key, data[key])
	autosave_file.save("user://save.cfg")

func load_save(player):
	var autosave_file = ConfigFile.new()
	var err = autosave_file.load("user://save.cfg")
	if err != OK:
		return
	
	player.position.x = autosave_file.get_value("SaveData", "player_pos_x", 0)
	player.position.y = autosave_file.get_value("SaveData", "player_pos_y", 0)
	money = autosave_file.get_value("SaveData", "money", 0)
	served_customers = autosave_file.get_value("SaveData", "served_customers", 0)
