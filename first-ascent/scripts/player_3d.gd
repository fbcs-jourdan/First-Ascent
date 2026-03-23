extends RigidBody3D

@export var right: MeshInstance3D
@export var left: MeshInstance3D 
@export var move_radius := 0.5
@export var pull_strength := 5
@export var wall_normal := Vector3.FORWARD # normal pointing OUT of wall


@onready var cam: Camera3D = $body/cam
@onready var body: MeshInstance3D = $body
@onready var col: CollisionShape3D = $CollisionShape3D
@onready var player: RigidBody3D = $"."

var right_limit
var left_limit
var upper_limit
var climbing := false
var right_selected := true
var right_center
var left_center

func _physics_process(_delta):
	# Pull into wall (toward the surface)
	apply_central_force(-wall_normal * pull_strength)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	right_limit = body.global_position.x - 1.5
	left_limit = body.global_position.x + 1.5
	upper_limit = body.global_position.y + 5
	update_limits()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	right_center = right.global_position
	left_center = left.global_position
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	
	axis_lock_angular_x = true  # lock roll
	axis_lock_angular_z = true  # lock pitch

	# Add damping so small torques die out quickly.           // NEW
	angular_damp_mode = RigidBody3D.DAMP_MODE_REPLACE
	angular_damp = 8.0

	linear_damp_mode = RigidBody3D.DAMP_MODE_COMBINE
	linear_damp = 0.6

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	print(right.global_position.x)
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
			update_limits()
			#Input.warp_mouse(left.global_position)
		elif Input.is_action_just_pressed("switch_right"):
			right_selected = true
			_warp_mouse_to_hand(right)
			update_limits()
		
		var mouse_pos = get_viewport().get_mouse_position()
		
		print(mouse_pos)
		var rayStart : Vector3 = cam.project_ray_origin(mouse_pos)
		var direction : Vector3 = cam.project_ray_normal(mouse_pos)
		
		var plane := Plane(-cam.global_transform.basis.z, right.global_position)
		
		var intersection = plane.intersects_ray(rayStart, direction)
		
		if intersection and right_selected:
			right.global_position.y = intersection.y
			right.global_position.x = intersection.x
			if right.global_position.x < right_limit:
				right.global_position.x = right_limit
			elif right.global_position.x > left_limit:
				right.global_position.x = left_limit
			if right.global_position.y > upper_limit:
				right.global_position.y = upper_limit
			
		elif intersection and not right_selected:
			left.global_position.y = intersection.y
			left.global_position.x = intersection.x
			if left.global_position.x > left_limit:
				left.global_position.x = left_limit
			elif left.global_position.x < right_limit:
				left.global_position.x = right_limit
			if left.global_position.y > upper_limit:
				left.global_position.y = upper_limit
		


func _warp_mouse_to_hand(new_hand: MeshInstance3D) -> void:
	var screen_pos: Vector2 = cam.unproject_position(new_hand.global_transform.origin)
	Input.warp_mouse(screen_pos)


func update_limits():
	right_limit = body.global_position.x - 1.5
	left_limit = body.global_position.x + 1.5
	upper_limit = body.global_position.y + 5


	
	
