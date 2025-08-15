import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.leaderboard,
              size: 64,
              color: AppTheme.warningColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Ranking Global',
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