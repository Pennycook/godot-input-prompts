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
var textures: Dictionary[StringName, Texture2D] = {}


## Return the [Texture2D] associated with the specified [InputEvent], or null.
func get_texture(event: InputEvent) -> Texture2D:
	if not event is InputEventKey:
		return null
	var key_event := event as InputEventKey
	var scancode := key_event.keycode
	if scancode == 0:
		scancode = key_event.physical_keycode
	return textures[OS.get_keycode_string(scancode)]


func _get(property: StringName):
	return textures.get(property)


func _set(property: StringName, value) -> bool:
	if OS.find_keycode_from_string(property) not in KeyPrompt._KEYS:
		return false
	if value == null:
		textures.erase(property)
	else:
		textures[property] = value
	return true


func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	for k: int in KeyPrompt._KEYS:
		properties.append(
			{
				name = OS.get_keycode_string(k),
				type = TYPE_OBJECT,
				hint = PROPERTY_HINT_RESOURCE_TYPE,
				hint_string = "Texture2D"
			}
		)
	return properties
