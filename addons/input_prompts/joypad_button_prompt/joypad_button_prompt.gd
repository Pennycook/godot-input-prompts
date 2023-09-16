# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
extends "res://addons/input_prompts/base_prompt.gd"

var button = 0: set = _set_button
var icon = InputPrompts.Icons.AUTOMATIC: set = _set_icon

func _ready():
	_update_icon()

func _set_button(index : int):
	button = index
	_update_icon()

func _set_icon(new_icon):
	icon = new_icon
	_update_icon()

func _update_icon():
	var textures := InputPrompts.get_joypad_button_textures(icon)
	texture = textures.get_texture(button)
	queue_redraw()

func _input(event : InputEvent):
	if not event is InputEventJoypadButton:
		return
	if not event.get_button_index() == button:
		return
	if not event.is_pressed():
		return
	emit_signal("pressed")

func _get_property_list():
	var properties = []
	properties.append({
		name = "JoypadButtonPrompt",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
	})
	properties.append({
		name = "button",
		type = TYPE_INT,
		hint = PROPERTY_HINT_RANGE,
		hint_string = "0,22"
	})
	properties.append({
		name = "icon",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = "Automatic,Xbox,Sony,Nintendo"
	})
	return properties
