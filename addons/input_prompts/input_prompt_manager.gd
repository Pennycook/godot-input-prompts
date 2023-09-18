# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
class_name InputPromptManager
extends Node
## Singleton class for managing [InputPrompt]s.
##
## Singleton class for managing [InputPrompt]s.
## [br][br]
## [b]Note[/b]: An instance of [InputPromptManager] is autoloaded under the name
## PromptManager.

## Emitted when the preferred icons change. If the preferred icons are set to
## "Automatic", emitted whenever the input device changes.
signal icons_changed

## The icons currently used by [ActionPrompt] nodes.
var icons := InputPrompt.Icons.XBOX:
	get:
		# In the Editor, InputMap reflects Editor settings
		# Pick a default so there's something to render
		if Engine.is_editor_hint():
			return InputPrompt.Icons.XBOX
		return icons

## The icons currently used by [JoypadButtonPrompt] and [JoypadMotionPrompt] nodes.
var joy_icons = InputPrompt.Icons.XBOX:
	get:
		# In the Editor, InputMap reflects Editor settings
		# Pick a default so there's something to render
		if Engine.is_editor_hint():
			return InputPrompt.Icons.XBOX
		return joy_icons

## The preferred icons to be used by [ActionPrompt], [JoypadButtonPrompt] and [JoypadMotionPrompt]
## nodes. When set to a specific value, all nodes with "Automatic" icons will be overridden to use
## the specified value.
var preferred_icons := InputPrompt.Icons.AUTOMATIC:
	set(value):
		preferred_icons = value
		if preferred_icons == null or preferred_icons == InputPrompt.Icons.AUTOMATIC:
			icons = InputPrompt.Icons.XBOX
		else:
			icons = value
		emit_signal("icons_changed")


## Return the [KeyboardTextures] used by [KeyPrompt] nodes.
func get_keyboard_textures() -> KeyboardTextures:
	return preload("res://addons/input_prompts/key_prompt/keys.tres")


## Return the [MouseButtonTextures] used by [MouseButtonPrompt] nodes.
func get_mouse_textures() -> MouseButtonTextures:
	return preload("res://addons/input_prompts/mouse_button_prompt/buttons.tres")


## Return the [JoypadButtonTextures] used by [JoypadButtonPrompt] nodes.
func get_joypad_button_textures(icons: int) -> JoypadButtonTextures:
	match icons:
		InputPrompt.Icons.AUTOMATIC:
			return get_joypad_button_textures(joy_icons)
		InputPrompt.Icons.XBOX:
			return preload("res://addons/input_prompts/joypad_button_prompt/xbox.tres")
		InputPrompt.Icons.SONY:
			return preload("res://addons/input_prompts/joypad_button_prompt/sony.tres")
		InputPrompt.Icons.NINTENDO:
			return preload("res://addons/input_prompts/joypad_button_prompt/nintendo.tres")
		InputPrompt.Icons.KEYBOARD:
			push_error("No JoypadButtonTextures for InputPrompt.Icons.KEYBOARD.")
	return null


## Return the [JoypadMotionTextures] used by [JoypadMotionPrompt] nodes.
func get_joypad_motion_textures(icons: int) -> JoypadMotionTextures:
	match icons:
		InputPrompt.Icons.AUTOMATIC:
			return get_joypad_motion_textures(joy_icons)
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
	if not (preferred_icons == null or preferred_icons == InputPrompt.Icons.AUTOMATIC):
		return
	if event is InputEventKey or event is InputEventMouse:
		if icons != InputPrompt.Icons.KEYBOARD:
			icons = InputPrompt.Icons.KEYBOARD
			emit_signal("icons_changed")
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		var device = event.device
		var joy_name = Input.get_joy_name(device)
		if joy_name.find("Xbox"):
			joy_icons = InputPrompt.Icons.XBOX
		elif joy_name.find("DualShock") or joy_name.find("PS"):
			joy_icons = InputPrompt.Icons.SONY
		elif joy_name.find("Nintendo"):
			joy_icons = InputPrompt.Icons.NINTENDO
		else:
			joy_icons = InputPrompt.Icons.XBOX
		if icons != joy_icons:
			icons = joy_icons
			emit_signal("icons_changed")
