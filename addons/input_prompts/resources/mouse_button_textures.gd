# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
class_name MouseButtonTextures
extends Resource
## Textures used by a [MouseButtonPrompt] or [ActionPrompt].
##
## Textures used by a [MouseButtonPrompt] or [ActionPrompt]. Stores a texture
## for each mouse button index.

## Texture for Left Mouse Button.
@export var button_1: Texture2D = null

## Texture for Right Mouse Button.
@export var button_2: Texture2D = null

## Texture for Middle Mouse Button.
@export var button_3: Texture2D = null

## Texture for Mouse Wheel Up.
@export var button_4: Texture2D = null

## Texture for Mouse Wheel Down.
@export var button_5: Texture2D = null

## Texture for Mouse Wheel Left.
@export var button_6: Texture2D = null

## Texture for Mouse Wheel Right.
@export var button_7: Texture2D = null

## Texture for Mouse Thumb Button 1.
@export var button_8: Texture2D = null

## Texture for Mouse Thumb Button 2.
@export var button_9: Texture2D = null


## Return the [Texture2D] associated with the specified [InputEvent], or null.
func get_texture(event: InputEvent) -> Texture2D:
	if not event is InputEventMouseButton:
		return null
	var mouse_event := event as InputEventMouseButton
	var button := mouse_event.button_index
	return get("button_" + str(button))
