tool
extends EditorPlugin

var sc_todo

func _enter_tree():
	sc_todo = preload("res://addons/ToDoList/ToDo_scenes/MCF_todo.tscn").instance()
	add_control_to_dock(DOCK_SLOT_RIGHT_BL, sc_todo)

func _exit_tree():
	remove_control_from_docks(sc_todo)
	sc_todo.queue_free()

func save_external_data():
	sc_todo.save_task()
