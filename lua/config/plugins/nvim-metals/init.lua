local metals_config = require("metals").bare_config()
local system_config = require("config")
local current = system_config.completion.current
system_config = system_config.completion[current](metals_config)

metals_config.settings = {
    showImplicitArguments = true,
    excludePackages = {
        "akka.actor.typed.javadsl",
        "com.github.swagger.akka.javadsl"
    }
}

local cmd = vim.cmd
cmd [[
augroup lsp
au!
au FileType scala,sbt lua require("metals").initialize_or_attach({})
augroup end]]
