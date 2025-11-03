extends Node2D

@onready var player := $Player
@onready var enemy := $Enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy.setup(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
