{
  config.plugins.render-markdown = {
    enable = true;

    settings = {
      sign.enabled = false;

      heading = {
        # 󰉲 󰉴 󰉱 󰉳
        icons = [ " 󰉫 " " 󰉬 " " 󰉭 " " 󰉮 " " 󰉯 " " 󰉰 " ];
        position = "inline";
        # position = "right";
        # left_pad = 1;
        # left_margin = 1;
        # border = [ true false false false true true true ];
        # render_modes = true;
      };

      checkbox = {
        right_pad = 0;
        # checked.icon = "";
        # unchecked.icon = "";

        custom = {
          todo = {
            raw = "[-]";
            rendered = "󰥔";
            highlight = "RenderMarkdownTodo";
            # scope_highlight = nil;
          };

          partial = {
            raw = "[o]";
            rendered = "▣ ";
            highlight = "RenderMarkdownTodo";
            # scope_highlight = nil;
          };

          radio = {
            raw = "( )";
            rendered = "○";
            highlight = "RenderMarkdownTodo";
            # scope_highlight = nil;
          };

          radio_filled = {
            raw = "(*)";
            rendered = "◉";
            highlight = "RenderMarkdownTodo";
            # scope_highlight = nil;
          };
        };
      };

      # bullet.icons = [ "●" "○" "◆" "◇" ];
      bullet.icons = [ "•" "◦" ];
      # ● ○ ◼ ◻ ◆ ◇
      # ● ○ ■ □ ◆ ◇
      # • ◦ ▪ ▫ ⬥ ⬦
      # ⸱
      # ⚬
      # ● ○ ◉
      # ■ ☐ ▢ ▣
      # ☑
      # ☒
      # 󰄱
      # 󰱒

      pipe_table = {
        preset = "round";
        alignment_indicator = "═";
        # |- -|
        # ~- -~
        # ╾ ╼ ╴╶ ─
        # alignment_indicator = "━";
        # alignment_indicator = "━";
        # alignment_indicator = "─";
        # alignment_indicator = "╌";
        # alignment_indicator = "┄";
        # alignment_indicator = "┈";
      };

      code = {
        # language_icon = true;
        # style = "language";
        border = "thin";

        # Used above code blocks to fill remaining space around language.
        language_border = "█";
        # Added to the left of language.
        language_left = "";
        # Added to the right of language.
        language_right = "";
        # Used above code blocks for thin border.
        above = "▄";
        # Used below code blocks for thin border.
        below = "▀";
      };
    };
  };
}
