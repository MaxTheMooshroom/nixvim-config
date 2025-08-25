{
  config = {
    plugins.notify = {
      enable = true;

      settings = {
        max_height = 10;
        max_width = 80;
        stages = "slide";
      };
    };

    highlight = {
      NotifyBackground.bg = "#333333";
    };

# E5108: Error executing lua: ...ckages/start/bufferline.nvim/lua/bufferline/commands.lua:25: Vim:E325: ATTENTION
# stack traceback:
# 	[C]: in function 'nvim_set_current_buf'
# 	...ckages/start/bufferline.nvim/lua/bufferline/commands.lua:25: in function 'open_element'
# 	...ckages/start/bufferline.nvim/lua/bufferline/commands.lua:216: in function 'cycle'
# 	/nix/store/8sjb0g3lf2adnjzysqksx5db8z6w6vqd-init.lua:685: in function </nix/store/8sjb0g3lf2adnjzysqksx5db8z6w6vqd-init.lua:684>

    extraConfigLuaPre = ''vim.notify = require('notify')'';
  };
}
