{ lib, ... }: {
  config.keymaps =
  let
    join = sep: list:
      builtins.foldl'
        (joined: new: joined + sep + new)
        (builtins.head list)
        (builtins.tail list);

    inMode = mode: keymap:
    let
      modes = [ "n" "i" "v" ];
    in
      assert lib.assertMsg
        (builtins.isString mode)
        "inMode parameter 'mode' must be a string! (was ${builtins.typeOf mode})";

      assert lib.assertMsg
        (builtins.elem mode modes)
        "inMode parameter 'mode' must be one of [ \"${join "\" \"" modes}\" ]. (was \"${mode}\")";

      assert lib.assertMsg
        ( builtins.all
          (value: builtins.isString value)
          (builtins.attrValues keymap)
        )
        "inMode parameter 'keymap' must only have values that are strings! (keymap for mode \"${mode}\")";

      builtins.attrValues
      ( builtins.mapAttrs
          (key: action: { inherit key action; mode = [ mode ]; })
          keymap
      );
  in
  # (inMode [] {}) ++ (
  # (inMode "y" {}) ++ (
  # (inMode "i" { "o" = 8; }) ++ (
  (
    inMode "n" {
      "<BS>"    = "i<BS>";
      "<S-Tab>" = "<<";
      "<Tab>"   = ">>";

      "<m-Up>"   = ":m .-2<CR>";
      "<m-Down>" = ":m .+1<CR>";

      "<S-Up>"    = "Vk";
      "<S-Down>"  = "Vj";
      "<S-Left>"  = "v<Left>";
      "<S-Right>" = "v<Right>";
    }
  ) ++ (
    inMode "i" {
      "<m-Up>"   = "<Esc>:m .-2<CR>i";
      "<m-Down>" = "<Esc>:m .+1<CR>i";
      "<C-c>"    = "<Esc>";
      "<S-Tab>"  = "<Esc><<i";
    }
  ) ++ (
    inMode "v" {
      "<C-c>"     = "<Esc>";
      "<m-Up>"    = ":m '<-2<CR>gv";
      "<m-Down>"  = ":m '>+1<CR>gv";
      "<S-Tab>"   = "<gv";
      "<Tab>"     = ">gv";
      "<S-Up>"    = "k";
      "<S-Down>"  = "j";
      "<S-Left>"  = "<Left>";
      "<S-Right>" = "<Right>";
    }
  );
}
