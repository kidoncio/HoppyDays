extends Area2D

const BOOST_ANIMATION: String = "Boost"
const BOOST_METHOD: String = "boost"

func _on_JumpPad_body_entered(body):
	if body.has_method(BOOST_METHOD):
		$AnimationPlayer.play(BOOST_ANIMATION)
		body.boost()
