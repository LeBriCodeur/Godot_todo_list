tool
extends Panel

signal update_info(id, is_checked)

var task_id : int setget set_task_id, get_task_id
var task_name : String setget set_task_name, get_task_name
var task_checked : bool setget set_task_checked, get_task_checked

func _ready():
	randomize()
	task_id = randi() # en cas de soucis créer un uid

func set_info(a_id, a_name, a_checked):
	set_task_id(a_id)
	set_task_name(a_name)
	set_task_checked(a_checked)
	$TextTask.text = a_name
	if a_checked:
		$CheckBox.pressed = a_checked

func set_task_id(value): task_id = value
func get_task_id(): return task_id

func set_task_name(value): task_name = value
func get_task_name(): return task_name

func set_task_checked(value): task_checked = value
func get_task_checked(): return task_checked

func _on_CheckBox_toggled(button_pressed):
	set_task_checked(button_pressed)

func _on_BtnEdit_pressed():
	if $TextTask.readonly:
		$TextTask.readonly = false
	else:
		$TextTask.readonly = true

func _on_TextTask_focus_exited():
	$TextTask.readonly = true
	set_task_name($TextTask.text)
