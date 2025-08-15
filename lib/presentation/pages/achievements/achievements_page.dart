import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events,
              size: 64,
              color: AppTheme.warningColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Conquistas',
              style: AppTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Em desenvolvimento...',
              style: AppTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}