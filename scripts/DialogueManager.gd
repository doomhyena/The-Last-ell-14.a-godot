extends Node
# DialogueManager.gd
# Autoload - szöveg animáció és dialógus logika

signal dialogue_finished
signal typewriter_done

var _label: RichTextLabel = null
var _full_text: String = ""
var _current_index: int = 0
var _timer: Timer = null
var _speed: float = 0.03  # másodperc / karakter
var _is_playing: bool = false

func setup(label: RichTextLabel) -> void:
	_label = label
	if _timer == null:
		_timer = Timer.new()
		_timer.one_shot = false
		_timer.timeout.connect(_on_timer_tick)
		add_child(_timer)

func play_text(text: String, speed: float = 0.03) -> void:
	if _label == null:
		push_warning("DialogueManager: nincs beállított label!")
		return
	_full_text = text
	_current_index = 0
	_speed = speed
	_is_playing = true
	_label.text = ""
	_timer.wait_time = _speed
	_timer.start()

func skip_to_end() -> void:
	if _is_playing:
		_timer.stop()
		_label.text = _full_text
		_is_playing = false
		emit_signal("typewriter_done")

func is_playing() -> bool:
	return _is_playing

func _on_timer_tick() -> void:
	if _current_index < _full_text.length():
		_label.text += _full_text[_current_index]
		_current_index += 1
	else:
		_timer.stop()
		_is_playing = false
		emit_signal("typewriter_done")
