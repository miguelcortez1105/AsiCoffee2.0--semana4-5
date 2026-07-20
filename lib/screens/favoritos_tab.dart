import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/menu_providers.dart';
import '../widgets/cardapio_item_card.dart';


class FavoritosTab extends ConsumerWidget {
  const FavoritosTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritos = ref.watch(favoritosFiltradosProvider);
    final scheme = Theme.of(context).colorScheme;

    if (favoritos.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite_border_rounded,
                  size: 56, color: scheme.onSurface.withValues(alpha: 0.25)),
              const SizedBox(height: 16),
              Text(
                'Você ainda não tem favoritos',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Toque no coração de um item do cardápio para salvá-lo aqui.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final ehLargo = constraints.maxWidth > 600;

        if (ehLargo) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.6,
            ),
            itemCount: favoritos.length,
            itemBuilder: (context, index) =>
                CardapioItemCard(item: favoritos[index], index: index),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: favoritos.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              CardapioItemCard(item: favoritos[index], index: index),
        );
      },
    );
  }
}
