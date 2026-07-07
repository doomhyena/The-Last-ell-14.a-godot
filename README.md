# Last Bell: 14.A — Godot 4 Project

**kísérleti prototípus**, ezt a projektet iskolai keretek között készítettem azzal a céllal, hogy évvégén és nyilvánosan bemutassam. Különböző iskolai események miatt ez a bemutató végül nem valósult meg, a Godot-os verzió befejezetlen maradt.

**Műfaj:** Choice-based comedy visual novel / school day simulator  
**Engine:** Godot 4.2+  
**Verzió:** v0.1 (demo build)

---

## Projekt megnyitása

1. Töltsd le és telepítsd a **Godot 4.2+** engine-t: https://godotengine.org/
2. Csomagold ki ezt a mappát
3. Nyisd meg a Godot Project Managert
4. Kattints **"Import"** → navigálj a `LastBell14A/` mappába → válaszd ki a `project.godot` fájlt
5. Kattints **"Import & Edit"**
6. Nyomd meg az **F5** gombot (vagy a Play gomb) a játék indításához

---

## Projekt struktúra

```
LastBell14A/
├── project.godot          ← Godot projekt konfiguráció
├── scenes/                ← Összes .tscn scene fájl
│   ├── MainMenu.tscn
│   ├── TeacherSelect.tscn
│   ├── RouteIntro.tscn
│   ├── ClassroomScene.tscn   ← FŐ gameplay scene
│   ├── LessonSummary.tscn
│   ├── EndingScene.tscn
│   └── CreditsScene.tscn
├── scripts/               ← Összes .gd GDScript fájl
│   ├── GameManager.gd     ← Autoload singleton (game state)
│   ├── EventData.gd       ← Autoload singleton (összes esemény)
│   ├── DialogueManager.gd ← Autoload singleton (typewriter effekt)
│   ├── SaveManager.gd     ← Autoload singleton (mentés/betöltés)
│   ├── MainMenu.gd
│   ├── TeacherSelect.gd
│   ├── RouteIntro.gd
│   ├── ClassroomScene.gd
│   ├── LessonSummary.gd
│   ├── EndingScene.gd
│   └── CreditsScene.gd
└── assets/
    ├── icon.svg
    └── themes/
        └── main_theme.tres   ← Dark terminal UI téma
```

---

## Autoload beállítása (FONTOS!)

A Godot-ban manuálisan kell regisztrálni az Autoload singleton-okat.  
Nyisd meg: **Project → Project Settings → Autoload**

Add hozzá ezeket sorban:

| Path | Name |
|------|------|
| `res://scripts/GameManager.gd` | `GameManager` |
| `res://scripts/EventData.gd` | `EventData` |
| `res://scripts/DialogueManager.gd` | `DialogueManager` |
| `res://scripts/SaveManager.gd` | `SaveManager` |

---

## Téma alkalmazása

A dark terminal téma (`main_theme.tres`) manuálisan alkalmazandó a scene-ekre:  
Minden scene gyökér `Control` node-jánál a **Theme** property-ben add meg:  
`res://assets/themes/main_theme.tres`

---

## Game Flow

```
MainMenu
  └─► TeacherSelect
        └─► RouteIntro
              └─► ClassroomScene (Event 1)
                    └─► ClassroomScene (Event 2)
                          └─► LessonSummary (1. óra vége)
                                └─► ClassroomScene (Event 3)
                                      └─► ClassroomScene (Event 4)
                                            └─► LessonSummary (2. óra vége)
                                                  └─► ClassroomScene (Event 5)
                                                        └─► ClassroomScene (Event 6)
                                                              └─► EndingScene
```

---

## Route-ok és Endingek

### Hujbert Balázs (zöld)
- **Good:** PHP Apostle — kontrollált káosz, Fábia él
- **Neutral:** Patch Notes Pending — túlélés
- **Bad:** Check Engine — Fábia motor eltűnik
- **Bad:** Server Overloaded — wifi kimegy
- **Secret:** Diamond IV Együtt — gamer respect szükséges

### Nagy Ádám (kék)
- **Good:** Secure Connection — rendszer stabil
- **Neutral:** Soft Reboot — részleges siker
- **Bad:** Facebook Wedding — 3+ suspicious click
- **Bad:** Root Access Denied — alacsony stats

### Punch Dávid (narancs)
- **Good:** Homeroom Hero — szülők meggyőzve
- **Neutral:** Admin Survived — részleges siker
- **Bad:** Parent Meeting Boss Fight — magas admin load
- **Bad:** Aura: Zero — alacsony stats

---

## Fejlesztési tennivalók (következő verziók)

- [ ] Karakterportré asszetek (PNG) hozzáadása
- [ ] Háttér illusztrációk osztálytermekhez
- [ ] Hangeffektek és ambient zene
- [ ] Gallery scene a feloldott endingekhez
- [ ] Animált stat változás visszajelzés
- [ ] Billentyűzet navigáció (1/2/3 választáshoz)
- [ ] Mobil-barát layout

---

## Technikai megjegyzések

- **Godot 4.2+** szükséges (GDScript 2.0 szintaxis)
- Mentés helye: `user://save_data.cfg` (platformfüggő app data mappa)
- A `DialogueManager` typewriter effektje skip-elhető kattintással
- Minden stat 0–120 közé van clampelve

---

*Last Bell: 14.A — Demo Build v0.0.1*
