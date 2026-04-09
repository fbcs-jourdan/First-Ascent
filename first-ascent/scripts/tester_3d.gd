extends Node3D

@onready var player: RigidBody3D = $Player3D

@export var gust_min_delay := 2.0
@export var gust_max_delay := 6.0
@export var gust_duration := 1.5
@export var wind_strength := 12.0


var gust_timer := 0.0
var gust_time_left := 0.0
var wind_active := false


var wall_normal: Vector3
var wind_dir := wall_normal.cross(Vector3.UP).normalized()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randf() > 0.5:
		wind_dir *= -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	_blow_wind()	
	if not wind_active:
		gust_timer -= delta
		if gust_timer <= 0:
			wind_active = true
			gust_time_left = gust_duration
	else:
		gust_time_left -= delta
		if gust_time_left <= 0:
			wind_active = false
			gust_timer = randf_range(gust_min_delay, gust_max_delay)
	if wind_active:
		player.apply_torque(wind_dir * wind_strength * 0.4)
		player.apply_central_force(wind_dir * wind_strength)




func _on_ending_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://scenes/2d_world_2.tscn")
	




func _on_rock_area_entered(area: Area3D) -> void:
	Climb.can_climb = true
	print("MY NAME IS MATTHEW AND IM CLIMBING")
	


func _on_rock_area_exited(area: Area3D) -> void:
	Climb.can_climb = false
	
func _blow_wind() -> void:
	player.global_position.x -= 0.01
