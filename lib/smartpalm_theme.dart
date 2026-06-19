import 'package:flutter/material.dart';
import 'smartpalm_tokens.dart';

class SPTheme {
  SPTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: _colorScheme,
    scaffoldBackgroundColor: SPColors.bg,
    fontFamily: SPType.fontFamily,

    appBarTheme: const AppBarTheme(
      backgroundColor: SPColors.primaryDark,
      foregroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: SPType.fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      indicatorColor: SPColors.primary.withOpacity(0.13),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final active = states.contains(WidgetState.selected);
        return TextStyle(
          fontFamily: SPType.fontFamily,
          fontSize: 10,
          fontWeight: active ? FontWeight.bold : FontWeight.normal,
          color: active ? SPColors.primary : SPColors.muted,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final active = states.contains(WidgetState.selected);
        return IconThemeData(color: active ? SPColors.primary : SPColors.muted);
      }),
      height: 80,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    ),

    cardTheme: CardThemeData(
      elevation: 1,
      shadowColor: const Color(0x12000000),
      surfaceTintColor: Colors.transparent,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SPRadius.card),
        side: const BorderSide(color: SPColors.border, width: 1),
      ),
      margin: const EdgeInsets.only(bottom: 10),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: SPColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SPRadius.pill)),
        textStyle: const TextStyle(
          fontFamily: SPType.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: SPColors.primary,
        textStyle: const TextStyle(
          fontFamily: SPType.fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: SPColors.primary,
        side: const BorderSide(color: SPColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SPRadius.pill)),
      ),
    ),

    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.white;
          return const Color(0x1FFFFFFF);
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return SPColors.primaryDark;
          return Colors.white;
        }),
        side: WidgetStateProperty.all(const BorderSide(color: Color(0x33FFFFFF))),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SPRadius.field),
        borderSide: const BorderSide(color: SPColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SPRadius.field),
        borderSide: const BorderSide(color: SPColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SPRadius.field),
        borderSide: const BorderSide(color: SPColors.primary, width: 2),
      ),
      labelStyle: const TextStyle(fontFamily: SPType.fontFamily, fontSize: 14, color: SPColors.muted),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: SPColors.primary,
      linearTrackColor: SPColors.softGreen,
      linearMinHeight: 4,
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),

    dividerTheme: const DividerThemeData(
      color: Color(0xFFF3F4F6),
      thickness: 1,
      space: 0,
    ),

    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      minLeadingWidth: 0,
    ),

    textTheme: const TextTheme(
      displayLarge:   TextStyle(fontFamily: SPType.fontFamily, fontSize: 28, fontWeight: FontWeight.w500, color: SPColors.text),
      titleLarge:     TextStyle(fontFamily: SPType.fontFamily, fontSize: 16, fontWeight: FontWeight.w500, color: SPColors.text),
      titleMedium:    TextStyle(fontFamily: SPType.fontFamily, fontSize: 15, fontWeight: FontWeight.bold, color: SPColors.text),
      bodyLarge:      TextStyle(fontFamily: SPType.fontFamily, fontSize: 14, fontWeight: FontWeight.normal, color: SPColors.text),
      bodyMedium:     TextStyle(fontFamily: SPType.fontFamily, fontSize: 13, fontWeight: FontWeight.normal, color: SPColors.body),
      bodySmall:      TextStyle(fontFamily: SPType.fontFamily, fontSize: 12, fontWeight: FontWeight.normal, color: SPColors.muted),
      labelLarge:     TextStyle(fontFamily: SPType.fontFamily, fontSize: 11, fontWeight: FontWeight.bold, color: SPColors.text),
      labelSmall:     TextStyle(fontFamily: SPType.fontFamily, fontSize: 10, fontWeight: FontWeight.normal, color: SPColors.muted),
    ),
  );

  static const ColorScheme _colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary:          SPColors.primary,
    onPrimary:        Colors.white,
    primaryContainer: SPColors.softGreen,
    onPrimaryContainer: SPColors.primaryDark,
    secondary:          SPColors.teal,
    onSecondary:        Colors.white,
    secondaryContainer: Color(0xFFCCFBF1),
    onSecondaryContainer: Color(0xFF134E4A),
    tertiary:          SPColors.amber,
    onTertiary:        Colors.white,
    tertiaryContainer: Color(0xFFFEF3C7),
    onTertiaryContainer: Color(0xFF78350F),
    error:          SPColors.crit,
    onError:        Colors.white,
    errorContainer: Color(0xFFFEE2E2),
    onErrorContainer: Color(0xFF991B1B),
    surface:        Colors.white,
    onSurface:      SPColors.text,
    surfaceVariant: SPColors.bg,
    onSurfaceVariant: SPColors.body,
    outline:        SPColors.border,
    outlineVariant: Color(0xFFF3F4F6),
    shadow:         Color(0x1A000000),
    scrim:          Color(0x66000000),
    inverseSurface: SPColors.text,
    onInverseSurface: Colors.white,
    inversePrimary: SPColors.softGreen,
  );
}

InputDecoration spDarkInputDecoration({required String label, String? hint}) =>
    InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: const Color(0x12FFFFFF),
      labelStyle: const TextStyle(
        fontFamily: SPType.fontFamily, fontSize: 11, color: Color(0x80FFFFFF),
      ),
      hintStyle: const TextStyle(
        fontFamily: SPType.fontFamily, fontSize: 16, color: Color(0x8DFFFFFF),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SPRadius.field),
        borderSide: const BorderSide(color: Color(0x40FFFFFF), width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SPRadius.field),
        borderSide: const BorderSide(color: Color(0x40FFFFFF), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(SPRadius.field),
        borderSide: const BorderSide(color: Color(0x99FFFFFF), width: 1.5),
      ),
    );
