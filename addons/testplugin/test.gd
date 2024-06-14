@tool
extends EditorPlugin

var window:Window
var toolbar_button

func _enter_tree() -> void:
	toolbar_button = preload("res://mrp/test_button.tscn").instantiate()
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, toolbar_button)
	toolbar_button.focus_mode = Control.FOCUS_NONE
	toolbar_button.visible = true
	toolbar_button.is_in_editor = true
	toolbar_button.pressed.connect(open_window)
	toolbar_button.request_open.connect(open_window)
	


func open_window():
	if is_instance_valid(window):
		window.grab_focus()
	else:
		window = preload("res://mrp/laggy_window.tscn").instantiate()
		get_editor_interface().get_base_control().add_child.call_deferred(window)
		await get_tree().process_frame
		window.popup()
