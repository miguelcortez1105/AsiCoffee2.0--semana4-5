import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 

// modelo dos dados

 
class MenuItem {
  final String id;
  final String nome;
  final double preco;
  final String imagemUrl;
  final String categoria;
  final String descricao;

 
  const MenuItem({
    required this.id,
    required this.nome,
    required this.preco,
    required this.imagemUrl,
    required this.categoria,
    required this.descricao,
  });
}

class ItemCarrinho {
  final MenuItem item;
  int quantidade;

  ItemCarrinho({
    required this.item,
    this.quantidade = 1,
  });

  double get subtotal => item.preco * quantidade;
}
 

// dados do cardápio

 
final List<MenuItem> cardapio = [
  const MenuItem(
    id: '1',
    nome: 'Espresso Clássico',
    preco: 7.50,
    imagemUrl:
        'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=400&q=80',
    categoria: 'Cafés',
    descricao: 'Encorpado e intenso, extraído em 25 segundos perfeitos',
  ),
  const MenuItem(
    id: '2',
    nome: 'Cappuccino',
    preco: 12.00,
    imagemUrl:
        'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=400&q=80',
    categoria: 'Cafés',
    descricao: 'Espresso com leite vaporizado e espuma cremosa',
  ),
  const MenuItem(
    id: '3',
    nome: 'Cold Brew',
    preco: 14.50,
    imagemUrl:
        'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=400&q=80',
    categoria: 'Cafés Gelados',
    descricao: 'Infusão a frio por 18h, suave e naturalmente adocicado',
  ),
  const MenuItem(
    id: '4',
    nome: 'Matcha Latte',
    preco: 16.00,
    imagemUrl:
        'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=400&q=80',
    categoria: 'Chás e Especiais',
    descricao: 'Matcha japonês premium com leite de aveia',
  ),
  const MenuItem(
    id: '5',
    nome: 'Croissant de Manteiga',
    preco: 9.90,
    imagemUrl:
        'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=400&q=80',
    categoria: 'Pães e Doces',
    descricao: 'Folhado artesanal com manteiga francesa, assado na hora',
  ),
  const MenuItem(
    id: '6',
    nome: 'Flat White',
    preco: 13.00,
    imagemUrl:
        'https://images.unsplash.com/photo-1577968897966-3d4325b36b61?w=400&q=80',
    categoria: 'Cafés',
    descricao: 'Duplo espresso com microespuma de leite sedosa',
  ),
  const MenuItem(
    id: '7',
    nome: 'Brownie de Chocolate',
    preco: 11.00,
    imagemUrl:
        'https://images.unsplash.com/photo-1564355808539-22fda35bed7e?w=400&q=80',
    categoria: 'Pães e Doces',
    descricao: 'Denso, úmido e com gotas de chocolate 70%',
  ),
  const MenuItem(
    id: '8',
    nome: 'Chai Latte',
    preco: 14.00,
    imagemUrl:
        'https://images.unsplash.com/photo-1571934811356-5cc061b6821f?w=400&q=80',
    categoria: 'Chás e Especiais',
    descricao: 'Especiarias indianas, canela e leite vaporizado',
  ),
  const MenuItem(
    id: '9',
    nome: 'Affogato',
    preco: 17.00,
    imagemUrl:
        'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=400&q=80',
    categoria: 'Cafés Gelados',
    descricao: 'Sorvete de baunilha afogado em espresso quente',
  ),
  const MenuItem(
    id: '10',
    nome: 'Pão de Queijo',
    preco: 6.50,
    imagemUrl:  
        'https://images.unsplash.com/photo-1548940740-204726a19be3?w=400&q=80',
    categoria: 'Pães e Doces',
    descricao: 'Tradicional mineiro, quentinho e com recheio generoso',
  ),
];
 

// ponto de entrada

 
void main() {
  runApp(const AsiCoffeeApp());
}
 
