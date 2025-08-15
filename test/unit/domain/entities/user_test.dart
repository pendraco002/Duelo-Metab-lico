import 'package:flutter_test/flutter_test.dart';
import 'package:duelo_metabolico/domain/entities/user.dart';

void main() {
  group('User Entity Tests', () {
    late User testUser;
    late UserLevel testLevel;
    late UserStatistics testStatistics;
    late GameSettings testSettings;

    setUp(() {
      testLevel = const UserLevel(
        currentLevel: 5,
        currentXP: 1250,
        xpToNextLevel: 500,
        levelTitle: 'Liga Bronze',
        badgeIcon: 'bronze_badge',
      );

      testStatistics = const UserStatistics(
        totalGames: 42,
        gamesWon: 28,
        gamesLost: 14,
        totalScore: 8400,
        bestScore: 950,
        winStreak: 3,
        longestWinStreak: 7,
        averageResponseTime: 12.5,
        correctAnswers: 156,
        totalAnswers: 210,
        categoryStats: {
          'metabolismo': 85,
          'nutricao_clinica': 72,
          'nutricao_esportiva': 90,
        },
      );

      testSettings = const GameSettings();

      testUser = User(
        id: 'test_user_1',
        name: 'Test User',
        email: 'test@example.com',
        avatar: 'test_avatar.png',
        level: testLevel,
        statistics: testStatistics,
        achievements: [],
        preferences: testSettings,
        createdAt: DateTime(2023, 1, 1),
        lastActiveAt: DateTime(2023, 12, 31),
      );
    });

    test('should create User with all required fields', () {
      expect(testUser.id, 'test_user_1');
      expect(testUser.name, 'Test User');
      expect(testUser.email, 'test@example.com');
      expect(testUser.avatar, 'test_avatar.png');
      expect(testUser.level, testLevel);
      expect(testUser.statistics, testStatistics);
      expect(testUser.achievements, isEmpty);
      expect(testUser.preferences, testSettings);
    });

    test('should serialize to JSON correctly', () {
      final json = testUser.toJson();
      
      expect(json['id'], 'test_user_1');
      expect(json['name'], 'Test User');
      expect(json['email'], 'test@example.com');
      expect(json['level'], isA<Map<String, dynamic>>());
      expect(json['statistics'], isA<Map<String, dynamic>>());
    });

    test('should deserialize from JSON correctly', () {
      final json = testUser.toJson();
      final deserializedUser = User.fromJson(json);
      
      expect(deserializedUser.id, testUser.id);
      expect(deserializedUser.name, testUser.name);
      expect(deserializedUser.email, testUser.email);
      expect(deserializedUser.level.currentLevel, testUser.level.currentLevel);
      expect(deserializedUser.statistics.totalGames, testUser.statistics.totalGames);
    });

    test('should support copyWith functionality', () {
      final updatedUser = testUser.copyWith(
        name: 'Updated Name',
        email: 'updated@example.com',
      );
      
      expect(updatedUser.name, 'Updated Name');
      expect(updatedUser.email, 'updated@example.com');
      expect(updatedUser.id, testUser.id); // Should remain unchanged
      expect(updatedUser.level, testUser.level); // Should remain unchanged
    });
  });

  group('UserStatistics Tests', () {
    test('should calculate win rate correctly', () {
      const statistics = UserStatistics(
        totalGames: 100,
        gamesWon: 70,
        gamesLost: 30,
        totalScore: 10000,
        bestScore: 950,
        winStreak: 5,
        longestWinStreak: 12,
        averageResponseTime: 15.0,
        correctAnswers: 350,
        totalAnswers: 500,
        categoryStats: {},
      );
      
      expect(statistics.winRate, 70.0);
    });

    test('should calculate accuracy correctly', () {
      const statistics = UserStatistics(
        totalGames: 50,
        gamesWon: 30,
        gamesLost: 20,
        totalScore: 5000,
        bestScore: 800,
        winStreak: 3,
        longestWinStreak: 8,
        averageResponseTime: 12.0,
        correctAnswers: 200,
        totalAnswers: 250,
        categoryStats: {},
      );
      
      expect(statistics.accuracy, 80.0);
    });

    test('should handle zero games for win rate', () {
      const statistics = UserStatistics(
        totalGames: 0,
        gamesWon: 0,
        gamesLost: 0,
        totalScore: 0,
        bestScore: 0,
        winStreak: 0,
        longestWinStreak: 0,
        averageResponseTime: 0.0,
        correctAnswers: 0,
        totalAnswers: 0,
        categoryStats: {},
      );
      
      expect(statistics.winRate, 0.0);
      expect(statistics.accuracy, 0.0);
    });
  });

  group('GameSettings Tests', () {
    test('should create with default values', () {
      const settings = GameSettings();
      
      expect(settings.soundEnabled, true);
      expect(settings.musicEnabled, true);
      expect(settings.vibrationEnabled, true);
      expect(settings.notificationsEnabled, true);
      expect(settings.questionTimeLimit, 30);
      expect(settings.difficulty, 'medium');
      expect(settings.preferredCategories, 'all');
      expect(settings.language, 'portuguese');
    });

    test('should allow custom values', () {
      const settings = GameSettings(
        soundEnabled: false,
        musicEnabled: false,
        questionTimeLimit: 45,
        difficulty: 'hard',
        language: 'english',
      );
      
      expect(settings.soundEnabled, false);
      expect(settings.musicEnabled, false);
      expect(settings.questionTimeLimit, 45);
      expect(settings.difficulty, 'hard');
      expect(settings.language, 'english');
    });
  });

  group('Achievement Tests', () {
    test('should create Achievement with all fields', () {
      final achievement = Achievement(
        id: 'ach_001',
        title: 'First Victory',
        description: 'Win your first duel',
        iconPath: 'assets/icons/first_victory.png',
        type: AchievementType.gamesWon,
        progress: 1,
        target: 1,
        isCompleted: true,
        completedAt: DateTime(2023, 6, 15),
        xpReward: 100,
      );
      
      expect(achievement.id, 'ach_001');
      expect(achievement.title, 'First Victory');
      expect(achievement.isCompleted, true);
      expect(achievement.progress, achievement.target);
      expect(achievement.xpReward, 100);
    });

    test('should handle incomplete achievement', () {
      final achievement = Achievement(
        id: 'ach_002',
        title: 'Win Streak',
        description: 'Win 5 games in a row',
        iconPath: 'assets/icons/win_streak.png',
        type: AchievementType.winStreak,
        progress: 3,
        target: 5,
        isCompleted: false,
        completedAt: null,
        xpReward: 250,
      );
      
      expect(achievement.isCompleted, false);
      expect(achievement.completedAt, null);
      expect(achievement.progress < achievement.target, true);
    });
  });
}