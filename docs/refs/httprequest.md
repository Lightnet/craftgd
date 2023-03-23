https://docs.godotengine.org/en/stable/classes/class_httprequest.html

```gd
func _ready():
    # Create an HTTP request node and connect its completion signal.
    var http_request = HTTPRequest.new()
    add_child(http_request)
    http_request.request_completed.connect(self._http_request_completed)

    # Perform a GET request. The URL below returns JSON as of writing.
    var error = http_request.request("https://httpbin.org/get")
    if error != OK:
        push_error("An error occurred in the HTTP request.")

    # Perform a POST request. The URL below returns JSON as of writing.
    # Note: Don't make simultaneous requests using a single HTTPRequest node.
    # The snippet below is provided for reference only.
    var body = JSON.new().stringify({"name": "Godette"})
    error = http_request.request("https://httpbin.org/post", [], true, HTTPClient.METHOD_POST, body)
    if error != OK:
        push_error("An error occurred in the HTTP request.")

# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
    var json = JSON.new()
    json.parse(body.get_string_from_utf8())
    var response = json.get_data()

    # Will print the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
    print(response.headers["User-Agent"])
```

```
func _ready():
    # Create an HTTP request node and connect its completion signal.
    var http_request = HTTPRequest.new()
    add_child(http_request)
    http_request.request_completed.connect(self._http_request_completed)

    # Perform the HTTP request. The URL below returns a PNG image as of writing.
    var error = http_request.request("https://via.placeholder.com/512")
    if error != OK:
        push_error("An error occurred in the HTTP request.")

# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
    if result != HTTPRequest.RESULT_SUCCESS:
        push_error("Image couldn't be downloaded. Try a different image.")

    var image = Image.new()
    var error = image.load_png_from_buffer(body)
    if error != OK:
        push_error("Couldn't load the image.")

    var texture = ImageTexture.create_from_image(image)

    # Display the image in a TextureRect node.
    var texture_rect = TextureRect.new()
    add_child(texture_rect)
    texture_rect.texture = texture
```