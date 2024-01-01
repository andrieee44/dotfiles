{ config, ... }:
{
	config.programs.librewolf.settings = {
		"privacy.clearOnShutdown.history" = false;
		"privacy.clearOnShutdown.downloads" = false;
		"privacy.history.custom" = false;
		"privacy.donottrackheader.enabled" = true;
		"browser.startup.couldRestoreSession.count" = 1;
		"browser.search.suggest.enabled" = true;
		"browser.urlbar.suggest.searches" = true;
		"intl.regional_prefs.use_os_locales" = true;
		"services.sync.engine.addresses.available" = false;
		"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
	};
}
