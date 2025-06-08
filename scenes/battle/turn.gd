class_name Turn
extends Node


signal battle_ended


@export var action: Action
@export var target: Combatant


func setup(parent: Node) -> void:
	connect("battle_ended", parent.battle_ended)


func execute() -> void:
	action.execute(target)
	if target.hp == 0:
		emit_signal("battle_ended")
