# =============================================================================
# ConsoleAdapter
# =============================================================================
# This script provides an adapter layer between the game and the Godot Console
# plugin. It allows for easier integration and customization of the console
# functionality within the game.
#
# @author winkensjw
# @version 1.0
# =============================================================================
class_name ConsoleAdapter
extends Node

## Whether debug mode is enabled.
## When debug mode is enabled, debug messages will be printed to the console.
static var _debug_enabled: bool = false

## Whether to print messages to Godot's output.
## When enabled, messages will be printed to Godot's output in addition to the console.
static var _print_to_godot: bool = true


## Returns whether debug mode is enabled.
static func get_debug_enabled() -> bool:
	return _debug_enabled


## Sets whether debug mode is enabled.
## @param debug_enabled Whether to enable debug mode.
static func set_debug_enabled(debug_enabled: bool) -> void:
	_debug_enabled = debug_enabled


## Returns whether to print messages to Godot's output.
static func get_print_to_godot() -> bool:
	return _print_to_godot


## Sets whether to print messages to Godot's output.
## @param print_to_godot Whether to print messages to Godot's output.
static func set_print_to_godot(print_to_godot: bool) -> void:
	_print_to_godot = print_to_godot


static func set_hotkey(key: Key) -> void:
	Console.hotkey = key


## Initializes the console adapter.
## This method should be called once when the game starts.
static func init() -> void:
	# initialize console here via Console.property
	# Allow mouse clicks through the main control node
	Console.control.mouse_filter = Control.MOUSE_FILTER_IGNORE


## Adds a command to the console.
## @param command_name The name of the command to add.
## @param function The function to call when the command is executed.
## @param arguments An array of argument names for the command.
## @param required The number of required arguments for the command.
## @param description A description of the command.
static func add_command(command_name: String, function: Callable, arguments: Array = [], required: int = 0, description: String = "") -> void:
	Console.add_command(command_name, function, arguments, required, description)


## Adds a hidden command to the console.
## @param command_name The name of the command to add.
## @param function The function to call when the command is executed.
## @param arguments An array of argument names for the command.
## @param required The number of required arguments for the command.
static func add_hidden_command(command_name: String, function: Callable, arguments: Array = [], required: int = 0) -> void:
	Console.add_hidden_command(command_name, function, arguments, required)


## Removes a command from the console.
## @param command_name The name of the command to remove.
static func remove_command(command_name: String) -> void:
	Console.remove_command(command_name)


## Adds an autocomplete list to a command.
## @param command_name The name of the command to add the autocomplete list to.
## @param param_list An array of strings to use for autocomplete.
static func add_command_autocomplete_list(command_name: String, param_list: PackedStringArray) -> void:
	Console.add_command_autocomplete_list(command_name, param_list)


## Prints an error message to the console.
## @param text The text to print.
static func error(text: Variant) -> void:
	Console.print_error(text, get_print_to_godot())


## Prints an info message to the console.
## @param text The text to print.
static func info(text: Variant) -> void:
	Console.print_info(text, get_print_to_godot())


## Prints a warning message to the console.
## @param text The text to print.
static func warning(text: Variant) -> void:
	Console.print_warning(text, get_print_to_godot())


## Prints a debug message to the console.
## @param text The text to print.
static func debug(text: Variant) -> void:
	if not get_debug_enabled():
		return
	_print_debug(text, get_print_to_godot())


## Prints a debug message to the console.
## @param text The text to print.
## @param print_godot Whether to print the message to Godot's output.
static func _print_debug(text: Variant, print_godot: bool) -> void:
	if not text is String:
		text = str(text)
	Console.print_line("	   [color=light_green]   DEBUG:[/color] %s" % text, print_godot)
