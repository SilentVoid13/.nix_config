{...}: {
  programs.nixvim = {
    plugins.comment = {
      enable = true;
      settings = {
        mappings.basic = true;
        toggler = {
          line = "<leader>cll";
          block = "<leader>cbb";
        };
        opleader = {
          line = "<leader>cl";
          block = "<leader>cb";
        };
      };
    };
  };
}
