extends CharacterBody2D


var speed : float
const normSpeed := 40000.0
const sprintSpeed := 75000.0
const zoomPercent : Vector2 = Vector2(0.1, 0.1)
const maxZoom : Vector2 = Vector2.ZERO
const minZoom : Vector2 = Vector2(2, 2)

@onready var cam : Camera2D = $Camera2D

func _ready() -> void:
	speed = normSpeed

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("game_sprint"):
		speed = sprintSpeed
	else:
		speed = normSpeed

	var directionx := Input.get_axis("game_left", "game_right")
	var directiony := Input.get_axis("game_up", "game_down")
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
	
	if Input.is_action_just_pressed("game_zoom_in") and (cam.zoom + zoomPercent) < minZoom:
		cam.zoom += zoomPercent
	if Input.is_action_just_pressed("game_zoom_out") and (cam.zoom - zoomPercent) > maxZoom:
		cam.zoom -= zoomPercent
	
	move_and_slide()
