#!/usr/bin/env lua

-- Load module json from github: https://github.com/craigmj/json4lua
local json = require("json") 

--[[
-
- Author    Leon <jiangxilee@gmail.com>
- License   Translate base on fanyi.baidu.com by curl.
- Copyright 2016-08-23 13:29:00
-
--]]

-- Send request by method GET
function get(url)
    local handle = io.popen("curl -q -k -s -m 1 " .. url)
    local result = handle:read("*a")
    handle:close()
    return result
end

-- Send request by method POST
function post(url, fields)
    local handle = io.popen("curl -q -k -s -m 1 " .. url .." -d '" .. fields .. "'")
    local result = handle:read("*a")
    handle:close()
    return result
end

-- Print with color base linux `echo`
function console(message, color, begin, over)
    color = color ~= nil and color or 30
    begin = begin or ''
    over = over or ''
    local command = 'echo "' .. begin .. '\\033[1;' .. color .. 'm' .. message .. '\\033[0;0m' .. over .. '"'
    os.execute(command)
end

-- The baidu api url
local baiduUrl = 'http://fanyi.baidu.com/v2transapi'

if (arg[1] == nil)
then
    console("Error: Give me the keyword to be translated.", 31, '\n', '\n')
    return
end

local from = arg[2] ~= nil and arg[2] or 'en'
local to = arg[2] ~= nil and arg[3] or 'zh'

-- The api need params
local fields = 'from=' .. from .. '&to=' .. to .. '&query=' .. arg[1] .. '&transtype=translang&simple_means_flag=3'

local response = post(baiduUrl, fields)
local text = json.decode(response)

if (text.error ~= nil)
then
    console("Error: " .. response, 31, '\n', '\n')
    return
end

-- os.execute('clear')
console('The keyword need translate', 30, '\n', '\n')
console(arg[1], 34, '\t')

if (text.dict_result.simple_means ~= nil and text.dict_result.simple_means.word_means ~= nil)
then
    console('The simple means', 30, '\n', '\n')
    for key, mean in pairs(text.dict_result.simple_means.word_means)
    do
        console(mean, 34, '\t')
    end
end

console('The complete means', 30, '\n', '\n')
console(text.trans_result.data[1].dst, 34, '\t', '\n')
