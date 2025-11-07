{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Development Tools
    postman
    mysql84
    git
    vscodium
    github-desktop

    httpie
    zoxide
  ];

}