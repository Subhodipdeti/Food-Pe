import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      fontFamily: "EudoxusSans",
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1!.apply(color: _darkFillColor),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color.fromARGB(255, 23, 24, 30),
    primaryContainer: Color.fromARGB(255, 37, 39, 48),
    secondary: Color(0xFFEFF3F3),
    secondaryContainer: Color.fromARGB(255, 246, 246, 246),
    background: Color.fromARGB(255, 254, 229, 76),
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color.fromARGB(255, 158, 157, 157),
    onSurface: Color.fromARGB(255, 139, 137, 137),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    primaryContainer: Color(0xFF1CDEC9),
    secondary: Color(0xFF4D1F7C),
    secondaryContainer: Color(0xFF451B6F),
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF),
    // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headline4: GoogleFonts.poppins(fontWeight: _bold, fontSize: 30.0),
    caption: GoogleFonts.poppins(fontWeight: _semiBold, fontSize: 16.0),
    headline5: GoogleFonts.poppins(fontWeight: _bold, fontSize: 22.0),
    subtitle1: GoogleFonts.poppins(fontWeight: _medium, fontSize: 16.0),
    overline: GoogleFonts.poppins(fontWeight: _medium, fontSize: 12.0),
    bodyText1: GoogleFonts.poppins(fontWeight: _semiBold, fontSize: 20.0),
    subtitle2: GoogleFonts.poppins(fontWeight: _medium, fontSize: 14.0),
    bodyText2: GoogleFonts.poppins(fontWeight: _regular, fontSize: 20.0),
    headline6: GoogleFonts.poppins(fontWeight: _bold, fontSize: 16.0),
    button: GoogleFonts.poppins(fontWeight: _semiBold, fontSize: 14.0),
  );
}