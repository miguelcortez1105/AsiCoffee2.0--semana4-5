import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/menu_providers.dart';

class TelaCarrinho extends ConsumerWidget {
  const TelaCarrinho({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carrinho = ref.watch(carrinhoProvider);
    final total = carrinho.fold<double>(0, (soma, item) => soma + item.subtotal);

    return Scaffold(
      appBar: AppBar(title: const Text('Meu Pedido')),
      body: Column(
        children: [
          Expanded(
            child: carrinho.isEmpty
                ? const Center(child: Text('Seu carrinho está vazio'))
                : ListView.builder(
                    itemCount: carrinho.length,
                    itemBuilder: (context, index) {
                      final item = carrinho[index];
                      return ListTile(
                        title: Text(item.item.nome),
                        subtitle: Text('Quantidade: ${item.quantidade}'),
                        trailing: Text(
                            'R\$ ${item.subtotal.toStringAsFixed(2)}'),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Total: R\$ ${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
