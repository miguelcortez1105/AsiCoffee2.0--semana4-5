import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/menu_item.dart';
import '../providers/menu_providers.dart';

/// Abre o formulário de cadastro em um Modal (showModalBottomSheet).
///
/// Explora 4 tipos de input diferentes, conforme pedido no requisito:
/// - Texto (nome)
/// - Numérico (preço)
/// - Dropdown (categoria)
/// - DatePicker (data de lançamento)
Future<void> mostrarModalNovoItem(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true, // permite o modal crescer com o teclado
    useSafeArea: true,
    builder: (context) => const _FormularioNovoItem(),
  );
}

class _FormularioNovoItem extends ConsumerStatefulWidget {
  const _FormularioNovoItem();

  @override
  ConsumerState<_FormularioNovoItem> createState() =>
      _FormularioNovoItemState();
}

class _FormularioNovoItemState extends ConsumerState<_FormularioNovoItem> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _imagemController = TextEditingController();

  String _categoriaSelecionada = kCategorias.first;
  DateTime? _dataLancamento;
  bool _semGluten = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _descricaoController.dispose();
    _imagemController.dispose();
    super.dispose();
  }

  Future<void> _selecionarData() async {
    final agora = DateTime.now();
    final dataEscolhida = await showDatePicker(
      context: context,
      initialDate: _dataLancamento ?? agora,
      firstDate: DateTime(2015),
      lastDate: DateTime(agora.year + 1),
      helpText: 'Data de lançamento',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
    );
    if (dataEscolhida != null) {
      setState(() => _dataLancamento = dataEscolhida);
    }
  }

  void _salvar() {
    final formValido = _formKey.currentState?.validate() ?? false;

    // Validação extra: DatePicker não é validado pelo Form, então checamos
    // manualmente e mostramos um erro visual (ver `errorText` abaixo).
    if (_dataLancamento == null || !formValido) {
      setState(() {}); // força rebuild para exibir o erro da data
      return;
    }

    final novoItem = MenuItem(
      id: const Uuid().v4(),
      nome: _nomeController.text.trim(),
      preco: double.parse(_precoController.text.replaceAll(',', '.')),
      imagemUrl: _imagemController.text.trim().isEmpty
          ? 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400&q=80'
          : _imagemController.text.trim(),
      categoria: _categoriaSelecionada,
      descricao: _descricaoController.text.trim().isEmpty
          ? 'Novo item do cardápio'
          : _descricaoController.text.trim(),
      dataLancamento: _dataLancamento!,
      semGluten: _semGluten,
    );

    ref.read(menuProvider.notifier).adicionarItem(novoItem);

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${novoItem.nome}" adicionado ao cardápio!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final erroData = _dataLancamento == null;

    return Padding(
      // Empurra o modal para cima do teclado.
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Text(
                'Novo item do cardápio',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // Input de TEXTO — nome
              TextFormField(
                controller: _nomeController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nome do item',
                  hintText: 'Ex: Latte de Caramelo',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe um nome para o item';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Input NUMÉRICO — preço
              TextFormField(
                controller: _precoController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*[,.]?\d{0,2}')),
                ],
                decoration: const InputDecoration(
                  labelText: 'Preço (R\$)',
                  hintText: 'Ex: 14.90',
                  prefixText: 'R\$ ',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o preço';
                  }
                  final numero = double.tryParse(valor.replaceAll(',', '.'));
                  if (numero == null) {
                    return 'Digite um preço válido';
                  }
                  if (numero <= 0) {
                    return 'O preço não pode ser negativo ou zero';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // Input de DROPDOWN — categoria
              DropdownButtonFormField<String>(
                initialValue: _categoriaSelecionada,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                ),
                items: kCategorias
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (valor) {
                  if (valor != null) {
                    setState(() => _categoriaSelecionada = valor);
                  }
                },
              ),
              const SizedBox(height: 14),

              // DATE PICKER — data de lançamento
              InkWell(
                onTap: _selecionarData,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Data de lançamento',
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.calendar_month_rounded),
                    errorText: erroData ? 'Selecione uma data' : null,
                  ),
                  child: Text(
                    _dataLancamento == null
                        ? 'Toque para selecionar'
                        : DateFormat('dd/MM/yyyy').format(_dataLancamento!),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _descricaoController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Descrição (opcional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _imagemController,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'URL da imagem (opcional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 6),

              SwitchListTile(
                value: _semGluten,
                onChanged: (valor) => setState(() => _semGluten = valor),
                title: const Text('Sem Glúten'),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _salvar,
                  icon: const Icon(Icons.check_rounded),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Cadastrar item'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
