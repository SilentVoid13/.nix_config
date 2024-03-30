{lib, ...}:
with lib; rec {
  toLuaObject = args:
    if builtins.isAttrs args
    then
      if hasAttr "__raw" args
      then args.__raw
      else if hasAttr "__empty" args
      then "{ }"
      else
        "{"
        + (concatStringsSep ","
          (mapAttrsToList
            (n: v:
              if head (stringToCharacters n) == "@"
              then toLuaObject v
              else "[${toLuaObject n}] = " + (toLuaObject v))
            (filterAttrs
              (
                n: v:
                  v != null && (toLuaObject v != "{}")
              )
              args)))
        + "}"
    else if builtins.isList args
    then "{" + concatMapStringsSep "," toLuaObject args + "}"
    else if builtins.isString args
    then builtins.toJSON args
    else if builtins.isPath args
    then builtins.toJSON (toString args)
    else if builtins.isBool args
    then "${boolToString args}"
    else if builtins.isFloat args
    then "${toString args}"
    else if builtins.isInt args
    then "${toString args}"
    else if (args == null)
    then "nil"
    else "";

  mkPluginSetupCall = plugin: options: ''require("${plugin}").setup(${toLuaObject options})'';

  mkRaw = r: {__raw = r;};
}
