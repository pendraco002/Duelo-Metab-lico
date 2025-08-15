import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    required String avatar,
    required UserLevel level,
    required UserStatistics statistics,
    required List<Achievement> achievements,
    required GameSettings preferences,
    required DateTime createdAt,
    required DateTime lastActiveAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class UserLevel with _$UserLevel {
  const factory UserLevel({
    required int currentLevel,
    required int currentXP,
    required int xpToNextLevel,
    required String levelTitle,
    required String badgeIcon,
  }) = _UserLevel;

  factory UserLevel.fromJson(Map<String, dynamic> json) => _$UserLevelFromJson(json);
}

@freezed
class UserStatistics with _$UserStatistics {
  const factory UserStatistics({
    required int totalGames,
    required int gamesWon,
    required int gamesLost,
    required int totalScore,
    required int bestScore,
    required int winStreak,
    required int longestWinStreak,
    required double averageResponseTime,
    required int correctAnswers,
    required int totalAnswers,
    required Map<String, int> categoryStats,
  }) = _UserStatistics;

  factory UserStatistics.fromJson(Map<String, dynamic> json) => _$UserStatisticsFromJson(json);

  // Calculated properties
  const UserStatistics._();
  
  double get winRate => totalGames > 0 ? (gamesWon / totalGames) * 100 : 0.0;
  double get accuracy => totalAnswers > 0 ? (correctAnswers / totalAnswers) * 100 : 0.0;
}

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required String iconPath,
    required AchievementType type,
    required int progress,
    required int target,
    required bool isCompleted,
    required DateTime? completedAt,
    required int xpReward,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);
}

enum AchievementType {
  @JsonValue('games_won')
  gamesWon,
  @JsonValue('win_streak')
  winStreak,
  @JsonValue('perfect_game')
  perfectGame,
  @JsonValue('speed_demon')
  speedDemon,
  @JsonValue('knowledge_master')
  knowledgeMaster,
  @JsonValue('social_player')
  socialPlayer,
}

@freezed
class GameSettings with _$GameSettings {
  const factory GameSettings({
    @Default(true) bool soundEnabled,
    @Default(true) bool musicEnabled,
    @Default(true) bool vibrationEnabled,
    @Default(true) bool notificationsEnabled,
    @Default(30) int questionTimeLimit,
    @Default('medium') String difficulty,
    @Default('all') String preferredCategories,
    @Default('portuguese') String language,
  }) = _GameSettings;

  factory GameSettings.fromJson(Map<String, dynamic> json) => _$GameSettingsFromJson(json);
}