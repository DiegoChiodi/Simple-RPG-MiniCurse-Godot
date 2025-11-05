extends BaseEntity
class_name Player


@onready var hurtDownCol  := $hurtBoxDown/CollisionShape2D
@onready var hurtUpCol    := $hurtBoxUp/CollisionShape2D
@onready var hurtLeftCol  := $hurtBoxLeft/CollisionShape2D
@onready var hurtRightCol := $hurtBoxRight/CollisionShape2D


var directionLast : Vector2 = Vector2.ZERO
var attackDelay : float = 0.5
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
	
	if direction != Vector2.ZERO:
		directionLast = direction
	animation(directionLast)
 	
func setDirection() -> void:
	if inAttack:
		direction = Vector2.ZERO
		return
	sprite.flip_h = false
	
		# 1) Captura o movimento
	direction = Vector2.ZERO
	moving = false

	if Input.is_action_pressed("Down"):
		direction.y = 1
		moving = true
		
	elif Input.is_action_pressed("Up"):
		direction.y = -1
		moving = true

	if Input.is_action_pressed("Right"):
		direction.x = 1
		moving = true
	elif Input.is_action_pressed("Left"):
		direction.x = -1
		moving = true
		
func animation(dir : Vector2):
	if inAttack:
		if abs(dir.x) >= abs(dir.y):
			# Movimento horizontal (esquerda / direita)
			sprite.play("attackX")
			sprite.flip_h = dir.x < 0
		elif dir.y > 0:
			sprite.play("attackDown")
		else:
			sprite.play("attackUp")
		return
	
	super.animation(dir)

func isRival (area : Area2D) -> bool:
	return super.isRival(area) and area.get_parent() is Enemy
