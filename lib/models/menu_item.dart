/// Modelo de dados de um item do cardápio.
///
/// Inclui campos usados pelos novos recursos da v2.0:
/// - [dataLancamento]: preenchida pelo DatePicker no formulário de cadastro.
/// - [semGluten]: usada pelo filtro global "Sem Glúten" do Drawer.
class MenuItem {
  final String id;
  final String nome;
  final double preco;
  final String imagemUrl;
  final String categoria;
  final String descricao;
  final DateTime dataLancamento;
  final bool semGluten;

  const MenuItem({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imagemUrl,
    required this.categoria,
    required this.descricao,
    required this.dataLancamento,
    this.semGluten = false,
  });

  MenuItem copyWith({
    String? nome,
    double? preco,
    String? imagemUrl,
    String? categoria,
    String? descricao,
    DateTime? dataLancamento,
    bool? semGluten,
  }) {
    return MenuItem(
      id: id,
      nome: nome ?? this.nome,
      preco: preco ?? this.preco,
      imagemUrl: imagemUrl ?? this.imagemUrl,
      categoria: categoria ?? this.categoria,
      descricao: descricao ?? this.descricao,
      dataLancamento: dataLancamento ?? this.dataLancamento,
      semGluten: semGluten ?? this.semGluten,
    );
  }
}

/// Categorias disponíveis para o Dropdown do formulário e para os filtros.
const List<String> kCategorias = [
  'Cafés',
  'Cafés Gelados',
  'Chás e Especiais',
  'Pães e Doces',
];
