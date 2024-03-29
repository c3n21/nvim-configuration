local on_attach = require('plugins.lsp.on_attach')

return {
    on_attach = on_attach,
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = { 'jdtls' },
    --[[ cmd = { ]]
    --[[]]
    --[[     -- 💀 ]]
    --[[     'java', -- or '/path/to/java11_or_newer/bin/java' ]]
    --[[     -- depends on if `java` is in your $PATH env variable and if it points to the right version. ]]
    --[[]]
    --[[     '-Declipse.application=org.eclipse.jdt.ls.core.id1', ]]
    --[[     '-Dosgi.bundles.defaultStartLevel=4', ]]
    --[[     '-Declipse.product=org.eclipse.jdt.ls.core.product', ]]
    --[[     '-Dlog.protocol=true', ]]
    --[[     '-Dlog.level=ALL', ]]
    --[[     '-Xms1g', ]]
    --[[     '--add-modules=ALL-SYSTEM', ]]
    --[[     '--add-opens', ]]
    --[[     'java.base/java.util=ALL-UNNAMED', ]]
    --[[     '--add-opens', ]]
    --[[     'java.base/java.lang=ALL-UNNAMED', ]]
    --[[]]
    --[[     -- 💀 ]]
    --[[     '-jar', ]]
    --[[     vim.fn.glob('/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar', false, false), ]]
    --[[     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^ ]]
    --[[     -- Must point to the                                                     Change this to ]]
    --[[     -- eclipse.jdt.ls installation                                           the actual version ]]
    --[[]]
    --[[     -- 💀 ]]
    --[[     '-configuration', ]]
    --[[     _configuration, ]]
    --[[     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^ ]]
    --[[     -- Must point to the                      Change to one of `linux`, `win` or `mac` ]]
    --[[     -- eclipse.jdt.ls installation            Depending on your system. ]]
    --[[]]
    --[[     -- 💀 ]]
    --[[     -- See `data directory configuration` section in the README ]]
    --[[     '-data', ]]
    --[[     _data, ]]
    --[[ }, ]]

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            format = {
                settings = {
                    url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
                },
            },
        },
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {},
    },
}
