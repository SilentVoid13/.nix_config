{
  myconf,
  ...
}: {
  home.sessionPath = ["$HOME/H/p/sov/target/debug"];

  programs.nixvim = {
    extraFiles = {"lua/my_sov.lua" = builtins.readFile ./my_sov.lua;};

    keymaps = [
      {
        mode = "n";
        key = "<leader>rd";
        action = "<cmd>SovDaily<CR>";
      }
      {
        mode = "n";
        key = "<leader>re";
        action = "function() require('my_sov').new_note() end";
        lua = true;
      }
      {
        mode = "n";
        key = "<leader>rd";
        action = "<cmd>SovDaily<CR>";
      }
      {
        mode = "n";
        key = "<leader>ro";
        action = "<cmd>SovFindFiles<CR>";
      }
      {
        mode = "n";
        key = "<leader>rs";
        action = "<cmd>SovFuzzySearch<CR>";
      }
    ];

    extraConfigLua = ''
      require("sov").setup({
        root_dir = '${myconf.knowledge_base}'
      })
    '';
  };
}
