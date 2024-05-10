extends Node

const ES_SOCIAL_FEEDIA___HEYSON = preload("res://Music/ES_Social Feedia - Heyson.wav")

@onready var audio_stream_player: AudioStreamPlayer = $/root/Editor/AudioStreamPlayer
@onready var timer: Timer = $/root/Editor/AudioTimer
@onready var audio_spectrum_analyzer_instance: AudioEffectSpectrumAnalyzerInstance = AudioServer.get_bus_effect_instance(0, 0)

@onready var cam: Camera = $/root/Editor/Misc/Cam

var music_move_intensity: float = 15;

var enabled: bool = false;

var SONGS = [ES_SOCIAL_FEEDIA___HEYSON];

func _ready():
	play_random_song()

	audio_stream_player.finished.connect(play_random_song)

	timer.timeout.connect(play_effects)

func play_random_song() -> void:
	if !enabled: return
	timer.stop()

	var song = SONGS.pick_random()

	audio_stream_player.stream = song
	audio_stream_player.play()
	timer.start()

func find_volume():
	var volume = audio_spectrum_analyzer_instance.get_magnitude_for_frequency_range(0.0, 20000, AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_MAX).length()
	return volume

func play_effects() -> void:
	if !enabled: return timer.stop()
	var res = find_volume()
	# music_move_intensity goes between 0 and 10 in settings, this is weak.
	cam.focus_temp(res * music_move_intensity * 20)

func set_volume(value: float) -> void:
	var clampedVolume = clamp(value, 0, 100)
	var decibels = lerp(-60, 0, clampedVolume / 100.0)

	audio_stream_player.volume_db = decibels

func set_enabled(value: bool) -> void:
	enabled = value;

	if !value:
		audio_stream_player.stop()
	else:
		play_random_song()
