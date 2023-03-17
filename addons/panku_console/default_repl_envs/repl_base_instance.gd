extends Node

const _HELP_help := "List all available registered objects."
var help:String:
	get:
		var result = ["Registered objects:\n"]
		var colors = ["#7c3f58", "#eb6b6f", "#f9a875", "#fff6d3"]
		var i = 0
		for k in get_parent()._envs:
			var c = colors[i%4]
			i = i + 1
			result.push_back("[b][color=%s]%s[/color][/b]  "%[c, k])
		result.push_back("\n")
		result.push_back("You can type [b]helpe(object)[/b] to get more information.")
		return "".join(PackedStringArray(result))

const _HELP_helpe := "Provide detailed information about one specific registered object."
func helpe(obj:Object) -> String:
	if !obj:
		return "Invalid!"
	if !obj.get_script():
		return "It has no attached script!"
	return PankuConsole.Utils.generate_help_text_from_script(obj.get_script())
