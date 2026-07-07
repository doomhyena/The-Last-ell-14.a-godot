extends Control
# RouteIntro.gd

const INTROS = {
	"balazs": {
		"desc": "Hujbert Balázs tanár úr reggel PHP dolgozatot tervezett. A Fábia viszont már nem indul el. A wifi jelszót valaki megváltoztotta. A LoL lobby még nyitva van az iskolai gépen.\n\nEz a te napod, Dr.Csont. Segítesz... vagy csak rosszabbá teszed?",
		"vibe": "GAMER TANÁR  ·  PHP PÁNIK  ·  FÁBIA LORE  ·  HUMOR"
	},
	"adam": {
		"desc": "Nagy Ádám tanár úr megbízható ember. Vagy az volt, amíg valaki létre nem hozott egy fake Facebook profilt a nevével, és az iskola szervere reggel óta nem válaszol.\n\nDr.Csont, valami köze van ehhez? Biztosan nincs.",
		"vibe": "CYBER KÁOSZ  ·  FAKE PROFIL  ·  WEDDING LORE  ·  PARANOIA"
	},
	"punch": {
		"desc": "Punch Dávid osztályfőnöknek ma öt szülői megbeszélése, három admin határideje és két szökött osztálya van. Egyszerre.\n\nDr.Csont mint megbízható osztályképviselő – ez most rajtad áll.",
		"vibe": "OFŐ MODE  ·  ADMIN HORROR  ·  SZÜLŐI BOSS FIGHT  ·  FEGYELEM"
	}
}

func _ready() -> void:
	var route_key   = GameManager.current_route
	var route_data  = GameManager.ROUTES[route_key]
	var intro       = INTROS.get(route_key, {})
	var route_color = route_data.get("color", Color.WHITE)

	# Tartalom beállítása
	_set_text("RouteTitle",  route_data.get("route_title", ""))
	_set_color("RouteTitle", Color(0.35, 0.47, 0.60))
	_set_text("TeacherName",  route_data.get("name", "???"))
	_set_color("TeacherName", route_color)
	_set_text("Description",  intro.get("desc", ""))
	_set_text("VibeTitle",    intro.get("vibe", ""))
	_set_color("VibeTitle",  Color(0.35, 0.47, 0.60))

	# PaddedContent bal/jobb margó scriptből
	var padded = _find("PaddedContent")
	if padded:
		padded.add_theme_constant_override("margin_left", 32)
		padded.add_theme_constant_override("margin_right", 32)

	# Vissza gomb
	var btn_back = _find("BtnBack") as Button
	if btn_back:
		btn_back.pressed.connect(func():
			get_tree().change_scene_to_file("res://scenes/TeacherSelect.tscn"))

	# Start gomb
	var btn_start = _find("BtnStart") as Button
	if btn_start:
		btn_start.pressed.connect(func():
			get_tree().change_scene_to_file("res://scenes/ClassroomScene.tscn"))
	else:
		push_error("RouteIntro: BtnStart nem található!")

	modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.6)

func _set_text(node_name: String, text: String) -> void:
	var node = _find(node_name)
	if node:
		node.set("text", text)

func _set_color(node_name: String, color: Color) -> void:
	var node = _find(node_name)
	if node and node.has_method("add_theme_color_override"):
		node.add_theme_color_override("font_color", color)

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
