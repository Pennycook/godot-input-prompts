# Copyright (C) 2022 John Pennycook
# SPDX-License-Identifier: MIT
tool
extends Node

signal icons_changed

enum Icons {
	AUTOMATIC,
	XBOX,
	SONY,
	NINTENDO,
	KEYBOARD,
}

const KeyPromptMap = {
	KEY_ESCAPE : Rect2(0, 0, 16, 16),
	KEY_F1 : Rect2(16, 0, 16, 16),
	KEY_F2 : Rect2(32, 0, 16, 16),
	KEY_F3 : Rect2(48, 0, 16, 16),
	KEY_F4 : Rect2(64, 0, 16, 16),
	KEY_F5 : Rect2(80, 0, 16, 16),
	KEY_F6 : Rect2(96, 0, 16, 16),
	KEY_F7 : Rect2(112, 0, 16, 16),
	KEY_F8 : Rect2(128, 0, 16, 16),
	KEY_F9 : Rect2(144, 0, 16, 16),
	KEY_F10 : Rect2(160, 0, 16, 16),
	KEY_F11 : Rect2(176, 0, 16, 16),
	KEY_F12 : Rect2(192, 0, 16, 16),
	KEY_ASCIITILDE : Rect2(208, 0, 16, 16),
	KEY_EXCLAM : Rect2(224, 0, 16, 16),
	KEY_AT : Rect2(240, 0, 16, 16),
	KEY_NUMBERSIGN : Rect2(256, 0, 16, 16),
	KEY_1 : Rect2(0, 16, 16, 16),
	KEY_2 : Rect2(16, 16, 16, 16),
	KEY_3 : Rect2(32, 16, 16, 16),
	KEY_4 : Rect2(48, 16, 16, 16),
	KEY_5 : Rect2(64, 16, 16, 16),
	KEY_6 : Rect2(80, 16, 16, 16),
	KEY_7 : Rect2(96, 16, 16, 16),
	KEY_8 : Rect2(112, 16, 16, 16),
	KEY_9 : Rect2(128, 16, 16, 16),
	KEY_0 : Rect2(144, 16, 16, 16),
	KEY_MINUS : Rect2(160, 16, 16, 16),
	KEY_PLUS : Rect2(176, 16, 16, 16),
	KEY_EQUAL : Rect2(192, 16, 16, 16),
	KEY_UNDERSCORE : Rect2(208, 16, 16, 16),
	KEY_BAR : Rect2(224, 16, 16, 16),
	KEY_BACKSPACE : Rect2(240, 16, 32, 16),
	KEY_Q : Rect2(0, 32, 16, 16),
	KEY_W : Rect2(16, 32, 16, 16),
	KEY_E : Rect2(32, 32, 16, 16),
	KEY_R : Rect2(48, 32, 16, 16),
	KEY_T : Rect2(64, 32, 16, 16),
	KEY_Y : Rect2(80, 32, 16, 16),
	KEY_U : Rect2(96, 32, 16, 16),
	KEY_I : Rect2(112, 32, 16, 16),
	KEY_O : Rect2(128, 32, 16, 16),
	KEY_P : Rect2(144, 32, 16, 16),
	KEY_BRACKETLEFT : Rect2(160, 32, 16, 16),
	KEY_BRACKETRIGHT : Rect2(176, 32, 16, 16),
	KEY_BRACELEFT : Rect2(192, 32, 16, 16),
	KEY_BRACERIGHT : Rect2(208, 32, 16, 16),
	KEY_BACKSLASH : Rect2(224, 32, 16, 16),
	KEY_ENTER : Rect2(240, 32, 32, 32),
	KEY_A : Rect2(16, 48, 16, 16),
	KEY_S : Rect2(32, 48, 16, 16),
	KEY_D : Rect2(48, 48, 16, 16),
	KEY_F : Rect2(64, 48, 16, 16),
	KEY_G : Rect2(80, 48, 16, 16),
	KEY_H : Rect2(96, 48, 16, 16),
	KEY_J : Rect2(112, 48, 16, 16),
	KEY_K : Rect2(128, 48, 16, 16),
	KEY_L : Rect2(144, 48, 16, 16),
	KEY_APOSTROPHE : Rect2(160, 48, 16, 16),
	KEY_QUOTEDBL : Rect2(176, 48, 16, 16),
	KEY_COLON : Rect2(192, 48, 16, 16),
	KEY_SEMICOLON : Rect2(208, 48, 16, 16),
	KEY_ASTERISK : Rect2(224, 48, 16, 16),
	KEY_NOBREAKSPACE : Rect2(0, 64, 16, 16),
	KEY_META : Rect2(16, 64, 16, 16),
	KEY_Z : Rect2(32, 64, 16, 16),
	KEY_X : Rect2(48, 64, 16, 16),
	KEY_C : Rect2(64, 64, 16, 16),
	KEY_V : Rect2(80, 64, 16, 16),
	KEY_B : Rect2(96, 64, 16, 16),
	KEY_N : Rect2(112, 64, 16, 16),
	KEY_M : Rect2(128, 64, 16, 16),
	KEY_LESS : Rect2(144, 64, 16, 16),
	KEY_GREATER : Rect2(160, 64, 16, 16),
	KEY_QUESTION : Rect2(176, 64, 16, 16),
	KEY_SLASH : Rect2(192, 64, 16, 16),
	KEY_UP : Rect2(208, 64, 16, 16),
	KEY_RIGHT : Rect2(224, 64, 16, 16),
	KEY_DOWN : Rect2(240, 64, 16, 16),
	KEY_LEFT : Rect2(256, 64, 16, 16),
	KEY_ALT : Rect2(0, 80, 32, 16),
	KEY_TAB : Rect2(32, 80, 32, 16),
	KEY_DELETE : Rect2(64, 80, 32, 16),
	KEY_END : Rect2(96, 80, 32, 16),
	KEY_NUMLOCK : Rect2(128, 80, 32, 16),
	KEY_PERIOD : Rect2(160, 80, 16, 16),
	KEY_DOLLAR : Rect2(176, 80, 16, 16),
	KEY_PERCENT : Rect2(192, 80, 16, 16),
	KEY_ASCIICIRCUM : Rect2(208, 80, 16, 16),
	KEY_CENT : Rect2(224, 80, 16, 16),
	KEY_PARENLEFT : Rect2(240, 80, 16, 16),
	KEY_PARENRIGHT : Rect2(256, 80, 16, 16),
	KEY_CONTROL : Rect2(0, 96, 32, 16),
	KEY_CAPSLOCK : Rect2(32, 96, 32, 16),
	KEY_HOME : Rect2(64, 96, 32, 16),
	KEY_PAGEUP : Rect2(96, 96, 32, 16),
	KEY_PAGEDOWN : Rect2(128, 96, 32, 16),
	KEY_COMMA : Rect2(160, 96, 16, 16),
	KEY_MEDIARECORD : Rect2(208, 96, 16, 16),
	KEY_SPACE : Rect2(224, 96, 48, 16),
	KEY_SHIFT : Rect2(0, 112, 32, 16),
	KEY_INSERT : Rect2(32, 112, 32, 16),
	KEY_PRINT : Rect2(64, 112, 32, 16),
	KEY_SCROLLLOCK : Rect2(96, 112, 32, 16),
	KEY_PAUSE : Rect2(128, 112, 32, 16),
	KEY_MEDIAPLAY : Rect2(160, 112, 16, 16),
	KEY_MEDIASTOP : Rect2(192, 112, 16, 16),
	KEY_BACK : Rect2(208, 112, 16, 16),
	KEY_FORWARD : Rect2(224, 112, 16, 16),
	KEY_MEDIAPREVIOUS : Rect2(240, 112, 16, 16),
	KEY_MEDIANEXT : Rect2(256, 112, 16, 16),
}

