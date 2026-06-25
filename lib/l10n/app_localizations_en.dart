// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SnapSpot';

  @override
  String get navHome => 'Home';

  @override
  String get navDiscover => 'Discover';

  @override
  String get navPlan => 'Plan';

  @override
  String get navCreate => 'Create';

  @override
  String get navProfile => 'Profile';

  @override
  String get goodMorning => 'Good morning';

  @override
  String get readyToShoot => 'Ready to shoot?';

  @override
  String get trendingCities => 'Trending cities';

  @override
  String get forYou => 'For you';

  @override
  String get searchCityHint => 'Search city or country…';

  @override
  String get whereShooting => 'Where are you shooting?';

  @override
  String get whereShootingSubtitle =>
      'Pick a city to explore photo spots, poses & routes.';

  @override
  String get trending => 'Trending';

  @override
  String get featuredWorldwide => 'Featured worldwide';

  @override
  String get smartRoute => 'Smart Route';

  @override
  String get selectSpotsRoute => 'Select spots to build your shoot day.';

  @override
  String get selectSpotsOrCity =>
      'Pick a city in Discover or select featured spots.';

  @override
  String get prioritizeGoldenHour => 'Prioritize golden hour';

  @override
  String get prioritizeGoldenHourSubtitle =>
      'Sort sunrise & sunset spots first';

  @override
  String get generateRoute => 'Generate Route';

  @override
  String generateRouteCount(int count) {
    return 'Generate Route ($count)';
  }

  @override
  String get selectSpotsFirst => 'Select spots first';

  @override
  String get routeOptimized => 'Route optimized for golden hour';

  @override
  String get viewFirstStop => 'View first stop';

  @override
  String minWalk(int minutes) {
    return '$minutes min walk';
  }

  @override
  String get createTitle => 'Create';

  @override
  String get createSubtitle => 'Pose, outfit & on-location AI guidance.';

  @override
  String get poseAssistant => 'AI Pose Assistant';

  @override
  String get poseAssistantSubtitle => 'Vibe-based poses, lens & angle tips';

  @override
  String posesForSpot(String spotName) {
    return 'Poses for $spotName';
  }

  @override
  String get allVibes => 'All vibes';

  @override
  String get noPosesFilter => 'No poses for this filter.';

  @override
  String get outfitPlanner => 'Outfit Planner';

  @override
  String get outfitPlannerSubtitle => 'Concept looks, color harmony & wardrobe';

  @override
  String get photoConcepts => 'Photo concepts';

  @override
  String get yourWardrobe => 'Your wardrobe';

  @override
  String get aiOutfitSuggestion => 'AI outfit suggestion';

  @override
  String get photoAssistant => 'AI Photo Assistant';

  @override
  String get photoAssistantSubtitle =>
      'Ask before you shoot — pose, lens, crowd';

  @override
  String get overview => 'Overview';

  @override
  String get addToRoute => 'Add to Route';

  @override
  String get spotNotFound => 'Spot not found';

  @override
  String get pose => 'Pose';

  @override
  String get outfit => 'Outfit';

  @override
  String get noSpotsCategory => 'No spots in this category';

  @override
  String get save => 'Save';

  @override
  String get route => 'Route';

  @override
  String get tapForDetails => 'Tap for details →';

  @override
  String get profileGuest => 'Guest';

  @override
  String get collections => 'Collections';

  @override
  String get favorites => 'Favorites';

  @override
  String get bucketList => 'Travel bucket list';

  @override
  String get savedCities => 'Saved cities';

  @override
  String get moodboards => 'Moodboards';

  @override
  String get community => 'Community';

  @override
  String get shareSpot => 'Share a spot';

  @override
  String get submitHiddenGems => 'Submit hidden gems';

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageTurkish => 'Turkish';

  @override
  String get signOut => 'Sign out';

  @override
  String get premiumTitle => 'Create viral content\nwithout limits';

  @override
  String get premiumSubtitle =>
      'Everything you need for aesthetic travel shoots.';

  @override
  String get unlockPremium => 'Unlock AI routes & unlimited poses';

  @override
  String get startFreeTrial => 'Start 7-day free trial';

  @override
  String get restorePurchases => 'Restore purchases';

  @override
  String get cancelAnytime => 'Cancel anytime. Restore purchases on device.';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get signInSubtitle => 'Sign in to plan your next viral shoot.';

  @override
  String get signIn => 'Sign In';

  @override
  String get continueGuest => 'Continue as guest';

  @override
  String get continueApple => 'Continue with Apple';

  @override
  String get getStarted => 'Get Started';

  @override
  String get skip => 'Skip';

  @override
  String get onboarding1Title => 'Find your shot';

  @override
  String get onboarding1Subtitle =>
      'Discover the most Instagrammable spots in any city.';

  @override
  String get onboarding2Title => 'Pose like a pro';

  @override
  String get onboarding2Subtitle =>
      'AI-powered pose suggestions for every vibe.';

  @override
  String get onboarding3Title => 'Plan the perfect day';

  @override
  String get onboarding3Subtitle => 'Smart routes timed for golden hour.';

  @override
  String get continuePage => 'Continue';

  @override
  String spotsSaved(int count) {
    return '$count spots saved';
  }

  @override
  String destinationsCount(int count) {
    return '$count destinations';
  }

  @override
  String boardsCount(int count) {
    return '$count boards';
  }

  @override
  String citiesCount(int count) {
    return '$count cities';
  }

  @override
  String get goldenHourAlerts => 'Golden hour alerts';

  @override
  String get goldenHourAlertsSubtitle =>
      'Daily reminder before best shoot light';

  @override
  String get notificationsEnabled => 'Notifications enabled';

  @override
  String get notificationsDisabled => 'Notifications disabled';

  @override
  String get premiumActive => 'SnapSpot+ active';

  @override
  String get demoPurchaseSuccess => 'SnapSpot+ unlocked (demo)';

  @override
  String get demoPurchaseFailed => 'Purchase could not be completed';

  @override
  String shareSpotTitle(String spotName) {
    return 'Check out $spotName on SnapSpot!';
  }

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get back => 'Back';

  @override
  String get share => 'Share';
}
