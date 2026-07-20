import '../models/menu_item.dart';

/// Dados iniciais do cardápio. Servem apenas de "seed" — a partir daqui,
/// toda a lista passa a ser gerenciada pelo [MenuNotifier] (Riverpod).
final List<MenuItem> cardapioInicial = [
  MenuItem(
    id: '1',
    nome: 'Espresso Clássico',
    preco: 7.50,
    imagemUrl:
        'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=400&q=80',
    categoria: 'Cafés',
    descricao: 'Encorpado e intenso, extraído em 25 segundos perfeitos',
    dataLancamento: DateTime(2023, 3, 10),
    semGluten: true,
  ),
  MenuItem(
    id: '2',
    nome: 'Cappuccino',
    preco: 12.00,
    imagemUrl:
        'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400&q=80',
    categoria: 'Cafés',
    descricao: 'Espresso com leite vaporizado e espuma cremosa',
    dataLancamento: DateTime(2023, 3, 10),
    semGluten: true,
  ),
  MenuItem(
    id: '3',
    nome: 'Cold Brew',
    preco: 14.50,
    imagemUrl:
        'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=400&q=80',
    categoria: 'Cafés Gelados',
    descricao: 'Infusão a frio por 18h, suave e naturalmente adocicado',
    dataLancamento: DateTime(2023, 6, 1),
    semGluten: true,
  ),
  MenuItem(
    id: '4',
    nome: 'Matcha Latte',
    preco: 16.00,
    imagemUrl:
        'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=400&q=80',
    categoria: 'Chás e Especiais',
    descricao: 'Matcha japonês premium com leite de aveia',
    dataLancamento: DateTime(2023, 9, 15),
    semGluten: true,
  ),
  MenuItem(
    id: '5',
    nome: 'Croissant de Manteiga',
    preco: 9.90,
    imagemUrl:
        'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=400&q=80',
    categoria: 'Pães e Doces',
    descricao: 'Folhado artesanal com manteiga francesa, assado na hora',
    dataLancamento: DateTime(2023, 1, 20),
    semGluten: false,
  ),
  MenuItem(
    id: '6',
    nome: 'Flat White',
    preco: 13.00,
    imagemUrl:
        'https://images.unsplash.com/photo-1577968897966-3d4325b36b61?w=400&q=80',
    categoria: 'Cafés',
    descricao: 'Duplo espresso com microespuma de leite sedosa',
    dataLancamento: DateTime(2024, 2, 5),
    semGluten: true,
  ),
  MenuItem(
    id: '7',
    nome: 'Brownie de Chocolate',
    preco: 11.00,
    imagemUrl:
        'https://images.unsplash.com/photo-1564355808539-22fda35bed7e?w=400&q=80',
    categoria: 'Pães e Doces',
    descricao: 'Denso, úmido e com gotas de chocolate 70%',
    dataLancamento: DateTime(2023, 11, 12),
    semGluten: false,
  ),
  MenuItem(
    id: '8',
    nome: 'Chai Latte',
    preco: 14.00,
    imagemUrl:
        'https://images.unsplash.com/photo-1571934811356-5cc061b6821f?w=400&q=80',
    categoria: 'Chás e Especiais',
    descricao: 'Especiarias indianas, canela e leite vaporizado',
    dataLancamento: DateTime(2024, 4, 18),
    semGluten: true,
  ),
  MenuItem(
    id: '9',
    nome: 'Affogato',
    preco: 17.00,
    imagemUrl:
        'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=400&q=80',
    categoria: 'Cafés Gelados',
    descricao: 'Sorvete de baunilha afogado em espresso quente',
    dataLancamento: DateTime(2024, 6, 30),
    semGluten: true,
  ),
  MenuItem(
    id: '10',
    nome: 'Pão de Queijo',
    preco: 6.50,
    imagemUrl:
        'https://images.unsplash.com/photo-1548940740-204726a19be3?w=400&q=80',
    categoria: 'Pães e Doces',
    descricao: 'Tradicional mineiro, quentinho e com recheio generoso',
    dataLancamento: DateTime(2023, 5, 8),
    semGluten: true,
  ),
];
