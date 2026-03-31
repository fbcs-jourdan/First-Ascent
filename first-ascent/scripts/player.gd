extends CharacterBody2D

@onready var player: CharacterBody2D = $"."
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var moving := true

func _process(delta: float) -> void:
	if Climb.can_move:
		if Input.is_action_pressed("move_right"):
			animated_sprite.play("move_right")
			player.global_position.x += 1.2
			moving = true
		if Input.is_action_pressed("move_left"):
			animated_sprite.play("move_left")
			player.global_position.x -= 1.2
			moving = true
		if Input.is_action_pressed("move_up"):
			animated_sprite.play("move_up")
			player.global_position.y -= 1.2
			moving = true
		if Input.is_action_pressed("move_down"):
			animated_sprite.play("move_down")
			player.global_position.y += 1.2
			moving = true
	
	
