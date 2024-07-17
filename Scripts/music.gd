extends AudioStreamPlayer2D

var m_vol: float = 0.5
var g_vol: float = 0.5
var mvol_db: float
var gvol_db: float
var music_toggle: bool = false

func _process(_delta):
	volume_db = mvol_db
	check_music_toggle()
	
func check_music_toggle():
	if music_toggle and not playing:
		play()
	if not music_toggle and playing:
		stop()
