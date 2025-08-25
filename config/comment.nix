{
  config.plugins.ts-context-commentstring.enable = true;
  config.plugins.ts-comments.enable = true; # Treesitter comment extensions

  config.plugins.comment = {
    enable = true;
    settings.pre_hook = /* lua */ ''
      require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    '';
  };

  # Neovim seems to register <c-/> as <c-_>
  config.keymaps = [
    { mode = [ "n" ]; key = "<c-_>"; action = "<Plug>(comment_toggle_linewise_current)"; }
    { mode = [ "v" ]; key = "<c-_>"; action = "<Plug>(comment_toggle_linewise_visual)";  }
    { mode = [ "n" ]; key = "<c-/>"; action = "<Plug>(comment_toggle_linewise_current)"; }
    { mode = [ "v" ]; key = "<c-/>"; action = "<Plug>(comment_toggle_linewise_visual)";  }
  ];
}
