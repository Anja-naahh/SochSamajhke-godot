extends AudioStreamPlayer

var current_track = ""

func play_music(track_path: String):
	if current_track == track_path:
		return  # already playing this one

	current_track = track_path
	stream = load(track_path)
	play()
