class_name Combatant
extends Node2D


@export var sprite_frames: SpriteFrames = load("res://resources/sprite_frames/default_combatant.tres")
@export var combatant_name: String = "Combatant"

@onready var attack_audio_stream_player = $AttackAudioStreamPlayer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = find_child("HealthBar")
@onready var name_label: Label = find_child("NameLabel")

@onready var battle_manager: Node = get_tree().get_first_node_in_group("battle_manager")


var hp: int = 100
var attacks: Array[AttackDTO] = []
var inventory: Array = []

func _ready():
	name_label.text = combatant_name
	animated_sprite.play("idle_front")
	add_attack("Soco", 10)
	add_attack("Xingar a mãe", 50)


func set_data(sprite_frames: SpriteFrames, combatant_name: String) -> void:
	self.sprite_frames = sprite_frames
	self.combatant_name = combatant_name
	animated_sprite.sprite_frames = self.sprite_frames
	name_label.text = self.combatant_name


func set_inventory(inventory: Array) -> void:
	self.inventory = inventory


func add_attack(attack_name: String, attack_damage: float):
	var attack = AttackDTO.new()
	attack.attack_damage = attack_damage
	attack.attack_name = attack_name
	attacks.append(attack)


func _process(_delta: float) -> void:
	health_bar.value = hp


func take_damage(damage: float) -> void:
	self.hp -= damage
	self.hp = clamp(self.hp, 0, 100)
	$BloodParticles.emitting = true


func heal(amount: float) -> void:
	self.hp += amount
	self.hp = clamp(self.hp, 0, 100)
	$HealParticles.emitting = true


func play_random_attack_animation() -> void:
	attack_audio_stream_player.play()


func update_animation(animation_name: String, flip_h: bool) -> void:
	animated_sprite.play(animation_name)
	animated_sprite.flip_h = flip_h


# intended for enemy use only
func choose_random_attack() -> void:
	var turn = battle_manager.get_current_turn()
	var action = AttackAction.new()
	var i = randi_range(0, len(attacks) - 1)
	action.action = attacks[i]
	turn.action = action
	print("chose random attack")
