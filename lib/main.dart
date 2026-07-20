import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/menu_providers.dart';
import 'screens/detalhes_screen.dart';
import 'screens/home_shell.dart';
import 'theme/app_theme.dart';

void main() {
  // ProviderScope precisa envolver o app inteiro para que qualquer widget
  // em qualquer tela possa acessar os providers do Riverpod.
  runApp(const ProviderScope(child: AsiCoffeeApp()));
}

class AsiCoffeeApp extends ConsumerWidget {
  const AsiCoffeeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'AsiCoffee',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      home: const HomeShell(),
      // Rota nomeada usada para navegar até os Detalhes passando o produto
      // via `arguments` (Navigator.pushNamed(..., arguments: item)).
      routes: {
        DetalhesScreen.routeName: (context) => const DetalhesScreen(),
      },
    );
  }
}
