{
  config.plugins.lualine = {
    enable = true;

    settings.sections = {
      lualine_c = [
        {
          __unkeyed-1 = "filename";
          path = 1;
          newfile_status = true;
        }
      ];

      lualine_x = [
        "encoding"
        "fileformat"
        "filetype"
      ];
    };
  };
}
