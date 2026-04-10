extends Node3D

@onready var player: RigidBody3D = $Player3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	_blow_wind()
	#apply_gravity()



func _on_ending_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://scenes/2d_world_2.tscn")
	




func _on_rock_area_entered(area: Area3D) -> void:
	Climb.can_climb = true
	print("MY NAME IS MATTHEW AND IM CLIMBING")
	


func _on_rock_area_exited(area: Area3D) -> void:
	Climb.can_climb = false
	
func _blow_wind() -> void:
	if not Climb.right_attached and not Climb.left_attached:
		player.global_position.x -= 0.01
		player.global_position.y -= .1
		Climb.wind_blowing = true
	elif not Climb.has_grip:
		player.global_position.x -= 0.01
		player.global_position.y -= .1
		Climb.wind_blowing = true

func apply_gravity() -> void:
	pass
	
