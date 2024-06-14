@tool
extends Window

var editor : Control
var editor_window : Window
var window_factor_window : Window
var editor_start_size:Vector2
var editor_content_scale:=1.0
#
func _on_about_to_popup() -> void:
	editor = find_child("Editor")
	editor_window = find_child("Window")
	window_factor_window = find_child("WindowFactorWindow")
	editor_start_size = editor.size
	
	editor_window.visible = true
	window_factor_window.visible = true
	
	await get_tree().process_frame
	update_content_scale(1.0)
#
func _process(delta):
	if not editor or not editor_window:
		return
	update_content_scale(editor_content_scale)
#
func _on_close_requested() -> void:
	var text := ""
	hide()


func update_content_scale(scale_factor:float):
	if not editor_window or not editor:
		return
	
	editor_window.content_scale_factor = scale_factor
	
	editor.size.x = max(size.x, editor_start_size.x) / scale_factor
	editor.size.y = max(size.y, editor_start_size.y) / scale_factor
	
	editor_window.size = size
	editor_window.size *= 2
	editor_window.size.y -= find_child("WindowFactorContainer").size.y*2
	editor_window.position = -size
	editor_window.position.y += find_child("WindowFactorContainer").size.y
	
	find_child("WindowFactorLabel").text = str(scale_factor * 100, "%")
	window_factor_window.position.y = size.y - find_child("WindowFactorContainer").size.y
	

func _on_size_changed() -> void:
	update_content_scale(editor_content_scale)
