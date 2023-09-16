# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
extends "res://addons/input_prompts/base_prompt.gd"

var button = 1: set = _set_button

func _ready():
	_update_icon()

func _set_button(index : int):
	button = index
	_update_icon()

func _update_icon():
	var textures := InputPrompts.get_mouse_textures()
	texture = textures.get_texture(button)
	queue_redraw()

func _input(event : InputEvent):
	if not event is InputEventMouseButton:
		return
	if not event.get_button_index() == button:
		return
	if not event.is_pressed():
		return
	emit_signal("pressed")

func _get_property_list():
	var properties = []
	properties.append({
		name = "MouseButtonPrompt",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
	})
	properties.append({
		name = "button",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = "Left:0,Right:1,Middle:2,Wheel Up:3,Wheel Down:4,Wheel Left:5,Wheel Right:6"
	})
	return properties
