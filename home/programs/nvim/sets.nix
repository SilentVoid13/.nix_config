{ ... }:
{
  programs.nixvim = {
    enable = true;

    opts = {
      encoding = "utf-8";
      laststatus = 2;
      updatetime = 300;

      # Avoids delay when pressing <Esc> key
      # https://vi.stackexchange.com/questions/16148/slow-vim-escape-from-insert-mode
      ttimeoutlen = 50;

      number = true;
      relativenumber = true;

      linespace = 0;

      #textwidth = 78;
      colorcolumn = "80";
      shiftwidth = 4;
      tabstop = 4;
      softtabstop = 4;
      expandtab = true;
      backspace = "indent,eol,start";

      autoread = true;
      ruler = true;
      showcmd = true;
      scrolloff = 8;
      incsearch = true;
      ignorecase = true;
      smartcase = true;

      mouse = "a";
      belloff = "all";
      errorbells = false;

      guicursor = "";

      conceallevel = 1;
    };

    globals = {
      mapleader = " ";
    };
  };
}
