import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:duelo_metabolico/presentation/bloc/auth/auth_bloc.dart';
import 'package:duelo_metabolico/domain/entities/user.dart';
import 'package:duelo_metabolico/domain/usecases/auth/login_usecase.dart';
import 'package:duelo_metabolico/domain/usecases/auth/logout_usecase.dart';
import 'package:duelo_metabolico/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:duelo_metabolico/core/errors/failure.dart';

// Mock classes
class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockLogoutUseCase extends Mock implements LogoutUseCase {}
class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

void main() {
  group('AuthBloc Tests', () {
    late AuthBloc authBloc;
    late MockLoginUseCase mockLoginUseCase;
    late MockLogoutUseCase mockLogoutUseCase;
    late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;
    late User testUser;

    setUp(() {
      mockLoginUseCase = MockLoginUseCase();
      mockLogoutUseCase = MockLogoutUseCase();
      mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
      
      authBloc = AuthBloc(
        mockLoginUseCase,
        mockLogoutUseCase,
        mockGetCurrentUserUseCase,
      );

      testUser = User(
        id: 'test_user',
        name: 'Test User',
        email: 'test@example.com',
        avatar: '',
        level: const UserLevel(
          currentLevel: 1,
          currentXP: 0,
          xpToNextLevel: 100,
          levelTitle: 'Iniciante',
          badgeIcon: 'beginner_badge',
        ),
        statistics: const UserStatistics(
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
        ),
        achievements: [],
        preferences: const GameSettings(),
        createdAt: DateTime.now(),
        lastActiveAt: DateTime.now(),
      );
    });

    tearDown(() {
      authBloc.close();
    });

    test('initial state should be AuthInitial', () {
      expect(authBloc.state, const AuthInitial());
    });

    group('AuthCheckRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when user is found',
        build: () {
          when(() => mockGetCurrentUserUseCase())
              .thenAnswer((_) async => Right(testUser));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthCheckRequested()),
        expect: () => [
          const AuthLoading(),
          AuthAuthenticated(testUser),
        ],
        verify: (_) {
          verify(() => mockGetCurrentUserUseCase()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when user is not found',
        build: () {
          when(() => mockGetCurrentUserUseCase())
              .thenAnswer((_) async => const Left(Failure('User not found')));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthCheckRequested()),
        expect: () => [
          const AuthLoading(),
          const AuthUnauthenticated(),
        ],
        verify: (_) {
          verify(() => mockGetCurrentUserUseCase()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when exception occurs',
        build: () {
          when(() => mockGetCurrentUserUseCase())
              .thenThrow(Exception('Network error'));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthCheckRequested()),
        expect: () => [
          const AuthLoading(),
          const AuthUnauthenticated(),
        ],
        verify: (_) {
          verify(() => mockGetCurrentUserUseCase()).called(1);
        },
      );
    });

    group('AuthLoginRequested', () {
      const email = 'test@example.com';
      const password = 'password123';

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when login succeeds',
        build: () {
          when(() => mockLoginUseCase(any()))
              .thenAnswer((_) async => Right(testUser));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          const AuthLoginRequested(email: email, password: password),
        ),
        expect: () => [
          const AuthLoading(),
          AuthAuthenticated(testUser),
        ],
        verify: (_) {
          verify(() => mockLoginUseCase(
            const LoginParams(email: email, password: password),
          )).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when login fails',
        build: () {
          when(() => mockLoginUseCase(any()))
              .thenAnswer((_) async => const Left(Failure('Invalid credentials')));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          const AuthLoginRequested(email: email, password: password),
        ),
        expect: () => [
          const AuthLoading(),
          const AuthError('Invalid credentials'),
        ],
        verify: (_) {
          verify(() => mockLoginUseCase(
            const LoginParams(email: email, password: password),
          )).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when exception occurs during login',
        build: () {
          when(() => mockLoginUseCase(any()))
              .thenThrow(Exception('Network error'));
          return authBloc;
        },
        act: (bloc) => bloc.add(
          const AuthLoginRequested(email: email, password: password),
        ),
        expect: () => [
          const AuthLoading(),
          const AuthError('Exception: Network error'),
        ],
        verify: (_) {
          verify(() => mockLoginUseCase(any())).called(1);
        },
      );
    });

    group('AuthLogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when logout succeeds',
        build: () {
          when(() => mockLogoutUseCase())
              .thenAnswer((_) async => const Right(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthLogoutRequested()),
        expect: () => [
          const AuthLoading(),
          const AuthUnauthenticated(),
        ],
        verify: (_) {
          verify(() => mockLogoutUseCase()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when logout fails',
        build: () {
          when(() => mockLogoutUseCase())
              .thenAnswer((_) async => const Left(Failure('Logout failed')));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthLogoutRequested()),
        expect: () => [
          const AuthLoading(),
          const AuthError('Logout failed'),
        ],
        verify: (_) {
          verify(() => mockLogoutUseCase()).called(1);
        },
      );
    });

    group('AuthUserUpdated', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthAuthenticated] with updated user',
        build: () => authBloc,
        act: (bloc) => bloc.add(AuthUserUpdated(testUser)),
        expect: () => [
          AuthAuthenticated(testUser),
        ],
      );
    });

    group('AuthState Extensions', () {
      test('AuthStateExtension should work correctly', () {
        const initialState = AuthInitial();
        const loadingState = AuthLoading();
        final authenticatedState = AuthAuthenticated(testUser);
        const unauthenticatedState = AuthUnauthenticated();
        const errorState = AuthError('Test error');

        // Test isAuthenticated
        expect(initialState.isAuthenticated, false);
        expect(loadingState.isAuthenticated, false);
        expect(authenticatedState.isAuthenticated, true);
        expect(unauthenticatedState.isAuthenticated, false);
        expect(errorState.isAuthenticated, false);

        // Test isUnauthenticated
        expect(unauthenticatedState.isUnauthenticated, true);
        expect(authenticatedState.isUnauthenticated, false);

        // Test isLoading
        expect(loadingState.isLoading, true);
        expect(initialState.isLoading, false);

        // Test hasError
        expect(errorState.hasError, true);
        expect(loadingState.hasError, false);

        // Test user getter
        expect(authenticatedState.user, testUser);
        expect(initialState.user, null);

        // Test errorMessage getter
        expect(errorState.errorMessage, 'Test error');
        expect(loadingState.errorMessage, null);
      });
    });
  });
}