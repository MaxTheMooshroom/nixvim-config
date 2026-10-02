{
  plugins =
    {
      nix.enable = true;
      lsp.servers.nixd =
        {
          enable = true;
          settings =
            {
              diagnostic.suppress =
                [
                  "sema-unused-def-lambda-witharg-formal"
                ];
            };
        };
    };
}
