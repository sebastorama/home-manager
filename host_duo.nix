{ pkgs, ... }:
{
  home.file = {
    ".local/hm-bins/duo" = {
      source = hosts/duo/scripts;
    };
  };
}
