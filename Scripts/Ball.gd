extends CharacterBody2D

@export var speed: int = 100
@onready var sound = $bounce_sound

var setup_finished: bool = false

func _ready():
	await get_tree().create_timer(1).timeout
	speed = speed * (1 + gm.level * 0.1)
	if not gm.is_resume and not gm.is_loading:
		velocity = Vector2(speed * -1, speed)
	setup_finished = true
	
func _process(_delta):
	sound.volume_db = Music.gvol_db

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		sound.pitch_scale = randf_range(0.75, 1.5)
		sound.play()
		if collision.get_collider().has_method("hit"):
			collision.get_collider().hit()
	
	if (velocity.y > 0 and velocity.y < 100):
		velocity.y = -speed
		
	if (velocity.x == 0 and setup_finished):
		velocity.x = randi_range(-speed, speed)

func start_over():
	gm.score = 0
	gm.level = 1
	get_tree().reload_current_scene()

func _on_bottom_body_entered(_body):
	if setup_finished:
		await get_tree().create_timer(0.25).timeout
		$fail.volume_db = Music.gvol_db
		$fail.play()
		await get_tree().create_timer(1).timeout
		call_deferred("start_over")
