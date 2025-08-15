import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';

class AchievementShowcase extends StatelessWidget {
  const AchievementShowcase({super.key});

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
                Icons.emoji_events,
                color: AppTheme.warningColor,
                size: 24,
              ),
              const SizedBox(width: AppConstants.spacing8),
              Text(
                'Conquistas em Destaque',
                style: AppTheme.headlineMedium,
              ),
            ],
          ),
          
          const SizedBox(height: AppConstants.spacing16),
          
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _getMockAchievements().length,
              itemBuilder: (context, index) {
                final achievement = _getMockAchievements()[index];
                return Container(
                  width: 200,
                  margin: EdgeInsets.only(
                    right: index < _getMockAchievements().length - 1 
                        ? AppConstants.spacing16 
                        : 0,
                  ),
                  padding: const EdgeInsets.all(AppConstants.spacing16),
                  decoration: BoxDecoration(
                    gradient: achievement['gradient'] as LinearGradient,
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: (achievement['gradient'] as LinearGradient)
                            .colors.first.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            achievement['icon'] as IconData,
                            color: Colors.white,
                            size: 24,
                          ),
                          const Spacer(),
                          if (achievement['isLocked'] as bool)
                            Icon(
                              Icons.lock,
                              color: Colors.white.withOpacity(0.7),
                              size: 16,
                            ),
                        ],
                      ),
                      
                      const Spacer(),
                      
                      Text(
                        achievement['title'] as String,
                        style: AppTheme.titleMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: AppConstants.spacing4),
                      
                      Text(
                        achievement['description'] as String,
                        style: AppTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ).animate(delay: Duration(milliseconds: 1600 + (index * 200)))
                    .slideX(begin: 0.3, end: 0)
                    .fadeIn(duration: 600.ms);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getMockAchievements() {
    return [
      {
        'title': 'Primeira Vitória',
        'description': 'Vença seu primeiro duelo',
        'icon': Icons.military_tech,
        'gradient': const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'isLocked': false,
      },
      {
        'title': 'Sequência de 5',
        'description': 'Vença 5 duelos seguidos',
        'icon': Icons.whatshot,
        'gradient': const LinearGradient(
          colors: [Color(0xFFFF6B6B), Color(0xFFFF5722)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'isLocked': true,
      },
      {
        'title': 'Mestre da Velocidade',
        'description': 'Responda em menos de 5s',
        'icon': Icons.speed,
        'gradient': const LinearGradient(
          colors: [Color(0xFF4ECDC4), Color(0xFF26C6DA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        'isLocked': true,
      },
    ];
  }
}