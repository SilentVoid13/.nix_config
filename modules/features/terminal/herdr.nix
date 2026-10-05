{ ... }:
{
  flake.modules.homeManager.herdr =
    { ... }:
    {
      programs.herdr = {
        enable = true;
        settings = {
          onboarding = false;
          keys = {
            prefix = "ctrl+a";
            split_vertical = "prefix+%";
            split_horizontal = "prefix+\"";
            command = [
              {
                command = "sessionizer.open";
                description = "sessionizer";
                key = "prefix+f";
                type = "plugin_action";
              }
              {
                command = "\"$HERDR_BIN_PATH\" pane move \"$HERDR_ACTIVE_PANE_ID\" --new-tab --focus";
                description = "move pane to new tab";
                key = "prefix+!";
                type = "shell";
              }
            ];
          };
          ui = {
            prompt_new_tab_name = false;
            pane_gaps = false;
            pane_outer_borders = false;
            toast.delivery = "system";
          };
          terminal = {
            default_shell = "zsh";
          };
        };
      };
    };
}
