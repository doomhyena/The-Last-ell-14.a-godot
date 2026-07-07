extends Control
# EndingScene.gd

const TYPE_COLORS = {
	"good":    Color(0.0, 1.0, 0.53),
	"neutral": Color(0.0, 0.67, 1.0),
	"bad":     Color(1.0, 0.27, 0.33),
	"secret":  Color(0.8, 0.53, 1.0),
}
const TYPE_LABELS = {
	"good":    "★  GOOD END",
	"neutral": "◆  NEUTRAL END",
	"bad":     "✖  BAD END",
	"secret":  "?  SECRET END",
}

func _ready() -> void:
	var ending_key = GameManager.calculate_ending()
	var ending     = GameManager.ENDINGS.get(ending_key, {})
	var etype      = ending.get("type", "neutral")
	var color      = TYPE_COLORS.get(etype, Color.WHITE)

	_set_text_color("EndingBadge",  TYPE_LABELS.get(etype, "END"), color)
	_set_text_color("EndingTitle",  ending.get("title", "???"),    color)
	_set_text("EndingDesc",         ending.get("desc", ""))

	var gallery_key = ending.get("unlock_gallery", "")
	if gallery_key != "":
		GameManager.unlock_gallery_item(gallery_key)

	GameManager.complete_route(GameManager.current_route)
	SaveManager.save_game()

	var btn_menu  = _find("BtnMenu")  as Button
	var btn_again = _find("BtnAgain") as Button
	if btn_menu:  btn_menu.pressed.connect(func():  get_tree().change_scene_to_file("res://scenes/MainMenu.tscn"))
	if btn_again: btn_again.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/TeacherSelect.tscn"))

	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.2)

func _set_text(node_name: String, text: String) -> void:
	var node = _find(node_name)
	if node: node.set("text", text)

func _set_text_color(node_name: String, text: String, color: Color) -> void:
	var node = _find(node_name)
	if node:
		node.set("text", text)
		if node.has_method("add_theme_color_override"):
			node.add_theme_color_override("font_color", color)

func _find(target_name: String, root: Node = null) -> Node:
	return _find_recursive(root if root else self, target_name)

func _find_recursive(node: Node, target_name: String) -> Node:
	if node.name == target_name: return node
	for child in node.get_children():
		var result = _find_recursive(child, target_name)
		if result: return result
	return null
