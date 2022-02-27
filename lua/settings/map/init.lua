---Creates the mapping
---@param mode string|string[]
---@param lhs string
---@param default { cmd : string|function, opts : table }
-- ---@return Keymap
local function create_map(mode, lhs, default)
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

local opts = { noremap=true, silent=true }
---key is also called `kind`, which is the kind of mapping
---each `kind` has a set of `ops` which are the operations available on that kind
local maps = {
    buffer = {
        list = create_map("n", "<leader>b", {cmd = ":buffers<CR>", opts = opts}),
        close = create_map("n", "<C-q>")
    },
    lsp_buf = {
        declaration = create_map("n", "gD", { cmd = vim.lsp.buf.declaration, opts = opts}),
        definition = create_map("n", "gd", { cmd = vim.lsp.buf.definition, opts = opts}),
        hover = create_map("n", "K", { cmd = vim.lsp.buf.hover, opts = opts}),
        implementation = create_map("n", "gi", { cmd = vim.lsp.buf.implementation, opts = opts }),
        signature_help = create_map("n", "<C-k>", { cmd = vim.lsp.buf.signature_help, opts = opts}),
        type_definition = create_map("n", "<leader>D", { cmd = vim.lsp.buf.type_definition, opts = opts}),
        rename = create_map("n", "<leader>rn", { cmd = vim.lsp.buf.rename, opts = opts }),
        code_action = create_map("n", "<leader>ca", { cmd = vim.lsp.buf.code_action, opts = opts }),
    },
    lsp_diagnostic = {
        open_float = create_map("n", "<leader>d", { cmd = vim.diagnostic.open_float, opts = opts }),
        goto_prev = create_map("n", "[d", { cmd = vim.lsp.diagnostic.goto_prev, opts = opts }),
        goto_next = create_map("n", "]d", { cmd = vim.lsp.diagnostic.goto_next, opts = opts }),
        set_loclist = create_map("n", "<leader>q", { cmd = vim.lsp.diagnostic.set_loclist, opts = opts } )
    },
    quickfix = {
        close = create_map("n", "<leader>cq"),
        open = create_map("n", "<leader>co"),
    }

}

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
        print("start")
        force = force or false
        all = all or false

        local modes = {"n", "v", "i"}

        for _, mode in pairs(modes) do
            local keymaps = vim.api.nvim_get_keymap(mode)
            vim.tbl_map(function (map)
                -- if lhs2maps[map.lhs] == nil or next(lhs2maps[map.lhs]) == nil then
                --     return
                -- end

                print("Setting " .. map.lhs)
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
