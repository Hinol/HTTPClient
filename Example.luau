local HttpClient = require(game:GetService("ServerStorage").HTTPModule)
local client = HttpClient.new("https://jsonplaceholder.typicode.com", {})


--POST


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


--GET

local response = client:request("GET", "/posts/1")

if response.success then
	print("Data: ", response.body)
else
	warn("Request failed:", response.error)
end
