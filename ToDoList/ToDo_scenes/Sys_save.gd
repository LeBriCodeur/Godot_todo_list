tool
extends Node2D

var path_save = "user://dico_todo.txt"

func _ready():
	pass

func save(content):
	var file = File.new()
	file.open(path_save, File.WRITE)
	if content is Dictionary:
		content = to_json(content)
	file.store_string(content)
	file.close()


func load_todo():
	var file = File.new()
	var err = file.open(path_save, File.READ)
	if err != OK:
		save({})
		return {}
	var content = file.get_as_text()
	file.close()
	return parse_json(content)
