# thx to legion games uwu
# https://www.youtube.com/watch?v=_FRiPPbJsFQ

extends AudioStreamPlayer

@export var bpm = 240 # 60 bpm, semicrome
@export var measures = 16

@onready var latency = AudioServer.get_output_latency()
@onready var sec_per_beat = 60.0/bpm

var song_position = 0.0
var song_position_in_beats = 0
var last_reported_beat = 0
var curr_measure = 0

signal beat(beat: int)
signal measure(measure: int)

func _ready():
	pass

func _physics_process(delta):
	if playing:
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= latency
		song_position_in_beats = int(floor(song_position / sec_per_beat)) # + beats_before_start
		_report_beat()

func _report_beat():
	if last_reported_beat < song_position_in_beats:
		if curr_measure > measures:
			curr_measure = 1
		emit_signal("beat", song_position_in_beats)
		emit_signal("measure", measure)
		last_reported_beat = song_position_in_beats
		curr_measure += 1


func _on_audio_controller_beat(beat):
	pass
