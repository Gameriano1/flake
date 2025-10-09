{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    localVariables = {
      PATH="$PATH:/home/leleodocapa/go/bin:/home/leleodocapa/.local/bin";
    };
    shellAliases =
      let
        flakeDir = "~/flake";
      in {
        sw = "nh os switch";
        upd = "nh os switch --update";
        bf = "bash /home/leleodocapa/Documents/bf.sh";
        bfb = "bash /home/leleodocapa/Documents/bfb.sh";

        #rovodev = "acli rovodev";
        #acli = "~/rovodev/acli";

        kali = "distrobox enter --root kali";
        k = "distrobox enter --root kali --";


        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";

        shotgun = "steam-run /home/leleodocapa/Documents/Projetos/shotgun_interactive/dist/shotgun/shotgun";

        ".." = "cd ..";
      };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };
}