extends Node

const ES_SOCIAL_FEEDIA___HEYSON = preload("res://Music/ES_Social Feedia - Heyson.wav")

@onready var audio_stream_player: AudioStreamPlayer = $/root/Editor/AudioStreamPlayer
@onready var timer: Timer = $/root/Editor/AudioTimer

@onready var cam: Camera = $/root/Editor/Misc/Cam

var SONGS = [
	{
		"resource": ES_SOCIAL_FEEDIA___HEYSON,
		"data": [{ "timestamp": 0.0, "volume": 0.00836763 },{ "timestamp": 0.5, "volume": 0.04229784 },{ "timestamp": 1.0, "volume": 0.08433903 },{ "timestamp": 1.5, "volume": 0.13348341 },{ "timestamp": 2.0, "volume": 0.17841049 },{ "timestamp": 2.5, "volume": 0.24016248 },{ "timestamp": 3.0, "volume": 0.34835297 },{ "timestamp": 3.5, "volume": 0.4302526 },{ "timestamp": 4.0, "volume": 0.411317 },{ "timestamp": 4.5, "volume": 0.44440687 },{ "timestamp": 5.0, "volume": 0.49614662 },{ "timestamp": 5.5, "volume": 0.5401297 },{ "timestamp": 6.0, "volume": 0.5512869 },{ "timestamp": 6.5, "volume": 0.5783848 },{ "timestamp": 7.0, "volume": 0.75085765 },{ "timestamp": 7.5, "volume": 0.7740839 },{ "timestamp": 8.0, "volume": 0.68336725 },{ "timestamp": 8.5, "volume": 0.6445546 },{ "timestamp": 9.0, "volume": 0.63896316 },{ "timestamp": 9.5, "volume": 0.64759815 },{ "timestamp": 10.0, "volume": 0.62820506 },{ "timestamp": 10.5, "volume": 0.61258113 },{ "timestamp": 11.0, "volume": 0.73555386 },{ "timestamp": 11.5, "volume": 0.7203367 },{ "timestamp": 12.0, "volume": 0.61328655 },{ "timestamp": 12.5, "volume": 0.5336732 },{ "timestamp": 13.0, "volume": 0.48631907 },{ "timestamp": 13.5, "volume": 0.48554218 },{ "timestamp": 14.0, "volume": 0.4248345 },{ "timestamp": 14.5, "volume": 0.39371392 },{ "timestamp": 15.0, "volume": 0.46335813 },{ "timestamp": 15.5, "volume": 0.56123257 },{ "timestamp": 16.0, "volume": 0.881799 },{ "timestamp": 16.5, "volume": 0.98078555 },{ "timestamp": 17.0, "volume": 0.96766436 },{ "timestamp": 17.5, "volume": 0.98856 },{ "timestamp": 18.0, "volume": 0.938986 },{ "timestamp": 18.5, "volume": 0.9804879 },{ "timestamp": 19.0, "volume": 0.9805013 },{ "timestamp": 19.5, "volume": 0.9856507 },{ "timestamp": 20.0, "volume": 0.93158185 },{ "timestamp": 20.5, "volume": 0.9733336 },{ "timestamp": 21.0, "volume": 0.96112937 },{ "timestamp": 21.5, "volume": 0.9845094 },{ "timestamp": 22.0, "volume": 0.92206544 },{ "timestamp": 22.5, "volume": 0.9820239 },{ "timestamp": 23.0, "volume": 0.9543622 },{ "timestamp": 23.5, "volume": 0.9782326 },{ "timestamp": 24.0, "volume": 0.9533053 },{ "timestamp": 24.5, "volume": 0.9820061 },{ "timestamp": 25.0, "volume": 0.97418207 },{ "timestamp": 25.5, "volume": 0.99177635 },{ "timestamp": 26.0, "volume": 0.93318135 },{ "timestamp": 26.5, "volume": 0.9890001 },{ "timestamp": 27.0, "volume": 0.9574902 },{ "timestamp": 27.5, "volume": 0.9767158 },{ "timestamp": 28.0, "volume": 0.93685555 },{ "timestamp": 28.5, "volume": 0.981905 },{ "timestamp": 29.0, "volume": 0.9598211 },{ "timestamp": 29.5, "volume": 0.9921228 },{ "timestamp": 30.0, "volume": 0.92316335 },{ "timestamp": 30.5, "volume": 0.9843466 },{ "timestamp": 31.0, "volume": 0.9483756 },{ "timestamp": 31.5, "volume": 0.74437326 },{ "timestamp": 32.0, "volume": 0.7918301 },{ "timestamp": 32.5, "volume": 0.8895771 },{ "timestamp": 33.0, "volume": 0.97755086 },{ "timestamp": 33.5, "volume": 0.9880868 },{ "timestamp": 34.0, "volume": 0.9322979 },{ "timestamp": 34.5, "volume": 0.99489087 },{ "timestamp": 35.0, "volume": 0.9751137 },{ "timestamp": 35.5, "volume": 0.99370044 },{ "timestamp": 36.0, "volume": 0.9456274 },{ "timestamp": 36.5, "volume": 0.9760313 },{ "timestamp": 37.0, "volume": 0.9618795 },{ "timestamp": 37.5, "volume": 0.9708503 },{ "timestamp": 38.0, "volume": 0.92273307 },{ "timestamp": 38.5, "volume": 0.97320706 },{ "timestamp": 39.0, "volume": 0.9635486 },{ "timestamp": 39.5, "volume": 0.9795848 },{ "timestamp": 40.0, "volume": 0.9651791 },{ "timestamp": 40.5, "volume": 0.976798 },{ "timestamp": 41.0, "volume": 0.9708471 },{ "timestamp": 41.5, "volume": 0.98496246 },{ "timestamp": 42.0, "volume": 0.9343333 },{ "timestamp": 42.5, "volume": 0.9815807 },{ "timestamp": 43.0, "volume": 0.9696148 },{ "timestamp": 43.5, "volume": 0.98036736 },{ "timestamp": 44.0, "volume": 0.9427065 },{ "timestamp": 44.5, "volume": 0.980981 },{ "timestamp": 45.0, "volume": 0.9717646 },{ "timestamp": 45.5, "volume": 0.97539365 },{ "timestamp": 46.0, "volume": 0.89656126 },{ "timestamp": 46.5, "volume": 0.6727746 },{ "timestamp": 47.0, "volume": 0.52208626 },{ "timestamp": 47.5, "volume": 0.6523914 },{ "timestamp": 48.0, "volume": 0.8696013 },{ "timestamp": 48.5, "volume": 0.24851127 },{ "timestamp": 49.0, "volume": 0.74828833 },{ "timestamp": 49.5, "volume": 0.2862549 },{ "timestamp": 50.0, "volume": 0.75145024 },{ "timestamp": 50.5, "volume": 0.7770287 },{ "timestamp": 51.0, "volume": 0.80813026 },{ "timestamp": 51.5, "volume": 0.8734345 },{ "timestamp": 52.0, "volume": 0.76261026 },{ "timestamp": 52.5, "volume": 0.77295154 },{ "timestamp": 53.0, "volume": 0.78428406 },{ "timestamp": 53.5, "volume": 0.8224499 },{ "timestamp": 54.0, "volume": 0.75893754 },{ "timestamp": 54.5, "volume": 0.78468084 },{ "timestamp": 55.0, "volume": 0.8296787 },{ "timestamp": 55.5, "volume": 0.8367978 },{ "timestamp": 56.0, "volume": 0.3807715 },{ "timestamp": 56.5, "volume": 0.7802923 },{ "timestamp": 57.0, "volume": 0.7857499 },{ "timestamp": 57.5, "volume": 0.8213614 },{ "timestamp": 58.0, "volume": 0.76207644 },{ "timestamp": 58.5, "volume": 0.7871653 },{ "timestamp": 59.0, "volume": 0.8121875 },{ "timestamp": 59.5, "volume": 0.8586387 },{ "timestamp": 60.0, "volume": 0.7530108 },{ "timestamp": 60.5, "volume": 0.7664884 },{ "timestamp": 61.0, "volume": 0.7832367 },{ "timestamp": 61.5, "volume": 0.8192642 },{ "timestamp": 62.0, "volume": 0.7570066 },{ "timestamp": 62.5, "volume": 0.7973867 },{ "timestamp": 63.0, "volume": 0.8253908 },{ "timestamp": 63.5, "volume": 0.5977733 },{ "timestamp": 64.0, "volume": 0.8245195 },{ "timestamp": 64.5, "volume": 0.9714033 },{ "timestamp": 65.0, "volume": 0.8446488 },{ "timestamp": 65.5, "volume": 0.83116597 },{ "timestamp": 66.0, "volume": 0.8235587 },{ "timestamp": 66.5, "volume": 0.7844681 },{ "timestamp": 67.0, "volume": 0.8295616 },{ "timestamp": 67.5, "volume": 0.829551 },{ "timestamp": 68.0, "volume": 0.7819382 },{ "timestamp": 68.5, "volume": 0.7692151 },{ "timestamp": 69.0, "volume": 0.847781 },{ "timestamp": 69.5, "volume": 0.82383555 },{ "timestamp": 70.0, "volume": 0.80565566 },{ "timestamp": 70.5, "volume": 0.76918066 },{ "timestamp": 71.0, "volume": 0.8274252 },{ "timestamp": 71.5, "volume": 0.8131575 },{ "timestamp": 72.0, "volume": 0.82417935 },{ "timestamp": 72.5, "volume": 0.7795454 },{ "timestamp": 73.0, "volume": 0.85314894 },{ "timestamp": 73.5, "volume": 0.8394217 },{ "timestamp": 74.0, "volume": 0.8067681 },{ "timestamp": 74.5, "volume": 0.77598536 },{ "timestamp": 75.0, "volume": 0.8231677 },{ "timestamp": 75.5, "volume": 0.83628464 },{ "timestamp": 76.0, "volume": 0.7931606 },{ "timestamp": 76.5, "volume": 0.7779516 },{ "timestamp": 77.0, "volume": 0.8614028 },{ "timestamp": 77.5, "volume": 0.8354155 },{ "timestamp": 78.0, "volume": 0.76033515 },{ "timestamp": 78.5, "volume": 0.5092926 },{ "timestamp": 79.0, "volume": 0.45218003 },{ "timestamp": 79.5, "volume": 0.6035827 },{ "timestamp": 80.0, "volume": 0.5769522 },{ "timestamp": 80.5, "volume": 0.6359455 },{ "timestamp": 81.0, "volume": 0.6420358 },{ "timestamp": 81.5, "volume": 0.637257 },{ "timestamp": 82.0, "volume": 0.54812676 },{ "timestamp": 82.5, "volume": 0.60627234 },{ "timestamp": 83.0, "volume": 0.7372239 },{ "timestamp": 83.5, "volume": 0.7348953 },{ "timestamp": 84.0, "volume": 0.6460227 },{ "timestamp": 84.5, "volume": 0.634136 },{ "timestamp": 85.0, "volume": 0.6272189 },{ "timestamp": 85.5, "volume": 0.63898915 },{ "timestamp": 86.0, "volume": 0.57259756 },{ "timestamp": 86.5, "volume": 0.6235584 },{ "timestamp": 87.0, "volume": 0.7545161 },{ "timestamp": 87.5, "volume": 0.79828835 },{ "timestamp": 88.0, "volume": 0.4353099 },{ "timestamp": 88.5, "volume": 0.5976684 },{ "timestamp": 89.0, "volume": 0.66668093 },{ "timestamp": 89.5, "volume": 0.64736265 },{ "timestamp": 90.0, "volume": 0.60331845 },{ "timestamp": 90.5, "volume": 0.61359066 },{ "timestamp": 91.0, "volume": 0.76172704 },{ "timestamp": 91.5, "volume": 0.76729137 },{ "timestamp": 92.0, "volume": 0.6497544 },{ "timestamp": 92.5, "volume": 0.6519917 },{ "timestamp": 93.0, "volume": 0.6466384 },{ "timestamp": 93.5, "volume": 0.6363831 },{ "timestamp": 94.0, "volume": 0.5553753 },{ "timestamp": 94.5, "volume": 0.54020566 },{ "timestamp": 95.0, "volume": 0.5189163 },{ "timestamp": 95.5, "volume": 0.5047396 },{ "timestamp": 96.0, "volume": 0.33555707 },{ "timestamp": 96.5, "volume": 0.30001634 },{ "timestamp": 97.0, "volume": 0.35944608 },{ "timestamp": 97.5, "volume": 0.3930945 },{ "timestamp": 98.0, "volume": 0.8437165 },{ "timestamp": 98.5, "volume": 0.9697654 },{ "timestamp": 99.0, "volume": 0.9559049 },{ "timestamp": 99.5, "volume": 0.9812714 },{ "timestamp": 100.0, "volume": 0.93136 },{ "timestamp": 100.5, "volume": 0.97145617 },{ "timestamp": 101.0, "volume": 0.95447713 },{ "timestamp": 101.5, "volume": 0.9768387 },{ "timestamp": 102.0, "volume": 0.9225681 },{ "timestamp": 102.5, "volume": 0.9655512 },{ "timestamp": 103.0, "volume": 0.9509202 },{ "timestamp": 103.5, "volume": 0.9826846 },{ "timestamp": 104.0, "volume": 0.9545991 },{ "timestamp": 104.5, "volume": 0.96656513 },{ "timestamp": 105.0, "volume": 0.96109307 },{ "timestamp": 105.5, "volume": 0.9981885 },{ "timestamp": 106.0, "volume": 0.9276348 },{ "timestamp": 106.5, "volume": 0.96744215 },{ "timestamp": 107.0, "volume": 0.96471107 },{ "timestamp": 107.5, "volume": 1.0 },{ "timestamp": 108.0, "volume": 0.9312976 },{ "timestamp": 108.5, "volume": 0.97018445 },{ "timestamp": 109.0, "volume": 0.96915644 },{ "timestamp": 109.5, "volume": 0.9849681 },{ "timestamp": 110.0, "volume": 0.92785853 },{ "timestamp": 110.5, "volume": 0.975113 },{ "timestamp": 111.0, "volume": 0.9641298 },{ "timestamp": 111.5, "volume": 0.76869816 },{ "timestamp": 112.0, "volume": 0.8112611 },{ "timestamp": 112.5, "volume": 0.88990915 },{ "timestamp": 113.0, "volume": 0.9704508 },{ "timestamp": 113.5, "volume": 0.9891756 },{ "timestamp": 114.0, "volume": 0.9310405 },{ "timestamp": 114.5, "volume": 0.97838634 },{ "timestamp": 115.0, "volume": 0.95890313 },{ "timestamp": 115.5, "volume": 0.97587603 },{ "timestamp": 116.0, "volume": 0.9265072 },{ "timestamp": 116.5, "volume": 0.9638161 },{ "timestamp": 117.0, "volume": 0.94931173 },{ "timestamp": 117.5, "volume": 0.9695449 },{ "timestamp": 118.0, "volume": 0.9269481 },{ "timestamp": 118.5, "volume": 0.9471165 },{ "timestamp": 119.0, "volume": 0.94819415 },{ "timestamp": 119.5, "volume": 0.9968117 },{ "timestamp": 120.0, "volume": 0.9513709 },{ "timestamp": 120.5, "volume": 0.96307653 },{ "timestamp": 121.0, "volume": 0.9729599 },{ "timestamp": 121.5, "volume": 0.9873784 },{ "timestamp": 122.0, "volume": 0.9367664 },{ "timestamp": 122.5, "volume": 0.97611874 },{ "timestamp": 123.0, "volume": 0.97060084 },{ "timestamp": 123.5, "volume": 0.9724163 },{ "timestamp": 124.0, "volume": 0.9262696 },{ "timestamp": 124.5, "volume": 0.96751976 },{ "timestamp": 125.0, "volume": 0.95763785 },{ "timestamp": 125.5, "volume": 0.98182946 },{ "timestamp": 126.0, "volume": 0.9124887 },{ "timestamp": 126.5, "volume": 0.67410773 },{ "timestamp": 127.0, "volume": 0.5325852 },{ "timestamp": 127.5, "volume": 0.65061027 },{ "timestamp": 128.0, "volume": 0.39609173 },{ "timestamp": 128.5, "volume": 0.07278648 },{ "timestamp": 129.0, "volume": 0.018340461 },{ "timestamp": 129.5, "volume": 0.005838264 },{ "timestamp": 130.0, "volume": 0.0015963682 },{ "timestamp": 130.5, "volume": 0.000251077 },{ "timestamp": 131.0, "volume": 0.0 }]
	}
]

var data: Array;
var iter: int;

var enabled: bool = true;

func _ready():
	play_random_song()

	audio_stream_player.finished.connect(play_random_song)

	timer.timeout.connect(play_effects)

func play_random_song() -> void:
	if !enabled: return

	iter = 0;
	timer.stop()

	var song = SONGS.pick_random()

	audio_stream_player.stream = song.resource
	audio_stream_player.play()
	timer.start()

	data = song.data

func find_volume_at_timestamp(timestamp: float) -> Dictionary:
	for pair in data:
		if pair["timestamp"] == timestamp:
			return pair;
	return {};

func play_effects() -> void:
	if !enabled: return timer.stop()

	iter += 1;

	var res = find_volume_at_timestamp(iter * 0.5)

	if !("volume" in res): return

	cam.focus_temp(res.volume)

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
