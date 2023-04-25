
# Links:
 * https://docs.godotengine.org/en/stable/tutorials/scripting/resources.html
 * https://docs.godotengine.org/en/stable/contributing/development/file_formats/tscn.html
 * 

# Types:
 * TSCN (text scene)
 * ESCN (exported scene) compiled to binary
 * tres tileset-resource
 * .res

# convert:
* .tres > .res
* .tres > .res

# Notes:
 * class resource array does not work when using the class_name as it global when save and load error
  * ResourceSaver.FLAG_BUNDLE_RESOURCES error on this as save class_name