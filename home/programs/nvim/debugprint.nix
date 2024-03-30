{...}: {
  programs.nixvim = {
    plugins.debugprint = {
      enable = true;
      displayCounter = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>pd";
        action = "function() return require('debugprint').debugprint() end";
        lua = true;
        options = {expr = true;};
      }
      {
        mode = "n";
        key = "<leader>pD";
        action = "function() return require('debugprint').debugprint({ above = true }) end";
        lua = true;
        options = {expr = true;};
      }
      {
        mode = "n";
        key = "<leader>pq";
        action = "function() return require('debugprint').debugprint({ variable = true }) end";
        lua = true;
        options = {expr = true;};
      }
      {
        mode = "n";
        key = "<leader>pQ";
        action = "function() return require('debugprint').debugprint({ above = true, variable = true }) end";
        lua = true;
        options = {expr = true;};
      }
      {
        mode = "n";
        key = "<leader>pc";
        action = "function(opts) require('debugprint').deleteprints(opts) end";
        lua = true;
        #options = { range = true; };
      }
    ];
  };
}
