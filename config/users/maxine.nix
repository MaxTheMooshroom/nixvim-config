{
  config.keymaps = [
    # move line up one with alt + up-arrow
    {  mode = [ "n" "i" ];  key = "<m-Up>";    action = ":m .-2<CR>";     }
    {  mode = [ "v" ];      key = "<m-Up>";    action = ":m '<-2<CR>gv";  }

    # move line down one with alt + down-arrow
    {  mode = [ "n" "i" ];  key = "<m-Down>";  action = ":m .+1<CR>";     }
    {  mode = [ "v" ];      key = "<m-Down>";  action = ":m '>+1<CR>gv";  }

    # unindent by one level
    {  mode = [ "n" "i" ];  key = "<S-Tab>";   action = "<<";             }
    {  mode = [ "v" ];      key = "<S-Tab>";   action = "<gv";            }

    # add indent level to selection
    {  mode = [ "v" ];      key = "<Tab>";     action = ">gv";            }
  ];
}
