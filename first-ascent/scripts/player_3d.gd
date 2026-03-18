extends Node3D

@export var right: MeshInstance3D
@export var left: MeshInstance3D 

@onready var cam: Camera3D = $Camera3D

var right_selected := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("switch_left"):
		right_selected = false
		#Input.warp_mouse(left.global_position)
	elif Input.is_action_just_pressed("switch_right"):
		right_selected = true
		
	var mouse_pos = get_viewport().get_mouse_position()
	
	var rayStart : Vector3 = cam.project_ray_origin(mouse_pos)
	var direction : Vector3 = cam.project_ray_normal(mouse_pos)
	
	var plane := Plane(-cam.global_transform.basis.z, right.global_position)
	
	var intersection = plane.intersects_ray(rayStart, direction)
	
	if intersection and right_selected:
		right.global_position.x = intersection.x
		right.global_position.y = intersection.y
		
	elif intersection and not right_selected:
		left.global_position.x = intersection.x
		left.global_position.y = intersection.y
	
	
