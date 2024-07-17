extends Control

func _ready():
	var existing_save = FileAccess.file_exists("user://saved_game.tres")
	if existing_save:
		gm.no_save = false
	else:
		gm.no_save = true
	
	if gm.no_save:
		$MarginContainer/VBoxContainer/Resume.visible = false
	else:
		$MarginContainer/VBoxContainer/Resume.visible = true

func _on_play_pressed():
	gm.is_resume = false
	gm.score = 0
	gm.level = 1
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/options.tscn")

func _on_exit_pressed():
	get_tree().quit()
	
func _on_resume_pressed():
	gm.is_resume = true
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
