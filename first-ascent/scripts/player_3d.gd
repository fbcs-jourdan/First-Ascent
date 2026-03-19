extends RigidBody3D

@export var right: MeshInstance3D
@export var left: MeshInstance3D 
@export var move_radius := 0.5

@onready var cam: Camera3D = $body/cam
@onready var body: MeshInstance3D = $body
@onready var col: CollisionShape3D = $CollisionShape3D
@onready var player: RigidBody3D = $"."

var climbing := false
var right_selected := true
var right_center
var left_center

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	right_center = right.global_position.x
	left_center = left.global_position.x
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	body.global_position.y = ((right.global_position.y + left.global_position.y) * 0.5)
	
	col.global_position.y = body.global_position.y
	if Input.is_action_just_pressed("climb") and not climbing:
		climbing = true
	elif Input.is_action_just_pressed("climb") and climbing:
		climbing = false
	if climbing:
		if Input.is_action_just_pressed("switch_left"):
			right_selected = false
			_warp_mouse_to_hand(left)
			#Input.warp_mouse(left.global_position)
		elif Input.is_action_just_pressed("switch_right"):
			right_selected = true
			_warp_mouse_to_hand(right)
		
		var mouse_pos = get_viewport().get_mouse_position()
		
		print(mouse_pos)
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
		


func _warp_mouse_to_hand(new_hand: MeshInstance3D) -> void:
	var screen_pos: Vector2 = cam.unproject_position(new_hand.global_transform.origin)
	Input.warp_mouse(screen_pos)

	
	
