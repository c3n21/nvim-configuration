local fmt = string.format

local utils = {}

---Same as C language's printf
---@param s string
---@vararg any
utils.printf = function(s, ...)
    local args = { ... }
    print(fmt(s, unpack(args)))
end

return utils
