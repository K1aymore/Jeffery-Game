extends CharacterBody2D


var movement_speed: float = 300.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0



func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target


func _physics_process(delta):
	
	if navigation_agent.is_navigation_finished():
		$AnimationPlayer.play("RESET", 1)
		return
	else:
		$AnimationPlayer.play("Walk")
		print(velocity)
	
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed

	velocity = new_velocity
	move_and_slide()
	
	$Sprite.flip_h = velocity.x < 0
	
	$Sprite.scale = Vector2.ONE * ((1000 + position.y) / 2000)
	


func _unhandled_input(event):
	if event is InputEventMouseButton && event.get_button_index() == MOUSE_BUTTON_LEFT && event.pressed:
		
		set_movement_target(get_global_mouse_position())
