@tool
extends Node2D

var path_save = "user://dico_todo.txt"

func save(content):
	var file = FileAccess.open(path_save, FileAccess.WRITE)
#	file.open(path_save, File.WRITE)
	if content is Dictionary:
		content = var_to_str(content)
	file.store_string(content)

func load_todo():
	var file = FileAccess.open(path_save, FileAccess.READ)
	if !file:
		save({})
		return {}
	var content = file.get_as_text()
	return str_to_var(content)
