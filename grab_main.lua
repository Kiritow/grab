-- Grab : Official OpenComputerScripts Installer
-- Created By Kiritow

local computer=require('computer')
local component=require('component')
local shell=require('shell')
local filesystem=require('filesystem')
local serialization=require('serialization')
local event=require('event')
local term=require('term')

local grab_version="Grab v2.99.1-alpha"

GRAB_INFO = {}

local liblog = {} -- #include grab_log.lua liblog
GRAB_INFO.liblog = liblog

local meta={} -- #include grab_meta.lua meta
GRAB_INFO.home = meta.detect()
print("grab home set to " .. GRAB_INFO.home)

local help={} -- #include grab_help.lua help

local function cleanUp()
    GRAB_INFO=nil
end

local args,options=shell.parse(...)
local valid_options = {
    version=true,
    help=true
}

for k,v in pairs(options) do
    if not valid_options[k] then
        if string.len(k)>1 then
            print("Unknown option: --" .. k)
        else
            print("Unknown option: -" .. k)
        end
        cleanUp()
        return
    elseif type(valid_options[k]) == "string" then
        if type(v) ~= valid_options[k] then
            print("Invalid option type: --" .. k .. ": " .. valid_options[k] .. " expected, got " .. type(v))
            cleanUp()
            return
        end
    end
end

local valid_commands = {
    update =  function()
        meta.update(options)
    end,
    clean = function()
        meta.clean()
    end,
    install = function()

    end,
    remove = function()

    end,
    autoremove = function()

    end,
    add = function()

    end,
    list = function()

    end,
    search = function()

    end
}

if args[1] then
    if valid_commands[args[1]] then
        if options['help'] then
            print(help.topic(args[1]))
        end
        valid_commands[args[1]]()
    else
        print(string.format("unknown command: %s", args[1]))
    end
else
    print("grab: try 'grab --help' for more information.")
end

cleanUp()
