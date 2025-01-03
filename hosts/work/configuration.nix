# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  wsl.enable = true;
  wsl.defaultUser = "nixos";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = [
    pkgs.wget
    pkgs.vim
    pkgs.neovim
    pkgs.git
    pkgs.tmux
    pkgs.zig
    pkgs.fd
    pkgs.cmake
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.jq
    pkgs.zsh
    pkgs.unzip
    pkgs.dotnetCorePackages.sdk_8_0
    pkgs.omnisharp-roslyn
    pkgs.netcoredbg
    pkgs.nodejs
    pkgs.vscode-langservers-extracted
	pkgs.direnv
	pkgs.marksman
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "nixos" = import ./home.nix;
    };
  };

  # This is an alternative to use Mason in nvim
  # Fix and use NixVim in future
  programs.nix-ld.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
