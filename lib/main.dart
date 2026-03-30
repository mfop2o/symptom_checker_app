import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

// Global ValueNotifier to hold the current language.
final ValueNotifier<String> currentLanguageNotifier = ValueNotifier<String>('en');

void main() {
  runApp(SymptomCheckerApp());
}

class SymptomCheckerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: currentLanguageNotifier,
      builder: (context, langCode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ethio Health Checker',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF0F9D58), // Deep Green
              primary: const Color(0xFF0F9D58),
              secondary: const Color(0xFFF4B400), // Gold/Yellow
              tertiary: const Color(0xFFDB4437),  // Warm Red
            ),
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
            ),
          ),
          home: HomeScreen(),
        );
      },
    );
  }
}