extends CharacterBody2D


var speed : float
@export var normSpeed := 400.0
@export var sprintSpeed := 750.0

func _ready() -> void:
	normSpeed *= 100
	sprintSpeed *= 100
	speed = normSpeed

func _physics_process(delta: float) -> void:
	#if Input.is_action_pressed("game_sprint"):
		#speed = sprintSpeed
	#else:
		#speed = normSpeed

	var directionx := randf_range(-1, 1)
	var directiony := randf_range(-1, 1)
	#print("X: %s" % directionx)
	#print("Y: %s" % directiony)
	
	if directionx:
		velocity.x = directionx * speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if directiony:
		velocity.y = directiony * speed * delta
	else:
		velocity.y = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
