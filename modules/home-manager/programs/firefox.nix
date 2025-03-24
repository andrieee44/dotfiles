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

      extensions = {
        force = true;

        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          ublock-origin
          vimium
        ];
      };

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
        "general.useragent.override" =
          "Mozilla/5.0 (Windows NT 10.0 Win64; x64 AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.3";
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

      search = {
        default = "Brave";
        privateDefault = "Brave";
        force = true;

        engines = {
          google.metaData.hidden = true;
          bing.metaData.hidden = true;
          ddg.metaData.hidden = true;
          wikipedia.metaData.hidden = true;

          Brave = {
            urls = [ { template = "https://search.brave.com/search?q={searchTerms}"; } ];
            icon = "https://brave.com/favicon.ico";
            updateInterval = 24 * 60 * 60 * 1000;
          };
        };
      };
    };
  };
}
