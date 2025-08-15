import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/animated_background.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _backgroundController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // Auto login after animation
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _performAutoLogin();
      }
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  void _performAutoLogin() {
    // Simulate auto login for demo
    context.read<AuthBloc>().add(const AuthLoginRequested(
      email: 'rennan@example.com',
      password: 'demo123',
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(AppConstants.homeRoute);
        }
      },
      child: Scaffold(
        body: AnimatedBackground(
          controller: _backgroundController,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: AppTheme.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.local_fire_department,
                    size: 60,
                    color: Colors.white,
                  ),
                )
                    .animate()
                    .scale(
                      duration: 800.ms,
                      curve: Curves.elasticOut,
                    )
                    .then()
                    .shimmer(
                      duration: 1500.ms,
                      color: Colors.white.withOpacity(0.5),
                    ),

                const SizedBox(height: 40),

                // App Name
                Text(
                  AppConstants.appName,
                  style: AppTheme.displayLarge.copyWith(
                    foreground: Paint()
                      ..shader = AppTheme.primaryGradient.createShader(
                        const Rect.fromLTWH(0, 0, 300, 80),
                      ),
                  ),
                )
                    .animate(delay: 500.ms)
                    .fadeIn(duration: 800.ms)
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 16),

                // App Description
                Text(
                  AppConstants.appDescription,
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                )
                    .animate(delay: 800.ms)
                    .fadeIn(duration: 800.ms)
                    .slideY(begin: 0.3, end: 0),

                const SizedBox(height: 60),

                // Loading Indicator
                SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    backgroundColor: AppTheme.surfaceColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryColor,
                    ),
                  ),
                )
                    .animate(delay: 1200.ms)
                    .fadeIn(duration: 600.ms)
                    .scale(begin: const Offset(0.8, 1.0)),

                const SizedBox(height: 20),

                // Loading Text
                Text(
                  'Preparando a arena...',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textTertiary,
                  ),
                )
                    .animate(delay: 1400.ms)
                    .fadeIn(duration: 600.ms)
                    .then()
                    .animate(onPlay: (controller) => controller.repeat())
                    .fadeOut(duration: 1000.ms)
                    .then()
                    .fadeIn(duration: 1000.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}