class_name Turn
extends Node


@export var action: Action
@export var target: Combatant


func execute() -> void:
	print("executed")
	action.execute(target)
