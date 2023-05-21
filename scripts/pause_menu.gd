extends Control


func _on_resume_pressed():
	get_tree().paused = false
	visible = false


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
