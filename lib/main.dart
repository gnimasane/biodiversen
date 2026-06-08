// lib/main.dart

import 'package:flutter/material.dart';
import 'screens/liste_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/formulaire_screen.dart';
import 'screens/apropos_screen.dart';

void main() {
  runApp(const BiodiverSenApp());
}

class BiodiverSenApp extends StatelessWidget {
  const BiodiverSenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BiodiverSen - Inventaire Bio',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        // ── Palette "Terrestrial Life Conservation" ──────────────
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF012d1d),
          brightness: Brightness.light,
        ).copyWith(
          primary:              const Color(0xFF012d1d),
          onPrimary:            const Color(0xFFFFFFFF),
          primaryContainer:     const Color(0xFF1b4332),
          onPrimaryContainer:   const Color(0xFF86af99),
          secondary:            const Color(0xFF75593a),
          onSecondary:          const Color(0xFFFFFFFF),
          secondaryContainer:   const Color(0xFFfdd6ae),
          onSecondaryContainer: const Color(0xFF785b3c),
          tertiary:             const Color(0xFF3d1e07),
          onTertiary:           const Color(0xFFFFFFFF),
          tertiaryContainer:    const Color(0xFF57331a),
          onTertiaryContainer:  const Color(0xFFcf9b7a),
          error:                const Color(0xFFba1a1a),
          onError:              const Color(0xFFFFFFFF),
          errorContainer:       const Color(0xFFffdad6),
          onErrorContainer:     const Color(0xFF93000a),
          surface:              const Color(0xFFfdfae7),
          onSurface:            const Color(0xFF1c1c11),
          onSurfaceVariant:     const Color(0xFF414844),
          outline:              const Color(0xFF717973),
          outlineVariant:       const Color(0xFFc1c8c2),
          inverseSurface:       const Color(0xFF313124),
          onInverseSurface:     const Color(0xFFf4f1de),
          inversePrimary:       const Color(0xFFa5d0b9),
        ),

        // ── Fond parchemin sur tous les écrans ───────────────────
        scaffoldBackgroundColor: const Color(0xFFfdfae7),

        // ── Typographie ──────────────────────────────────────────
        textTheme: const TextTheme(
          // Titres → Source Serif 4
          displayLarge: TextStyle(
            fontFamily: 'Source Serif 4',
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.68, // -0.02em
            height: 1.18,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Source Serif 4',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            height: 1.21,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Source Serif 4',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 1.33,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Source Serif 4',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
          // Corps → Work Sans
          bodyLarge: TextStyle(
            fontFamily: 'Work Sans',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.56,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Work Sans',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Work Sans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.43,
          ),
          // Labels → JetBrains Mono
          labelLarge: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
            height: 1.33,
          ),
          labelMedium: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.55,
            height: 1.27,
          ),
          labelSmall: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            height: 1.2,
          ),
        ),

        // ── AppBar ───────────────────────────────────────────────
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFf7f4e1),
          foregroundColor: Color(0xFF012d1d),
          elevation: 0,
          centerTitle: false,
          surfaceTintColor: Color(0xFF3f6653),
          titleTextStyle: TextStyle(          // ← correction
            fontFamily: 'Source Serif 4',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF012d1d),
          ),
        ),

        // ── Cards ────────────────────────────────────────────────
        cardTheme: CardThemeData(
          color: const Color(0xFFFFFFFF),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: const BorderSide(
              color: Color(0xFFc1c8c2),
              width: 1,
            ),
          ),
        ),

        // ── Bouton principal ─────────────────────────────────────
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF012d1d),
            foregroundColor: const Color(0xFFFFFFFF),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontFamily: 'Work Sans',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            minimumSize: const Size.fromHeight(52),
          ),
        ),

        // ── Bouton secondaire ────────────────────────────────────
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF012d1d),
            side: const BorderSide(color: Color(0xFF717973), width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),

        // ── Champs de saisie ─────────────────────────────────────
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFFFFFFF),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFFc1c8c2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFFc1c8c2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Color(0xFF012d1d),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Color(0xFFba1a1a),
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Color(0xFFba1a1a),
              width: 2,
            ),
          ),
          labelStyle: const TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF414844),
            letterSpacing: 0.6,
          ),
          hintStyle: const TextStyle(
            fontFamily: 'Work Sans',
            fontSize: 16,
            color: Color(0xFF717973),
          ),
        ),

        // ── Chips filtre ─────────────────────────────────────────
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFFf1eedb),
          selectedColor: const Color(0xFF012d1d),
          labelStyle: const TextStyle(
            fontFamily: 'Work Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1c1c11),
          ),
          secondaryLabelStyle: const TextStyle(
            fontFamily: 'Work Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFFFFFFFF),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: Color(0xFFc1c8c2)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),

        // ── FAB ──────────────────────────────────────────────────
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF012d1d),
          foregroundColor: Color(0xFFFFFFFF),
          elevation: 2,
          shape: CircleBorder(),
        ),

        // ── Bottom navigation bar ────────────────────────────────
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFf7f4e1),
          selectedItemColor: Color(0xFF012d1d),
          unselectedItemColor: Color(0xFF414844),
          selectedLabelStyle: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'JetBrains Mono',
            fontSize: 11,
          ),
          elevation: 1,
          type: BottomNavigationBarType.fixed,
        ),

        // ── Switch (toggle menacée) ──────────────────────────────
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xFFFFFFFF);
            }
            return const Color(0xFF717973);
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const Color(0xFF012d1d);
            }
            return const Color(0xFFc1c8c2);
          }),
        ),
      ),

      // ── Routes nommées ───────────────────────────────────────
      initialRoute: '/',
      routes: {
        '/':           (_) => const ListeObservationsScreen(),
        '/detail':     (_) => const DetailObservationScreen(),
        '/formulaire': (_) => const FormulaireObservationScreen(),
        '/apropos':    (_) => const AProposScreen(),
      },
    );
  }
}