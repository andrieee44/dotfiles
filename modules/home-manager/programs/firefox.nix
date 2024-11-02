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

      Permissions = builtins.mapAttrs (name: value: value // { Locked = true; }) {
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

      Preferences = builtins.mapAttrs (name: value: value // { Status = "locked"; }) {
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
            PostData = "preferences=eJx1WMuO7DYO_ZqpjXELM5MBglnUKkC2GSCZtSFLLFvXkuirR1W5vz6kH2Wq3XfR7tahRFEUeUi1Vhl6jBbSrYcAUbmLU6EvqocbhG____PiUCvHg4sqGTX6yUGG28V6mtNOEV_z7a9Y4OIhD2hu__vjz78uSd0hgYp6uP3zkgfwcEuWV14ipOJyajG0AZ5tVt3td-USXAzaloToHhBvqGh4xdhf1mVtyjMZYVQcLxpChtgqZ_vg6e9tvTIPFTSYdtt3RX8UiHNrQ5ttJgUraMPdBptJq47o3Iau69gwvTplJlUOdF6PN2AeYU43A3dFJ7gYm1TnaD8IvQ3kv__2qm_bhNoq13gwVv3j378pN5GwcTaUVzMpPZLTUtvazLIQVGp4U_uAtr1bB4nhaWy8jRGjxMgJDX2blDHKyUFpDEbtKtPYtttF0vBpRzuxJRLsrLP807YPawDTAoW-npK7okfIm9pu6ipxNrbvDyOWw1611lcDQquepgh3iEDXsikif6dEIPlJW8ZX7GkeloJBbDHD9GnYLAHHvlt-byDFEEH8ZU0lOgtyHSG8_VxZr4Yw4F1CBuCDQqr1JVm9jFNW2ZJmpOCNjJi-oZvnsLEYklzM-rXDLXykgA5mzaGDb8OoXF2GITfzT4_n8wnZ6lPhWyGrXCDwJyje-Nh_DSKvJppOX7bQ4_c9QPZZmeJ1rpz4r5cw6m4i8qH2uyeXmDyo7CnH5bQI0CS856eK0BgbKY84o9YwuEcbRqu0XDDPwlU92I-BslIglL-q28MIDXQQ-21IMqD4Q7-PEU0EZeRyxJ4OPzk1cxql4wBS4pHiULrZExNEzmerl1t_m9tPaIwMmUF1UfFns2GgXIe43s0KwOudBKQ1XS1uY-tNd1hqfV-i2MkGJQyygf60WNLX2G7Nd5sGPHRSwkcV54bvNFlxeOKl_lEFpMMuZbjG3WxidaUnFfYhfgxWzvdP3zkJhGm_hjArdWyFZk4g6QEnIP7OIOxkKMKEwsKVM23aqYgo5Zxpb_CcRIdoz6GvllU5NJWOiOyxbfjjqUKWqyLmTGUHKTYQRIitqvycuLLIFLdJl5Su00z1cfejVsbMHLK-EKXseTHZbwM6OOGrao76hj9v1JNpVjdJ0yoVJakSf8U8cYUWlmQcZ8xIoTHyhe4uzuwq0qFKNVmgm2NyFaizGhDratNVREttw0sFE-vywyzYIY7pM_ijYO04BhOWqM_oBHpJ1J_Ahx8YpoYiLb6sZz9w_uSfJ7p7VJ5q9lCTtNX5A0M118_EeMRoTY4qJEcZbSrO_OWXX1-Hi00xEGSofATlK3X4HWA8I-eA3vAqYhfemqzDfOwR1IP5ScRt6eYe_J7YE0DMpZMZudRxWj5yNX5CJ0Szqosoj8-2xUJkIDU6cn6iFJbYE192xEAp1qQ5YJi5cByegTHWh1uh014rfCqM6ft0nZ7S13RBukrg9OiZZISuB5W0pUXbfMPh4anWVycu3ru54tSDJdcwHUo-KlBFNGN_7XEnlQuEunNcKGhtEXnnvZeLlNvCSBVf9iFju6Pk0spPB-1zH3f21IJWLl2Qk-uYfTlXZB3XA9xHZLZ9d0LwsEQ7ZJ1sVZCrXTOUvUIffUjVEeXZY6CTihu_O6tHWfBoupW1rGey3Wsllfpjk7V0yw22Yn5ywYZXTtiwkxs2_AtSHbb9ls1HMlslWUvB-7nZqXvlofoxsM4oCeLPZFT68s9krJlccRZ_fNvqu6zra8HHOy0LFO5JeoOl8OatinQUvS8Mhp8Y-RYPKg1UIL6YYd6dgn1RV1zMcZFUrUYLe4PE0aaoL-SOOEGuWHuXUSWm6FBby13LKa8BMvWxezM7GSazY9JELzaut5vU8qsRkozaiXtfcfPL-LqYe1g9WW7XOiW8S72fJk9Q58s93R7IZKxndcKCebKyi6jjb4VOobrCp6iMilq8pqMnRZJtJ_nP2Hy6hkTVQO190sGNWIgx6kuhRkGPSGl_d_g8XpGlKyGXvUFl1wVqBNen6lftRpkglvS-XHrGW0MNf1wDdndcCYn67DTIRxx3EbVjZiyfCtMbeT_QlHVEJRwYYtrDeu4mj0pDZFppJoCXLKkiX2WcWhRi19NlSOHpSqRQFcP9_G6fFC2HP3zwxGiCHcWDCzHzK4qd9-kan8q5gep4kCblHK9WFDjK9EeVxAtwPssKn06xwnV5yP_ZX_fHvzkmV6hapRtH1eu6ja5aOV2IRXDvgA_RQFxGXc5WrKUkgbu3NtzxJCE9LZUcPb5r5NfbMv9sopMOVO36v6RnpE78vEVcXmZtiY7meA790xwm8JaIk2QU-Rfqm4lvbn8DX5M9Jw==&q={searchTerms}";
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
