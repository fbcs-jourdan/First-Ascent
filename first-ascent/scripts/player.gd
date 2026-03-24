extends CharacterBody2D

@onready var player: CharacterBody2D = $"."

func _process(delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		player.global_position.x += 10
	if Input.is_action_pressed("move_left"):
		player.global_position.x -= 10
	if Input.is_action_pressed("move_up"):
		player.global_position.y -= 10
	if Input.is_action_pressed("move_down"):
		player.global_position.y += 10
