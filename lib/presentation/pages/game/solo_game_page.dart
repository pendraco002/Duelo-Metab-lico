import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SoloGamePage extends StatelessWidget {
  const SoloGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafio Solo'),
      ),
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
              'Modo Solo',
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

class OnlineGamePage extends StatelessWidget {
  const OnlineGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arena Online'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.public,
              size: 64,
              color: AppTheme.errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Arena Online',
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

class LocalGamePage extends StatelessWidget {
  const LocalGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arena Local'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.groups,
              size: 64,
              color: AppTheme.secondaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Arena Local',
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

class GameResultsPage extends StatelessWidget {
  final dynamic gameResults;
  final dynamic gameMode;

  const GameResultsPage({
    super.key,
    this.gameResults,
    this.gameMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
      ),
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
              'Resultados do Jogo',
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