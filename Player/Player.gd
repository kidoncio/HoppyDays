extends KinematicBody2D

var motion: Vector2 = Vector2(0, 0)

const UP: Vector2 = Vector2(0, -1)
const SPEED: int = 1500
const GRAVITY: int = 150
const JUMP_SPEED: int = 3000

const BOOST_MULTIPLIER: float = 1.5
const WORLD_LIMIT: int = 5000

# Groups
const GAME_STATE_GROUP: String = "GameState"

# Methods
const END_GAME_METHOD: String = "end_game"

# Signals
signal animate
const ANIMATE_SIGNAL: String = "animate"

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)


func apply_gravity() -> void:
	if position.y > WORLD_LIMIT:
		get_tree().call_group(GAME_STATE_GROUP, END_GAME_METHOD)
		pass

	if is_on_floor() and motion.y > 0:
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY


func jump() -> void:
	if Input.is_action_pressed("jump") && is_on_floor():
		$SFX/Jump.play()
		motion.y -= JUMP_SPEED


func move() -> void:
	if Input.is_action_pressed("left") && !Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") && !Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0


func boost() -> void:
	position.y -= 1
	
	var jumpIsPressed: bool = false

	if Input.is_action_pressed("jump"):
		jumpIsPressed = true

	yield(get_tree(), "idle_frame")
	
	if jumpIsPressed:
		motion.y += JUMP_SPEED
	
	motion.y -= JUMP_SPEED * BOOST_MULTIPLIER


func animate() -> void:
	emit_signal(ANIMATE_SIGNAL, motion)


func hurt() -> void:
	$SFX/Pain.play()

	var jumpIsPressed: bool = false

	if Input.is_action_pressed("jump"):
		jumpIsPressed = true

	position.y -= 1
	yield(get_tree(), "idle_frame")
	
	if !jumpIsPressed:
		motion.y = -JUMP_SPEED