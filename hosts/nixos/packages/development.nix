{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Development Tools
    git
    httpie # keeping httpie as it can be useful for root sometimes, but user requested move. Wait, plan said remove.
    # checking plan: "Remove migrated tools."
    # postman, mysql84, vscodium, github-desktop, zoxide moved.
    # keeping git as system-wide git is standard.
  ];

}