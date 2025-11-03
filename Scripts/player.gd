extends BaseEntity
class_name Player


@onready var hurtDownCol  := $hurtBoxDown/CollisionShape2D
@onready var hurtUpCol    := $hurtBoxUp/CollisionShape2D
@onready var hurtLeftCol  := $hurtBoxLeft/CollisionShape2D
@onready var hurtRightCol := $hurtBoxRight/CollisionShape2D


var directionLast : Vector2 = Vector2.ZERO
var attackDelay : float = 0.1
var attackWait : float = attackDelay
var inAttack : bool = false

func _ready() -> void:
	sprite = $sprite

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("left_click") or Input.is_action_just_pressed("space")) and !inAttack:
		if directionLast.x == -1:
			hurtLeftCol.disabled = false
		elif directionLast.x == 1:
			hurtRightCol.disabled = false
		elif directionLast.y == 1:
			hurtDownCol.disabled = false
		elif directionLast.y == -1:
			hurtUpCol.disabled = false
		
		attackWait = 0.0
		inAttack = true
	
	if attackWait < attackDelay:
		attackWait += delta
	else:
		hurtLeftCol.disabled = true
		hurtRightCol.disabled = true
		hurtDownCol.disabled = true
		hurtUpCol.disabled = true
		inAttack = false
	
	animation(directionLast)
 
func setDirection() -> void:
	var moving : bool = false
	
	sprite.flip_h = false
	
	if Input.is_action_pressed("Down"):
		direction.y = 1
		moving = true
		sprite.play("runDown")
	
	elif Input.is_action_pressed("Up"):
		direction.y = -1
		moving = true
		sprite.play("runUp")
	else:
		direction.y = 0
		
	if Input.is_action_pressed("Right"):
		direction.x = 1
		moving = true
		sprite.play("runX")
	
	elif Input.is_action_pressed("Left"):
		direction.x = -1
		moving = true
		sprite.play("runX")
		sprite.flip_h = true
	else:
		direction.x = 0
	
	if moving:
		directionLast = direction
	else:
		direction = Vector2.ZERO
		if directionLast.x == 1:
			sprite.play("idleX")
		elif directionLast.x == -1:
			sprite.play("idleX")
			sprite.flip_h = true
		elif directionLast.y == 1:
			sprite.play("idleDown")
		else:
			sprite.play("idleUp")

func isRival (area : Area2D) -> bool:
	return super.isRival(area) and area.get_parent() is Enemy