class AsiCoffeeApp extends StatelessWidget {
  const AsiCoffeeApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AsiCoffee',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const TelaCardapio(),
    );
  }
 
  ThemeData _buildTheme() {
    const Color marromEscuro = Color(0xFF2C1A0E);
    const Color marromMedio = Color(0xFF5C3317);
    const Color caramelo = Color(0xFFB5651D);
    const Color cremoso = Color(0xFFF5EDD6);
    const Color bege = Color(0xFFFAF3E0);
 
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: caramelo,
        brightness: Brightness.light,
        primary: marromMedio,
        onPrimary: Colors.white,
        secondary: caramelo,
        surface: bege,
        onSurface: marromEscuro,
      ),
      scaffoldBackgroundColor: bege,
      appBarTheme: AppBarTheme(
        backgroundColor: marromEscuro,
        foregroundColor: cremoso,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: cremoso,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        titleLarge: GoogleFonts.playfairDisplay(
          color: marromEscuro,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
 

// TELA PRINCIPAL — cardápio

 
class TelaCardapio extends StatefulWidget {
  const TelaCardapio({super.key});
 
  @override
  State<TelaCardapio> createState() => _TelaCardapioState();
}
 
class _TelaCardapioState extends State<TelaCardapio> {
  final Set<String> _favoritos = {};
  String _categoriaSelecionada = 'Todos';
  final List<ItemCarrinho> _carrinho = [];
 
  static const List<String> _categorias = [
    'Todos',
    'Cafés',
    'Cafés Gelados',
    'Chás e Especiais',
    'Pães e Doces',
  ];
 
  List<MenuItem> get _itensFiltrados {
    if (_categoriaSelecionada == 'Todos') return cardapio;
    return cardapio
        .where((item) => item.categoria == _categoriaSelecionada)
        .toList();
  }
 
  void _toggleFavorito(String id) {
    setState(() {
      if (_favoritos.contains(id)) {
        _favoritos.remove(id);
      } else {
        _favoritos.add(id);
      }
    });
  }
  void _adicionarAoCarrinho(MenuItem item) {
  final index =
      _carrinho.indexWhere((e) => e.item.id == item.id);

  setState(() {
    if (index >= 0) {
      _carrinho[index].quantidade++;
    } else {
      _carrinho.add(ItemCarrinho(item: item));
    }
  });
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.coffee_rounded, size: 28),
            const SizedBox(width: 10),
            Text(
              'AsiCoffee',
              style: GoogleFonts.playfairDisplay(
                color: const Color(0xFFF5EDD6),
                fontSize: 26,
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
                icon: const Icon(Icons.favorite_rounded),
                color: const Color(0xFFF5EDD6),
                onPressed: () {},
                tooltip: 'Favoritos',
              ),
              if (_favoritos.isNotEmpty)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Color(0xFFB5651D),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_favoritos.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
           Stack(
    children: [
      IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => TelaCarrinho(
                carrinho: _carrinho,
              ),
            ),
          );
        },
      ),
      if (_carrinho.isNotEmpty)
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${_carrinho.fold(0, (soma, item) => soma + item.quantidade)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ),
        ),
    ],
  ),

  const SizedBox(width: 4),
],
         
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner de boas-vindas
          _BannerBoasVindas(),
 
          // Filtro de categorias
          _FiltroCategorias(
            categorias: _categorias,
            selecionada: _categoriaSelecionada,
            onSelecionar: (cat) =>
                setState(() => _categoriaSelecionada = cat),
          ),
 
          // Contador de resultados
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Text(
              '${_itensFiltrados.length} ${_itensFiltrados.length == 1 ? 'item' : 'itens'}',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: const Color(0xFF5C3317).withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
 
          // Lista de produtos
          Expanded(
            child: ListView.separated(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              itemCount: _itensFiltrados.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _itensFiltrados[index];
                return CardapioItem(
                    item: item,
                    isFavorito: _favoritos.contains(item.id),
                    onToggleFavorito: () => _toggleFavorito(item.id),
                    onAdicionarCarrinho: () => _adicionarAoCarrinho(item),
);
                
              },
            ),
          ),
        ],
      ),
    );
  }
}
 

