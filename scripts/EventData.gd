extends Node
# EventData.gd
# Autoload - minden route összes eseménye itt van definiálva

const EVENTS: Dictionary = {

	# ==============================
	# BALÁZS ROUTE - 6 esemény
	# ==============================
	"balazs": [
		# LESSON 1 - EVENT 0
		{
			"id": "balazs_php_panic",
			"lesson": 0,
			"speaker": "HUJBERT BALÁZS",
			"speaker_color": Color(0.0, 1.0, 0.53),
			"text": "Jó napot mindenkinek. Ma PHP dolgozat lesz... amennyiben valaki egyáltalán megírta otthon a feladatot. Dr.Csont, te megírtad?",
			"choices": [
				{
					"text": "Igen, megírtam. Sőt, refaktoráltam is.",
					"effects": {"patience": 10, "stress": -5},
					"flags_set": {},
					"result": "Balázs láthatóan megkönnyebbül. 'Valaki legalább.' A Türelem stat nő, a Stressz csökken."
				},
				{
					"text": "Megírtam, csak... más nyelven. Pythonban.",
					"effects": {"stress": 10, "patience": -5},
					"flags_set": {},
					"result": "Mély csend. 'Ez informatika, nem kísérlet.' Stressz +10."
				},
				{
					"text": "Elfelejtettük. Az egész osztály.",
					"effects": {"stress": 20, "fabia": -15, "patience": -15},
					"flags_set": {"php_panic": true},
					"result": "Balázs gépe megáll. A Fábia valahol a parkolóban elsírja magát."
				},
			]
		},
		# LESSON 1 - EVENT 1
		{
			"id": "balazs_wifi_chaos",
			"lesson": 0,
			"speaker": "TURBÓ PÉTER",
			"speaker_color": Color(0.8, 0.53, 1.0),
			"text": "Tanár úr, az iskola wifi jelszava '123456' volt. Én meg is változtattam. Biztonsági okokból.",
			"choices": [
				{
					"text": "Megdicsérem Pétert. Jó kezdeményezés.",
					"effects": {"patience": 5, "stress": 15},
					"flags_set": {},
					"result": "Az egész tanári kar elvesztette a netet. Stressz robban."
				},
				{
					"text": "Azonnal visszaállítom az eredeti jelszót.",
					"effects": {"stress": -10, "patience": 5},
					"flags_set": {"class_control": true},
					"result": "Pár perc alatt kész. Balázs bólint. 'Köszönöm, Csont.'"
				},
				{
					"text": "Hagyom, hátha jobb így.",
					"effects": {"stress": 25, "fabia": -10},
					"flags_set": {},
					"result": "Az igazgató személyesen jön be. A Fábia motor furcsa hangot ad ki."
				},
			]
		},
		# LESSON 2 - EVENT 0
		{
			"id": "balazs_lol_screen",
			"lesson": 1,
			"speaker": "HUJBERT BALÁZS",
			"speaker_color": Color(0.0, 1.0, 0.53),
			"text": "[A gép lefagy LoL lobby screennél.] Ez... nem az én számítógépem. Valaki bejelentkezett az iskolai gépen?",
			"choices": [
				{
					"text": "Csendben bezárom a tabokat.",
					"effects": {"patience": 10, "stress": -10},
					"flags_set": {},
					"result": "Balázs nem veszi észre. A dolgozat megkezdődik. Türelem +10."
				},
				{
					"text": "Beismerem: én voltam. De legalább Diamondban vagyok.",
					"effects": {"stress": 15, "patience": -10},
					"flags_set": {"gamer_respect": true},
					"result": "'Gyémánt? Ez nem mentség.' Stressz nő, de valahol respect is van."
				},
				{
					"text": "π Márkra mutatok.",
					"effects": {"fabia": -20, "stress": 10},
					"flags_set": {},
					"result": "π Márk elkezd egy végtelen rekurzív magyarázkodást. Balázs összecsukja a laptopot."
				},
			]
		},
		# LESSON 2 - EVENT 1
		{
			"id": "balazs_fabia_parking",
			"lesson": 1,
			"speaker": "TÖRPE LÓRI",
			"speaker_color": Color(1.0, 0.53, 0.67),
			"text": "[Suttogva] Csont, figyelj, szerintem Balázs tanár úr autója le van tiltva. Láttam a parkolóban.",
			"choices": [
				{
					"text": "Szólok Balázsnak diszkréten.",
					"effects": {"patience": 15, "fabia": 10},
					"flags_set": {"fabia_flag": true},
					"result": "Balázs értékeli. 'Köszönöm.' A Fábia HP visszanő kicsit."
				},
				{
					"text": "Nem avatkozom bele.",
					"effects": {},
					"flags_set": {},
					"result": "Semmi nem történik. Egyelőre."
				},
				{
					"text": "Hangosan kimondom az egész osztálynak.",
					"effects": {"stress": 20, "fabia": -30},
					"flags_set": {},
					"result": "Az egész 14.A kimegy megnézni. Az óra kaotikusan ér véget."
				},
			]
		},
		# LESSON 3 - EVENT 0
		{
			"id": "balazs_cs2_classlist",
			"lesson": 2,
			"speaker": "HUJBERT BALÁZS",
			"speaker_color": Color(0.0, 1.0, 0.53),
			"text": "A PHP dolgozat értékelési szempontjait elküldöm... [emailt néz] ...jaj. Valaki az osztálylistát kicserélte egy CS2 stat exportra.",
			"choices": [
				{
					"text": "Segítek visszaállítani a fájlt.",
					"effects": {"patience": 20, "stress": -15},
					"flags_set": {},
					"result": "Közös backup-mentés. Minden adat megvan. Türelem maximumon."
				},
				{
					"text": "Megpróbálom a CS2 statokból kitalálni ki kicsoda.",
					"effects": {"stress": -5, "patience": 5},
					"flags_set": {},
					"result": "Meglepően jól sikerül. 'ADR: 87 – ez biztosan π Márk.'"
				},
				{
					"text": "Javaslom hogy fogadja el a stat exportot osztályzatként.",
					"effects": {"stress": 30, "fabia": -25, "patience": -20},
					"flags_set": {},
					"result": "Csend. Majd nevetés. Majd igazgatói kihívás. A Fábia füstöl."
				},
			]
		},
		# LESSON 3 - EVENT 1
		{
			"id": "balazs_final_commit",
			"lesson": 2,
			"speaker": "HUJBERT BALÁZS",
			"speaker_color": Color(0.0, 1.0, 0.53),
			"text": "Ez az utolsó perc. Mindenki küldje be a dolgozatát. Ha nincs meg... ott van a pull request határidő.",
			"choices": [
				{
					"text": "Commitolom a dolgozatot. Commit message: 'végre kész'.",
					"effects": {"patience": 15, "stress": -10},
					"flags_set": {},
					"result": "Balázs mosolyog. 'Legalább a git-et tudjátok.' Jó vég felé haladunk."
				},
				{
					"text": "Force push-olom a main branch-re, felülírva mindenki másét.",
					"effects": {"stress": 40, "fabia": -40, "patience": -30},
					"flags_set": {},
					"result": "Az összes dolgozat törlődik. A Fábia motora eltűnik a parkolóból."
				},
				{
					"text": "Merge conflict van, kérem Pétert hogy oldja meg.",
					"effects": {"stress": 15, "patience": -5},
					"flags_set": {},
					"result": "Péter 'megoldja'. Nem oldja meg. De legalább magabiztosan csinálja."
				},
			]
		},
	],

	# ==============================
	# ÁDÁM ROUTE - 6 esemény
	# ==============================
	"adam": [
		# LESSON 1 - EVENT 0
		{
			"id": "adam_suspicious_link",
			"lesson": 0,
			"speaker": "NAGY ÁDÁM",
			"speaker_color": Color(0.0, 0.67, 1.0),
			"text": "Az iskola szervere reggel óta nem válaszol. Valaki elküldött egy linket az osztálycsoportba. Nem kattintottatok rá, ugye?",
			"choices": [
				{
					"text": "Nem kattintottam. Figyeltem a fejlécet.",
					"effects": {"stability": 10, "reputation": 10},
					"flags_set": {"adam_trust": true},
					"result": "Ádám bólint. 'Jó. Legalább egy.' Rendszer stabil marad."
				},
				{
					"text": "Lehet hogy igen? Az URL megbízhatónak tűnt.",
					"effects": {"clicks": 1, "stability": -20, "reputation": -10},
					"flags_set": {"suspicious_clicks": true},
					"result": "Ádám elsápad. Elindít egy Wireshark sessiont. 'Remélem ez nem az volt, amire gondolok.'"
				},
				{
					"text": "Turbó Péter kattintott. Én csak mellette ültem.",
					"effects": {"stability": -10, "reputation": 5},
					"flags_set": {},
					"result": "Péter felháborodik. De a log tényleg Péter IP-jét mutatja. Senki nem lepődik meg."
				},
			]
		},
		# LESSON 1 - EVENT 1
		{
			"id": "adam_fake_profile",
			"lesson": 0,
			"speaker": "NAGY ÁDÁM",
			"speaker_color": Color(0.0, 0.67, 1.0),
			"text": "[Suttogva, Dr.Csontnak] Valaki csinált egy Facebook profilt az én nevemmel. Profilkép: egy szerver rack. Foglalkozás: 'Kamu hálózati guru'. Te tudsz erről valamit?",
			"choices": [
				{
					"text": "Nem én voltam. De segítek leszedni.",
					"effects": {"reputation": 15, "stability": 5},
					"flags_set": {},
					"result": "Közös DMCA report. A profil 20 percen belül eltűnik. Ádám megköszöni."
				},
				{
					"text": "Én csináltam. Poénból. De tényleg jó profilkép.",
					"effects": {"clicks": 1, "reputation": -25},
					"flags_set": {"fake_profile_chaos": true},
					"result": "Hosszú csend. 'Dr.Csont. Az iroda. Most.' A fake profil meme lett az iskolában."
				},
				{
					"text": "Ez lehet Turbó Péter munkája.",
					"effects": {"reputation": -5, "stability": 0},
					"flags_set": {},
					"result": "Ádám szkeptikus. De Péter mosolya gyanúsan elégedett."
				},
			]
		},
		# LESSON 2 - EVENT 0
		{
			"id": "adam_pi_mark",
			"lesson": 1,
			"speaker": "π MÁRK",
			"speaker_color": Color(1.0, 0.8, 0.0),
			"text": "Ádám tanár úr, én kiszámítottam, hogy az iskolai router optimális konfigurációja 3.14159 Mbps throttle lenne. Dokumentáltam is.",
			"choices": [
				{
					"text": "Megköszönöm π Márk javaslatát udvariasan.",
					"effects": {"stability": 0, "reputation": 5},
					"flags_set": {},
					"result": "Ádám zavartan mosolyog. 'Köszönöm, Márk. Majd... megnézzük.'"
				},
				{
					"text": "Beviszem a javaslatot Ádám gépébe.",
					"effects": {"stability": -15, "clicks": 1},
					"flags_set": {},
					"result": "A router konfigurációs panelen van egy rekurzív loop. π Márk büszke."
				},
				{
					"text": "Azt mondom: 'π Márk, te géniusz vagy.'",
					"effects": {"reputation": 10, "stability": 5},
					"flags_set": {},
					"result": "π Márk elindul egy 20 perces monológba a hálózati topológiáról. De legalább Ádám szeret minket."
				},
			]
		},
		# LESSON 2 - EVENT 1
		{
			"id": "adam_admin_login",
			"lesson": 1,
			"speaker": "NAGY ÁDÁM",
			"speaker_color": Color(0.0, 0.67, 1.0),
			"text": "Valaki admin joggal belépett a rendszerbe. A log szerint a belépési kísérlet 03:47-kor volt. Osztályból. Kinek volt ébren a laptopja?",
			"choices": [
				{
					"text": "Megmutatom a saját logomat: csak GitHub volt nyitva.",
					"effects": {"reputation": 10, "stability": 5},
					"flags_set": {},
					"result": "Ádám ellenőrzi. 'Oké, Csont, te tiszta vagy.' Bizalom +."
				},
				{
					"text": "Csendben maradok, hátha elfelejti.",
					"effects": {"stability": -5, "reputation": -5},
					"flags_set": {},
					"result": "Ádám nem felejti. Soha semmit nem felejt."
				},
				{
					"text": "Felajánlom, hogy segítek audit logot olvasni.",
					"effects": {"stability": 20, "reputation": 15},
					"flags_set": {"system_stability": true},
					"result": "Együtt megtaláljuk a belépési pontot. Ádám impresszionált. 'Ezt taníthatnám is.'"
				},
			]
		},
		# LESSON 3 - EVENT 0
		{
			"id": "adam_wedding",
			"lesson": 2,
			"speaker": "NAGY ÁDÁM",
			"speaker_color": Color(0.0, 0.67, 1.0),
			"text": "[Halványan pirul] Szóval. Valaki összekapcsolt engem egy... házassági hirdetéssel. Facebook Marketplace-en. Dr.Csont és én. Esküvő szombaton.",
			"choices": [
				{
					"text": "Lájkolom az eseményt.",
					"effects": {"clicks": 2, "reputation": -15},
					"flags_set": {"wedding_lore_flag": true},
					"result": "50 ember visszaigazolja a részvételt. Az iskolai konyha büfészerűen kezd teríteni."
				},
				{
					"text": "Azonnal eltávolítom és bocsánatot kérek.",
					"effects": {"reputation": 20, "stability": 10},
					"flags_set": {},
					"result": "Ádám értékeli. Bár a screenshotok már mindenhol ott vannak."
				},
				{
					"text": "Megkérdezem: 'Mi lesz az esküvői tortán?'",
					"effects": {"clicks": 1, "reputation": -10},
					"flags_set": {"wedding_lore_flag": true},
					"result": "Turbó Péter már rendelt tortát. PHP mintával. Ez nem állt meg."
				},
			]
		},
		# LESSON 3 - EVENT 1
		{
			"id": "adam_root_password",
			"lesson": 2,
			"speaker": "NAGY ÁDÁM",
			"speaker_color": Color(0.0, 0.67, 1.0),
			"text": "Utolsó feladat: a szerver visszaáll. De valakinek root jelszót kell megadni. Dr.Csont, te csináltad, te tudod. Mi az?",
			"choices": [
				{
					"text": "'admin123' – én állítottam be, nem tudtam jobbat.",
					"effects": {"stability": -30, "reputation": -20, "clicks": 1},
					"flags_set": {},
					"result": "Ádám bezárja a szemét. 'Ez... ez nem lehet igaz.' A szerver sírva megy back online."
				},
				{
					"text": "Elmondom az igazi, biztonságos jelszót.",
					"effects": {"stability": 30, "reputation": 20},
					"flags_set": {},
					"result": "A szerver visszaáll. Ádám: 'Köszönöm Csont. Talán nem minden elveszett.'"
				},
				{
					"text": "Elfelejtettem. De van egy papír a fiókban.",
					"effects": {"stability": -10, "reputation": -5},
					"flags_set": {},
					"result": "A papír nincs a fiókban. Csak egy sticky note: 'lásd: másik fiók.'"
				},
			]
		},
	],

	# ==============================
	# PUNCH ROUTE - 6 esemény
	# ==============================
	"punch": [
		# LESSON 1 - EVENT 0
		{
			"id": "punch_morning_chaos",
			"lesson": 0,
			"speaker": "PUNCH DÁVID",
			"speaker_color": Color(1.0, 0.53, 0.0),
			"text": "Jó reggelt. Három osztályban vagyok egyszerre. A 13.B megint szökött. A 14.B szülői értekezlete ma van. Dr.Csont, mi a helyzet a 14.A-ban?",
			"choices": [
				{
					"text": "Minden rendben, mindenki itt van.",
					"effects": {"discipline": 10, "aura": 5},
					"flags_set": {},
					"result": "Punch láthatóan megkönnyebbül. 'Köszönöm Csont. Legalább egy osztály.'"
				},
				{
					"text": "Hatan hiányoznak, de küldtek cédulát.",
					"effects": {"adminload": 10, "discipline": -5},
					"flags_set": {},
					"result": "Hat cédula, hat különböző betegség. Punch kezdi gyanítani az összefüggést."
				},
				{
					"text": "Az osztály itt van, de valaki elvitte a táblakrétát.",
					"effects": {"adminload": 15, "aura": -10},
					"flags_set": {},
					"result": "Punch arca megkövül. 'Ki. Vitte. El. A krétát.'"
				},
			]
		},
		# LESSON 1 - EVENT 1
		{
			"id": "punch_parent_call",
			"lesson": 0,
			"speaker": "SZÜLŐ (telefon)",
			"speaker_color": Color(1.0, 0.27, 0.33),
			"text": "[Punch telefonja csörög] Punch úr! A fiam azt mondja, hogy ma dolgozat van, de ő nem tud róla. Ezt nem hagyom annyiban!",
			"choices": [
				{
					"text": "Segítek Punchnak megmagyarázni a helyzetet.",
					"effects": {"aura": 10, "adminload": -5},
					"flags_set": {},
					"result": "A szülő meggyőzhető. Punch hálás. 'Jól kezeled a kommunikációt, Csont.'"
				},
				{
					"text": "Megmondom hogy a dolgozatot mindenki tudta.",
					"effects": {"discipline": 10, "adminload": 10},
					"flags_set": {"parent_anger": true},
					"result": "Igaz, de a szülő eszkalál. Most az igazgatóhoz megy."
				},
				{
					"text": "Turbó Péter veszi át a telefont.",
					"effects": {"adminload": 25, "aura": -20},
					"flags_set": {"parent_anger": true},
					"result": "Péter elmagyarázza, hogy 'statisztikailag a szülők 73%-a téved'. A szülő nem fogadja el ezt az érvelést."
				},
			]
		},
		# LESSON 2 - EVENT 0
		{
			"id": "punch_admin_system",
			"lesson": 1,
			"speaker": "PUNCH DÁVID",
			"speaker_color": Color(1.0, 0.53, 0.0),
			"text": "[Stresszesen] Az admin rendszer megint lezárt. Nem tudom lezárni az ellenőrzőket. Valaki ismeri a bypass-t?",
			"choices": [
				{
					"text": "Tudom a bypass kódot, de nem mondom meg.",
					"effects": {"discipline": 15, "adminload": -10},
					"flags_set": {},
					"result": "Punch dühös, de az admin rendszer biztonságban marad."
				},
				{
					"text": "Megmutatom a bypass-t.",
					"effects": {"adminload": -20, "aura": -15, "discipline": -5},
					"flags_set": {},
					"result": "Punch belép. De π Márk is megtanulja a bypass-t. Ez nem jó."
				},
				{
					"text": "Segítek jelezni az IT-nek.",
					"effects": {"adminload": -5, "aura": 10},
					"flags_set": {},
					"result": "Az IT 'hamarosan' reagál. Punch értékeli a szabálykövetést."
				},
			]
		},
		# LESSON 2 - EVENT 1
		{
			"id": "punch_organize_help",
			"lesson": 1,
			"speaker": "TÖRPE LÓRI",
			"speaker_color": Color(1.0, 0.53, 0.67),
			"text": "[Suttogva] Csont, Punch tanár úrnak ma öt szülői, három admin határidője és egy osztálykirándulás-engedélye van. Segítsünk neki?",
			"choices": [
				{
					"text": "Megszervezzük a szülői leveleket.",
					"effects": {"adminload": -20, "aura": 15},
					"flags_set": {},
					"result": "Punch: 'Ti... megszerveztétek? Köszönöm.' Az aura emelkedik."
				},
				{
					"text": "Nem szólunk bele, ez tanári dolog.",
					"effects": {},
					"flags_set": {},
					"result": "Punch egyedül csinálja végig. Fáradt, de büszke."
				},
				{
					"text": "Elküldjük a szülőknek, hogy elmarad az értekezlet.",
					"effects": {"adminload": -30, "aura": -30, "discipline": -20},
					"flags_set": {"parent_anger": true},
					"result": "Punch megtudja. 'KI KÜLDTE EL?' Az Ofő Aura kritikusra esik."
				},
			]
		},
		# LESSON 3 - EVENT 0
		{
			"id": "punch_two_classes",
			"lesson": 2,
			"speaker": "PUNCH DÁVID",
			"speaker_color": Color(1.0, 0.53, 0.0),
			"text": "A 13.B visszajött a szökésből. Magukkal hozták a 14.A három tagját. Most mind a két osztály az ajtóban áll és mosolyog.",
			"choices": [
				{
					"text": "Fegyelmezetten szétválasztom a két osztályt.",
					"effects": {"discipline": 20, "aura": 10},
					"flags_set": {},
					"result": "Rend helyreáll. Punch: 'Ilyen döntésekre volt szükség.'"
				},
				{
					"text": "Hagyom, legyen közös óra.",
					"effects": {"adminload": 20, "discipline": -15},
					"flags_set": {},
					"result": "Káosz, de kreatív. Valaki véletlenül jó projektötletet vet fel."
				},
				{
					"text": "Bejelentem hogy most teapartyt tartunk.",
					"effects": {"aura": -25, "discipline": -25, "adminload": 30},
					"flags_set": {},
					"result": "Mindenki csatlakozik. Az igazgató is. Punch lemondani készül."
				},
			]
		},
		# LESSON 3 - EVENT 1
		{
			"id": "punch_parent_bossfight",
			"lesson": 2,
			"speaker": "SZÜLŐK CSOPORTJA",
			"speaker_color": Color(1.0, 0.27, 0.33),
			"text": "[Az ajtóban öt szülő áll. Egyszerre.] PUNCH ÚR! Azonnal magyarázatot kérünk!",
			"choices": [
				{
					"text": "Nyugodtan, egyenként fogadom mindenkit.",
					"effects": {"aura": 20, "adminload": -10, "discipline": 10},
					"flags_set": {},
					"result": "A szülők meglepve, de kielégítetten távoznak. Boss fight megnyerve."
				},
				{
					"text": "Dr.Csontra mutatok mint osztályképviselőre.",
					"effects": {"aura": -10, "discipline": 5, "adminload": 20},
					"flags_set": {},
					"result": "Az osztály egyhangúlag megvon minden bizalmat tőlem. De Punch megmenekül."
				},
				{
					"text": "Meghívom őket a következő tanévbe tanítani.",
					"effects": {"aura": 30, "discipline": -20, "adminload": 40},
					"flags_set": {"parent_anger": true},
					"result": "Két szülő tényleg igent mond. Az iskolai rendszer csendesen összeomlik."
				},
			]
		},
	],
}

func get_event(route_key: String, event_index: int) -> Dictionary:
	if EVENTS.has(route_key) and event_index < EVENTS[route_key].size():
		return EVENTS[route_key][event_index]
	return {}

func get_event_count(route_key: String) -> int:
	if EVENTS.has(route_key):
		return EVENTS[route_key].size()
	return 0
