extends RigidBody2D

onready var area = $Area2D

var speed = 0
var direction = 0
var is_rewind = false
var max_speed = 300
onready var is_on_table = 10


func _physics_process(delta):
	
	if Input.is_action_pressed("acelerate"):
		if linear_velocity.length() < max_speed:
			apply_central_impulse(Vector2(10,0).rotated(rotation))
		is_rewind = false
	elif Input.is_action_pressed("break"):
		apply_central_impulse(Vector2(10,0).rotated(rotation - PI))
		is_rewind = true
	else:
		apply_central_impulse(-linear_velocity*0.01)
		
		
		
	var turning_factor = (linear_velocity.length() if linear_velocity.length() < max_speed else max_speed) /(max_speed/1.1)
	if Input.is_action_pressed("turn_left"):
		apply_torque_impulse(-30*turning_factor)
	if Input.is_action_pressed("turn_right"):
		apply_torque_impulse(30*turning_factor)
		
	
	if is_on_table > 0:
		var force = linear_velocity
		apply_central_impulse(-force)
		var diference
		if is_rewind:
			diference = angle_to_angle(rotation - PI, force.angle())
		else:
			diference = angle_to_angle(rotation, force.angle())
		apply_central_impulse(force.rotated(-diference))
	
	var check = true
	for a in area.get_overlapping_areas():
		if a.is_in_group("Ground"):
			check = false
			break
			
	if check:
		is_on_table -= 1
		
	if is_on_table <= 0:
		z_index = -1
		gravity_scale = 2
	
	
	
static func angle_to_angle(from, to):
    return fposmod(to-from + PI, PI*2) - PI