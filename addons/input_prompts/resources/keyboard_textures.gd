# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
class_name KeyboardTextures
extends Resource
## Textures used by a [KeyPrompt] or [ActionPrompt].
##
## Textures used by a [KeyPrompt] or [ActionPrompt]. Stores a texture for each
## keyboard scancode.

## A mapping from keyboard strings (as returned by
## [method OS.get_keycode_string]) to textures.
var textures: Dictionary = {}


func _init():
	for k in KeyPrompt._KEYS:
		textures[OS.get_keycode_string(k)] = null


## Return the [Texture2D] associated with the specified [InputEvent], or null.
func get_texture(event: InputEvent) -> Texture2D:
	if not event is InputEventKey:
		return null
	var key_event := event as InputEventKey
	var scancode := key_event.keycode
	if scancode == 0:
		scancode = key_event.physical_keycode
	return textures[OS.get_keycode_string(scancode)]


func _get(property):
	if property in textures.keys():
		return textures[property]
	return null


func _set(property, value):
	if property in textures.keys():
		textures[property] = value
		return true
	return false


func _get_property_list():
	var properties = []
	for k in KeyPrompt._KEYS:
		properties.append(
			{
				name = OS.get_keycode_string(k),
				type = TYPE_OBJECT,
				hint = PROPERTY_HINT_RESOURCE_TYPE,
				hint_string = "Texture2D"
			}
		)
	return properties
