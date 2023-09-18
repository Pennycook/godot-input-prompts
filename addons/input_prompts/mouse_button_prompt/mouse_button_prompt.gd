# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
@icon("res://addons/input_prompts/mouse_button_prompt/icon.svg")
class_name MouseButtonPrompt
extends "res://addons/input_prompts/input_prompt.gd"
## Displays a prompt based on a mouse button index.
##
## Displays a prompt based on a mouse button index.
## The texture used for the prompt is determined automatically.
## [br][br]
## [b]Note[/b]: A [MouseButtonPrompt] will never show joypad or keyboard
## prompts. To automatically reflect the most recent input device, use
## [ActionPrompt] instead.

## A mouse button index, such as [constant @GlobalScope.MOUSE_BUTTON_LEFT].
var button := 1:
	set = _set_button


func _ready():
	_update_icon()


func _set_button(index: int):
	button = index
	var event := InputEventMouseButton.new()
	event.button_index = button
	events = [event]
	_update_icon()


func _update_icon():
	var textures := PromptManager.get_mouse_textures()
	texture = textures.get_texture(events[0])
	queue_redraw()


func _get_property_list():
	var properties = []
	properties.append(
		{
			name = "MouseButtonPrompt",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
		}
	)
	properties.append(
		{
			name = "button",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string =
			"Left:1,Right:2,Middle:3,Wheel Up:4,Wheel Down:5,Wheel Left:6,Wheel Right:7"
		}
	)
	return properties
