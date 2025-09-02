local fs = require("@lune/fs")
local datetime = require("@lune/datetime")
local io = require("@lune/stdio")

-- utility function for resetting stdio.style() and stdio.color() for readability
local function reset()
    return io.color("reset"), io.style("reset")
end

-- utility function which makes reading and scaling the log module much easier
local function logFn(self, level: string, color: io.Color, style: io.Style, message: string)
    local timestamp = datetime.now():toRfc3339()
    
    if self.prettyOutput then
        io.write(`{style}{color}{level}{reset()} - {message}\n`)
    else
        io.write(`{level} - {message}\n`)
    end

    if self.filePath then
        local contents = fs.readFile(self.filePath)

        fs.writeFile(self.filePath, `{contents}{timestamp} - {level} - {message}\n`)
    end
end

return {
    reset = reset,
    logFn = logFn
}