extends Control

@onready var card_play_sound = preload("res://assets/core/sounds/whoosh-clothes-cape-243486.mp3")
@onready var card_fail_play_sound = preload("res://assets/core/sounds/bonk-99378.mp3")
@onready var flip_card_sound = preload("res://assets/core/sounds/flipcard-91468.mp3")
@onready var cards_dealt_sound = preload("res://assets/core/sounds/card-deck-stopped-record-sound-106719.mp3")

@onready var stream_player_1: AudioStreamPlayer = $StreamPlayer1
@onready var stream_player_2: AudioStreamPlayer = $StreamPlayer2
@onready var bg_music_player_1: AudioStreamPlayer = $BackGroundMusicPlayer1

func _ready() -> void:
	SignalBus.added_card.connect(card_drawn)
	SignalBus.cards_dealt.connect(cards_dealt_fn)
	bg_music_player_1.play()
	
func card_played():
	stream_player_1.stream = card_play_sound
	stream_player_1.play()
	
func card_failed():
	stream_player_1.stream = card_fail_play_sound
	stream_player_1.play()

func card_drawn():
	stream_player_2.stream = flip_card_sound
	stream_player_2.play()

func cards_dealt_fn():
	print("Cards have been dealt!")
	stream_player_1.stream = cards_dealt_sound
	stream_player_1.play()
	
