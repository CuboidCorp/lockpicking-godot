extends Sprite2D

@export_range (0,360,1,"or_greater")
var BOBBY_ROTATION_ZONE : int = 180

@export
var CORRECTNESS_DIFFICULTY_SCALING : int = 10

@export
var HINT_DIFFICULTY_SCALING : int = 30

var correct_angle : int
var correctness_zone : int
var hint_zone : int

var show_debug_mode : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	generate(1)
	pass # Replace with function body.

# Function to generate random lockpick according to difficulty
func generate(difficulty: int):
	var min_angle = BOBBY_ROTATION_ZONE / 2 * -1
	var max_angle = BOBBY_ROTATION_ZONE / 2
	
	correct_angle = randi_range(min_angle,max_angle)
	correctness_zone = CORRECTNESS_DIFFICULTY_SCALING * difficulty
	hint_zone = HINT_DIFFICULTY_SCALING * difficulty
	pass

func show_debug():
	print("debug")
	show_debug_mode = true
	queue_redraw()

func _draw():
	if show_debug_mode:
		draw_arc(get_child(0).position, 200, deg_to_rad(-90 + (correct_angle - hint_zone / 2)), deg_to_rad(-90+(correct_angle + hint_zone / 2)), 24, Color(1, 1, 0),2)
		
		draw_arc(get_child(0).position, 210, deg_to_rad(-90 + (correct_angle - correctness_zone / 2)), deg_to_rad(-90+(correct_angle + correctness_zone / 2)), 24, Color(1, 0, 0),2)
		
		draw_arc(get_child(0).position, 220, deg_to_rad(-90 + -BOBBY_ROTATION_ZONE / 2), deg_to_rad(-90 + BOBBY_ROTATION_ZONE/2), 24, Color(1, 1, 1),2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
