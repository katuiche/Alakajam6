extends RigidBody2D

var speed = 0
var direction = 0

var max_speed = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("turn_left"):
		direction -= 0.1 * (speed/max_speed)
	if Input.is_action_pressed("turn_right"):
		direction += 0.1 * (speed/max_speed)
	if Input.is_action_pressed("acelerate"):
		speed += 0.5
	else:
		if speed > 0:
			speed *= 0.99
			
	if speed > max_speed:
		speed = max_speed
		
	linear_velocity = Vector2(speed,0).rotated(direction)
	rotation = direction