import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/menu_item.dart';
import '../providers/menu_providers.dart';
import '../widgets/banner_boas_vindas.dart';
import '../widgets/cardapio_item_card.dart';
import '../widgets/filtro_categorias.dart';

const List<String> _categoriasComTodos = ['Todos', ...kCategorias];


class CardapioTab extends ConsumerWidget {
  const CardapioTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itensFiltrados = ref.watch(itensFiltradosProvider);
    final categoriaSelecionada = ref.watch(categoriaSelecionadaProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BannerBoasVindas(),
        FiltroCategorias(
          categorias: _categoriasComTodos,
          selecionada: categoriaSelecionada,
          onSelecionar: (cat) =>
              ref.read(categoriaSelecionadaProvider.notifier).state = cat,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            '${itensFiltrados.length} ${itensFiltrados.length == 1 ? 'item' : 'itens'}',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6),
            ),
          ),
        ),
        Expanded(
          child: itensFiltrados.isEmpty
              ? const _EstadoVazio()
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final ehLargo = constraints.maxWidth > 600;

                    if (ehLargo) {
                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 2.6,
                        ),
                        itemCount: itensFiltrados.length,
                        itemBuilder: (context, index) => CardapioItemCard(
                          item: itensFiltrados[index],
                          index: index,
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      itemCount: itensFiltrados.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => CardapioItemCard(
                        item: itensFiltrados[index],
                        index: index,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _EstadoVazio extends StatelessWidget {
  const _EstadoVazio();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off_rounded,
                size: 48,
                color:
                    Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)),
            const SizedBox(height: 12),
            const Text(
              'Nenhum item encontrado com os filtros atuais.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
