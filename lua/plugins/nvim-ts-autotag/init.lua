local filetypes = {
    'html',
    'javascript',
    'typescript',
    'javascriptreact',
    'typescriptreact',
    'jsx',
    'tsx',
    'svelte',
    'vue',
    'tsx',
    'jsx',
    'rescript',
    'xml',
    'php',
    'markdown',
    'glimmer',
    'handlebars',
    'hbs',
    'phtml',
}

require('nvim-ts-autotag').setup({
    filetypes = filetypes,
})