const KeyPromptNames = {
	KEY_ESCAPE : "Escape",
	KEY_F1 : "F1",
	KEY_F2 : "F2",
	KEY_F3 : "F3",
	KEY_F4 : "F4",
	KEY_F5 : "F5",
	KEY_F6 : "F6",
	KEY_F7 : "F7",
	KEY_F8 : "F8",
	KEY_F9 : "F9",
	KEY_F10 : "F10",
	KEY_F11 : "F11",
	KEY_F12 : "F12",
	KEY_ASCIITILDE : "~",
	KEY_EXCLAM : "!",
	KEY_AT : "@",
	KEY_NUMBERSIGN : "#",
	KEY_1 : "1",
	KEY_2 : "2",
	KEY_3 : "3",
	KEY_4 : "4",
	KEY_5 : "5",
	KEY_6 : "6",
	KEY_7 : "7",
	KEY_8 : "8",
	KEY_9 : "9",
	KEY_0 : "0",
	KEY_MINUS : "-",
	KEY_PLUS : "+",
	KEY_EQUAL : "=",
	KEY_UNDERSCORE : "_",
	KEY_BAR : "|",
	KEY_BACKSPACE : "Backspace",
	KEY_Q : "Q",
	KEY_W : "W",
	KEY_E : "E",
	KEY_R : "R",
	KEY_T : "T",
	KEY_Y : "Y",
	KEY_U : "U",
	KEY_I : "I",
	KEY_O : "O",
	KEY_P : "P",
	KEY_BRACKETLEFT : "[",
	KEY_BRACKETRIGHT : "]",
	KEY_BRACELEFT : "(",
	KEY_BRACERIGHT : ")",
	KEY_BACKSLASH : "\\",
	KEY_ENTER : "Enter",
	KEY_A : "A",
	KEY_S : "S",
	KEY_D : "D",
	KEY_F : "F",
	KEY_G : "G",
	KEY_H : "H",
	KEY_J : "J",
	KEY_K : "K",
	KEY_L : "L",
	KEY_APOSTROPHE : "'",
	KEY_QUOTEDBL : "\"",
	KEY_COLON : "Colon",
	KEY_SEMICOLON : "Semi-colon",
	KEY_ASTERISK : "*",
	KEY_NOBREAKSPACE : "Non-Breaking Space",
	KEY_META : "Meta",
	KEY_Z : "Z",
	KEY_X : "X",
	KEY_C : "C",
	KEY_V : "V",
	KEY_B : "B",
	KEY_N : "N",
	KEY_M : "M",
	KEY_LESS : "<",
	KEY_GREATER : ">",
	KEY_QUESTION : "?",
	KEY_SLASH : "/",
	KEY_UP : "Up",
	KEY_RIGHT : "Right",
	KEY_DOWN : "Down",
	KEY_LEFT : "Left",
	KEY_ALT : "Alt",
	KEY_TAB : "Tab",
	KEY_DELETE : "Delete",
	KEY_END : "End",
	KEY_NUMLOCK : "Num Lock",
	KEY_PERIOD : ".",
	KEY_DOLLAR : "$",
	KEY_PERCENT : "%",
	KEY_ASCIICIRCUM : "^",
	KEY_CENT : "Cent",
	KEY_PARENLEFT : "(",
	KEY_PARENRIGHT : ")",
	KEY_CONTROL : "Control",
	KEY_CAPSLOCK : "Caps Lock",
	KEY_HOME : "Home",
	KEY_PAGEUP : "Page Up",
	KEY_PAGEDOWN : "Page Down",
	KEY_COMMA : "Comma",
	KEY_MEDIARECORD : "Record",
	KEY_SPACE : "Space",
	KEY_SHIFT : "Shift",
	KEY_INSERT : "Insert",
	KEY_PRINT : "Print",
	KEY_SCROLLLOCK : "Scroll Lock",
	KEY_PAUSE : "Pause",
	KEY_MEDIAPLAY : "Play",
	KEY_MEDIASTOP : "Stop",
	KEY_BACK : "Back",
	KEY_FORWARD : "Forward",
	KEY_MEDIAPREVIOUS : "Previous",
	KEY_MEDIANEXT : "Next",
}

