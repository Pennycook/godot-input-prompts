# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
@icon("res://addons/input_prompts/joypad_button_prompt/icon.svg")
class_name JoypadButtonPrompt
extends "res://addons/input_prompts/input_prompt.gd"
## Displays a prompt based on a joypad button index.
##
## Displays a prompt based on a joypad button index.
## The texture used for the prompt is determined by an icon preference. When
## the icon preference is set to "Automatic", the prompt automatically adjusts
## to match the most recent joypad device.
## [br][br]
## [b]Note[/b]: A [JoypadButtonPrompt] will never show keyboard or mouse
## prompts. To automatically reflect the most recent input device, use
## [ActionPrompt] instead.

## A joypad button index, such as [constant @GlobalScope.JOY_BUTTON_A].
var button := 0:
	set = _set_button

## The icon preference for this prompt:
## Automatic (0), Xbox (1), Sony (2), Nintendo (3).
## When set to "Automatic", the prompt automatically adjusts to match the most
## recent joypad device.
var icon: int = Icons.AUTOMATIC:
	set = _set_icon


func _ready():
	_update_icon()


func _set_button(index: int):
	button = index
	var event := InputEventJoypadButton.new()
	event.button_index = button
	events = [event]
	_update_icon()


func _set_icon(new_icon):
	icon = new_icon
	_update_icon()


func _update_icon():
	var textures := PromptManager.get_joypad_button_textures(icon)
	texture = textures.get_texture(events[0])
	queue_redraw()


func _get_property_list():
	var properties = []
	properties.append(
		{
			name = "JoypadButtonPrompt",
			type = TYPE_NIL,
			usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
		}
	)
	properties.append(
		{name = "button", type = TYPE_INT, hint = PROPERTY_HINT_RANGE, hint_string = "0,22"}
	)
	properties.append(
		{
			name = "icon",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = "Automatic,Xbox,Sony,Nintendo"
		}
	)
	return properties
