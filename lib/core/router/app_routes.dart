class AppRoutes {
  AppRoutes._();

  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';

  static const home = '/home';
  static const discover = '/discover';
  static const plan = '/plan';
  static const create = '/create';
  static const profile = '/profile';

  static const spotDetail = '/spot/:id';
  static String spotDetailPath(String id) => '/spot/$id';

  static const designSystem = '/design-system';
  static const poseAssistant = '/pose';
  static const outfitPlanner = '/outfit';
  static const photoAssistant = '/photo-assistant';

  static const favorites = '/favorites';
  static const bucketList = '/bucket-list';
  static const savedCities = '/saved-cities';
  static const moodboards = '/moodboards';
  static const moodboardDetail = '/moodboard/:id';
  static String moodboardDetailPath(String id) => '/moodboard/$id';
  static const submitSpot = '/submit-spot';
  static const premium = '/premium';
}
