extends Control
# MainMenu.gd

func _ready() -> void:
	SaveManager.load_game()

	# Gombok megkeresése név alapján (biztonságos)
	var btn_new_game = _find_button("BtnNewGame")
	var btn_credits  = _find_button("BtnCredits")
	var btn_quit     = _find_button("BtnQuit")

	if btn_new_game: btn_new_game.pressed.connect(_on_new_game)
	if btn_credits:  btn_credits.pressed.connect(_on_credits)
	if btn_quit:     btn_quit.pressed.connect(_on_quit)

	# Footer szövegek
	_update_footer()

	# Fade-in
	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.8)

func _find_button(node_name: String) -> Button:
	# Rekurzívan keresi a node-ot a teljes scene fában
	return _find_node_recursive(self, node_name) as Button

func _find_node_recursive(node: Node, target_name: String) -> Node:
	if node.name == target_name:
		return node
	for child in node.get_children():
		var result = _find_node_recursive(child, target_name)
		if result:
			return result
	return null

func _update_footer() -> void:
	var completed = GameManager.completed_routes.size()

	var label_routes = _find_node_recursive(self, "LabelRoutes")
	if label_routes:
		label_routes.set("text", "BEFEJEZETT ROUTE-OK: %d / 3" % completed)

	var fabia_states = ["ISMERETLEN", "AGGASZTÓ", "KRITIKUS", "KERESETT"]
	var label_fabia = _find_node_recursive(self, "LabelFabia")
	if label_fabia:
		label_fabia.set("text", "FÁBIA STÁTUSZ: " + fabia_states[randi() % fabia_states.size()])

func _on_new_game() -> void:
	get_tree().change_scene_to_file("res://scenes/TeacherSelect.tscn")

func _on_credits() -> void:
	get_tree().change_scene_to_file("res://scenes/CreditsScene.tscn")

func _on_quit() -> void:
	get_tree().quit()
