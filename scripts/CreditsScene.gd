extends Control
# CreditsScene.gd

func _ready() -> void:
	var btn_back = _find("BtnBack") as Button
	if btn_back:
		btn_back.pressed.connect(func():
			get_tree().change_scene_to_file("res://scenes/MainMenu.tscn"))

func _find(target_name: String, root: Node = null) -> Node:
	return _find_recursive(root if root else self, target_name)

func _find_recursive(node: Node, target_name: String) -> Node:
	if node.name == target_name:
		return node
	for child in node.get_children():
		var result = _find_recursive(child, target_name)
		if result:
			return result
	return null
