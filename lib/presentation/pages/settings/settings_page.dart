import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              size: 64,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Configurações',
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