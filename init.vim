"execute 'source $HOME/.config/nvim/config/plugins.vim'
"execute 'source $HOME/.config/nvim/config/general.vim'
"execute 'source $HOME/.config/nvim/config/keys.vim'
"execute 'source $HOME/.config/nvim/config/commands.vim'
source $HOME/.config/nvim/config/plugins.vim
source $HOME/.config/nvim/config/general.vim
source $HOME/.config/nvim/config/keys.vim
source $HOME/.config/nvim/config/commands.vim

lua <<EOF
    require('init')
EOF
