




                                                   
                                                   

                                                                                     
                                                                                     
--$$\    $$\ $$\   $$\ $$\   $$\  $$$$$$$\  $$$$$$\      $$\   $$\ $$\   $$\ $$$$$$$$\ 
--\$$\  $$  |$$ |  $$ |$$ |  $$ |$$  _____|$$  __$$\     \$$\ $$  |$$ |  $$ |\____$$  |
-- \$$\$$  / $$ |  $$ |$$ |  $$ |$$ /      $$$$$$$$ |     \$$$$  / $$ |  $$ |  $$$$ _/ 
--  \$$$  /  $$ |  $$ |$$ |  $$ |$$ |      $$   ____|     $$  $$<  $$ |  $$ | $$  _/   
--   \$  /   \$$$$$$$ |\$$$$$$$ |\$$$$$$$\ \$$$$$$$\ $$\ $$  /\$$\ \$$$$$$$ |$$$$$$$$\ 
--    \_/     \____$$ | \____$$ | \_______| \_______|\__|\__/  \__| \____$$ |\________|
--           $$\   $$ |$$\   $$ |                                  $$\   $$ |          
--           \$$$$$$  |\$$$$$$  |                                  \$$$$$$  |          
--            \______/  \______/                                    \______/           


--MIT License

--Copyright (c) 2025 h1n0l, vyyce.xyz

--Permission is hereby granted, free of charge, to any person obtaining a copy
--of this software and associated documentation files (the "Software"), to deal
--in the Software without restriction, including without limitation the rights
--to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--copies of the Software, and to permit persons to whom the Software is
--furnished to do so, subject to the following conditions:

--	The above copyright notice and this permission notice shall be included in all
--	copies or substantial portions of the Software.

--		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--	SOFTWARE.



--example usage: 
	
--local httpClient = require(game:GetService("ServerStorage").HTTPModule)
--local client = httpClient.new("https://jsonplaceholder.typicode.com", {authorization = "Bearer token"})
--local response = client:request("GET", "/todos/1")

--if response.success then
--	print("Data: ", response.body)
--else
--	warn("Request failed:", response.error)
--end











local HttpService = game:GetService("HttpService")

local http = {}
http.__index = http

function http.new(baseUrl : string, options : table)
	local self = setmetatable({}, http)
	self.baseUrl = baseUrl
	self.options = options or {}
	print("constructor: " .. self.baseUrl .. " " .. (HttpService:JSONEncode(self.options) or "{}"))
	return self
end

function http:_build(endpoint : string)
	if not endpoint then  
		warn("No endpoint provided") 
		return nil 
	end
	return self.baseUrl .. endpoint
end

function http:_buildHeaders(customHeaders : table)
	local headers = {
		["Content-Type"] = self.options.content_type or "application/json"
	}
	if self.options.authorization then
		headers["Authorization"] = self.options.authorization
	end
	if customHeaders then
		for k,v in pairs(customHeaders) do
			headers[k] = v
		end
	end
	print("built headers: " .. HttpService:JSONEncode(headers))
	return headers
end

function http:request(method : string, endpoint : string, data : table, customHeaders : table)
	local url = self:_build(endpoint)
	if not url then return {success = false, error = "Invalid URL"} end

	local body = data and HttpService:JSONEncode(data) or nil
	local headers = self:_buildHeaders(customHeaders)

	local options = {
		Url = url,
		Method = method:upper(),
		Headers = headers,
		Body = body,
	}

	local success, response = pcall(function()
		return HttpService:RequestAsync(options)
	end)

	if success then
		if response.Success then
			local responseBody = nil
			if response.Body and response.Body ~= "" then
				responseBody = HttpService:JSONDecode(response.Body)
			end
			return { success = true, statusCode = response.StatusCode, body = responseBody }
		else
			return { success = false, statusCode = response.StatusCode, error = response.StatusMessage }
		end
	else
		return { success = false, error = response }
	end
end

return http
