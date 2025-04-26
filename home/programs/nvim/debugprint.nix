{ ... }:
{
  programs.nixvim = {
    plugins.debugprint = {
      enable = true;
      settings = {
        display_counter = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>pd";
        action.__raw = "function() return require('debugprint').debugprint() end";
        options = {
          expr = true;
        };
      }
      {
        mode = "n";
        key = "<leader>pD";
        action.__raw = "function() return require('debugprint').debugprint({ above = true }) end";
        options = {
          expr = true;
        };
      }
      {
        mode = "n";
        key = "<leader>pq";
        action.__raw = "function() return require('debugprint').debugprint({ variable = true }) end";
        options = {
          expr = true;
        };
      }
      {
        mode = "n";
        key = "<leader>pQ";
        action.__raw = "function() return require('debugprint').debugprint({ above = true, variable = true }) end";
        options = {
          expr = true;
        };
      }
      {
        mode = "n";
        key = "<leader>pc";
        action.__raw = "function(opts) require('debugprint').deleteprints(opts) end";
      }
    ];
  };
}
