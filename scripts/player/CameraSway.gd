extends Spatial

export var sway_amount: float = 0.05 
export var smooth_speed: float = 8.0   

func _process(delta: float) -> void:
	var input_x: float = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	var target_z_rot: float = -input_x * sway_amount
	
	rotation.z = lerp(rotation.z, target_z_rot, smooth_speed * delta)
