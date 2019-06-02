extends RigidBody2D

onready var area = $Area2D

var speed = 0
var direction = 0
var is_rewind = false
var max_speed = 100
onready var is_on_table = 10
var target = null

func _physics_process(delta):
	if target == null:
		target = find_target()
		
	if true:
		if linear_velocity.length() < max_speed:
			apply_central_impulse(Vector2(10,0).rotated(rotation))
		is_rewind = false
	else:
		apply_central_impulse(-linear_velocity*0.01)
		
	var avoid = find_avoid()
		
	var d
	if avoid == null:
		var angle1 = rad2deg(global_position.angle_to_point(target.global_position))
		var angle2 = rotation_degrees
		d = angle_difference(angle1, angle2)
	else:
		var angle1 = rad2deg(global_position.angle_to_point(target.global_position))
		var angle2 = rotation_degrees
		d = angle_difference(angle1, angle2) -180
	
	var turning_factor = (linear_velocity.length() if linear_velocity.length() < max_speed else max_speed) /(max_speed/1.1)
	
	if d < 0:
		apply_torque_impulse(-30*turning_factor)
	else:
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
	
func find_target():
	var list = get_tree().get_nodes_in_group("Target")
	if list.size() > 0:
		return list[0]
		
func find_avoid():
	for a in area.get_overlapping_areas():
		if a.is_in_group("Avoid"):
			return a
	
	
static func angle_to_angle(from, to):
    return fposmod(to-from + PI, PI*2) - PI

func angle_difference(angle1, angle2):
    var diff = angle2 - angle1
    return diff if abs(diff) < 180 else diff + (360 * -sign(diff))