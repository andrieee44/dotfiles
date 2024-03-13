{ ... }:
{
	programs.librewolf.settings = {
		"privacy.clearOnShutdown.history" = true;
		"privacy.clearOnShutdown.downloads" = true;
		"privacy.history.custom" = false;
		"privacy.donottrackheader.enabled" = true;
		"browser.startup.couldRestoreSession.count" = 0;
		"browser.search.suggest.enabled" = false;
		"browser.urlbar.suggest.searches" = false;
		"intl.regional_prefs.use_os_locales" = true;
		"services.sync.engine.addresses.available" = false;
		"toolkit.legacyUserProfileCustomizations.stylesheets" = false;
	};
}
