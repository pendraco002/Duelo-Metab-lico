class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Duelo Metabólico';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Arena de batalhas de conhecimento nutricional';

  // API
  static const String baseUrl = 'https://api.duelometabolico.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 15);

  // Local Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String gameSettingsKey = 'game_settings';
  static const String achievementsKey = 'achievements';
  static const String statisticsKey = 'statistics';

  // Game Configuration
  static const int maxQuestions = 10;
  static const int timePerQuestion = 30; // seconds
  static const int pointsPerCorrectAnswer = 100;
  static const int bonusTimeThreshold = 10; // seconds for bonus
  static const int bonusMultiplier = 2;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
  static const Duration pageTransition = Duration(milliseconds: 300);

  // UI Constants
  static const double borderRadius = 12.0;
  static const double cardElevation = 4.0;
  static const double iconSize = 24.0;
  static const double avatarSize = 48.0;

  // Spacing
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;

  // Routes
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
  static const String soloGameRoute = '/solo-game';
  static const String onlineGameRoute = '/online-game';
  static const String localGameRoute = '/local-game';
  static const String leaderboardRoute = '/leaderboard';
  static const String achievementsRoute = '/achievements';
  static const String settingsRoute = '/settings';
}