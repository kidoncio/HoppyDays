extends KinematicBody2D

var motion: Vector2 = Vector2(0, 0)

const UP: Vector2 = Vector2(0, -1)
const SPEED: int = 1500
const GRAVITY: int = 500
const JUMP_SPEED: int = 4000

signal animate
const ANIMATE_SIGNAL: String = "animate"

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)


func apply_gravity() -> void:
	if is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY


func jump() -> void:
	if Input.is_action_pressed("jump") && is_on_floor():
		motion.y -= JUMP_SPEED


func move() -> void:
	if Input.is_action_pressed("left") && !Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") && !Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0


func animate() -> void:
	emit_signal(ANIMATE_SIGNAL, motion)