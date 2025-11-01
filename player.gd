extends CharacterBody2D

var directionLast : Vector2 = Vector2.ZERO
const SPEED = 300.0
@onready var sprite := $AnimationPlayer

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : Vector2 = Vector2.ZERO
	
	var moving : bool = false
	
	if Input.is_action_pressed("Down"):
		direction.y = 1
		moving = true
		sprite.play("RunDown")
		
	
	if Input.is_action_pressed("Up"):
		direction.y = -1
		moving = true
		sprite.play("RunUp")
	
	if Input.is_action_pressed("Right"):
		direction.x = 1
		moving = true
	
	if Input.is_action_pressed("Left"):
		direction.x = -1
		moving = true
	
	if moving:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	
	
	
	move_and_slide()
