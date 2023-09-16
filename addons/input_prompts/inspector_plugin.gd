# Copyright (C) 2022-2023 John Pennycook
# SPDX-License-Identifier: MIT
@tool
extends EditorInspectorPlugin

func _can_handle(object):
	return object.has_method("_is_input_prompt")

func _parse_property(object, _type, name, _hint_type, _hint_string, _usage_flags, _wide):
	# Hide the texture property of TextureRect to ensure that user can only
	# modify it indirectly (e.g. via setting key, button, action or icon)
	return name == "texture"
