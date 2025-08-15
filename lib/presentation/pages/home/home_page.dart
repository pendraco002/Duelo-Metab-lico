import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../widgets/animated_background.dart';
import '../../widgets/game_mode_card.dart';
import '../../widgets/user_profile_header.dart';
import '../../widgets/recent_duels_section.dart';
import '../../widgets/achievement_showcase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        controller: _backgroundController,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Custom App Bar with User Info
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthAuthenticated) {
                        return UserProfileHeader(user: state.user)
                            .animate()
                            .fadeIn(duration: 600.ms)
                            .slideY(begin: -0.3, end: 0);
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),

              // Welcome Section
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(AppConstants.spacing24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Arena de Batalha',
                        style: AppTheme.displayLarge.copyWith(
                          foreground: Paint()
                            ..shader = AppTheme.primaryGradient.createShader(
                              const Rect.fromLTWH(0, 0, 300, 60),
                            ),
                        ),
                      ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.3),
                      
                      const SizedBox(height: AppConstants.spacing8),
                      
                      Text(
                        'Bem-vindo, rennan Lima!',
                        style: AppTheme.headlineMedium.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.3),
                      
                      const SizedBox(height: AppConstants.spacing32),
                      
                      Text(
                        'Escolha seu Modo de Jogo',
                        style: AppTheme.headlineLarge,
                      ).animate().fadeIn(delay: 600.ms),
                    ],
                  ),
                ),
              ),

              // Game Modes Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacing24,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: AppConstants.spacing16,
                    childAspectRatio: 2.5,
                  ),
                  delegate: SliverChildListDelegate([
                    GameModeCard(
                      title: 'Desafio Solo',
                      subtitle: 'Pratique suas habilidades contra nossa IA inteligente',
                      features: const [
                        'Sem pressão de tempo',
                        'Feedback detalhado',
                        'Ganha NumScore',
                      ],
                      gradient: AppTheme.primaryGradient,
                      icon: Icons.person,
                      onTap: () => context.go('/home/solo-game'),
                      animationDelay: 800.ms,
                    ),
                    
                    GameModeCard(
                      title: 'Arena Online',
                      subtitle: 'Duel com nutricionistas do mundo inteiro',
                      features: const [
                        'Ranking global',
                        'Duelo em tempo real',
                        'Mais NumScore',
                      ],
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE74C3C), Color(0xFFC0392B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      icon: Icons.public,
                      onTap: () => context.go('/home/online-game'),
                      animationDelay: 1000.ms,
                      pulseController: _pulseController,
                    ),
                    
                    GameModeCard(
                      title: 'Arena Local',
                      subtitle: 'Jogue com amigos na mesma sala ou grupo de estudo',
                      features: const [
                        '1v1 ou 3v3',
                        'Partidas para até 6',
                        'Poderes especiais',
                      ],
                      gradient: AppTheme.secondaryGradient,
                      icon: Icons.groups,
                      onTap: () => context.go('/home/local-game'),
                      animationDelay: 1200.ms,
                    ),
                  ]),
                ),
              ),

              // Recent Duels Section
              const SliverToBoxAdapter(
                child: RecentDuelsSection(),
              ),

              // Achievement Showcase
              const SliverToBoxAdapter(
                child: AchievementShowcase(),
              ),

              // Bottom Spacing
              const SliverToBoxAdapter(
                child: SizedBox(height: AppConstants.spacing32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}