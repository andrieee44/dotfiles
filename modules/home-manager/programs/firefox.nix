{ config, pkgs, ... }:
{
	programs.firefox = {
		package = pkgs.firefox-esr;

		policies = {
			AppAutoUpdate = false;
			AutofillAddressEnabled = false;
			AutofillCreditCardEnabled = false;
			BlockAboutAddons = false;
			BlockAboutConfig = true;
			BlockAboutProfiles = true;
			BlockAboutSupport = false;
			CaptivePortal = true;
			DefaultDownloadDirectory = config.xdg.userDirs.download;
			DisableAppUpdate = true;
			DisableBuiltinPDFViewer = false;
			DisableDeveloperTools = false;
			DisableFeedbackCommands = false;
			DisableFirefoxAccounts = true;
			DisableFirefoxScreenshots = true;
			DisableFirefoxStudies = true;
			DisableForgetButton = false;
			DisableFormHistory = true;
			DisableMasterPasswordCreation = true;
			DisablePasswordReveal = true;
			DisablePocket = true;
			DisablePrivateBrowsing = false;
			DisableProfileImport = true;
			DisableProfileRefresh = false;
			DisableSafeMode = false;
			DisableSetDesktopBackground = true;
			DisableSystemAddonUpdate = true;
			DisableTelemetry = true;
			DisplayBookmarksToolbar = "never";
			DisplayMenuBar = "default-off";
			DNSOverHTTPS.Locked = true;
			DontCheckDefaultBrowser = true;
			DownloadDirectory = config.xdg.userDirs.download;
			EncryptedMediaExtensions.Locked = false;
			ExtensionUpdate = false;
			HardwareAcceleration = true;
			InstallAddonsPermission.Default = true;
			LegacySameSiteCookieBehaviorEnabled = false;
			ManualAppUpdateOnly = true;
			NetworkPrediction = false;
			NewTabPage = true;
			NoDefaultBookmarks = true;
			OfferToSaveLogins = false;
			PasswordManagerEnabled = false;
			PrimaryPassword = false;
			PrintingEnabled = true;
			PromptForDownloadLocation = true;
			SearchBar = "unified";
			SearchSuggestEnabled = false;
			StartDownloadsInTempDirectory = false;
			UseSystemPrintDialog = true;

			Cookies = {
				Behavior = "reject-tracker-and-partition-foreign";
				BehaviorPrivateBrowsing = "reject-tracker-and-partition-foreign";
				Locked = true;
			};

			DisableSecurityBypass = {
				InvalidCertificate = true;
				SafeBrowsing = true;
			};

			EnableTrackingProtection = {
				Cryptomining = true;
				EmailTracking = true;
				Fingerprinting = true;
				Locked = true;
				Value = true;
			};

			FirefoxHome = {
				Highlights = false;
				Locked = true;
				Pocket = false;
				Search = true;
				Snippets = false;
				SponsoredPocket = false;
				SponsoredTopSites = false;
				TopSites = false;
			};

			FirefoxSuggest = {
				ImproveSuggest = false;
				Locked = true;
				SponsoredSuggestions = false;
				WebSuggestions = false;
			};

			Homepage = {
				Locked = true;
				StartPage = "none";
			};

			PDFjs = {
				Enable = true;
				EnablePermissions = true;
			};

			Permissions = builtins.mapAttrs (name: value:
				value // { Locked = true; }
			) {
				Autoplay.Default = "block-audio-video";
				Camera.BlockNewRequests = true;
				Location.BlockNewRequests = true;
				Microphone.BlockNewRequests = true;
				Notifications.BlockNewRequests = true;
			};

			PictureInPicture = {
				Enabled = true;
				Locked = true;
			};

			PopupBlocking = {
				Default = true;
				Locked = true;
			};

			Preferences = builtins.mapAttrs (name: value:
				value // { Status = "locked"; }
			) {
				"app.update.auto".Value = false;
				"browser.aboutConfig.showWarning".Value = false;
				"browser.cache.offline.enable".Value = false;
				"browser.crashReports.unsubmittedCheck.autoSubmit".Value = false;
				"browser.crashReports.unsubmittedCheck.autoSubmit2".Value = false;
				"browser.crashReports.unsubmittedCheck.enabled".Value = false;
				"browser.disableResetPrompt".Value = true;
				"browser.fixup.alternate.enabled".Value = false;
				"browser.newtab.preload".Value = false;
				"browser.newtabpage.activity-stream.section.highlights.includePocket".Value = false;
				"browser.newtabpage.enabled".Value = false;
				"browser.newtabpage.enhanced".Value = false;
				"browser.newtabpage.introShown".Value = true;
				"browser.safebrowsing.appRepURL".Value = "";
				"browser.safebrowsing.blockedURIs.enabled".Value = false;
				"browser.safebrowsing.downloads.enabled".Value = false;
				"browser.safebrowsing.downloads.remote.enabled".Value = false;
				"browser.safebrowsing.downloads.remote.url".Value = "";
				"browser.safebrowsing.enabled".Value = false;
				"browser.safebrowsing.malware.enabled".Value = false;
				"browser.safebrowsing.phishing.enabled".Value = false;
				"browser.search.suggest.enabled".Value = false;
				"browser.selfsupport.url".Value = "";
				"browser.send_pings".Value = false;
				"browser.sessionstore.privacy_level".Value = 0;
				"browser.shell.checkDefaultBrowser".Value = false;
				"browser.startup.homepage_override.mstone".Value = "ignore";
				"browser.tabs.crashReporting.sendReport".Value = false;
				"browser.urlbar.groupLabels.enabled".Value = false;
				"browser.urlbar.maxRichResults".Value = 0;
				"browser.urlbar.quicksuggest.enabled".Value = false;
				"browser.urlbar.speculativeConnect.enabled".Value = false;
				"browser.urlbar.trimURLs".Value = false;
				"datareporting.policy.dataSubmissionEnabled".Value = false;
				"dom.battery.enabled".Value = false;
				"dom.event.clipboardevents.enabled".Value = false;
				"dom.security.https_only_mode".Value = true;
				"dom.security.https_only_mode_ever_enabled".Value = true;
				"dom.webaudio.enabled".Value = false;
				"extensions.getAddons.cache.enabled".Value = false;
				"extensions.getAddons.showPane".Value = false;
				"extensions.pocket.enabled".Value = false;
				"extensions.shield-recipe-client.api_url".Value = "";
				"extensions.shield-recipe-client.enabled".Value = false;
				"extensions.webservice.discoverURL".Value = "";
				"keyword.enabled".Value = true;
				"media.autoplay.default".Value = 1;
				"media.autoplay.enabled".Value = false;
				"media.eme.enabled".Value = false;
				"media.gmp-widevinecdm.enabled".Value = false;
				"media.navigator.enabled".Value = false;
				"media.peerconnection.enabled".Value = false;
				"media.video_stats.enabled".Value = false;
				"network.IDN_show_punycode".Value = true;
				"network.allow-experiments".Value = false;
				"network.captive-portal-service.enabled".Value = false;
				"network.cookie.cookieBehavior".Value = 1;
				"network.dns.disablePrefetch".Value = true;
				"network.dns.disablePrefetchFromHTTPS".Value = true;
				"network.http.referer.spoofSource".Value = true;
				"network.http.speculative-parallel-limit".Value = 0;
				"network.predictor.enable-prefetch".Value = false;
				"network.predictor.enabled".Value = false;
				"network.prefetch-next".Value = false;
				"network.trr.mode".Value = 5;
				"security.disable_button.openCertManager".Value = true;
				"security.disable_button.openDeviceManager".Value = true;
				"security.insecure_connection_text.enabled".Value = true;
				"security.insecure_connection_text.pbmode.enabled".Value = true;
				"security.OCSP.require".Value = true;
				"security.ssl.require_safe_negotiation".Value = true;
				"signon.autofillForms".Value = false;
			};

			SanitizeOnShutdown = {
				Cache = true;
				Cookies = false;
				Downloads = true;
				FormData = true;
				History = true;
				Sessions = false;
				SiteSettings = false;
				OfflineApps = true;
				Locked = true;
			};

			SearchEngines = {
				Default = "SearXNG";
				PreventInstalls = true;

				Add = [
					{
						Alias = "searxng";
						Description = "SearXNG - a privacy-respecting, open metasearch engine";
						IconURL = "https://search.bus-hit.me/favicon.ico";
						Method = "POST";
						Name = "SearXNG";
						PostData = "preferences=eJx1WMuu5DYO_ZrUppDCZBJgMItaBcg2AyRZG7RE22pLoluPqvL9-qH8KFPXtxfXXTqSKIqPQ6oVJOwpGIz3Hj0GsBcLvs_Q4x39z__8dbGkwJbBBXIiRW6ymPB-MY7XNFOg13z_O2S8OEwD6fv__vzr70uEDiNCUMP9X5c0oMN7NGXnJWDMNsWGfOPx2SRo73-AjXjRZBqeJPvAcCfg4Y1Cf1m3NTHNrISGMF4U-oShAWt67_j3th_0A7xC3Wznruj3jGFujG-SSSxgBY3vjDeJpapA1m7ouq8oplajzCzKokrr9QZKI87xrrEDvsFFmwit5fPQ98az_f7bQ980kZQBe3WoDfz079_Be4jXItg8sGk6YzEWeBqvzoRAQWJ80St_rzFRkIs9KPIamsakMoxj02zO4uHTjGYqp0mwNdaUv6Z5GI0UF8j39ZLUZjVi2sS2U1tNJ236_lBiudBNKXXTKKSqaQrYYUA2_SaIbRojg2wLZQq-Yk_9MOxwccSM06fhdQmqyIKWfzeQ44Sh8i2ScrAG5T5GyvFzpT0MfqBOQhrxg8OmcTkatYxjgmRYMnGAhoLo_sreLaFhyEe5GVl_o4-lxegaUmVzzdYsfz2dryHmVtMJE4q56qYCfyKUg4_z11hxMPFy_hYNHX3b42BflTgu58pWv7yEUp0OVC61u7gLiNdIXXpCwKs2gWO_ZMHq1i4YPxpQUsA8C5v0nGHQ7kFAGlsM_TbsiXRA0MLaDPV8h8nCXII-HnrIGUccNdJajnMzlAwzavHRW5l-Iq2lgwdoA5TPpsMAHO1hNfEK4Gv7ZZxuD82M63MQko0HoYDx_NNQjl9j--nfTBzokMnpGCDM1-KKaMRlLaflo4ojS21MeAu7msyroCbw-5A-BiPXu6drrQT85La1fgY4jiI9R5TJSxMygyYUehYo4ERCw4ntBr2JO1Fwwm9UKc58g-fYP6b20P9qWxX6U26ZZh7bgd-f4JPcFSglJn7iWCAUIbWKcnMs3C7Wr3gJyWv5bGIjOpZr1DWqgSwEyVdMDSFNpcAJMYnGmRKxX8fijd0-qdyTZUCuFgt0u1WqomyGgagm8rbiMK66L_A61MxemKclGuNn8Hum-tYFjJSDOqMTqiWrfgAfdigw12M26Px59YPmT_Z5ku0COLDTUBOjUemDfLXWzY4ZixMiBfDRclLriqd-_fU_r8PEOmv00s8fHlwljr4hjjXCxDEZS-nY5-FRCEIEUm7nHt2eaRNiSLmVKbKUPd4-luL1xFZMzVDXnDI-R3_InJ1SomWDRs4piT3pZUbyHPPXOHvybBx5WxxDnR8rdDprhU8FJn6bbtNT2o-NrqqMio--ZL2Q9eDSwNyUd4osLndcGqsbZ-fsXJHcQVtr6A05HSWgyvyxv_W0Z_kFfd1MLZywnH8tJ--tT-B8FUpCeJmHjNeWE0aBmw4eLm3P2VILWpl0QU6mK3RY4h_FXjVgN1Khv3fjgA_DVMLayZJPpdxch7yXxKOeV51Fmh15vqnweGeNGmUF4uVGFpe-sB_thjXpOGStnfKArZqeTLDhlRE27GSGDf-CKIftvOXwkdWGKIsbOjcz5zqXS1O1cEvdH68rcsTwozmuRelHc0Uym-I8_fHzVnBloV0rMHW8zXO4R2mNMotvLqqIBLgd1-R_oOR7eoA4MOl_sUK_S7d5KUtZH47kCjQa3DuUEm3AbVfpLCOmion3OS6NHB2wdaj1POc1YuJ-cG8KJ13I7Fg08SOG3zf7rCkPKYwyaqfSQwrPL-Pbou6h9WQCG6kFYV1uvhRbwnhdmqo9kFlZV8QJDebJyLJex98KnUJ1hU9RGYB7rmvLrXmUfR_bT5t0ckPkagB743JwI2VmjNopXPzVSJz2naXn8ejKbfYp7x1jMZ3nzmx92X3VQuQJQ45v5_LL1mjup8MasLvhso_c6MZBvnlKZ1AbZqb8qTC9kfd7BoxlKimBIZY9jCvt3VFpmEwryQyULUuqyNdNSS0OsdvJGXLy5BI5CZndc-gnp5bLHzZ4UtDejOLhQpS6Ekvh5MYnWDtwHfdSpZTCzYgCx5n-qJJ4Ac53WeHTLVa4Lg_pt_0xfLz8J5u5WsV7iarXbRvdItquMb6jrfM8Ztj7DVcPNb7L3dcSCpVsUycZA9MhNz_YMBVYWCOtWkDQrP-V8gzcBp91CMszqOFnNK9xJcxPawpZN0ySPMdRfuG-l7nl_n-8yNzp&q={searchTerms}";
						URLTemplate = "https://search.bus-hit.me/search";
					}
				];

				Remove = [
					"Bing"
					"DuckDuckGo"
					"Google"
				];
			};

			UserMessaging = {
				ExtensionRecommendations = false;
				FeatureRecommendations = false;
				Locked = true;
				MoreFromMozilla = false;
				SkipOnboarding = true;
				UrlbarInterventions = false;
				WhatsNew = false;
			};
		};

		profiles.default = {
			id = 0;
			isDefault = true;

			extensions = with config.nur.repos.rycee.firefox-addons; [
				darkreader
				ublock-origin
				vimium
			];

			settings = {
				"app.normandy.api_url" = "";
 				"app.normandy.enabled" = false;
 				"app.shield.optoutstudies.enabled" = false;
 				"beacon.enabled" = false;
 				"breakpad.reportURL" = "";
 				"datareporting.healthreport.service.enabled" = false;
 				"datareporting.healthreport.uploadEnabled" = false;
 				"device.sensors.ambientLight.enabled" = false;
 				"device.sensors.enabled" = false;
 				"device.sensors.motion.enabled" = false;
 				"device.sensors.orientation.enabled" = false;
 				"device.sensors.proximity.enabled" = false;
 				"experiments.activeExperiment" = false;
 				"experiments.enabled" = false;
 				"experiments.manifest.uri" = "";
 				"experiments.supported" = false;
				"extensions.autoDisableScopes" = 0;
 				"general.useragent.override" = "Mozilla/5.0 (Windows NT 10.0 Win64; x64 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.3";
 				"privacy.donottrackheader.enabled" = true;
 				"privacy.donottrackheader.value" = 1;
 				"privacy.firstparty.isolate" = true;
 				"privacy.query_stripping" = true;
 				"privacy.resistFingerprinting" = true;
 				"privacy.trackingprotection.cryptomining.enabled" = true;
 				"privacy.trackingprotection.enabled" = true;
 				"privacy.trackingprotection.fingerprinting.enabled" = true;
 				"privacy.trackingprotection.pbmode.enabled" = true;
 				"privacy.usercontext.about_newtab_segregation.enabled" = true;
 				"security.ssl.disable_session_identifiers" = true;
 				"services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite" = false;
 				"toolkit.telemetry.archive.enabled" = false;
 				"toolkit.telemetry.bhrPing.enabled" = false;
 				"toolkit.telemetry.cachedClientID" = "";
 				"toolkit.telemetry.enabled" = false;
 				"toolkit.telemetry.firstShutdownPing.enabled" = false;
 				"toolkit.telemetry.hybridContent.enabled" = false;
 				"toolkit.telemetry.newProfilePing.enabled" = false;
 				"toolkit.telemetry.prompted" = 2;
 				"toolkit.telemetry.rejected" = true;
 				"toolkit.telemetry.reportingpolicy.firstRun" = false;
 				"toolkit.telemetry.server" = "";
 				"toolkit.telemetry.shutdownPingSender.enabled" = false;
 				"toolkit.telemetry.unified" = false;
 				"toolkit.telemetry.unifiedIsOptIn" = false;
 				"toolkit.telemetry.updatePing.enabled" = false;
 				"webgl.disabled" = true;
 				"webgl.renderer-string-override" = " ";
 				"webgl.vendor-string-override" = " ";
			};
		};
	};
}
