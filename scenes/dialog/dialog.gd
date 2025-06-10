extends Node


signal dialog_finished


@export var character_name: String = "Character"
@export var character_portrait: Texture = preload("res://assets/portraits/prototype/default.png")
@export var dialog_text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin fringilla quam lorem, at hendrerit sapien pellentesque lobortis. Suspendisse mi est, bibendum eget commodo nec, varius ac nibh. Vivamus efficitur rutrum gravida. Phasellus sollicitudin suscipit nulla. Vestibulum mollis, lectus sit amet ultricies venenatis, enim massa molestie magna, a euismod justo diam blandit odio. Nulla a tortor ut ante dictum vehicula suscipit eu arcu. Sed elit ante, pellentesque pellentesque hendrerit quis, porta nec ex. Fusce varius est lectus, nec porta neque commodo eget. Nunc eu auctor justo. Maecenas dolor ante, pharetra et massa quis, pharetra pellentesque elit. Vestibulum convallis consequat feugiat. Mauris eu neque felis. Pellentesque vitae lectus orci. Duis mattis eu enim a placerat. Vestibulum ut neque a lectus congue imperdiet."
@export var voice: AudioStream = preload("res://scenes/dialog/male_voice_calm.tres")

var finished = false
var frame_count = 0
var progress = 0

@onready var audio_player = $AudioStreamPlayer
@onready var character_box = $CanvasLayer/Control/Background/CharacterName
@onready var character_image = $CanvasLayer/Control/Background/CharacterPortrait
@onready var text_box = $CanvasLayer/Control/Background/DialogText
@onready var input_prompt_hint = find_child("InputPromptHint")


func _ready() -> void:
	audio_player.stream = voice
	character_box.text = character_name
	character_image.texture = character_portrait
	GameState.freeze_player()
	input_prompt_hint.visible = false
	connect("dialog_finished", GameState.on_dialog_finished)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pass_dialog"):
		if not finished:
			#progress = len(dialog_text) - 2
			pass
		else:
			GameState.unfreeze_player()
			emit_signal("dialog_finished")
			queue_free()


func _process(_delta: float) -> void:
	render_text()


func render_text():
	if progress < len(dialog_text):
		if not frame_count % 3:
			progress += 1
			text_box.text = dialog_text.substr(0, progress)
			if not progress % 5:
				audio_player.pitch_scale = 1.0 + randfn(0.0, 0.25)
				audio_player.playing = true
		frame_count += 1
	else:
		finished = true
		input_prompt_hint.visible = true


func _on_text_draw_clock_timeout() -> void:
	$TextDrawClock.start()


func setup(character_name: String, character_portrait: Texture, text: String) -> void:
	character_box.text = character_name
	character_image.texture = character_portrait
	dialog_text = text
