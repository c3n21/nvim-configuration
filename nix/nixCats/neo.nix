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
    ai = true;
    astro = true;
    backend = true;
    clang = true;
    dap = true;
    dotnet = true;
    fzf-lua = true;
    general = true;
    gitPlugins = true;
    go = true;
    java = true;
    json = true;
    nix = true;
    nlua = true;
    node = true;
    note = false;
    tailwindcss = true;
    xml = true;
  };
}
