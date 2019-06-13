extends AnimatedSprite

const IDLE_ANIMATION: String = "idle"
const JUMP_ANIMATION: String = "jump"
const WALK_ANIMATION: String = "walk"

func _on_Player_animate(motion: Vector2):
	if motion.y < 0:
		play(JUMP_ANIMATION)
	elif motion.x > 0:
		flip_h = false
		play(WALK_ANIMATION)
	elif motion.x < 0:
		flip_h = true
		play(WALK_ANIMATION)
	else:
		play(IDLE_ANIMATION)