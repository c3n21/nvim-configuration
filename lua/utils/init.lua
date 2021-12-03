local fmt = string.format

local util = {}

---Same as C language's printf
---@param s string
---@vararg any
local function printf(s, ...)
    local args = {...}
    print(fmt(s, unpack(args)))
end

util.printf = printf

return util
