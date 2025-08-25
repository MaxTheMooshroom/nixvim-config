{
  config.plugins.femaco.enable = true;

  config.keymaps = [
    { key = "<leader>ge"; action.__raw = "function() require('femaco.edit').edit_code_block() end"; }
  ];
}
