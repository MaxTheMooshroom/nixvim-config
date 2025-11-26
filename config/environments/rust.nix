{ config, ... }: {
  config.plugins = {
    dap-lldb.enable = true;
    neotest.adapters.rust.enable = config.plugins.neotest.enable;
  };
}
