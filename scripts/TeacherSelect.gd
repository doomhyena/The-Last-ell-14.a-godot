extends Control
# TeacherSelect.gd

func _ready() -> void:
	var btn_back   = _find("BtnBack")
	# A három kártya BtnSelect gombjai — külön kártyánként keressük
	var card_balazs = _find("CardBalazs")
	var card_adam   = _find("CardAdam")
	var card_punch  = _find("CardPunch")

	if btn_back: btn_back.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/MainMenu.tscn"))

	if card_balazs:
		var b = _find("BtnSelect", card_balazs)
		if b: b.pressed.connect(func(): _start_route("balazs"))
	if card_adam:
		var b = _find("BtnSelect", card_adam)
		if b: b.pressed.connect(func(): _start_route("adam"))
	if card_punch:
		var b = _find("BtnSelect", card_punch)
		if b: b.pressed.connect(func(): _start_route("punch"))

	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5)

func _start_route(route_key: String) -> void:
	GameManager.start_route(route_key)
	get_tree().change_scene_to_file("res://scenes/RouteIntro.tscn")

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
