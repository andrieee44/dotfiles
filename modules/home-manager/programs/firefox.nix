{ config, pkgs, ... }:
{
	programs.firefox = {
		package = pkgs.firefox-esr;

		policies = {
			AppAutoUpdate = false;
			AutofillAddressEnabled = false;
			AutofillCreditCardEnabled = false;
			BlockAboutAddons = true;
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
			InstallAddonsPermission.Default = false;
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
	};
}
