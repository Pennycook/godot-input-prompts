# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
@icon("res://addons/input_prompts/icon.svg")
class_name InputPrompt
extends TextureRect
## Base class for input prompts.
##
## Base class for input prompts.

## Emitted when one of the [InputEvent]s associated with this prompt is pressed.
signal pressed

enum Icons {
	AUTOMATIC,
	XBOX,
	SONY,
	NINTENDO,
	KEYBOARD,
}

## The set of [InputEvent]s that should satisfy this input prompt.
@export var events: Array[InputEvent] = []


func _init():
	texture = null
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED


func _update_icon():
	pass


func _refresh():
	_update_icon()


func _input(event: InputEvent):
	if not events.any(func(e): return event.is_match(e)):
		return
	if not event.is_pressed():
		return
	if event.is_echo():
		return
	emit_signal("pressed")


func _enter_tree():
	PromptManager.icons_changed.connect(_update_icon)
	add_to_group("_input_prompts")


func _exit_tree():
	remove_from_group("_input_prompts")
	PromptManager.icons_changed.disconnect(_update_icon)


## Force this [InputPrompt] node to refresh its icons and events.
## Must be called if the [InputMap] is changed.
## [br][br]
## [b]Note[/b]: Use [InputPromptManager] to refresh all nodes at once.
func refresh():
	_refresh()
