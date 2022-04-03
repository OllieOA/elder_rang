extends Node

signal game_lost

signal alert_raised(object)
#warning-ignore-all:variable_conflicts_function - 2022-04-03 - velopman
signal swipe_complete(object)

signal titlescreen_game_started
signal title_fade_complete

# Nan signals
signal nan_index_update(value)
signal nan_name_updated
signal nan_answered_phone
signal dialled_nan
#warnings-disable - 2022-04-03 - velopman

# Dialogue signals
signal single_dialogue_finished(type, expected_response)
signal question_asked(expected_response)
signal response_provided(response_correct)
signal response_correct
signal response_incorrect

# UI Signals
signal settings_button_pressed
signal settings_close_menu_pressed

signal tutorial_button_pressed
signal tutorial_close_menu_pressed

signal credits_button_pressed
signal credits_close_menu_pressed

signal options_button_pressed
signal options_close_menu_pressed

