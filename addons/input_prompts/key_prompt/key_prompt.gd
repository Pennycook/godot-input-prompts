# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
@icon("res://addons/input_prompts/key_prompt/icon.png")
class_name KeyPrompt
extends "res://addons/input_prompts/base_prompt.gd"

var key = KEY_EXCLAM:
	set = _set_key


func _ready():
	_update_icon()


func _set_key(scancode: int):
	key = scancode
	_update_icon()


func _update_icon():
	var textures := InputPrompts.get_keyboard_textures()
	texture = textures.get_texture(key)
	queue_redraw()


func _input(event: InputEvent):
	if not event is InputEventKey:
		return
	if not event.get_keycode() == key:
		return
	if not event.is_pressed():
		return
	if event.is_echo():
		return
	emit_signal("pressed")


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
	for k in InputPrompts.Keys:
		if keys != "":
			keys += ","
		keys += "{0}:{1}".format([OS.get_keycode_string(k), k])
	properties.append(
		{name = "key", type = TYPE_INT, hint = PROPERTY_HINT_ENUM, hint_string = keys}
	)
	return properties
