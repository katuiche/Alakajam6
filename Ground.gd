extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_falling = false
var speed = 0
onready var sprite = $Sprite
onready var area = $Area2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rand_range(0,100) > 97:
		var tilesNumber = 0
		for areas in area.get_overlapping_areas():
			if areas.is_in_group("Ground"):
				tilesNumber += 1
		if tilesNumber < 6:
			is_falling = true
		
	if is_falling:
		modulate.a -= 0.01
		speed += 0.01
		global_position.y += speed
		sprite.position = Vector2(rand_range(-2,2),rand_range(-2,2))