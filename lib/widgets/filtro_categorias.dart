import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltroCategorias extends StatelessWidget {
  final List<String> categorias;
  final String selecionada;
  final ValueChanged<String> onSelecionar;

  const FiltroCategorias({
    super.key,
    required this.categorias,
    required this.selecionada,
    required this.onSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

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
          return GestureDetector(
            onTap: () => onSelecionar(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: ativo
                    ? scheme.primary
                    : scheme.onSurface.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ativo
                      ? scheme.primary
                      : scheme.onSurface.withValues(alpha: 0.15),
                ),
              ),
              child: Center(
                child: Text(
                  cat,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: ativo ? FontWeight.w600 : FontWeight.w400,
                    color: ativo
                        ? scheme.onPrimary
                        : scheme.onSurface.withValues(alpha: 0.7),
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
