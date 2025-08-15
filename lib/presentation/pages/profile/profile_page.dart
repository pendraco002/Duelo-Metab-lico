import 'package:flutter/material.dart';
import '../../widgets/animated_background.dart';
import '../../../core/theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 64,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Perfil do Usuário',
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