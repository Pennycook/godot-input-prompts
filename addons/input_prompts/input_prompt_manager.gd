# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
extends Node
class_name InputPromptManager

signal icons_changed


var _preferred_icons = InputPrompt.Icons.AUTOMATIC
var _icons = InputPrompt.Icons.XBOX
var _joy_icons = InputPrompt.Icons.XBOX


func get_preferred_icons():
	return _preferred_icons


func set_preferred_icons(icons):
	_preferred_icons = icons
	if _preferred_icons == null or _preferred_icons == InputPrompt.Icons.AUTOMATIC:
		_icons = InputPrompt.Icons.XBOX
	else:
		_icons = icons
	emit_signal("icons_changed")


func get_icons():
	# In the Editor, InputMap reflects Editor settings
	# Pick a default so there's something to render
	if Engine.is_editor_hint():
		return InputPrompt.Icons.XBOX
	return _icons


func get_joy_icons():
	# In the Editor, InputMap reflects Editor settings
	# Pick a default so there's something to render
	if Engine.is_editor_hint():
		return InputPrompt.Icons.XBOX
	return _joy_icons


func get_keyboard_textures() -> KeyboardTextures:
	return preload("res://addons/input_prompts/key_prompt/keys.tres")


func get_mouse_textures() -> MouseButtonTextures:
	return preload("res://addons/input_prompts/mouse_button_prompt/buttons.tres")


func get_joypad_button_textures(icons: int) -> JoypadButtonTextures:
	match icons:
		InputPrompt.Icons.AUTOMATIC:
			return get_joypad_button_textures(get_joy_icons())
		InputPrompt.Icons.XBOX:
			return preload("res://addons/input_prompts/joypad_button_prompt/xbox.tres")
		InputPrompt.Icons.SONY:
			return preload("res://addons/input_prompts/joypad_button_prompt/sony.tres")
		InputPrompt.Icons.NINTENDO:
			return preload("res://addons/input_prompts/joypad_button_prompt/nintendo.tres")
		InputPrompt.Icons.KEYBOARD:
			push_error("No JoypadButtonTextures for InputPrompt.Icons.KEYBOARD.")
	return null


func get_joypad_motion_textures(icons: int) -> JoypadMotionTextures:
	match icons:
		InputPrompt.Icons.AUTOMATIC:
			return get_joypad_motion_textures(get_joy_icons())
		InputPrompt.Icons.XBOX:
			return preload("res://addons/input_prompts/joypad_motion_prompt/xbox.tres")
		InputPrompt.Icons.SONY:
			return preload("res://addons/input_prompts/joypad_motion_prompt/sony.tres")
		InputPrompt.Icons.NINTENDO:
			return preload("res://addons/input_prompts/joypad_motion_prompt/nintendo.tres")
		InputPrompt.Icons.KEYBOARD:
			push_error("No JoypadMotionTextures for InputPrompt.Icons.KEYBOARD.")
	return null


# Monitor InputEvents and emit icons_changed if:
# 1) The user has not expressed an icon preference
# 2) The type of InputEvent is different to last time
func _input(event: InputEvent):
	if not (_preferred_icons == null or _preferred_icons == InputPrompt.Icons.AUTOMATIC):
		return
	if event is InputEventKey or event is InputEventMouse:
		if _icons != InputPrompt.Icons.KEYBOARD:
			_icons = InputPrompt.Icons.KEYBOARD
			emit_signal("icons_changed")
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		var device = event.device
		var joy_name = Input.get_joy_name(device)
		if joy_name.find("Xbox"):
			_joy_icons = InputPrompt.Icons.XBOX
		elif joy_name.find("DualShock") or joy_name.find("PS"):
			_joy_icons = InputPrompt.Icons.SONY
		elif joy_name.find("Nintendo"):
			_joy_icons = InputPrompt.Icons.NINTENDO
		else:
			_joy_icons = InputPrompt.Icons.XBOX
		if _icons != _joy_icons:
			_icons = _joy_icons
			emit_signal("icons_changed")
