{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Development Tools
    postman
    mysql84
    git
    vscodium
    windsurf
    github-desktop

    httpie
    zoxide
  ];

}