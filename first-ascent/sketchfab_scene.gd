class_name Hand extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_grab() -> void:
	animation_player.play("GrabHold")
	
