import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/menu_item.dart';
import '../providers/menu_providers.dart';
import '../screens/detalhes_screen.dart';

/// Card do item do cardápio.
///
/// Envolvido por [Dismissible] para permitir a remoção com gesto de
/// arrastar. Ao tocar no card, navega para [DetalhesScreen] passando o
/// produto como argumento da rota.
class CardapioItemCard extends ConsumerWidget {
  final MenuItem item;
  final int index;

  const CardapioItemCard({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorito = ref.watch(favoritosProvider).contains(item.id);
    final scheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        margin: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_forever_rounded, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Remover item'),
                content: Text('Remover "${item.nome}" do cardápio?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancelar'),
                  ),
                  FilledButton.tonal(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Remover'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      onDismissed: (_) {
        final itemRemovido = item;
        final indiceRemovido = index;
        ref.read(menuProvider.notifier).removerItem(item.id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('"${itemRemovido.nome}" removido do cardápio'),
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                ref
                    .read(menuProvider.notifier)
                    .restaurarItem(itemRemovido, indiceRemovido);
              },
            ),
          ),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(
          context,
          DetalhesScreen.routeName,
          arguments: item, // <- dados do produto passados via argumentos
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.imagemUrl,
                    width: 88,
                    height: 88,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        width: 88,
                        height: 88,
                        color: scheme.surfaceContainerHighest,
                        child: const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 88,
                      height: 88,
                      color: scheme.surfaceContainerHighest,
                      child: Icon(Icons.coffee_rounded, color: scheme.primary),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: scheme.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              item.categoria,
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: scheme.primary,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          if (item.semGluten) ...[
                            const SizedBox(width: 6),
                            Icon(Icons.spa_rounded,
                                size: 14, color: scheme.secondary),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.nome,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.descricao,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color
                              ?.withValues(alpha: 0.6),
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'R\$ ${item.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => ref
                                    .read(favoritosProvider.notifier)
                                    .toggle(item.id),
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  transitionBuilder: (child, anim) =>
                                      ScaleTransition(
                                          scale: anim, child: child),
                                  child: Icon(
                                    isFavorito
                                        ? Icons.favorite_rounded
                                        : Icons.favorite_border_rounded,
                                    key: ValueKey(isFavorito),
                                    color: isFavorito
                                        ? Colors.red
                                        : scheme.onSurface.withValues(alpha: 0.25),
                                    size: 26,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () => ref
                                    .read(carrinhoProvider.notifier)
                                    .adicionar(item),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: scheme.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Pedir',
                                    style: GoogleFonts.inter(
                                      color: scheme.onPrimary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
