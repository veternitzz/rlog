local serde = require("@lune/serde")

local rlog = require("./lib")

export type JsonLog = { JsonLogObject }

export type JsonLogObject = {
    level: rlog.LevelKind,
    timestamp: string
}

local function serialize(level: rlog.LevelKind, timestamp: string): JsonLog
    
end
