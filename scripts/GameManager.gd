extends Node
# GameManager.gd
# Autoload singleton - ez kezeli az összes globális állapotot

signal stats_changed(stats: Dictionary)
signal flags_changed(flags: Dictionary)
signal route_started(route_key: String)
signal game_over(ending_key: String)

# === ROUTE DEFINÍCIÓK ===
const ROUTES: Dictionary = {
	"balazs": {
		"name": "Hujbert Balázs",
		"route_title": "Patch Notes & Check Engine",
		"color": Color(0.0, 1.0, 0.53),
		"stats": {"stress": 30, "patience": 80, "fabia": 100},
		"stat_labels": {"stress": "Stressz", "patience": "Türelem", "fabia": "Fábia HP"},
		"stat_colors": {"stress": "red", "patience": "green", "fabia": "orange"},
		"flags": ["fabia_flag", "gamer_respect", "php_panic", "class_control"],
		"lessons": [
			{"name": "1. óra: PHP Pánik", "meta": "14.A · Informatika terem"},
			{"name": "2. óra: LoL Break", "meta": "14.B · Gamer szoba"},
			{"name": "3. óra: Final Check", "meta": "14.A · Folyosó"},
		]
	},
	"adam": {
		"name": "Nagy Ádám",
		"route_title": "Root Access Denied",
		"color": Color(0.0, 0.67, 1.0),
		"stats": {"stability": 80, "reputation": 60, "clicks": 0},
		"stat_labels": {"stability": "Rendszer", "reputation": "Hírnév", "clicks": "Gyanús katt."},
		"stat_colors": {"stability": "blue", "reputation": "green", "clicks": "red"},
		"flags": ["suspicious_clicks", "system_stability", "adam_trust", "fake_profile_chaos", "wedding_lore_flag"],
		"lessons": [
			{"name": "1. óra: Hálózati krízis", "meta": "14.A · Szerverszoba"},
			{"name": "2. óra: Fake Profil", "meta": "14.A · Gépterem"},
			{"name": "3. óra: Root Access", "meta": "14.A · Folyosó"},
		]
	},
	"punch": {
		"name": "Punch Dávid",
		"route_title": "Ofő Mode: Critical",
		"color": Color(1.0, 0.53, 0.0),
		"stats": {"discipline": 70, "adminload": 20, "aura": 80},
		"stat_labels": {"discipline": "Fegyelem", "adminload": "Admin terhel.", "aura": "Ofő Aura"},
		"stat_colors": {"discipline": "green", "adminload": "red", "aura": "orange"},
		"flags": ["discipline", "admin_load", "homeroom_aura", "parent_anger"],
		"lessons": [
			{"name": "1. óra: Reggeli Káosz", "meta": "14.A · Osztályterem"},
			{"name": "2. óra: Szülői Nyomás", "meta": "Igazgatói iroda"},
			{"name": "3. óra: Boss Fight", "meta": "14.A · Folyosó"},
		]
	}
}