var _preferred_icons = Icons.AUTOMATIC
var _icons = Icons.XBOX

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
	if Engine.editor_hint:
		return Icons.XBOX
	else:
		return _icons

func get_key_atlas():
	return preload("res://addons/input_prompts/KeyPrompt/keys.png")

func get_key_region(scancode : int):
	return KeyPromptMap[scancode]

func get_mouse_atlas():
	return preload("res://addons/input_prompts/MouseButtonPrompt/buttons.png")

func get_mouse_region(button : int):
	var x = button - 1
	return Rect2(x * 16, 0, 16, 16)

func get_joypad_button_atlas(icons : int):
	match icons:
		Icons.AUTOMATIC:
			return get_joypad_button_atlas(get_icons())
		Icons.XBOX:
			return preload("res://addons/input_prompts/JoypadButtonPrompt/xbox.png")
		Icons.SONY:
			return preload("res://addons/input_prompts/JoypadButtonPrompt/sony.png")
		Icons.NINTENDO:
			return preload("res://addons/input_prompts/JoypadButtonPrompt/nintendo.png")

func get_joypad_button_region(button : int):
	var x = button % 16
	var y = button / 16
	return Rect2(x * 16, y * 16, 16, 16)

func get_joypad_motion_atlas():
	return preload("res://addons/input_prompts/JoypadMotionPrompt/axis.png")

func get_joypad_motion_region(axis : int, axis_value : int):
	var x = 0 if axis_value == -1 else 1
	var y = axis
	return Rect2(x * 16, y * 16, 16, 16)

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
		var joy_icons = null
		if joy_name.find("Xbox"):
			joy_icons = Icons.XBOX
		elif joy_name.find("DualShock") or joy_name.find("PS"):
			joy_icons = Icons.SONY
		elif joy_name.find("Nintendo"):
			joy_icons = Icons.NINTENDO
		else:
			joy_icons = Icons.XBOX
		if _icons != joy_icons:
			_icons = joy_icons
			emit_signal("icons_changed")
