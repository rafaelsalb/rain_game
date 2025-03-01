class_name SaveGame
extends Resource


const SAVE_GAME_PATH = "user://save_game.tres"

@export var player_character: PlayerCharacter

func write_savegame() -> void:
    ResourceSaver.save(self, SAVE_GAME_PATH)

static func load_savegame() -> Resource:
    var save = ResourceLoader.load(SAVE_GAME_PATH)
    return save

static func save_exists() -> bool:
    return ResourceLoader.exists(SAVE_GAME_PATH)
