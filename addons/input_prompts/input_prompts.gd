# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
extends Node

signal icons_changed

enum Icons {
	AUTOMATIC,
	XBOX,
	SONY,
	NINTENDO,
	KEYBOARD,
}

# TODO: Find a way to replace this with standard functionality.
#       The Key enum is not accessible directly and can't be iterated over.
const Keys = [
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

var _preferred_icons = Icons.AUTOMATIC
var _icons = Icons.XBOX
var _joy_icons = Icons.XBOX

func get_preferred_icons():
	return _preferred_icons

func set_preferred_icons(icons):
	_preferred_icons = icons
	if _preferred_icons == null or _preferred_icons == Icons.AUTOMATIC:
		_icons = Icons.XBOX
	else:
		_icons = icons
	emit_signal("icons_changed")

func get_icons():
	# In the Editor, InputMap reflects Editor settings
	# Pick a default so there's something to render
	if Engine.is_editor_hint():
		return Icons.XBOX
	else:
		return _icons

func get_joy_icons():
	# In the Editor, InputMap reflects Editor settings
	# Pick a default so there's something to render
	if Engine.is_editor_hint():
		return Icons.XBOX
	else:
		return _joy_icons

func get_keyboard_textures() -> KeyboardTextures:
	return preload("res://addons/input_prompts/key_prompt/keys.tres")

func get_mouse_textures() -> MouseButtonTextures:
	return preload("res://addons/input_prompts/mouse_button_prompt/buttons.tres")

func get_joypad_button_textures(icons: int) -> JoypadButtonTextures:
	match icons:
		Icons.AUTOMATIC:
			return get_joypad_button_textures(get_joy_icons())
		Icons.XBOX:
			return preload("res://addons/input_prompts/joypad_button_prompt/xbox.tres")
		Icons.SONY:
			return preload("res://addons/input_prompts/joypad_button_prompt/sony.tres")
		Icons.NINTENDO:
			return preload("res://addons/input_prompts/joypad_button_prompt/nintendo.tres")
		Icons.KEYBOARD:
			push_warning("No JoypadButtonTextures for Icons.KEYBOARD; defaulting to Xbox.")
	return preload("res://addons/input_prompts/joypad_button_prompt/xbox.tres")

func get_joypad_motion_textures(icons: int) -> JoypadMotionTextures:
	match icons:
		Icons.AUTOMATIC:
			return get_joypad_motion_textures(get_joy_icons())
		Icons.XBOX:
			return preload("res://addons/input_prompts/joypad_motion_prompt/xbox.tres")
		Icons.SONY:
			return preload("res://addons/input_prompts/joypad_motion_prompt/sony.tres")
		Icons.NINTENDO:
			return preload("res://addons/input_prompts/joypad_motion_prompt/nintendo.tres")
		Icons.KEYBOARD:
			push_warning("No JoypadMotionTextures for Icons.KEYBOARD; defaulting to Xbox.")
	return preload("res://addons/input_prompts/joypad_motion_prompt/xbox.tres")

# Monitor InputEvents and emit icons_changed if:
# 1) The user has not expressed an icon preference
# 2) The type of InputEvent is different to last time
func _input(event : InputEvent):
	if not (_preferred_icons == null or _preferred_icons == Icons.AUTOMATIC):
		return
	if event is InputEventKey or event is InputEventMouse:
		if _icons != Icons.KEYBOARD:
			_icons = Icons.KEYBOARD
			emit_signal("icons_changed")
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		var device = event.device
		var joy_name = Input.get_joy_name(device)
		if joy_name.find("Xbox"):
			_joy_icons = Icons.XBOX
		elif joy_name.find("DualShock") or joy_name.find("PS"):
			_joy_icons = Icons.SONY
		elif joy_name.find("Nintendo"):
			_joy_icons = Icons.NINTENDO
		else:
			_joy_icons = Icons.XBOX
		if _icons != _joy_icons:
			_icons = _joy_icons
			emit_signal("icons_changed")
