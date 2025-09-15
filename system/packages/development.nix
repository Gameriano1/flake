{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Development Tools
    postman
    mysql84
    git
    vscode
    github-desktop
  ];

}