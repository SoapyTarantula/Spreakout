extends Control

func _ready():
	$MarginContainer/VBoxContainer/Music_Vol_Slider.value = Music.m_vol
	$MarginContainer/VBoxContainer/Game_Vol_Slider.value = Music.g_vol
	
	if Music.music_toggle:
		$MarginContainer/VBoxContainer/Music_Toggle.button_pressed = true
	else:
		$MarginContainer/VBoxContainer/Music_Toggle.button_pressed = false

func _on_music_vol_slider_value_changed(value):
	Music.m_vol = value
	Music.mvol_db = linear_to_db(value)

func _on_game_vol_slider_value_changed(value):
	Music.g_vol = value
	Music.gvol_db = linear_to_db(value)

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _on_music_toggle_toggled(toggled_on):
	if toggled_on:
		Music.music_toggle = true
	else:
		Music.music_toggle = false
