extends Sprite2D

func update_score():
	$Score.text = "Score: %d" % GameState.score
