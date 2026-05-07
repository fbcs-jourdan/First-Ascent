extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_grab() -> void:
	animation_player.play("GrabHold")

func play_release() -> void:
	animation_player.play("GrabRelease")
