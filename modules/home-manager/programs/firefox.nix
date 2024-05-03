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
			SanitizeOnShutdown = true;
			SearchBar = "unified";
			SearchSuggestEnabled = false;
			StartDownloadsInTempDirectory = false;
			UseSystemPrintDialog = true;

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

			Permissions = {
				Autoplay = {
					Default = "block-audio-video";
					Locked = true;
				};

				Camera = {
					BlockNewRequests = true;
					Locked = true;
				};

				Location = {
					BlockNewRequests = true;
					Locked = true;
				};

				Microphone = {
					BlockNewRequests = true;
					Locked = true;
				};

				Notifications = {
					BlockNewRequests = true;
					Locked = true;
				};
			};

			PictureInPicture = {
				Enabled = true;
				Locked = true;
			};

			PopupBlocking = {
				Default = true;
				Locked = true;
			};

			Preferences = {
				"app.update.auto" = {
					Status = "locked";
					Value = false;
				};

				"browser.aboutConfig.showWarning" = {
					Status = "locked";
					Value = false;
				};

				"browser.cache.offline.enable" = {
					Status = "locked";
					Value = false;
				};

				"browser.crashReports.unsubmittedCheck.autoSubmit" = {
					Status = "locked";
					Value = false;
				};

				"browser.crashReports.unsubmittedCheck.autoSubmit2" = {
					Status = "locked";
					Value = false;
				};

				"browser.crashReports.unsubmittedCheck.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.disableResetPrompt" = {
					Status = "locked";
					Value = true;
				};

				"browser.fixup.alternate.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.newtab.preload" = {
					Status = "locked";
					Value = false;
				};

				"browser.newtabpage.activity-stream.section.highlights.includePocket" = {
					Status = "locked";
					Value = false;
				};

				"browser.newtabpage.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.newtabpage.enhanced" = {
					Status = "locked";
					Value = false;
				};

				"browser.newtabpage.introShown" = {
					Status = "locked";
					Value = true;
				};

				"browser.safebrowsing.appRepURL" = {
					Status = "locked";
					Value = "";
				};

				"browser.safebrowsing.blockedURIs.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.safebrowsing.downloads.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.safebrowsing.downloads.remote.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.safebrowsing.downloads.remote.url" = {
					Status = "locked";
					Value = "";
				};

				"browser.safebrowsing.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.safebrowsing.malware.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.safebrowsing.phishing.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.search.suggest.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.selfsupport.url" = {
					Status = "locked";
					Value = "";
				};

				"browser.send_pings" = {
					Status = "locked";
					Value = false;
				};

				"browser.sessionstore.privacy_level" = {
					Status = "locked";
					Value = 0;
				};

				"browser.shell.checkDefaultBrowser" = {
					Status = "locked";
					Value = false;
				};

				"browser.startup.homepage_override.mstone" = {
					Status = "locked";
					Value = "ignore";
				};

				"browser.tabs.crashReporting.sendReport" = {
					Status = "locked";
					Value = false;
				};

				"browser.urlbar.groupLabels.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.urlbar.quicksuggest.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.urlbar.speculativeConnect.enabled" = {
					Status = "locked";
					Value = false;
				};

				"browser.urlbar.trimURLs" = {
					Status = "locked";
					Value = false;
				};

				"datareporting.policy.dataSubmissionEnabled" = {
					Status = "locked";
					Value = false;
				};

				"dom.battery.enabled" = {
					Status = "locked";
					Value = false;
				};

				"dom.event.clipboardevents.enabled" = {
					Status = "locked";
					Value = false;
				};

				"dom.security.https_only_mode" = {
					Status = "locked";
					Value = true;
				};

				"dom.security.https_only_mode_ever_enabled" = {
					Status = "locked";
					Value = true;
				};

				"dom.webaudio.enabled" = {
					Status = "locked";
					Value = false;
				};

				"extensions.getAddons.cache.enabled" = {
					Status = "locked";
					Value = false;
				};

				"extensions.getAddons.showPane" = {
					Status = "locked";
					Value = false;
				};

				"extensions.pocket.enabled" = {
					Status = "locked";
					Value = false;
				};

				"extensions.shield-recipe-client.api_url" = {
					Status = "locked";
					Value = "";
				};

				"extensions.shield-recipe-client.enabled" = {
					Status = "locked";
					Value = false;
				};

				"extensions.webservice.discoverURL" = {
					Status = "locked";
					Value = "";
				};

				"keyword.enabled" = {
					Status = "locked";
					Value = true;
				};

				"media.autoplay.default" = {
					Status = "locked";
					Value = 1;
				};

				"media.autoplay.enabled" = {
					Status = "locked";
					Value = false;
				};

				"media.eme.enabled" = {
					Status = "locked";
					Value = false;
				};

				"media.gmp-widevinecdm.enabled" = {
					Status = "locked";
					Value = false;
				};

				"media.navigator.enabled" = {
					Status = "locked";
					Value = false;
				};

				"media.peerconnection.enabled" = {
					Status = "locked";
					Value = false;
				};

				"media.video_stats.enabled" = {
					Status = "locked";
					Value = false;
				};

				"network.IDN_show_punycode" = {
					Status = "locked";
					Value = true;
				};

				"network.allow-experiments" = {
					Status = "locked";
					Value = false;
				};

				"network.captive-portal-service.enabled" = {
					Status = "locked";
					Value = false;
				};

				"network.cookie.cookieBehavior" = {
					Status = "locked";
					Value = 1;
				};

				"network.dns.disablePrefetch" = {
					Status = "locked";
					Value = true;
				};

				"network.dns.disablePrefetchFromHTTPS" = {
					Status = "locked";
					Value = true;
				};

				"network.http.referer.spoofSource" = {
					Status = "locked";
					Value = true;
				};

				"network.http.speculative-parallel-limit" = {
					Status = "locked";
					Value = 0;
				};

				"network.predictor.enable-prefetch" = {
					Status = "locked";
					Value = false;
				};

				"network.predictor.enabled" = {
					Status = "locked";
					Value = false;
				};

				"network.prefetch-next" = {
					Status = "locked";
					Value = false;
				};

				"network.trr.mode" = {
					Status = "locked";
					Value = 5;
				};

				"security.disable_button.openCertManager" = {
					Status = "locked";
					Value = true;
				};

				"security.disable_button.openDeviceManager" = {
					Status = "locked";
					Value = true;
				};

				"security.insecure_connection_text.enabled" = {
					Status = "locked";
					Value = true;
				};

				"security.insecure_connection_text.pbmode.enabled" = {
					Status = "locked";
					Value = true;
				};

				"security.OCSP.require" = {
					Status = "locked";
					Value = true;
				};

				"security.ssl.require_safe_negotiation" = {
					Status = "locked";
					Value = true;
				};

				"signon.autofillForms" = {
					Status = "locked";
					Value = false;
				};
			};

			SearchEngines = {
				Default = "SearXNG";
				PreventInstalls = true;

				Add = [
					{
						Alias = "searxng";
						Description = "SearXNG - a privacy-respecting, open metasearch engine";
						IconURL = "https://search.bus-hit.me/search?q={searchTerms}";
						Method = "POST";
						PostData = "q={searchTerms}";
						Name = "SearXNG";
						SuggestURLTemplate = "https://search.bus-hit.me/suggest?q={searchTerms}";
						URLTemplate = "https://search.bus-hit.me/search?q={searchTerms}";
					}
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
