# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
class_name KeyboardTextures
extends Resource

var textures: Dictionary = {}


func _init():
	for k in InputPrompts.KEYS:
		textures[OS.get_keycode_string(k)] = null


func get_texture(scancode: int) -> Texture2D:
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
	for k in InputPrompts.KEYS:
		properties.append(
			{
				name = OS.get_keycode_string(k),
				type = TYPE_OBJECT,
				hint = PROPERTY_HINT_RESOURCE_TYPE,
				hint_string = "Texture2D"
			}
		)
	return properties
