local fmt = string.format

local utils = {}

---Same as C language's printf
---@param s string
---@vararg any
utils.printf = function(s, ...)
    local args = {...}
    print(fmt(s, unpack(args)))
end

---Creates the mapping
---@param mode string|string[]
---@param lhs string
---@param default { cmd : string|function, opts : table }
-- ---@return Keymap
utils.create_map = function(mode, lhs, default)
    if type(mode) == "string" then
        mode = {mode}
    end

    return
    -- ---@class Keymap
    {
        is_set = false,
        ---@type string[]
        mode = mode,
        ---@type string
        lhs = lhs,

        ---Sets the keymap only once, unless force = true
        ---@param self any
        ---@param cmd string|function
        ---@param opts table
        ---@param force boolean?
        set = function (self, cmd, opts, force)
            force = force or (not self.is_set)

            if not force then
                return
            end

            vim.keymap.set(mode, lhs, cmd, opts)
            self.is_set = true
        end,

        ---Sets the default value of the keymap if is_set == false.
        --If `force` is true, then it will set it anyway.
        --If no `default` is set but set_default() is called, then it will do nothing
        ---@param force boolean?
        set_default = function (self, force)
            local f = string.format
            force = force or (not self.is_set)

            if default == nil or next(default) == nil then
                vim.notify(f("No default keymap is set for '%s'", lhs), vim.log.levels.WARN)
                return
            end

            if not force  then
                return
            end

            vim.keymap.set(mode, lhs, default.cmd, default.opts)
            self.is_set = true
        end,

        ---Deletes the keymap
        ---@param self any
        del = function (self)
            self.is_set = false
            vim.keymap.del(self.mode, self.lhs)
        end
    }
end

return utils
