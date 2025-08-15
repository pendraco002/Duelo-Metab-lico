import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'core/constants/app_constants.dart';
import 'presentation/bloc/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Configure dependency injection
  await configureDependencies();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.backgroundColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const DueloMetabolicoApp());
}

class DueloMetabolicoApp extends StatelessWidget {
  const DueloMetabolicoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>()
            ..add(const AuthCheckRequested()),
        ),
        // Add other global blocs here
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}

// Global error widget
class AppErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const AppErrorWidget({
    super.key,
    required this.errorDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppTheme.errorColor,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Ops! Algo deu errado',
              style: AppTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Um erro inesperado aconteceu. Por favor, reinicie o aplicativo.',
              style: AppTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Restart app logic
                SystemNavigator.pop();
              },
              child: const Text('Reiniciar App'),
            ),
          ],
        ),
      ),
    );
  }
}