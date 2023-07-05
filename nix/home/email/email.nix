{ config, pkgs, ... }:
{
	config.accounts.email = {
		maildirBasePath = "${config.xdg.dataHome}/maildir";

		accounts."${config.customVars.user}" = {
			realName = config.customVars.user;
			address = config.customVars.email;
			passwordCommand = "${pkgs.pass}/bin/pass googleAppPasswords/neomutt";
			flavor = config.customVars.emailFlavor;
			primary = true;
			maildir.path = config.customVars.email;

			signature = {
				delimiter = "--";
				showSignature = "attach";

				text = ''
"Object-oriented design is the roman numerals of computing."
- Rob Pike
				'';
			};
		};
	};
}