// WIDGET — "Boas vindas"

 
class _BannerBoasVindas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      decoration: const BoxDecoration(
        color: Color(0xFF2C1A0E),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bom dia! ☀️',
            style: GoogleFonts.inter(
              color: const Color(0xFFB5651D),
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Vamos\n de café hoje?',
            style: GoogleFonts.playfairDisplay(
              color: const Color(0xFFF5EDD6),
              fontSize: 28,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
 

// WIDGET — filtro de categorias

 
class _FiltroCategorias extends StatelessWidget {
  final List<String> categorias;
  final String selecionada;
  final ValueChanged<String> onSelecionar;
 
  const _FiltroCategorias({
    required this.categorias,
    required this.selecionada,
    required this.onSelecionar,
  });
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categorias.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categorias[index];
          final ativo = cat == selecionada;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: () => onSelecionar(cat),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: ativo
                      ? const Color(0xFF5C3317)
                      : const Color(0xFF2C1A0E).withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ativo
                        ? const Color(0xFF5C3317)
                        : const Color(0xFF2C1A0E).withValues(alpha: 0.15),
                  ),
                ),
                child: Text(
                  cat,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight:
                        ativo ? FontWeight.w600 : FontWeight.w400,
                    color: ativo
                        ? Colors.white
                        : const Color(0xFF2C1A0E).withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
 

// WIDGET — card do item do cardapio 
 
class CardapioItem extends StatefulWidget {
  final MenuItem item;
  final bool isFavorito;
  final VoidCallback onToggleFavorito;
  final VoidCallback onAdicionarCarrinho;
 
  const CardapioItem({
    super.key,
    required this.item,
    required this.isFavorito,
    required this.onToggleFavorito,
    required this.onAdicionarCarrinho,
  });
 
  @override
  State<CardapioItem> createState() => _CardapioItemState();
}
 
class _CardapioItemState extends State<CardapioItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;
 
  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animController, curve: Curves.elasticOut),
    );
  }
  
 
  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }
 
  void _handleFavoritoTap() {
    _animController.forward().then((_) => _animController.reverse());
    widget.onToggleFavorito();
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C1A0E).withValues(alpha: 0.08),
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
            // Imagem do produto
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.item.imagemUrl,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    width: 88,
                    height: 88,
                    color: const Color(0xFFF5EDD6),
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xFFB5651D),
                        ),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 88,
                  height: 88,
                  color: const Color(0xFFF5EDD6),
                  child: const Icon(
                    Icons.coffee_rounded,
                    color: Color(0xFFB5651D),
                    size: 32,
                  ),
                ),
              ),
            ),
 
            const SizedBox(width: 14),
 
            // Informações do produto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Categoria
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB5651D).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      widget.item.categoria,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFB5651D),
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
 
                  const SizedBox(height: 6),
 
                  // Nome
                  Text(
                    widget.item.nome,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2C1A0E),
                    ),
                  ),
 
                  const SizedBox(height: 3),
 
                  // Descrição item
                  Text(
                    widget.item.descricao,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFF2C1A0E).withValues(alpha: 0.55),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
 
                  const SizedBox(height: 10),
 
                  // Preço + botão favorito
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'R\$ ${widget.item.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF5C3317),
                        ),
                      ),
                      Row(
                        children: [
                          // Botão favorito com animação
                          GestureDetector(
                            onTap: _handleFavoritoTap,
                            child: ScaleTransition(
                              scale: _scaleAnim,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) =>
                                    ScaleTransition(
                                        scale: animation, child: child),
                                child: Icon(
                                  widget.isFavorito
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  key: ValueKey(widget.isFavorito),
                                  color: widget.isFavorito
                                      ? const Color(0xFFE53935)
                                      : const Color(0xFF2C1A0E)
                                          .withValues(alpha: 0.25),
                                  size: 26,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
 
                          // Botão adicionar ao carrinho
                          GestureDetector(
                            onTap: widget.onAdicionarCarrinho,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 7),
                              decoration: BoxDecoration(
                                color: const Color(0xFF5C3317),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Pedir',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
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
    );
  }
}
class TelaCarrinho extends StatelessWidget {
  final List<ItemCarrinho> carrinho;

  const TelaCarrinho({
    super.key,
    required this.carrinho,
  });

  @override
  Widget build(BuildContext context) {
    final total = carrinho.fold<double>(
      0,
      (soma, item) => soma + item.subtotal,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Pedido'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: carrinho.length,
              itemBuilder: (context, index) {
                final item = carrinho[index];

                return ListTile(
                  title: Text(item.item.nome),
                  subtitle: Text(
                    'Quantidade: ${item.quantidade}',
                  ),
                  trailing: Text(
                    'R\$ ${item.subtotal.toStringAsFixed(2)}',
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Total: R\$ ${total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}