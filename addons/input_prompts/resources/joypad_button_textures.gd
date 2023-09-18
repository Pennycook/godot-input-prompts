# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
class_name JoypadButtonTextures
extends Resource
## Textures used by a [JoypadButtonPrompt] or [ActionPrompt].
##
## Textures used by a [JoypadButtonPrompt] or [ActionPrompt]. Stores a texture
## for each joypad button index.

## Texture for Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)
@export var button_0: Texture2D = null

## Texture for Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)
@export var button_1: Texture2D = null

## Texture for Joypad Button 2 (Left Action, Sony Square, Xbox X, Nintendo Y)
@export var button_2: Texture2D = null

## Texture for Joypad Button 3 (Top Action, Sony Triangle, Xbox Y, Nintendo X)
@export var button_3: Texture2D = null

## Texture for Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)
@export var button_4: Texture2D = null

## Texture for Joypad Button 5 (Guide, Sony PS, Xbox Home)
@export var button_5: Texture2D = null

## Texture for Joypad Button 6 (Start, Nintendo +)
@export var button_6: Texture2D = null

## Texture for Joypad Button 7 (Left Stick, Sony L3, Xbox L/LS)
@export var button_7: Texture2D = null

## Texture for Joypad Button 8 (Right Stick, Sony R3, Xbox R/RS)
@export var button_8: Texture2D = null

## Texture for Joypad Button 8 (Left Shoulder, Sony L1, Xbox LB)
@export var button_9: Texture2D = null

## Texture for Joypad Button 9 (Right Shoulder, Sony R1, Xbox RB)
@export var button_10: Texture2D = null

## Texture for Joypad Button 11 (D-pad Up)
@export var button_11: Texture2D = null

## Texture for Joypad Button 12 (D-pad Down)
@export var button_12: Texture2D = null

## Texture for Joypad Button 13 (D-pad Left)
@export var button_13: Texture2D = null

## Texture for Joypad Button 14 (D-pad Right)
@export var button_14: Texture2D = null

## Texture for Joypad Button 15 (Xbox Share, PS5 Microphone, Nintendo Capture)
@export var button_15: Texture2D = null

## Texture for Joypad Button 16 (Xbox Paddle 1)
@export var button_16: Texture2D = null

## Texture for Joypad Button 17 (Xbox Paddle 2)
@export var button_17: Texture2D = null

## Texture for Joypad Button 18 (Xbox Paddle 3)
@export var button_18: Texture2D = null

## Texture for Joypad Button 10 (Xbox Paddle 4)
@export var button_19: Texture2D = null

## Texture for Joypad Button 20 (Xbox Paddle 2)
@export var button_20: Texture2D = null


## Return the [Texture2D] associated with the specified [InputEvent], or null.
func get_texture(event: InputEvent) -> Texture2D:
	if not event is InputEventJoypadButton:
		return null
	var joypad_event := event as InputEventJoypadButton
	var button := joypad_event.button_index
	return get("button_" + str(button))