# === ENDING DEFINÍCIÓK ===
const ENDINGS: Dictionary = {
	# BALÁZS
	"balazs_good": {
		"type": "good",
		"title": "PHP Apostle",
		"desc": "Kontrollált káosz. A dolgozat megírva, a Fábia ép. Balázs tanár úr meghív egy kávéra és megmutatja a Diamond ELO-ját. Ez a legjobb ending.",
		"unlock_gallery": "balazs_good_art"
	},
	"balazs_neutral": {
		"type": "neutral",
		"title": "Patch Notes Pending",
		"desc": "Túlélted. A dolgozat leadva, a Fábia él – nagyjából. Balázs ígéri, hogy a következő órán 'rendesen kezdjük el'.",
		"unlock_gallery": "balazs_neutral_art"
	},
	"balazs_bad_fabia": {
		"type": "bad",
		"title": "Check Engine",
		"desc": "A Fábia motor eltűnik a parkolóból. Senki nem látja. Senki nem kérdez. Balázs tanár úr megtalálja a kulcsot egy PHP kódsorban.",
		"unlock_gallery": "balazs_bad_art"
	},
	"balazs_bad_server": {
		"type": "bad",
		"title": "Server Overloaded",
		"desc": "Az iskola wifi kimegy, a PHP projekt törlődik, Balázs CS2-t játszik a tanáriban. Az óra technikailag megtartva.",
		"unlock_gallery": ""
	},
	"balazs_secret": {
		"type": "secret",
		"title": "Diamond IV Együtt",
		"desc": "Dr.Csont és Balázs tanár úr közös rankolt meccset játszik az utolsó szünetben. Winrate: 100%. Ez sosem fog kiderülni.",
		"unlock_gallery": "balazs_secret_art"
	},
	# ÁDÁM
	"adam_good": {
		"type": "good",
		"title": "Secure Connection",
		"desc": "A rendszer stabil. A fake profil eltűnt. Ádám személyesen ajánl referenciát: 'Cyber Incident Responder – tapasztalt.'",
		"unlock_gallery": "adam_good_art"
	},
	"adam_neutral": {
		"type": "neutral",
		"title": "Soft Reboot",
		"desc": "A rendszer él, de a hírnév kissé megkarcolt. Ádám küld egy linket. A link megbízhatónak néz ki.",
		"unlock_gallery": ""
	},
	"adam_bad_wedding": {
		"type": "bad",
		"title": "Facebook Wedding",
		"desc": "Dr.Csont és Nagy Ádám 'összeházasodnak' Facebookon. 200 meghívó megy ki. A büfé terít. Az igazgató gratulál.",
		"unlock_gallery": "adam_wedding_art"
	},
	"adam_bad_server": {
		"type": "bad",
		"title": "Root Access Denied",
		"desc": "A szerver lezárva. A jelszó ismeretlen. Ádám csendben néz egy üres terminálablakot 10 percig.",
		"unlock_gallery": ""
	},
	# PUNCH
	"punch_good": {
		"type": "good",
		"title": "Homeroom Hero",
		"desc": "Az összes szülő elégedetten távozik. Punch bekeretezi a napi menetrendet. 'Ez volt az eddigi legjobb napom.'",
		"unlock_gallery": "punch_good_art"
	},
	"punch_neutral": {
		"type": "neutral",
		"title": "Admin Survived",
		"desc": "Túlélted. A szülők fele elégedett. Az admin rendszer 70%-ban működik. Punch bólint. Ez nála a dicséret.",
		"unlock_gallery": ""
	},
	"punch_bad_boss": {
		"type": "bad",
		"title": "Parent Meeting Boss Fight",
		"desc": "Az öt szülő végső boss csapattá alakul. HP-juk regenerál. Punch megnyomja a vészjelzőt. Az iskola evakuálva.",
		"unlock_gallery": "punch_boss_art"
	},
	"punch_bad_aura": {
		"type": "bad",
		"title": "Aura: Zero",
		"desc": "Az Ofő Aura kritikusan alacsony. Három osztály az egy teremben. Valaki teát főz. Punch sír egy kicsit.",
		"unlock_gallery": ""
	},
}

# === FUTÓ JÁTÉKÁLLAPOT ===
var current_route: String = ""
var current_lesson: int = 0
var current_event: int = 0
var stats: Dictionary = {}
var flags: Dictionary = {}
var unlocked_gallery: Array = []
var completed_routes: Array = []

# === METÓDUSOK ===
func start_route(route_key: String) -> void:
	current_route = route_key
	current_lesson = 0
	current_event = 0
	stats = ROUTES[route_key]["stats"].duplicate()
	flags = {}
	for flag in ROUTES[route_key]["flags"]:
		flags[flag] = false
	emit_signal("route_started", route_key)
	emit_signal("stats_changed", stats)

func apply_effects(effects: Dictionary) -> void:
	for key in effects:
		if stats.has(key):
			stats[key] += effects[key]
			stats[key] = clamp(stats[key], 0, 120)
	emit_signal("stats_changed", stats)

func set_flag(flag_name: String, value: bool = true) -> void:
	flags[flag_name] = value
	emit_signal("flags_changed", flags)

func get_stat(key: String) -> int:
	return stats.get(key, 0)

func get_stat_normalized(key: String) -> float:
	return clamp(float(stats.get(key, 0)) / 100.0, 0.0, 1.0)

func advance_event() -> void:
	current_event += 1
	if current_event >= 2:
		current_event = 0
		current_lesson += 1

func get_event_index() -> int:
	return current_lesson * 2 + current_event

func is_route_done() -> bool:
	return current_lesson >= 3

func calculate_ending() -> String:
	var route = current_route
	var avg = 0.0
	for v in stats.values():
		avg += v
	avg /= stats.size()

	match route:
		"balazs":
			if flags.get("gamer_respect", false) and avg >= 65:
				return "balazs_secret"
			elif avg >= 65:
				return "balazs_good"
			elif avg >= 40:
				return "balazs_neutral"
			elif stats.get("fabia", 100) < 30:
				return "balazs_bad_fabia"
			else:
				return "balazs_bad_server"
		"adam":
			if stats.get("clicks", 0) >= 3:
				return "adam_bad_wedding"
			elif avg >= 65:
				return "adam_good"
			elif avg >= 40:
				return "adam_neutral"
			else:
				return "adam_bad_server"
		"punch":
			if stats.get("adminload", 0) >= 60:
				return "punch_bad_boss"
			elif avg >= 65:
				return "punch_good"
			elif avg >= 40:
				return "punch_neutral"
			else:
				return "punch_bad_aura"
	return "balazs_neutral"

func unlock_gallery_item(item_key: String) -> void:
	if item_key != "" and not unlocked_gallery.has(item_key):
		unlocked_gallery.append(item_key)

func complete_route(route_key: String) -> void:
	if not completed_routes.has(route_key):
		completed_routes.append(route_key)
