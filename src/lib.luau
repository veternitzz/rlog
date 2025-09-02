local fs = require("@lune/fs")
local io = require("@lune/stdio")

local util = require("@self/util")

local logFn = util.logFn

-- constants for readibility
local RED = io.color("red")
local BLUE = io.color("blue")
local YELLOW = io.color("yellow")
local BOLD = io.style("bold")
local WHITE = io.color("white")

export type RLogImpl = {
    __index: Log,

    info: (self: Log, message: string) -> (),
    error: (self: Log, message: string) -> (),
    warn: (self: Log, message: string) -> (),
    debug: (self: Log, message: string) -> ()
}

export type Log = typeof(setmetatable(
    {} :: {
        filePath: string?,
        prettyOutput: string
    }, {} :: RLogImpl))

local log = {}
log.__index = log

--[[
    Constructs a new log instance.

    @param filePath Optional string which is a path to log to.
    @param prettyOutput Boolean which determines whether or not to make the console output pretty.
]]
function log.new(filePath: string?, prettyOutput: boolean?): Log
    -- check optional params
    if not filePath or filePath == "" then filePath = nil end
    if not prettyOutput then prettyOutput = false end

    -- make sure the file exists, if not then make it
    if filePath then
        fs.writeFile(filePath, "")
    end

    -- make class
    local self = setmetatable({}, log)
    self.filePath = filePath
    self.prettyOutput = prettyOutput

    return self :: Log
end

--[[
    Logs an info message. If ``prettyOutput`` is enabled, it will show as bold and blue.

    @param self
    @param message The string to log.
]]
function log.info(self, message: string)
    logFn(self, "INFO", BLUE, BOLD, message)
end

--[[
    Logs an error message. If ``prettyOutput`` is enabled, it will show as bold and red.

    @param self
    @message The string to log.
]]
function log.error(self, message: string)
    logFn(self, "ERROR", RED, BOLD, message)
end

--[[
    Logs a warning message. If ``prettyOutput`` is enabled, it will show as bold and yellow.

    @param self
    @message The string to log.
]]
function log.warn(self, message: string)
    logFn(self, "WARN", YELLOW, BOLD, message)
end

--[[
    Logs a debug message. If ``prettyOutput`` is enabled, it will show as bold and white.

    @param self
    @message The string to log.
]]
function log.debug(self, message: string)
    logFn(self, "DEBUG", WHITE, BOLD, message)
end

return log :: RLogImpl