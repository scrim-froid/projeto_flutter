import 'package:flutter/material.dart';
import 'package:projeto_flutter/presentation/screens/navigation/main_navigation_screen.dart';
import 'package:projeto_flutter/presentation/screens/profile/author_profile_screen.dart';
import 'package:projeto_flutter/presentation/screens/upload/create_work_screen.dart';
import 'package:projeto_flutter/providers/favoritos_provider.dart';
import 'package:projeto_flutter/providers/obra_provider.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';

import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/home/home_screen.dart';

class InkBRApp extends StatelessWidget {
  const InkBRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavoritosProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ObraProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'InkBR',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        initialRoute: '/login',
        routes: {
          '/login': (_) => const LoginScreen(),
          '/main': (_) => const MainNavigationScreen(),
          '/home': (_) => const HomeScreen(),
          '/author-profile': (_) => const AuthorProfileScreen(),
          '/create-work': (_) => const CreateWorkScreen(),
        },
      ),
    );
  }
}
