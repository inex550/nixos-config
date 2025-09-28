{ config, osConfig, pkgs, ... }:
let
  cfgUser = osConfig.users.users.inex;
in {
  home.username = cfgUser.name;
  home.homeDirectory = cfgUser.home;

  home.packages = with pkgs; [
    # Dev stuff
    clang clang-tools
    cmake ninja gnumake
    wayland wayland-scanner
    tree-sitter lua-language-server cmake-language-server nil
    nodejs python3
    
    # CLI programs
    openvpn
    p7zip
    ripgrep
    
    # GUI programs
    firefox tor-browser
    vlc
    qbittorrent
  ];

  home.stateVersion = "25.05";  
}
