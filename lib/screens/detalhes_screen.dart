import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/menu_item.dart';
import '../providers/menu_providers.dart';


class DetalhesScreen extends ConsumerWidget {
  static const routeName = '/detalhes';

  const DetalhesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ModalRoute.of(context)!.settings.arguments as MenuItem;
    final isFavorito = ref.watch(favoritosProvider).contains(item.id);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final ehLargo = constraints.maxWidth > 700;

          final imagem = Image.network(
            item.imagemUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: scheme.surfaceContainerHighest,
              child: Icon(Icons.coffee_rounded, size: 64, color: scheme.primary),
            ),
          );

          final conteudo = _ConteudoDetalhes(
            item: item,
            isFavorito: isFavorito,
            onToggleFavorito: () =>
                ref.read(favoritosProvider.notifier).toggle(item.id),
          );


          if (ehLargo) {
            return SafeArea(
              child: Row(
                children: [
                  Expanded(flex: 4, child: SizedBox.expand(child: imagem)),
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: conteudo,
                    ),
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: imagem,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: conteudo,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ConteudoDetalhes extends StatelessWidget {
  final MenuItem item;
  final bool isFavorito;
  final VoidCallback onToggleFavorito;

  const _ConteudoDetalhes({
    required this.item,
    required this.isFavorito,
    required this.onToggleFavorito,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                item.categoria,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: scheme.primary,
                ),
              ),
            ),
            if (item.semGluten) ...[
              const SizedBox(width: 8),
              Icon(Icons.spa_rounded, size: 16, color: scheme.secondary),
              const SizedBox(width: 4),
              Text('Sem Glúten',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: scheme.secondary)),
            ],
            const Spacer(),
            IconButton(
              onPressed: onToggleFavorito,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: Icon(
                  isFavorito ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  key: ValueKey(isFavorito),
                  color: isFavorito ? Colors.red : scheme.onSurface.withValues(alpha: 0.4),
                  size: 28,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          item.nome,
          style: GoogleFonts.playfairDisplay(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Lançado em ${DateFormat('dd/MM/yyyy').format(item.dataLancamento)}',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: scheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          item.descricao,
          style: GoogleFonts.inter(fontSize: 15, height: 1.5),
        ),
        const SizedBox(height: 24),
        Text(
          'R\$ ${item.preco.toStringAsFixed(2).replaceAll('.', ',')}',
          style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 20),
        Consumer(
          builder: (context, ref, _) => SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () =>
                  ref.read(carrinhoProvider.notifier).adicionar(item),
              icon: const Icon(Icons.shopping_cart_rounded),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('Adicionar ao pedido'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
