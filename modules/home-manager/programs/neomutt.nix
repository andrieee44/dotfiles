{ config, ... }:
{
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

		sidebar.enable = true;
	};
}
