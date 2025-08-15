import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
class GameSession with _$GameSession {
  const factory GameSession({
    required String id,
    required GameMode mode,
    required GameStatus status,
    required List<GameQuestion> questions,
    required int currentQuestionIndex,
    required List<Player> players,
    required String currentPlayerId,
    required GameSettings settings,
    required DateTime startedAt,
    DateTime? finishedAt,
    GameResults? results,
  }) = _GameSession;

  factory GameSession.fromJson(Map<String, dynamic> json) => _$GameSessionFromJson(json);

  // Business logic
  const GameSession._();
  
  GameQuestion? get currentQuestion {
    if (currentQuestionIndex < questions.length) {
      return questions[currentQuestionIndex];
    }
    return null;
  }
  
  bool get isFinished => status == GameStatus.finished;
  bool get isActive => status == GameStatus.active;
  int get totalQuestions => questions.length;
  int get remainingQuestions => totalQuestions - currentQuestionIndex;
  
  Duration get elapsedTime {
    if (finishedAt != null) {
      return finishedAt!.difference(startedAt);
    }
    return DateTime.now().difference(startedAt);
  }
}

@freezed
class GameQuestion with _$GameQuestion {
  const factory GameQuestion({
    required String id,
    required String question,
    required List<String> options,
    required int correctAnswerIndex,
    required String category,
    required QuestionDifficulty difficulty,
    required String explanation,
    String? imageUrl,
    Map<String, dynamic>? metadata,
  }) = _GameQuestion;

  factory GameQuestion.fromJson(Map<String, dynamic> json) => _$GameQuestionFromJson(json);

  // Business logic
  const GameQuestion._();
  
  String get correctAnswer => options[correctAnswerIndex];
  
  bool isCorrectAnswer(int selectedIndex) {
    return selectedIndex == correctAnswerIndex;
  }
  
  int get points {
    switch (difficulty) {
      case QuestionDifficulty.easy:
        return 100;
      case QuestionDifficulty.medium:
        return 200;
      case QuestionDifficulty.hard:
        return 300;
    }
  }
}

@freezed
class Player with _$Player {
  const factory Player({
    required String id,
    required String name,
    required String avatar,
    required int score,
    required int correctAnswers,
    required int wrongAnswers,
    required List<PlayerAnswer> answers,
    required double averageResponseTime,
    required bool isReady,
  }) = _Player;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  // Business logic
  const Player._();
  
  int get totalAnswers => correctAnswers + wrongAnswers;
  double get accuracy => totalAnswers > 0 ? (correctAnswers / totalAnswers) * 100 : 0.0;
}

@freezed
class PlayerAnswer with _$PlayerAnswer {
  const factory PlayerAnswer({
    required String questionId,
    required int selectedAnswerIndex,
    required bool isCorrect,
    required Duration responseTime,
    required DateTime answeredAt,
    required int pointsEarned,
  }) = _PlayerAnswer;

  factory PlayerAnswer.fromJson(Map<String, dynamic> json) => _$PlayerAnswerFromJson(json);
}

@freezed
class GameResults with _$GameResults {
  const factory GameResults({
    required String winnerId,
    required List<PlayerResult> playerResults,
    required Duration totalDuration,
    required GameStatistics statistics,
    required List<Achievement> achievementsEarned,
  }) = _GameResults;

  factory GameResults.fromJson(Map<String, dynamic> json) => _$GameResultsFromJson(json);
}

@freezed
class PlayerResult with _$PlayerResult {
  const factory PlayerResult({
    required String playerId,
    required String playerName,
    required int finalScore,
    required int correctAnswers,
    required int totalQuestions,
    required double accuracy,
    required double averageResponseTime,
    required int rank,
    required bool isWinner,
    required int xpEarned,
  }) = _PlayerResult;

  factory PlayerResult.fromJson(Map<String, dynamic> json) => _$PlayerResultFromJson(json);
}

@freezed
class GameStatistics with _$GameStatistics {
  const factory GameStatistics({
    required double averageScore,
    required double averageAccuracy,
    required Duration averageGameDuration,
    required Map<String, int> categoryPerformance,
    required QuestionDifficulty hardestQuestionDifficulty,
    required String mostMissedCategory,
  }) = _GameStatistics;

  factory GameStatistics.fromJson(Map<String, dynamic> json) => _$GameStatisticsFromJson(json);
}

enum GameMode {
  @JsonValue('solo')
  solo,
  @JsonValue('online')
  online,
  @JsonValue('local')
  local,
  @JsonValue('tournament')
  tournament,
}

enum GameStatus {
  @JsonValue('waiting')
  waiting,
  @JsonValue('active')
  active,
  @JsonValue('paused')
  paused,
  @JsonValue('finished')
  finished,
  @JsonValue('cancelled')
  cancelled,
}

enum QuestionDifficulty {
  @JsonValue('easy')
  easy,
  @JsonValue('medium')
  medium,
  @JsonValue('hard')
  hard,
}