import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/seed_data.dart';
import '../models/item_carrinho.dart';
import '../models/menu_item.dart';

/// -----------------------------------------------------------------------
/// CARDÁPIO — lista global de produtos
/// -----------------------------------------------------------------------
/// Fonte única de verdade para o cardápio. Cadastro (Modal) e remoção
/// (Dismissible) passam por aqui, então qualquer tela que observar este
/// provider (abas, detalhes, favoritos) é atualizada automaticamente.
class MenuNotifier extends StateNotifier<List<MenuItem>> {
  MenuNotifier() : super(cardapioInicial);

  void adicionarItem(MenuItem item) {
    state = [item, ...state];
  }

  void removerItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  /// Usado pelo "desfazer" do SnackBar ao remover um item com Dismissible.
  void restaurarItem(MenuItem item, int index) {
    final novaLista = [...state];
    final indiceSeguro = index.clamp(0, novaLista.length);
    novaLista.insert(indiceSeguro, item);
    state = novaLista;
  }
}

final menuProvider = StateNotifierProvider<MenuNotifier, List<MenuItem>>(
  (ref) => MenuNotifier(),
);

/// -----------------------------------------------------------------------
/// FAVORITOS — ids dos produtos favoritados
/// -----------------------------------------------------------------------
/// Guarda apenas os ids favoritados. Como é o mesmo provider observado pela
/// aba "Meus Favoritos" e pela tela de Detalhes, favoritar em qualquer lugar
/// reflete imediatamente em todo o app.
class FavoritosNotifier extends StateNotifier<Set<String>> {
  FavoritosNotifier() : super(<String>{});

  void toggle(String id) {
    final novoSet = {...state};
    if (novoSet.contains(id)) {
      novoSet.remove(id);
    } else {
      novoSet.add(id);
    }
    state = novoSet;
  }

  bool isFavorito(String id) => state.contains(id);
}

final favoritosProvider =
    StateNotifierProvider<FavoritosNotifier, Set<String>>(
  (ref) => FavoritosNotifier(),
);

/// -----------------------------------------------------------------------
/// CARRINHO — mantido da v1, agora também via Riverpod
/// -----------------------------------------------------------------------
class CarrinhoNotifier extends StateNotifier<List<ItemCarrinho>> {
  CarrinhoNotifier() : super(<ItemCarrinho>[]);

  void adicionar(MenuItem item) {
    final index = state.indexWhere((e) => e.item.id == item.id);
    if (index >= 0) {
      final novaLista = [...state];
      novaLista[index].quantidade++;
      state = novaLista;
    } else {
      state = [...state, ItemCarrinho(item: item)];
    }
  }
}

final carrinhoProvider =
    StateNotifierProvider<CarrinhoNotifier, List<ItemCarrinho>>(
  (ref) => CarrinhoNotifier(),
);

/// -----------------------------------------------------------------------
/// FILTROS GLOBAIS DO DRAWER
/// -----------------------------------------------------------------------
/// Representam filtros que se aplicam ao app inteiro (Cardápio e
/// Favoritos), diferente do filtro de categoria por chips, que é local
/// à aba de Cardápio.
@immutable
class FiltroGlobal {
  final bool apenasCafes;
  final bool semGluten;

  const FiltroGlobal({this.apenasCafes = false, this.semGluten = false});

  FiltroGlobal copyWith({bool? apenasCafes, bool? semGluten}) {
    return FiltroGlobal(
      apenasCafes: apenasCafes ?? this.apenasCafes,
      semGluten: semGluten ?? this.semGluten,
    );
  }

  bool get algumFiltroAtivo => apenasCafes || semGluten;

  bool aplicaA(MenuItem item) {
    if (apenasCafes && !item.categoria.startsWith('Café')) return false;
    if (semGluten && !item.semGluten) return false;
    return true;
  }
}

class FiltroGlobalNotifier extends StateNotifier<FiltroGlobal> {
  FiltroGlobalNotifier() : super(const FiltroGlobal());

  void setApenasCafes(bool valor) {
    state = state.copyWith(apenasCafes: valor);
  }

  void setSemGluten(bool valor) {
    state = state.copyWith(semGluten: valor);
  }

  void limpar() => state = const FiltroGlobal();
}

final filtroGlobalProvider =
    StateNotifierProvider<FiltroGlobalNotifier, FiltroGlobal>(
  (ref) => FiltroGlobalNotifier(),
);

/// Filtro local (chips) de categoria, usado apenas na aba Cardápio.
final categoriaSelecionadaProvider = StateProvider<String>((ref) => 'Todos');

/// -----------------------------------------------------------------------
/// PROVIDER DERIVADO — lista final já filtrada
/// -----------------------------------------------------------------------
/// Combina lista global + filtro de categoria (chips) + filtros do Drawer.
final itensFiltradosProvider = Provider<List<MenuItem>>((ref) {
  final lista = ref.watch(menuProvider);
  final categoria = ref.watch(categoriaSelecionadaProvider);
  final filtroGlobal = ref.watch(filtroGlobalProvider);

  return lista.where((item) {
    final passaCategoria = categoria == 'Todos' || item.categoria == categoria;
    return passaCategoria && filtroGlobal.aplicaA(item);
  }).toList();
});

/// Lista de favoritos já filtrada pelos critérios do Drawer.
final favoritosFiltradosProvider = Provider<List<MenuItem>>((ref) {
  final lista = ref.watch(menuProvider);
  final favoritos = ref.watch(favoritosProvider);
  final filtroGlobal = ref.watch(filtroGlobalProvider);

  return lista
      .where((item) => favoritos.contains(item.id))
      .where(filtroGlobal.aplicaA)
      .toList();
});

/// -----------------------------------------------------------------------
/// TEMA — claro / escuro
/// -----------------------------------------------------------------------
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);
