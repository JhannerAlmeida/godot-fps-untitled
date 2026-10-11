extends KinematicBody

onready var head = $Head
export var MOUSE_SENSI = 0.1
export var t_clamp = -90.0
export var b_clamp = 90.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		#head.rotate_x(deg2rad(event.relative.y * MOUSE_SENSI * -1))#
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSI * -1))
		head.rotation_degrees.x = clamp(head.rotation_degrees.x , t_clamp, b_clamp)
