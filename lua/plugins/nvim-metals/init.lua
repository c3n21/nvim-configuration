return {
    'scalameta/nvim-metals',
    enabled = false,
    config = function()
        local metals_config = require('metals').bare_config()
        local completion = require('settings').completion

        metals_config = completion(metals_config)

        metals_config.settings = {
            showImplicitArguments = true,
            excludePackages = {
                'akka.actor.typed.javadsl',
                'com.github.swagger.akka.javadsl',
            },
        }

        local cmd = vim.cmd
        cmd([[
augroup lsp
au!
au FileType scala,sbt lua require("metals").initialize_or_attach({})
augroup end]])
    end,
}
