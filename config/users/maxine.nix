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

      "<C-S-Up>"    = ":m .-2<CR>";
      "<C-S-Down>"  = ":m .+1<CR>";

      "<m-Up>"    = "<C-y>";
      "<m-Down>"  = "<C-e>";

      "<S-Up>"    = "Vk";
      "<S-Down>"  = "Vj";
      "<S-Left>"  = "v<Left>";
      "<S-Right>" = "v<Right>";
    }
  ) ++ (
    inMode "i" {
      "<C-S-Up>"    = "<C-o><C-S-Up>";
      "<C-S-Down>"  = "<C-o><C-S-Down>";

      "<m-Up>"    = "<C-o><C-y>";
      "<m-Down>"  = "<C-o><C-e>";

      "<C-c>"    = "<Esc>";
      "<S-Tab>"  = "<Esc><<i";
    }
  ) ++ (
    inMode "v" {
      "<C-S-Up>"    = ":m '<-2<CR>gv";
      "<C-S-Down>"  = ":m '>+1<CR>gv";

      "<m-Up>"    = "<C-o><C-y>";
      "<m-Down>"  = "<C-o><C-e>";
      "<C-c>"     = "<Esc>";
      "<S-Tab>"   = "<gv";
      "<Tab>"     = ">gv";
      "<S-Up>"    = "k";
      "<S-Down>"  = "j";
      "<S-Left>"  = "<Left>";
      "<S-Right>" = "<Right>";
    }
  );
}
