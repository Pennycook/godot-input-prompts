# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
@icon("res://addons/input_prompts/key_prompt/icon.svg")
class_name KeyPrompt
extends "res://addons/input_prompts/input_prompt.gd"
## Displays a prompt based on a keyboard scancode.
##
## Displays a prompt based on a keyboard scancode.
## The texture used for the prompt is determined automatically.
## [br][br]
## [b]Note[/b]: A [KeyPrompt] will never show joypad or mouse
## prompts. To automatically reflect the most recent input device, use
## [ActionPrompt] instead.

# TODO: Find a way to replace this with standard functionality.
#       The Key enum is not accessible directly and can't be iterated over.
const _KEYS = [
	KEY_ESCAPE,
	KEY_F1,
	KEY_F2,
	KEY_F3,
	KEY_F4,
	KEY_F5,
	KEY_F6,
	KEY_F7,
	KEY_F8,
	KEY_F9,
	KEY_F10,
	KEY_F11,
	KEY_F12,
	KEY_ASCIITILDE,
	KEY_EXCLAM,
	KEY_AT,
	KEY_NUMBERSIGN,
	KEY_1,
	KEY_2,
	KEY_3,
	KEY_4,
	KEY_5,
	KEY_6,
	KEY_7,
	KEY_8,
	KEY_9,
	KEY_0,
	KEY_MINUS,
	KEY_PLUS,
	KEY_EQUAL,
	KEY_UNDERSCORE,
	KEY_BAR,
	KEY_BACKSPACE,
	KEY_Q,
	KEY_W,
	KEY_E,
	KEY_R,
	KEY_T,
	KEY_Y,
	KEY_U,
	KEY_I,
	KEY_O,
	KEY_P,
	KEY_BRACKETLEFT,
	KEY_BRACKETRIGHT,
	KEY_BRACELEFT,
	KEY_BRACERIGHT,
	KEY_BACKSLASH,
	KEY_ENTER,
	KEY_A,
	KEY_S,
	KEY_D,
	KEY_F,
	KEY_G,
	KEY_H,
	KEY_J,
	KEY_K,
	KEY_L,
	KEY_APOSTROPHE,
	KEY_QUOTEDBL,
	KEY_COLON,
	KEY_SEMICOLON,
	KEY_ASTERISK,
	KEY_META,
	KEY_Z,
	KEY_X,
	KEY_C,
	KEY_V,
	KEY_B,
	KEY_N,
	KEY_M,
	KEY_LESS,
	KEY_GREATER,
	KEY_QUESTION,
	KEY_SLASH,
	KEY_UP,
	KEY_RIGHT,
	KEY_DOWN,
	KEY_LEFT,
	KEY_ALT,
	KEY_TAB,
	KEY_DELETE,
	KEY_END,
	KEY_NUMLOCK,
	KEY_PERIOD,
	KEY_DOLLAR,
	KEY_PERCENT,
	KEY_ASCIICIRCUM,
	KEY_PARENLEFT,
	KEY_PARENRIGHT,
	KEY_CTRL,
	KEY_CAPSLOCK,
	KEY_HOME,
	KEY_PAGEUP,
	KEY_PAGEDOWN,
	KEY_COMMA,
	KEY_MEDIARECORD,
	KEY_SPACE,
	KEY_SHIFT,
	KEY_INSERT,
	KEY_PRINT,
	KEY_SCROLLLOCK,
	KEY_PAUSE,
	KEY_MEDIAPLAY,
	KEY_MEDIASTOP,
	KEY_BACK,
	KEY_FORWARD,
	KEY_MEDIAPREVIOUS,
	KEY_MEDIANEXT,
]

## A keyboard scancode, such as [constant @GlobalScope.KEY_ESCAPE].
var key := KEY_EXCLAM:
	set = _set_key


func _ready():
	_update_icon()


func _set_key(scancode: int):
	key = scancode
	var event := InputEventKey.new()
	event.keycode = scancode
	events = [event]
	_update_icon()


func _update_icon():
	var textures := PromptManager.get_keyboard_textures()
	texture = textures.get_texture(events[0])
	queue_redraw()


func _get_property_list():
	var properties = []
	properties.append(
		{
			name = "KeyPrompt",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
		}
	)
	var keys: String = ""
	for k in _KEYS:
		if keys != "":
			keys += ","
		keys += "{0}:{1}".format([OS.get_keycode_string(k), k])
	properties.append(
		{name = "key", type = TYPE_INT, hint = PROPERTY_HINT_ENUM, hint_string = keys}
	)
	return properties
