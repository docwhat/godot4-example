extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction = Vector2(0, 1)

func _ready():
	$AnimationTree.set("parameters/Idle/blend_position", starting_direction)
	
func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		
	update_animation_parameters(input_direction)
 
	# update velocity
	velocity = input_direction * move_speed
	
	# Change animation
	pick_new_state()
	
	# Move and Slide function uses velocity of character body to move character on map
	move_and_slide()

func update_animation_parameters(move_input : Vector2):
	# Don't change animation parameters if there is no move input
	if(move_input != Vector2.ZERO):
		$AnimationTree.set("parameters/Idle/blend_position", move_input)
		$AnimationTree.set("parameters/Walk/blend_position", move_input)
		
func pick_new_state():
	var state_machine = $AnimationTree.get("parameters/playback")
	if(velocity == Vector2.ZERO):
		state_machine.travel("Idle")
	else:
		state_machine.travel("Walk")
