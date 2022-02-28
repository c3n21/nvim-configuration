local maps = require('config').mappings
local lhs2maps = {}
for _, ops in pairs(maps) do
    for _, map in pairs(ops) do
        lhs2maps[map.lhs] = map
    end
end

return {
    ---Sets the default mapping for each kind
    ---@param force boolean @ if true it will set the keymap even if it's already set.
    ---@param all boolean @ if true it will set the default keymap on every keymap, if it's not already set. Useful if used with `force` to forcefully set all the keymaps
    set_defaults = function (force, all)
        force = force or false
        all = all or false

        local modes = {"n", "v", "i"}

        for _, mode in pairs(modes) do
            local keymaps = vim.api.nvim_get_keymap(mode)
            vim.tbl_map(function (map)
                -- if lhs2maps[map.lhs] == nil or next(lhs2maps[map.lhs]) == nil then
                --     return
                -- end

                map:set_default(force)
            end, lhs2maps)
        end
    end,

    ---Gets a map-like object of operations and keymap available for the given kind
    ---@param kind string
    get_by_kind = function (kind)
        return maps[kind]
    end,

    ---Gets the keymap associated to the given lhs
    ---@param lhs string
    get_by_lhs = function (lhs)
        return lhs2maps[lhs]
    end
}
