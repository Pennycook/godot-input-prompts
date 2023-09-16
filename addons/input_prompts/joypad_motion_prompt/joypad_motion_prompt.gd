# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
@icon("res://addons/input_prompts/joypad_motion_prompt/icon.png")
class_name JoypadMotionPrompt
extends "res://addons/input_prompts/base_prompt.gd"

var axis = 0: set = _set_axis
var axis_value = -1: set = _set_axis_value
var icon = InputPrompts.Icons.AUTOMATIC: set = _set_icon

func _ready():
	_update_icon()

func _set_axis(new_axis : int):
	axis = new_axis
	_update_icon()

func _set_axis_value(new_value : int):
	axis_value = new_value
	_update_icon()
	
func _set_icon(new_icon):
	icon = new_icon
	_update_icon()

func _update_icon():
	var textures := InputPrompts.get_joypad_motion_textures(icon)
	texture = textures.get_texture(axis, axis_value)
	queue_redraw()

func _input(event : InputEvent):
	if not event is InputEventJoypadMotion:
		return
	if not event.get_axis() == axis:
		return
	if axis_value == -1 and event.get_axis_value() > 0:
		return
	if axis_value == 1 and event.get_axis_value() < 0:
		return
	emit_signal("pressed")

func _get_property_list():
	var properties = []
	properties.append({
		name = "JoypadMotionPrompt",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
	})
	properties.append({
		name = "axis",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = "Left Horizontal:0,Left Vertical:1,Right Horizontal:2,Right Vertical:3,Left Trigger:4,Right Trigger:5"
	})
	properties.append({
		name = "axis_value",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = "Negative:-1,Positive:1"
	})
	properties.append({
		name = "icon",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = "Automatic,Xbox,Sony,Nintendo"
	})
	return properties
