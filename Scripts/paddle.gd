extends CharacterBody2D

@export_category("Movement")
@export var speed: int = 500
@export var starting_position:Vector2
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		%SaverLoader.save_game_state()
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _physics_process(_delta):
	if position.y != starting_position.y:
		position.y = starting_position.y
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * speed 
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
