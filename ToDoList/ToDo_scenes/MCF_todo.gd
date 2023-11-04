@tool
extends Control

var dico_save : Dictionary

func _ready():
	load_todo_list()

func load_todo_list():
	dico_save = get_node("Sys_save").load_todo()
	if !dico_save.size(): return
	var dico_keys = dico_save.keys()
	for i in dico_keys:
		create_old_task(i)

func create_old_task(i):
	var old_task = load("res://addons/ToDoList/ToDo_scenes/Task_panel.tscn").instantiate()
	$Panel/ScrollContainer/TaskContainer.add_child(old_task)
	old_task.connect("update_info", self, "save_task")
	old_task.set_info(dico_save[i]["task_id"], dico_save[i]["task_name"], dico_save[i]["task_checked"])

func save_task(_id = -1, _is_checked = false):
	var n_dico = {}
	for i in get_node("Panel/ScrollContainer/TaskContainer").get_children():
		if i.task_id > 0:
			n_dico[i.task_id] = {
				"task_id" : i.task_id,
				"task_name" : i.task_name,
				"task_checked" : i.task_checked,
			}
	get_node("Sys_save").save(var_to_str(n_dico))

func add_task():
	
	if $Panel/VBoxContainer/TaskEdit.text.is_empty(): return
	var nt = load("res://addons/ToDoList/ToDo_scenes/Task_panel.tscn").instantiate()
	nt.get_node("TextTask").text = $Panel/VBoxContainer/TaskEdit.text
	get_node("Panel/ScrollContainer/TaskContainer").add_child(nt)
	nt.task_name = $Panel/VBoxContainer/TaskEdit.text
	$Panel/VBoxContainer/TaskEdit.text = ""
	nt.update_info.connect(save_task)
#	nt.connect("update_info", self, "save_task")

func _on_BtnAddTask_pressed():
	add_task()

func _on_BtnDeleteTask_pressed():
	for i in get_node("Panel/ScrollContainer/TaskContainer").get_children():
		if i.task_checked:
			i.queue_free()
