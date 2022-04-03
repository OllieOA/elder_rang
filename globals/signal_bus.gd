extends Node

signal game_lost

signal alert_raised(object)
#warning-ignore-all:variable_conflicts_function - 2022-04-03 - velopman
signal swipe_complete(object)

signal titlescreen_game_started
signal title_fade_complete

signal nan_index_update(value)
signal nan_name_updated

# UI Signals
signal settings_button_pressed

signal tutorial_button_pressed
signal tutorial_close_menu_pressed

signal credits_button_pressed
signal credits_close_menu_pressed

signal options_button_pressed
signal options_close_menu_pressed

