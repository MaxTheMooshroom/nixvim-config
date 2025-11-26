{
  config.plugins.lsp.enable = true;
  config.plugins.lsp.servers.nil_ls.enable = true;
  # config.plugins.lsp.servers.nixd.enable = true;
  config.plugins.lsp.servers.markdown_oxide.enable = true;

  config.plugins.lspsaga = {
    enable = true;

    settings = {
      implement.enable = false;
      symbol_in_winbar.enable = false;
      lightbulb.sign = false;

      ui.code_action = " "; # 󰌵"; #󰌶󱠂";

      scroll_preview = {
        scroll_down = "<c-j>";
        scroll_up = "<c-k>";
      };
    };
  };

  config.keymaps = [
    { key = "gh";         action = "<cmd>Lspsaga lsp_finder<CR>";           mode = [ "n" ]; }
    { key = "gr";         action = "<cmd>Lspsaga rename<CR>";               mode = [ "n" ]; }
    { key = "gp";         action = "<cmd>Lspsaga peek_definition<CR>";      mode = [ "n" ]; }
    { key = "gd";         action = "<cmd>Lspsaga goto_definition<CR>";      mode = [ "n" ]; }
    { key = "gt";         action = "<cmd>Lspsaga goto_type_definition<CR>"; mode = [ "n" ]; }
    { key = "<leader>ca"; action = "<cmd>Lspsaga code_action<CR>";                          }
    { key = "<m-d>";      action = "<cmd>Lspsaga term_toggle<CR>";                          }
    { key = "<m-d>";      action = "<cmd>Lspsaga term_toggle<CR>";          mode = [ "t" ]; }
  ];
}
