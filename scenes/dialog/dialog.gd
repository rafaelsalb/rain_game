@tool
extends Node


signal dialog_finished


@export var character_name: String = "Character"
@export var character_portrait: Texture = preload("res://assets/portraits/prototype/default.png")
@export var text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin fringilla quam lorem, at hendrerit sapien pellentesque lobortis. Suspendisse mi est, bibendum eget commodo nec, varius ac nibh. Vivamus efficitur rutrum gravida. Phasellus sollicitudin suscipit nulla. Vestibulum mollis, lectus sit amet ultricies venenatis, enim massa molestie magna, a euismod justo diam blandit odio. Nulla a tortor ut ante dictum vehicula suscipit eu arcu. Sed elit ante, pellentesque pellentesque hendrerit quis, porta nec ex. Fusce varius est lectus, nec porta neque commodo eget. Nunc eu auctor justo. Maecenas dolor ante, pharetra et massa quis, pharetra pellentesque elit. Vestibulum convallis consequat feugiat. Mauris eu neque felis. Pellentesque vitae lectus orci. Duis mattis eu enim a placerat. Vestibulum ut neque a lectus congue imperdiet."
@export var voice: AudioStream = preload("res://scenes/dialog/male_voice_calm.tres")

var finished = false
var frame_count = 0
var progress = 0

@onready var audio_player = $AudioStreamPlayer
@onready var character_box = $CanvasLayer/Control/Background/CharacterName
@onready var character_image = $CanvasLayer/Control/Background/CharacterPortrait
@onready var text_box = $CanvasLayer/Control/Background/DialogText


func _ready() -> void:
	audio_player.stream = voice
	print(voice)

	character_box.text = character_name
	character_image.texture = character_portrait


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if not finished:
			progress = len(text) - 2
		else:
			emit_signal("dialog_finished")
			queue_free()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		text_box.text = text
	render_text()


func render_text():
	if progress < len(text):
		if not frame_count % 2:
			progress += 1
			text_box.text = text.substr(0, progress)
			if not progress % 4:
				audio_player.pitch_scale = 1.0 + randfn(0.0, 0.25)
				audio_player.playing = true
		frame_count += 1
	else:
		finished = true


func _on_text_draw_clock_timeout() -> void:
	$TextDrawClock.start()
