import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/menu_providers.dart';
import '../theme/app_theme.dart';
import '../widgets/add_item_modal.dart';
import '../widgets/app_drawer.dart';
import 'cardapio_tab.dart';
import 'carrinho_screen.dart';
import 'favoritos_tab.dart';


class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int _abaAtual = 0;

  static const _abas = [
    CardapioTab(),
    FavoritosTab(),
  ];

  static const _titulos = ['Cardápio Completo', 'Meus Favoritos'];

  @override
  Widget build(BuildContext context) {
    final favoritosCount = ref.watch(favoritosProvider).length;
    final carrinhoCount = ref
        .watch(carrinhoProvider)
        .fold<int>(0, (soma, item) => soma + item.quantidade);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.coffee_rounded, size: 26),
            const SizedBox(width: 10),
            Text(
              _titulos[_abaAtual],
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_rounded),
                tooltip: 'Carrinho',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TelaCarrinho()),
                ),
              ),
              if (carrinhoCount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: _Badge(count: carrinhoCount),
                ),
            ],
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: IndexedStack(index: _abaAtual, children: _abas),
      floatingActionButton: _abaAtual == 0
          ? FloatingActionButton.extended(
              onPressed: () => mostrarModalNovoItem(context),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Novo item'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _abaAtual,
        onDestinationSelected: (index) => setState(() => _abaAtual = index),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.local_cafe_outlined),
            selectedIcon: Icon(Icons.local_cafe_rounded),
            label: 'Cardápio',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: favoritosCount > 0,
              label: Text('$favoritosCount'),
              child: const Icon(Icons.favorite_border_rounded),
            ),
            selectedIcon: const Icon(Icons.favorite_rounded),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final int count;
  const _Badge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: AsiCoffeeColors.caramelo,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$count',
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
