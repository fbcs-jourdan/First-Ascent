extends Node3D
@onready var spawn_positions: Node3D = $SpawnPositions
@onready var rock_timer: Timer = $RockTimer
@onready var warning_timer: Timer = $WarningTimer
@onready var container: Container = $Control/Container

@onready var warning_sign: Sprite3D = $warning_sign

var rock_scene = preload("res://scenes/rock.tscn")

	

	
func spawn_rock() -> void:
	var spawn_positions_array = spawn_positions.get_children()
	var random_spawn_position = spawn_positions_array.pick_random()
	var rock_instance = rock_scene.instantiate()
	add_child(rock_instance)
	rock_instance.global_position.x = warning_sign.global_position.x
	#if rock_instance.global_position.y <= 0:
		#rock_instance.queue_free()
	
func _on_rock_timer_timeout() -> void:
	spawn_rock()
	print("im matthew and im spawning a rock")
	warning_timer.start()

func move_warning() -> void:
	var spawn_positions_array = spawn_positions.get_children()
	var random_spawn_position = spawn_positions_array.pick_random()
	warning_sign.global_position.x = random_spawn_position.global_position.x
	rock_timer.start()
	
func _on_warning_timer_timeout() -> void:
	move_warning()
