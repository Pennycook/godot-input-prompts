# Copyright (C) 2022 John Pennycook
# SPDX-License-Identifier: MIT
tool
extends "res://addons/input_prompts/BasePrompt.gd"

var key = KEY_EXCLAM setget _set_key

func _ready():
	self.key = key
	_update_icon()

func _set_key(scancode : int):
	key = scancode
	_update_icon()
	
func _update_icon():
	texture.atlas = InputPrompts.get_key_atlas()
	texture.region = InputPrompts.get_key_region(key)
	update()

func _input(event : InputEvent):
	if not event is InputEventKey:
		return
	if not event.get_scancode() == key:
		return
	if not event.is_pressed():
		return
	if event.is_echo():
		return
	emit_signal("pressed")

func _get_property_list():
	var properties = []
	properties.append({
		name = "KeyPrompt",
		type = TYPE_NIL,
		usage = PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
	})
	var keys : String = ""
	for k in InputPrompts.KeyPromptMap:
		if keys != "":
			keys += ","
		keys += "{0}:{1}".format([InputPrompts.KeyPromptNames[k], k])
	properties.append({
		name = "key",
		type = TYPE_INT,
		hint = PROPERTY_HINT_ENUM,
		hint_string = keys
	})
	return properties
