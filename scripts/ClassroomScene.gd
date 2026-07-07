extends Control
# ClassroomScene.gd

enum State { DIALOGUE, CHOICES, RESULT }
var current_state: State = State.DIALOGUE
var current_event_data: Dictionary = {}
var chosen_choice: Dictionary = {}

var label_lesson_name: Node
var label_lesson_meta: Node
var progress_bar_container: Node
var stat_container: Node
var dialogue_panel: Node
var label_speaker: Node
var label_text: Node
var btn_advance: Node
var choices_panel: Node
var choices_container: Node
var result_panel: Node
var label_result: Node
var label_effects: Node
var btn_continue: Node

func _ready() -> void:
	label_lesson_name      = _find("LessonName")
	label_lesson_meta      = _find("LessonMeta")
	progress_bar_container = _find("ProgressBar")
	stat_container         = _find("Stats")
	dialogue_panel         = _find("DialogueBox")
	label_speaker          = _find("SpeakerLabel")
	label_text             = _find("DialogueText")
	btn_advance            = _find("BtnAdvance")
	choices_panel          = _find("ChoicesPanel")
	choices_container      = _find("Choices")
	result_panel           = _find("ResultPanel")
	label_result           = _find("ResultText")
	label_effects          = _find("EffectsLabel")
	btn_continue           = _find("BtnContinue")

	GameManager.stats_changed.connect(_on_stats_changed)
	if btn_advance:  btn_advance.pressed.connect(_on_advance_pressed)
	if btn_continue: btn_continue.pressed.connect(_on_continue_pressed)

	_set_visible(choices_panel, false)
	_set_visible(result_panel, false)
	_set_visible(btn_advance, false)

	_update_header()
	_update_stats()
	_update_progress()
	_load_current_event()

func _load_current_event() -> void:
	var idx = GameManager.get_event_index()
	current_event_data = EventData.get_event(GameManager.current_route, idx)
	if current_event_data.is_empty():
		push_error("Nem találtam eseményt! idx=%d" % idx)
		return
	_show_dialogue()

func _show_dialogue() -> void:
	current_state = State.DIALOGUE
	_set_visible(choices_panel, false)
	_set_visible(result_panel, false)
	_set_visible(dialogue_panel, true)
	_set_visible(btn_advance, false)

	_set_text(label_speaker, current_event_data.get("speaker", "???"))
	var speaker_color = current_event_data.get("speaker_color", Color.WHITE)
	if label_speaker and label_speaker.has_method("add_theme_color_override"):
		label_speaker.add_theme_color_override("font_color", speaker_color)

	_set_text(label_text, current_event_data.get("text", ""))
	_set_visible(btn_advance, true)

func _on_advance_pressed() -> void:
	if current_state == State.DIALOGUE:
		_show_choices()

func _show_choices() -> void:
	current_state = State.CHOICES
	_set_visible(dialogue_panel, false)
	_set_visible(btn_advance, false)
	_set_visible(result_panel, false)
	_set_visible(choices_panel, true)
	if choices_container == null:
		return
	for child in choices_container.get_children():
		child.queue_free()
	var choices = current_event_data.get("choices", [])
	for i in range(choices.size()):
		var btn = Button.new()
		btn.text = "> " + choices[i].get("text", "???")
		btn.custom_minimum_size.y = 48
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.add_theme_font_size_override("font_size", 14)
		var idx_capture = i
		btn.pressed.connect(func(): _on_choice_selected(idx_capture))
		choices_container.add_child(btn)

func _on_choice_selected(idx: int) -> void:
	var choices = current_event_data.get("choices", [])
	if idx >= choices.size():
		return
	chosen_choice = choices[idx]
	GameManager.apply_effects(chosen_choice.get("effects", {}))
	for flag_name in chosen_choice.get("flags_set", {}):
		GameManager.set_flag(flag_name, chosen_choice["flags_set"][flag_name])
	_show_result()

