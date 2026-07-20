import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/menu_providers.dart';
import '../theme/app_theme.dart';

/// Menu lateral (Drawer) com filtros globais, aplicados tanto na aba
/// "Cardápio Completo" quanto em "Meus Favoritos", pois ambos observam
/// o mesmo [filtroGlobalProvider].
class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtro = ref.watch(filtroGlobalProvider);
    final filtroNotifier = ref.read(filtroGlobalProvider.notifier);
    final themeMode = ref.watch(themeModeProvider);

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AsiCoffeeColors.marromEscuro,
              ),
              child: Row(
                children: [
                  const Icon(Icons.coffee_rounded,
                      color: AsiCoffeeColors.cremoso, size: 32),
                  const SizedBox(width: 12),
                  Text(
                    'AsiCoffee',
                    style: GoogleFonts.playfairDisplay(
                      color: AsiCoffeeColors.cremoso,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(
                'FILTROS GLOBAIS',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.coffee_rounded),
              title: const Text('Mostrar apenas Cafés'),
              value: filtro.apenasCafes,
              onChanged: filtroNotifier.setApenasCafes,
            ),
            SwitchListTile(
              secondary: const Icon(Icons.spa_rounded),
              title: const Text('Sem Glúten'),
              value: filtro.semGluten,
              onChanged: filtroNotifier.setSemGluten,
            ),
            if (filtro.algumFiltroAtivo)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextButton.icon(
                  onPressed: filtroNotifier.limpar,
                  icon: const Icon(Icons.filter_alt_off_rounded, size: 18),
                  label: const Text('Limpar filtros'),
                ),
              ),
            const Divider(height: 32),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: Text(
                'APARÊNCIA',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            SwitchListTile(
              secondary: Icon(
                themeMode == ThemeMode.dark
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
              ),
              title: const Text('Tema Escuro'),
              value: themeMode == ThemeMode.dark,
              onChanged: (ativo) {
                ref.read(themeModeProvider.notifier).state =
                    ativo ? ThemeMode.dark : ThemeMode.light;
              },
            ),
          ],
        ),
      ),
    );
  }
}
