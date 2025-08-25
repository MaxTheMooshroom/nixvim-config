{

  config.plugins.lsp.enable = true;
  config.plugins.lsp.servers.nil_ls.enable = true;
  # config.plugins.lsp.servers.nixd.enable = true;

  config.plugins.lspsaga = {
    enable = true;

    symbolInWinbar = {
      enable = false;
    };

    lightbulb = {
      sign = false;
    };

    ui.codeAction = " "; # 󰌵"; #󰌶󱠂";

    scrollPreview = {
      scrollDown = "<c-j>";
      scrollUp = "<c-k>";
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
