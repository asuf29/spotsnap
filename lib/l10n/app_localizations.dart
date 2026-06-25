import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'SnapSpot'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get navDiscover;

  /// No description provided for @navPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get navPlan;

  /// No description provided for @navCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get navCreate;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @readyToShoot.
  ///
  /// In en, this message translates to:
  /// **'Ready to shoot?'**
  String get readyToShoot;

  /// No description provided for @trendingCities.
  ///
  /// In en, this message translates to:
  /// **'Trending cities'**
  String get trendingCities;

  /// No description provided for @forYou.
  ///
  /// In en, this message translates to:
  /// **'For you'**
  String get forYou;

  /// No description provided for @searchCityHint.
  ///
  /// In en, this message translates to:
  /// **'Search city or country…'**
  String get searchCityHint;

  /// No description provided for @whereShooting.
  ///
  /// In en, this message translates to:
  /// **'Where are you shooting?'**
  String get whereShooting;

  /// No description provided for @whereShootingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a city to explore photo spots, poses & routes.'**
  String get whereShootingSubtitle;

  /// No description provided for @trending.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trending;

  /// No description provided for @featuredWorldwide.
  ///
  /// In en, this message translates to:
  /// **'Featured worldwide'**
  String get featuredWorldwide;

  /// No description provided for @smartRoute.
  ///
  /// In en, this message translates to:
  /// **'Smart Route'**
  String get smartRoute;

  /// No description provided for @selectSpotsRoute.
  ///
  /// In en, this message translates to:
  /// **'Select spots to build your shoot day.'**
  String get selectSpotsRoute;

  /// No description provided for @selectSpotsOrCity.
  ///
  /// In en, this message translates to:
  /// **'Pick a city in Discover or select featured spots.'**
  String get selectSpotsOrCity;

  /// No description provided for @prioritizeGoldenHour.
  ///
  /// In en, this message translates to:
  /// **'Prioritize golden hour'**
  String get prioritizeGoldenHour;

  /// No description provided for @prioritizeGoldenHourSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sort sunrise & sunset spots first'**
  String get prioritizeGoldenHourSubtitle;

  /// No description provided for @generateRoute.
  ///
  /// In en, this message translates to:
  /// **'Generate Route'**
  String get generateRoute;

  /// No description provided for @generateRouteCount.
  ///
  /// In en, this message translates to:
  /// **'Generate Route ({count})'**
  String generateRouteCount(int count);

  /// No description provided for @selectSpotsFirst.
  ///
  /// In en, this message translates to:
  /// **'Select spots first'**
  String get selectSpotsFirst;

  /// No description provided for @routeOptimized.
  ///
  /// In en, this message translates to:
  /// **'Route optimized for golden hour'**
  String get routeOptimized;

  /// No description provided for @viewFirstStop.
  ///
  /// In en, this message translates to:
  /// **'View first stop'**
  String get viewFirstStop;

  /// No description provided for @minWalk.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min walk'**
  String minWalk(int minutes);

  /// No description provided for @createTitle.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createTitle;

  /// No description provided for @createSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pose, outfit & on-location AI guidance.'**
  String get createSubtitle;

  /// No description provided for @poseAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Pose Assistant'**
  String get poseAssistant;

  /// No description provided for @poseAssistantSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Vibe-based poses, lens & angle tips'**
  String get poseAssistantSubtitle;

  /// No description provided for @posesForSpot.
  ///
  /// In en, this message translates to:
  /// **'Poses for {spotName}'**
  String posesForSpot(String spotName);

  /// No description provided for @allVibes.
  ///
  /// In en, this message translates to:
  /// **'All vibes'**
  String get allVibes;

  /// No description provided for @noPosesFilter.
  ///
  /// In en, this message translates to:
  /// **'No poses for this filter.'**
  String get noPosesFilter;

  /// No description provided for @outfitPlanner.
  ///
  /// In en, this message translates to:
  /// **'Outfit Planner'**
  String get outfitPlanner;

  /// No description provided for @outfitPlannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Concept looks, color harmony & wardrobe'**
  String get outfitPlannerSubtitle;

  /// No description provided for @photoConcepts.
  ///
  /// In en, this message translates to:
  /// **'Photo concepts'**
  String get photoConcepts;

  /// No description provided for @yourWardrobe.
  ///
  /// In en, this message translates to:
  /// **'Your wardrobe'**
  String get yourWardrobe;

  /// No description provided for @aiOutfitSuggestion.
  ///
  /// In en, this message translates to:
  /// **'AI outfit suggestion'**
  String get aiOutfitSuggestion;

  /// No description provided for @photoAssistant.
  ///
  /// In en, this message translates to:
  /// **'AI Photo Assistant'**
  String get photoAssistant;

  /// No description provided for @photoAssistantSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Ask before you shoot — pose, lens, crowd'**
  String get photoAssistantSubtitle;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @addToRoute.
  ///
  /// In en, this message translates to:
  /// **'Add to Route'**
  String get addToRoute;

  /// No description provided for @spotNotFound.
  ///
  /// In en, this message translates to:
  /// **'Spot not found'**
  String get spotNotFound;

  /// No description provided for @pose.
  ///
  /// In en, this message translates to:
  /// **'Pose'**
  String get pose;

  /// No description provided for @outfit.
  ///
  /// In en, this message translates to:
  /// **'Outfit'**
  String get outfit;

  /// No description provided for @noSpotsCategory.
  ///
  /// In en, this message translates to:
  /// **'No spots in this category'**
  String get noSpotsCategory;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @route.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get route;

  /// No description provided for @tapForDetails.
  ///
  /// In en, this message translates to:
  /// **'Tap for details →'**
  String get tapForDetails;

  /// No description provided for @profileGuest.
  ///
  /// In en, this message translates to:
  /// **'Guest'**
  String get profileGuest;

  /// No description provided for @collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get collections;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @bucketList.
  ///
  /// In en, this message translates to:
  /// **'Travel bucket list'**
  String get bucketList;

  /// No description provided for @savedCities.
  ///
  /// In en, this message translates to:
  /// **'Saved cities'**
  String get savedCities;

  /// No description provided for @moodboards.
  ///
  /// In en, this message translates to:
  /// **'Moodboards'**
  String get moodboards;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @shareSpot.
  ///
  /// In en, this message translates to:
  /// **'Share a spot'**
  String get shareSpot;

  /// No description provided for @submitHiddenGems.
  ///
  /// In en, this message translates to:
  /// **'Submit hidden gems'**
  String get submitHiddenGems;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageTurkish.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get languageTurkish;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @premiumTitle.
  ///
  /// In en, this message translates to:
  /// **'Create viral content\nwithout limits'**
  String get premiumTitle;

  /// No description provided for @premiumSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Everything you need for aesthetic travel shoots.'**
  String get premiumSubtitle;

  /// No description provided for @unlockPremium.
  ///
  /// In en, this message translates to:
  /// **'Unlock AI routes & unlimited poses'**
  String get unlockPremium;

  /// No description provided for @startFreeTrial.
  ///
  /// In en, this message translates to:
  /// **'Start 7-day free trial'**
  String get startFreeTrial;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restorePurchases;

  /// No description provided for @cancelAnytime.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime. Restore purchases on device.'**
  String get cancelAnytime;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @signInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to plan your next viral shoot.'**
  String get signInSubtitle;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @continueGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueGuest;

  /// No description provided for @continueApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueApple;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Find your shot'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover the most Instagrammable spots in any city.'**
  String get onboarding1Subtitle;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Pose like a pro'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'AI-powered pose suggestions for every vibe.'**
  String get onboarding2Subtitle;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Plan the perfect day'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Smart routes timed for golden hour.'**
  String get onboarding3Subtitle;

  /// No description provided for @continuePage.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continuePage;

  /// No description provided for @spotsSaved.
  ///
  /// In en, this message translates to:
  /// **'{count} spots saved'**
  String spotsSaved(int count);

  /// No description provided for @destinationsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} destinations'**
  String destinationsCount(int count);

  /// No description provided for @boardsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} boards'**
  String boardsCount(int count);

  /// No description provided for @citiesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} cities'**
  String citiesCount(int count);

  /// No description provided for @goldenHourAlerts.
  ///
  /// In en, this message translates to:
  /// **'Golden hour alerts'**
  String get goldenHourAlerts;

  /// No description provided for @goldenHourAlertsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Daily reminder before best shoot light'**
  String get goldenHourAlertsSubtitle;

  /// No description provided for @notificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications enabled'**
  String get notificationsEnabled;

  /// No description provided for @notificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications disabled'**
  String get notificationsDisabled;

  /// No description provided for @premiumActive.
  ///
  /// In en, this message translates to:
  /// **'SnapSpot+ active'**
  String get premiumActive;

  /// No description provided for @demoPurchaseSuccess.
  ///
  /// In en, this message translates to:
  /// **'SnapSpot+ unlocked (demo)'**
  String get demoPurchaseSuccess;

  /// No description provided for @demoPurchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase could not be completed'**
  String get demoPurchaseFailed;

  /// No description provided for @shareSpotTitle.
  ///
  /// In en, this message translates to:
  /// **'Check out {spotName} on SnapSpot!'**
  String shareSpotTitle(String spotName);

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
