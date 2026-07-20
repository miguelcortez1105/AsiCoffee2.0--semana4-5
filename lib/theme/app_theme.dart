import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AsiCoffeeColors {
  static const marromEscuro = Color(0xFF2C1A0E);
  static const marromMedio = Color(0xFF5C3317);
  static const caramelo = Color(0xFFB5651D);
  static const cremoso = Color(0xFFF5EDD6);
  static const bege = Color(0xFFFAF3E0);

  //Dark Mode
  static const fundoEscuro = Color(0xFF181210);
  static const superficieEscura = Color(0xFF241812);
}

ThemeData buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AsiCoffeeColors.caramelo,
      brightness: Brightness.light,
      primary: AsiCoffeeColors.marromMedio,
      onPrimary: Colors.white,
      secondary: AsiCoffeeColors.caramelo,
      surface: AsiCoffeeColors.bege,
      onSurface: AsiCoffeeColors.marromEscuro,
    ),
    scaffoldBackgroundColor: AsiCoffeeColors.bege,
    appBarTheme: AppBarTheme(
      backgroundColor: AsiCoffeeColors.marromEscuro,
      foregroundColor: AsiCoffeeColors.cremoso,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.playfairDisplay(
        color: AsiCoffeeColors.cremoso,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    ),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      titleLarge: GoogleFonts.playfairDisplay(
        color: AsiCoffeeColors.marromEscuro,
        fontWeight: FontWeight.w700,
      ),
    ),
    cardColor: Colors.white,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: AsiCoffeeColors.caramelo.withValues(alpha: 0.18),
    ),
  );
}

ThemeData buildDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AsiCoffeeColors.caramelo,
      brightness: Brightness.dark,
      primary: AsiCoffeeColors.caramelo,
      onPrimary: Colors.black,
      secondary: AsiCoffeeColors.cremoso,
      surface: AsiCoffeeColors.superficieEscura,
      onSurface: AsiCoffeeColors.cremoso,
    ),
    scaffoldBackgroundColor: AsiCoffeeColors.fundoEscuro,
    appBarTheme: AppBarTheme(
      backgroundColor: AsiCoffeeColors.superficieEscura,
      foregroundColor: AsiCoffeeColors.cremoso,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.playfairDisplay(
        color: AsiCoffeeColors.cremoso,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
      titleLarge: GoogleFonts.playfairDisplay(
        color: AsiCoffeeColors.cremoso,
        fontWeight: FontWeight.w700,
      ),
    ),
    cardColor: AsiCoffeeColors.superficieEscura,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AsiCoffeeColors.superficieEscura,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AsiCoffeeColors.superficieEscura,
      indicatorColor: AsiCoffeeColors.caramelo.withValues(alpha: 0.30),
    ),
  );
}
