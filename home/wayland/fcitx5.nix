{
  host,
  lib,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${host}/env.nix) WM;
in
  lib.mkIf (WM == "Hyprland" || WM == "niri") {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-configtool # needed enable rime using configtool after installed
          fcitx5-chinese-addons
          fcitx5-material-color # theme
          fcitx5-gtk # gtk im module
          fcitx5-rime # for flypy chinese input method
          libsForQt5.fcitx5-qt # qt im module
        ];
        settings.inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "pinyin";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "pinyin";
        };
        waylandFrontend = true;
      };
    };
  }
