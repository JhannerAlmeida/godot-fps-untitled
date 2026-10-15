extends KinematicBody

const SPEED = 30
const ACCEL = 15
const GRAV = -40.0
const JUMP_SPEED = 12
const AIR_ACCEL = 4

onready var head = $Head
onready var camera = $Head/Camera

export var MOUSE_SENSI = 0.1
export var t_clamp = -90.0
export var b_clamp = 90.0

var velocity = Vector3.ZERO
var current_vel = Vector3.ZERO
var dir = Vector3.ZERO
var jump_counter = 0

func _physics_process(delta):
	dir = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		dir -= camera.global_transform.basis.z
	if Input.is_action_pressed("move_backward"):
		dir += camera.global_transform.basis.z
	if Input.is_action_pressed("move_right"):
		dir += camera.global_transform.basis.x
	if Input.is_action_pressed("move_left"):
		dir -= camera.global_transform.basis.x
		
	dir = dir.normalized()
	var speed = SPEED
	var target_vel = dir * speed
	var accel = ACCEL if is_on_floor() else AIR_ACCEL
	
	if not is_on_floor():
		velocity.y += GRAV * delta
	else:
		velocity.y = -0.1
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = JUMP_SPEED
	#if is_on_floor():
		#jump_counter = 0
	#if Input.is_action_pressed("jump") and jump_counter < 2:
		#jump_counter += 1
		#velocity.y = JUMP_SPEED
	
	current_vel = current_vel.linear_interpolate(target_vel, accel * delta)
	velocity.x = current_vel.x
	velocity.z = current_vel.z
	velocity = move_and_slide(velocity, Vector3.UP, true, 4, deg2rad(45))

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		head.rotate_x(deg2rad(event.relative.y * MOUSE_SENSI * -1))#
		head.rotation_degrees.x = clamp(head.rotation_degrees.x , t_clamp, b_clamp)
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSI * -1))
