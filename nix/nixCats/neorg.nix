{ pkgs, ... }:
{
  # they contain a settings set defined above
  # see :help nixCats.flake.outputs.settings
  settings = {
    suffix-path = true;
    suffix-LD = true;
    wrapRc = true;
    # neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
    neovim-unwrapped = pkgs.neovim-unwrapped;
    autoconfigure = "suffix";
  };
  # and a set of categories that you want
  # (and other information to pass to lua)
  categories = {
    ai = false;
    astro = false;
    backend = false;
    clang = false;
    dap = false;
    dotnet = false;
    fzf-lua = true;
    general = true;
    # gitPlugins = true;
    gitPlugins = {
      client.fugit2 = true;
      gutter.gitsigns = true;
      misc = true;
    };
    filemanager = {
      oil = true;
    };
    go = false;
    java = false;
    json = false;
    nix = false;
    nlua = false;
    node = false;
    note = true;
    tailwindcss = false;
    xml = false;
  };
}
