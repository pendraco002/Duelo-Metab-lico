import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/user.dart';

class UserProfileHeader extends StatelessWidget {
  final User user;

  const UserProfileHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacing24),
      child: Row(
        children: [
          // User Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
              gradient: AppTheme.primaryGradient,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'R',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: AppConstants.spacing16),
          
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.name,
                  style: AppTheme.headlineMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing4),
                
                // Level Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.spacing12,
                    vertical: AppConstants.spacing4,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppTheme.secondaryGradient,
                    borderRadius: BorderRadius.circular(AppConstants.spacing12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: AppConstants.spacing4),
                      Text(
                        user.level.levelTitle,
                        style: AppTheme.labelSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppConstants.spacing8),
                
                // Stats Row
                Row(
                  children: [
                    _buildStatItem(
                      '${user.statistics.totalGames}',
                      'Vitórias',
                      Icons.emoji_events,
                    ),
                    const SizedBox(width: AppConstants.spacing16),
                    _buildStatItem(
                      '${user.statistics.winRate.toInt()}%',
                      'Taxa Vitória',
                      Icons.trending_up,
                    ),
                    const SizedBox(width: AppConstants.spacing16),
                    _buildStatItem(
                      '${user.level.currentLevel}',
                      'NumScore',
                      Icons.favorite,
                      color: AppTheme.errorColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: color ?? AppTheme.secondaryColor,
            ),
            const SizedBox(width: AppConstants.spacing4),
            Text(
              value,
              style: AppTheme.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: color ?? AppTheme.secondaryColor,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: AppTheme.labelSmall.copyWith(
            color: AppTheme.textTertiary,
          ),
        ),
      ],
    );
  }
}