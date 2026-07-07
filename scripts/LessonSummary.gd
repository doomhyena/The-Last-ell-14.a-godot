extends Control
# LessonSummary.gd

const SUMMARY_TEXTS = [
	"Az első óra véget ért. A döntéseid meghatározták a menetrend alakulását.",
	"Félúton vagy. Az utolsó óra mindent megváltoztathat.",
	"Ez volt az utolsó óra. Az ending számítása folyamatban..."
]

func _ready() -> void:
	var lesson_idx = GameManager.current_lesson - 1
	_set_text("Title", "// %d. ÓRA VÉGE" % (lesson_idx + 1))
	_set_text("SummaryText", SUMMARY_TEXTS[clamp(lesson_idx, 0, SUMMARY_TEXTS.size() - 1)])
	_build_stats()

	var next_text = "Következő óra  →" if GameManager.current_lesson < 3 else "Ending megtekintése  →"
	var btn = _find("BtnNext") as Button
	if btn:
		btn.text = next_text
		btn.pressed.connect(_on_next)

	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.6)

func _build_stats() -> void:
	var grid = _find("StatsGrid")
	if grid == null: return
	var route_data  = GameManager.ROUTES[GameManager.current_route]
	var stat_labels = route_data.get("stat_labels", {})
	var route_color = route_data.get("color", Color.WHITE)
	for key in stat_labels:
		var val_label = Label.new()
		val_label.text = str(GameManager.get_stat(key))
		val_label.add_theme_font_size_override("font_size", 32)
		val_label.add_theme_color_override("font_color", route_color)
		val_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		grid.add_child(val_label)
		var key_label = Label.new()
		key_label.text = stat_labels[key]
		key_label.add_theme_font_size_override("font_size", 10)
		key_label.add_theme_color_override("font_color", Color(0.35, 0.47, 0.60))
		key_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		grid.add_child(key_label)

func _on_next() -> void:
	if GameManager.is_route_done():
		get_tree().change_scene_to_file("res://scenes/EndingScene.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/ClassroomScene.tscn")

func _set_text(node_name: String, text: String) -> void:
	var node = _find(node_name)
	if node: node.set("text", text)

func _find(target_name: String, root: Node = null) -> Node:
	return _find_recursive(root if root else self, target_name)

func _find_recursive(node: Node, target_name: String) -> Node:
	if node.name == target_name: return node
	for child in node.get_children():
		var result = _find_recursive(child, target_name)
		if result: return result
	return null
