import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';

class GameModeCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<String> features;
  final LinearGradient gradient;
  final IconData icon;
  final VoidCallback onTap;
  final Duration animationDelay;
  final AnimationController? pulseController;

  const GameModeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.features,
    required this.gradient,
    required this.icon,
    required this.onTap,
    required this.animationDelay,
    this.pulseController,
  });

  @override
  State<GameModeCard> createState() => _GameModeCardState();
}

class _GameModeCardState extends State<GameModeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: AppConstants.shortAnimation,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: AppConstants.cardElevation,
      end: AppConstants.cardElevation * 2,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget card = AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
              gradient: widget.gradient,
              boxShadow: [
                BoxShadow(
                  color: widget.gradient.colors.first.withOpacity(0.3),
                  blurRadius: _elevationAnimation.value * 2,
                  offset: Offset(0, _elevationAnimation.value),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.onTap,
                onHover: _onHover,
                borderRadius: BorderRadius.circular(AppConstants.borderRadius * 2),
                child: Container(
                  padding: const EdgeInsets.all(AppConstants.spacing20),
                  child: Row(
                    children: [
                      // Icon Section
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        ),
                        child: Icon(
                          widget.icon,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      
                      const SizedBox(width: AppConstants.spacing20),
                      
                      // Content Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.title,
                              style: AppTheme.titleLarge.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            
                            const SizedBox(height: AppConstants.spacing8),
                            
                            Text(
                              widget.subtitle,
                              style: AppTheme.bodyMedium.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            const SizedBox(height: AppConstants.spacing12),
                            
                            // Features
                            Wrap(
                              spacing: AppConstants.spacing8,
                              runSpacing: AppConstants.spacing4,
                              children: widget.features.map((feature) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppConstants.spacing8,
                                    vertical: AppConstants.spacing4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(AppConstants.spacing12),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: AppConstants.spacing4),
                                      Text(
                                        feature,
                                        style: AppTheme.labelSmall.copyWith(
                                          color: Colors.white,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      
                      // Arrow Icon
                      AnimatedRotation(
                        turns: _isHovered ? 0.1 : 0.0,
                        duration: AppConstants.shortAnimation,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    // Add pulse animation if provided
    if (widget.pulseController != null) {
      card = AnimatedBuilder(
        animation: widget.pulseController!,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (widget.pulseController!.value * 0.05),
            child: card,
          );
        },
      );
    }

    return card
        .animate(delay: widget.animationDelay)
        .fadeIn(duration: 600.ms, curve: Curves.easeOut)
        .slideY(begin: 0.3, end: 0, curve: Curves.easeOut)
        .scale(begin: const Offset(0.8, 0.8), curve: Curves.elasticOut);
  }
}