func _show_result() -> void:
	current_state = State.RESULT
	_set_visible(dialogue_panel, false)
	_set_visible(choices_panel, false)
	_set_visible(result_panel, true)
	_set_text(label_result, chosen_choice.get("result", ""))
	var effects = chosen_choice.get("effects", {})
	var stat_labels = GameManager.ROUTES[GameManager.current_route].get("stat_labels", {})
	var effect_str = ""
	for key in effects:
		var val = effects[key]
		if val == 0: continue
		effect_str += "[%s: %s%d]  " % [stat_labels.get(key, key), "+" if val > 0 else "", val]
	_set_text(label_effects, effect_str.strip_edges())

func _on_continue_pressed() -> void:
	GameManager.advance_event()
	if GameManager.is_route_done():
		get_tree().change_scene_to_file("res://scenes/EndingScene.tscn")
	elif GameManager.current_event == 0:
		get_tree().change_scene_to_file("res://scenes/LessonSummary.tscn")
	else:
		_load_current_event()

func _on_stats_changed(_s: Dictionary) -> void:
	_update_stats()

func _update_header() -> void:
	var route_data = GameManager.ROUTES[GameManager.current_route]
	var lessons = route_data.get("lessons", [])
	if GameManager.current_lesson < lessons.size():
		_set_text(label_lesson_name, lessons[GameManager.current_lesson].get("name", ""))
		_set_text(label_lesson_meta, lessons[GameManager.current_lesson].get("meta", ""))
	if label_lesson_name and label_lesson_name.has_method("add_theme_color_override"):
		label_lesson_name.add_theme_color_override("font_color", route_data.get("color", Color.WHITE))

func _update_stats() -> void:
	if stat_container == null: return
	for child in stat_container.get_children():
		child.queue_free()
	var route_data  = GameManager.ROUTES[GameManager.current_route]
	var stat_labels = route_data.get("stat_labels", {})
	var stat_colors = route_data.get("stat_colors", {})
	var color_map   = {"green": Color(0,1,0.53), "blue": Color(0,0.67,1), "orange": Color(1,0.53,0), "red": Color(1,0.27,0.33)}
	for key in stat_labels:
		var row = HBoxContainer.new()
		row.custom_minimum_size.y = 20
		var lbl = Label.new()
		lbl.text = stat_labels[key]
		lbl.custom_minimum_size.x = 100
		lbl.add_theme_font_size_override("font_size", 11)
		lbl.add_theme_color_override("font_color", Color(0.35, 0.47, 0.60))
		row.add_child(lbl)
		var bar_bg = Panel.new()
		bar_bg.custom_minimum_size = Vector2(120, 8)
		bar_bg.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		var bar_fill = Panel.new()
		var val = GameManager.get_stat_normalized(key)
		bar_fill.custom_minimum_size = Vector2(120.0 * val, 8)
		var style = StyleBoxFlat.new()
		style.bg_color = color_map.get(stat_colors.get(key, "green"), Color.GREEN)
		bar_fill.add_theme_stylebox_override("panel", style)
		bar_bg.add_child(bar_fill)
		row.add_child(bar_bg)
		stat_container.add_child(row)

func _update_progress() -> void:
	if progress_bar_container == null: return
	for child in progress_bar_container.get_children():
		child.queue_free()
	var done = GameManager.get_event_index()
	var route_color = GameManager.ROUTES[GameManager.current_route].get("color", Color.WHITE)
	for i in range(6):
		var seg = Panel.new()
		seg.custom_minimum_size = Vector2(0, 4)
		seg.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		var style = StyleBoxFlat.new()
		style.bg_color = route_color if i < done else (Color(route_color.r, route_color.g, route_color.b, 0.4) if i == done else Color(0.12, 0.17, 0.24))
		seg.add_theme_stylebox_override("panel", style)
		progress_bar_container.add_child(seg)

func _find(target_name: String, root: Node = null) -> Node:
	return _find_recursive(root if root else self, target_name)

func _find_recursive(node: Node, target_name: String) -> Node:
	if node.name == target_name: return node
	for child in node.get_children():
		var result = _find_recursive(child, target_name)
		if result: return result
	return null

func _set_text(node: Node, text: String) -> void:
	if node: node.set("text", text)

func _set_visible(node: Node, value: bool) -> void:
	if node: node.visible = value
