import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';

class RecentDuelsSection extends StatelessWidget {
  const RecentDuelsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacing24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.history,
                color: AppTheme.textSecondary,
                size: 24,
              ),
              const SizedBox(width: AppConstants.spacing8),
              Text(
                'Duelos Recentes',
                style: AppTheme.headlineMedium,
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing16),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.spacing32),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              border: Border.all(
                color: AppTheme.surfaceColor,
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.emoji_events_outlined,
                  size: 48,
                  color: AppTheme.textTertiary,
                ),
                const SizedBox(height: AppConstants.spacing16),
                Text(
                  'Nenhum duelo ainda',
                  style: AppTheme.titleMedium.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: AppConstants.spacing8),
                Text(
                  'Que tal começar sua jornada na arena?',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ).animate(delay: 1400.ms)
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }
}