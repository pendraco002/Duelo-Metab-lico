import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../entities/user.dart';
import '../../../core/errors/failure.dart';

@injectable
class LoginUseCase {
  Future<Either<Failure, User>> call(LoginParams params) async {
    // Mock implementation
    await Future.delayed(const Duration(seconds: 1));
    
    // Simulate successful login
    return Right(User(
      id: '1',
      name: 'Rennan Lima',
      email: params.email,
      avatar: '',
      level: const UserLevel(
        currentLevel: 5,
        currentXP: 1250,
        xpToNextLevel: 500,
        levelTitle: 'Liga Bronze',
        badgeIcon: 'bronze_badge',
      ),
      statistics: const UserStatistics(
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
      ),
      achievements: [],
      preferences: const GameSettings(),
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lastActiveAt: DateTime.now(),
    ));
  }
}

class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}