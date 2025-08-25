{
  config.plugins.bufdelete.enable = true;

  config.keymaps = [
    # Close tab
    { mode = [ "n" ]; key = "<m-x>";   action.__raw = "function() require('bufdelete').bufdelete(0) end";   }
  ];
}
