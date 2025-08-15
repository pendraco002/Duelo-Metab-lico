import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_constants.dart';
import '../../presentation/pages/splash/splash_page.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/profile/profile_page.dart';
import '../../presentation/pages/game/solo_game_page.dart';
import '../../presentation/pages/game/online_game_page.dart';
import '../../presentation/pages/game/local_game_page.dart';
import '../../presentation/pages/game/game_results_page.dart';
import '../../presentation/pages/leaderboard/leaderboard_page.dart';
import '../../presentation/pages/achievements/achievements_page.dart';
import '../../presentation/pages/settings/settings_page.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppConstants.splashRoute,
    debugLogDiagnostics: true,
    redirect: _guard,
    routes: [
      // Splash Route
      GoRoute(
        path: AppConstants.splashRoute,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),

      // Shell Navigation (Bottom Navigation)
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return Scaffold(
            body: child,
            bottomNavigationBar: _buildBottomNavigation(context, state),
          );
        },
        routes: [
          // Home
          GoRoute(
            path: AppConstants.homeRoute,
            name: 'home',
            builder: (context, state) => const HomePage(),
            routes: [
              // Game Routes
              GoRoute(
                path: '/solo-game',
                name: 'solo-game',
                builder: (context, state) => const SoloGamePage(),
                routes: [
                  GoRoute(
                    path: '/results',
                    name: 'solo-game-results',
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      return GameResultsPage(
                        gameResults: extra?['results'],
                        gameMode: extra?['mode'],
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: '/online-game',
                name: 'online-game',
                builder: (context, state) => const OnlineGamePage(),
                routes: [
                  GoRoute(
                    path: '/results',
                    name: 'online-game-results',
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      return GameResultsPage(
                        gameResults: extra?['results'],
                        gameMode: extra?['mode'],
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: '/local-game',
                name: 'local-game',
                builder: (context, state) => const LocalGamePage(),
                routes: [
                  GoRoute(
                    path: '/results',
                    name: 'local-game-results',
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      return GameResultsPage(
                        gameResults: extra?['results'],
                        gameMode: extra?['mode'],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // Profile
          GoRoute(
            path: AppConstants.profileRoute,
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),

          // Leaderboard
          GoRoute(
            path: AppConstants.leaderboardRoute,
            name: 'leaderboard',
            builder: (context, state) => const LeaderboardPage(),
          ),

          // Achievements
          GoRoute(
            path: AppConstants.achievementsRoute,
            name: 'achievements',
            builder: (context, state) => const AchievementsPage(),
          ),

          // Settings
          GoRoute(
            path: AppConstants.settingsRoute,
            name: 'settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Página não encontrada',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'A página que você está procurando não existe.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppConstants.homeRoute),
              child: const Text('Voltar ao Início'),
            ),
          ],
        ),
      ),
    ),
  );

  // Navigation Guard
  static String? _guard(BuildContext context, GoRouterState state) {
    final authState = context.read<AuthBloc>().state;
    final isOnSplash = state.matchedLocation == AppConstants.splashRoute;
    final isAuthenticated = authState is AuthenticatedState;

    // If not authenticated and not on splash, redirect to splash
    if (!isAuthenticated && !isOnSplash) {
      return AppConstants.splashRoute;
    }

    // If authenticated and on splash, redirect to home
    if (isAuthenticated && isOnSplash) {
      return AppConstants.homeRoute;
    }

    return null;
  }

  // Bottom Navigation
  static Widget _buildBottomNavigation(BuildContext context, GoRouterState state) {
    final currentIndex = _calculateSelectedIndex(state.matchedLocation);

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) => _onDestinationSelected(context, index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Início',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Perfil',
        ),
        NavigationDestination(
          icon: Icon(Icons.leaderboard_outlined),
          selectedIcon: Icon(Icons.leaderboard),
          label: 'Ranking',
        ),
        NavigationDestination(
          icon: Icon(Icons.emoji_events_outlined),
          selectedIcon: Icon(Icons.emoji_events),
          label: 'Conquistas',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: 'Configurações',
        ),
      ],
    );
  }

  static int _calculateSelectedIndex(String location) {
    if (location.startsWith(AppConstants.homeRoute)) return 0;
    if (location.startsWith(AppConstants.profileRoute)) return 1;
    if (location.startsWith(AppConstants.leaderboardRoute)) return 2;
    if (location.startsWith(AppConstants.achievementsRoute)) return 3;
    if (location.startsWith(AppConstants.settingsRoute)) return 4;
    return 0;
  }

  static void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(AppConstants.homeRoute);
        break;
      case 1:
        context.go(AppConstants.profileRoute);
        break;
      case 2:
        context.go(AppConstants.leaderboardRoute);
        break;
      case 3:
        context.go(AppConstants.achievementsRoute);
        break;
      case 4:
        context.go(AppConstants.settingsRoute);
        break;
    }
  }
}

// Custom Page Transitions
class SlideTransitionPage extends CustomTransitionPage {
  const SlideTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
  }) : super(
          transitionsBuilder: _slideTransition,
          transitionDuration: AppConstants.pageTransition,
          reverseTransitionDuration: AppConstants.pageTransition,
        );

  static Widget _slideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: animation.drive(
        Tween(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOut)),
      ),
      child: child,
    );
  }
}

class FadeTransitionPage extends CustomTransitionPage {
  const FadeTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
  }) : super(
          transitionsBuilder: _fadeTransition,
          transitionDuration: AppConstants.pageTransition,
          reverseTransitionDuration: AppConstants.pageTransition,
        );

  static Widget _fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation.drive(
        CurveTween(curve: Curves.easeInOut),
      ),
      child: child,
    );
  }
}