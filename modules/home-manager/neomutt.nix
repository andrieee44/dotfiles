{ config, ... }:
{
	accounts.email.accounts."${config.home.username}".neomutt = {
		enable = config.programs.neomutt.enable;

		extraConfig = ''
			color normal default default
			color index brightblue default ~N
			color index red default ~F
			color index blue default ~T
			color index brightred default ~D
			color body brightgreen default (https?|ftp)://[\-\.+,/%~_:?&=\
			color body brightgreen default [\-\.+_a-zA-Z0-9]+@[\-\.a-zA-Z0-9]+
			color attachment magenta default
			color signature brightwhite default
			color search brightred black

			color indicator black cyan
			color error red default
			color status white brightblack
			color tree white default
			color tilde cyan default

			color hdrdefault brightblue default
			color header cyan default "^From:"
			color header cyan default "^Subject:"

			color quoted cyan default
			color quoted1 brightcyan default
			color quoted2 blue default
			color quoted3 green default
			color quoted4 yellow default
			color quoted5 red default
		'';
	};

	programs.neomutt = {
		settings = let
			dateFmt = "%b %e %Y (%a) %l:%M %p";
			indexFmt = "%5C %Z [%2N] (%4c) %{${dateFmt}} %-20.20F %s";
		in
		{
			ascii_chars = "yes";
			ask_bcc = "yes";
			ask_cc = "yes";
			autoedit = "yes";
			auto_tag = "yes";
			dateFmt = "\"${dateFmt}\"";
			edit_headers = "yes";
			fast_reply = "yes";
			force_name = "yes";
			forward_quote = "yes";
			hdrs = "yes";
			header = "yes";
			history = "100";
			index_format = "\"${indexFmt}\"";
			mail_check = "60";
			menu_scroll = "yes";
			metoo = "yes";
			pager_index_lines = "10";
			mime_forward = "yes";
			move = "yes";
			pager_context = "5";
			pager_format = "\"${indexFmt}\"";
			pager_stop = "yes";
			postponed = "+postponed";
			print = "ask-yes";
			status_chars ="\"UCRA\"";
			status_format ="\" %P %r %D (Total:%m/New:%n/Old:%o/Del:%d/Flag:%F/Tag:%t/Post:%p) (Thread:\"%T\"/Sort:\"%s\"/AuxSort:\"%S\")\"";
			tilde = "yes";
		};

		sidebar = {
			enable = true;
		};
	};
}
