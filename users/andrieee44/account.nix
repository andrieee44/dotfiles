{ config, pkgs, ... }:
{
  programs = {
    gpg.publicKeys = [
      {
        trust = 5;
        source = ./andrieee44-pub.key;
      }
    ];

    git = {
      userEmail = "andrieee44@gmail.com";
      signing.key = "A555AF06F5A80AB1";
    };

    irssi = {
      networks.liberachat = {
        nick = "andrieee44";

        server = {
          address = "irc.libera.chat";
          port = 6697;
          autoConnect = true;
        };
      };

      extraConfig = ''
        chatnets = {
        	liberachat = {
        		sasl_username = "andrieee44";
        		sasl_password = "PASSWORD";
        		sasl_mechanism = "PLAIN";
        	};
        };
      '';
    };
  };

  home = {
    file.".irssi/config".target = "${config.xdg.configHome}/irssi/base.config";

    shellAliases.irssi = builtins.toString (
      pkgs.writers.writeDash "irssiPass" ''
        set -eu

        ${pkgs.gawk}/bin/awk -v pass="$(${config.programs.password-store.package}/bin/pass liberachat/andrieee44)" '{
        		sub("sasl_password = .*", "sasl_password = \"" pass "\";")
        		print($0)
        	}' "${config.home.homeDirectory}/${
           config.home.file.".irssi/config".target
         }" > "${config.xdg.configHome}/irssi/config"

        ${pkgs.irssi}/bin/irssi --home "${config.xdg.configHome}/irssi" "$@"

        ${pkgs.toybox}/bin/rm "${config.xdg.configHome}/irssi/config"
      ''
    );
  };

  xdg.configFile.pam-gnupg = {
    enable = config.services.gpg-agent.enable;

    text = ''
      ${config.programs.gpg.homedir}
      4761373E4C1DF3223D5D82B64B2B4D7665A3138B
    '';
  };

  accounts.email.accounts."andrieee44@gmail.com" =
    let
      signatureText = "-- \n\"The art of programming is the art of organizing complexity.\" -Edsger Dijkstra";
    in
    {
      address = "andrieee44@gmail.com";
      flavor = "gmail.com";
      passwordCommand = "${config.programs.password-store.package}/bin/pass google/andrieee44/app";
      primary = true;
      realName = "andrieee44";
      userName = "andrieee44";
      maildir.path = "andrieee44@gmail.com";
      msmtp.enable = true;
      mu.enable = true;
      notmuch.enable = true;

      aerc = {
        enable = true;

        extraAccounts = {
          signature-file = builtins.toFile "signature.txt" signatureText;
          pgp-auto-sign = true;
          pgp-attach-key = true;
        };
      };

      gpg = {
        key = "B936 149C 88D4 64B3 DC0B 9F0D A555 AF06 F5A8 0AB1";
        signByDefault = true;
      };

      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "both";
        remove = "both";
        subFolders = "Maildir++";
      };

      signature = {
        text = signatureText;
        showSignature = "append";
      };
    };
}
