extends Node3D
@onready var spawn_positions: Node3D = $SpawnPositions

var rock_scene = preload("res://scenes/rock.tscn")

func _on_timer_timeout() -> void:
	spawn_rock()
	print("im matthew and im psawning a rock")
	
func spawn_rock() -> void:
	var spawn_positions_array = spawn_positions.get_children()
	var random_spawn_position = spawn_positions_array.pick_random()
	var rock_instance = rock_scene.instantiate()
	add_child(rock_instance)
	rock_instance.global_position = random_spawn_position.global_position
