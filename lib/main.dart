import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(SymptomCheckerApp());
}

class SymptomCheckerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Symptom Checker',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomeScreen(),
    );
  }
}