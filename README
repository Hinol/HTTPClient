
# vyyce HttpClient

This module implements a simple HTTP client in Luau using Object-Oriented Programming (OOP) principles. It allows sending HTTP requests (GET, POST, etc.) using Roblox’s HttpService.

Key features:
The constructor new(baseUrl, options) lets you set a base URL and optional settings such as authorization headers and content-type.

The _build method constructs the full URL by combining the base URL with the provided endpoint.

The _buildHeaders method generates request headers, including default headers, authorization, and any custom headers passed during the call.

The request method performs an asynchronous HTTP request using HttpService:RequestAsync, handling responses and errors, and returning a structured result.

The modular and clear class structure makes it easy to extend the client with additional features.
## Authors

- [@h1n0l](https://www.github.com/Hinol)


## Usage

GET

```lua
local HttpClient = require(game:GetService("ServerStorage").HTTPModule)
local client = HttpClient.new("https://jsonplaceholder.typicode.com", {})
local response = client:request("GET", "/todos/1")

if response.success then
	print("Data: ", response.body)
else
	warn("Request failed:", response.error)
end

```

POST

```lua
local HttpClient = require(game:GetService("ServerStorage").HTTPModule)
local client = HttpClient.new("https://jsonplaceholder.typicode.com", {})
local data = {
	title = "foo",
	body = "bar",
	userId = 1
}

local response = client:request("POST", "/posts", data)

if response.success then
	print("Data: ", response.body)
else
	warn("Request failed:", response.error)
end

```
