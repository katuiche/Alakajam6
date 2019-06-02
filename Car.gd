extends RigidBody2D

onready var area = $Area2D

var speed = 0
var direction = 0
var is_rewind = false
var max_speed = 100
onready var is_on_table = 10

func _ready():
	add_to_group("Target")


func _physics_process(delta):
	if is_on_table > 0:
		if Input.is_action_pressed("acelerate"):
			apply_central_impulse(Vector2(5,0).rotated(rotation))
			is_rewind = false
		elif Input.is_action_pressed("break"):
			apply_central_impulse(Vector2(5,0).rotated(rotation - PI))
			is_rewind = true
			
		if abs(get_linear_velocity().x) > max_speed or abs(get_linear_velocity().y) > max_speed:
			var new_speed = get_linear_velocity().normalized()
			new_speed *= max_speed
			set_linear_velocity(new_speed)
			
			
		if Input.is_action_pressed("turn_left"):
			apply_torque_impulse(-20)
		if Input.is_action_pressed("turn_right"):
			apply_torque_impulse(20)
		
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

func _on_Car_body_entered(body):
	pass
