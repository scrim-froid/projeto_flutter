import 'package:flutter/material.dart';
import 'package:projeto_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';

import 'providers/auth_provider.dart';
import 'providers/favoritos_provider.dart';
import 'providers/leitura_provider.dart';
import 'providers/obra_provider.dart';

import 'presentation/screens/auth/auth_gate.dart';
import 'presentation/screens/navigation/main_navigation_screen.dart';
import 'presentation/screens/home/home_screen.dart';
import 'presentation/screens/profile/author_profile_screen.dart';
import 'presentation/screens/upload/create_work_screen.dart';

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
        ChangeNotifierProvider(
          create: (_) {
            final provider = LeituraProvider();
            provider.carregarLeitura();
            return provider;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'InkBR',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,

        // Decide automaticamente entre Login e Home
        home: const AuthGate(),

        routes: {
          '/main': (_) => const MainNavigationScreen(),
          '/home': (_) => const HomeScreen(),
          '/create-work': (_) => const CreateWorkScreen(),
        },
      ),
    );
  }
}
