import 'package:flutter/material.dart';
import 'package:projeto_flutter/presentation/screens/navigation/main_navigation_screen.dart';

import 'core/theme/app_theme.dart';

import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/home/home_screen.dart';

class InkBRApp extends StatelessWidget {
  const InkBRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InkBR',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.dark,

      initialRoute: '/login',

      routes: {
        '/login': (_) => const LoginScreen(),

        '/main': (_) => const MainNavigationScreen(),

        '/home': (_) => const HomeScreen(),
      },
    );
  }
}