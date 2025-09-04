local fs = require("@lune/fs")
local io = require("@lune/stdio")

local util = require("./util")

local logFn = util.logFn

-- constants for readibility
local RED = io.color("red")
local BLUE = io.color("blue")
local YELLOW = io.color("yellow")
local BOLD = io.style("bold")
local WHITE = io.color("white")

export type LevelKind = "INFO" | "DEBUG" | "ERROR" | "WARN"

export type RLogConfig = {
    filePath: string?,
    prettyOutput: boolean
}

export type RLogImpl = {
    __index: Log,

    new: (config: RLogConfig) -> Log,

    info: (self: Log, message: string) -> (),
    error: (self: Log, message: string) -> (),
    warn: (self: Log, message: string) -> (),
    debug: (self: Log, message: string) -> ()
}

export type Log = typeof(setmetatable(
    {} :: {
        filePath: string?,
        prettyOutput: string,

        info: (self: Log, message: string) -> (),
        error: (self: Log, message: string) -> (),
        warn: (self: Log, message: string) -> (),
        debug: (self: Log, message: string) -> ()
    }, {} :: RLogImpl))

local log = {}
log.__index = log

--[[
    Constructs a new log instance.

    @param config Configuration of the log.
]]
function log.new(config: RLogConfig): Log

    -- check optional params
    if not config["filePath"] or config["filePath"] == "" then config["filePath"] = nil end
    if not config["prettyOutput"] then config["prettyOutput"] = false end

    -- make sure the file exists, if not then make it
    if config["filePath"] then
        fs.writeFile(config["filePath"], "")
    end

    -- make class
    local self = setmetatable({}, log)
    self.filePath = config["filePath"]
    self.prettyOutput = config["prettyOutput"]

    return self :: Log
end

--[[
    Logs an info message. If ``prettyOutput`` is enabled, it will show as bold and blue.

    @param self
    @param message The string to log.
]]
function log.info(self: Log, message: string)
    logFn(self, "INFO", BLUE, BOLD, message)
end

--[[
    Logs an error message. If ``prettyOutput`` is enabled, it will show as bold and red.

    @param self
    @param message The string to log.
]]
function log.error(self: Log, message: string)
    logFn(self, "ERROR", RED, BOLD, message)
end

--[[
    Logs a warning message. If ``prettyOutput`` is enabled, it will show as bold and yellow.

    @param self
    @param message The string to log.
]]
function log.warn(self: Log, message: string)
    logFn(self, "WARN", YELLOW, BOLD, message)
end

--[[
    Logs a debug message. If ``prettyOutput`` is enabled, it will show as bold and white.

    @param self
    @param message The string to log.
]]
function log.debug(self: Log, message: string)
    logFn(self, "DEBUG", WHITE, BOLD, message)
end

return log :: RLogImpl