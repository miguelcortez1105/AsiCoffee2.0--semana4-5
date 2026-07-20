import 'menu_item.dart';

class ItemCarrinho {
  final MenuItem item;
  int quantidade;

  ItemCarrinho({
    required this.item,
    this.quantidade = 1,
  });

  double get subtotal => item.preco * quantidade;
}
